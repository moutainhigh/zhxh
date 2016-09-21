package net.ussoft.zhxh.web.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicUserLinkService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.DateUtil;
import net.ussoft.zhxh.util.MD5;


@Controller
@RequestMapping("/orderUser")
public class OrderUserController extends BaseConstroller {
	
	@Resource
	private IPublicUserService userService;
	@Resource
	private IPublicUserLinkService userlinkService;	//个人中心关联关系
	
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(String parentid,String identity,String mapObj,int pageIndex,int pageSize,@RequestParam(value="showtype", defaultValue="1") int showtype,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		//分页
		PageBean<Public_user> pageBean = new PageBean<Public_user>();
		pageBean.setPageSize(pageSize);
		pageBean.setPageNo(pageIndex + 1);
		
		Map<String, Object> searchMap = new HashMap<String,Object>();
		
		if (null != mapObj && !"".equals(mapObj)) {
			searchMap = (Map<String, Object>) JSON.parse(mapObj);
		}
		
		userService.list(parentid, identity, searchMap,showtype, pageBean);
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("total", pageBean.getRowCount());
		map.put("data", pageBean.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 检查手机号是否存在。
	 * @param userid			机构id
	 * @param phoneNum			手机号码
	 * @param checkType			检查类型。 insert 新建。判断是否唯一。update 要判断是否等于原值，等于说明没有更改放过，不等于判断是否已存在
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/checkPhoneNum",method=RequestMethod.GET)
	public void checkPhoneNum(String userid,String phoneNum,String checkType,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		boolean flag = true;
		//判断检查类型
		if (checkType.equals("insert")) {
			flag = userService.checkPhoneNum(phoneNum);
		}
		else {
			Public_user user = userService.getById(userid);
			if (user.getPhonenumber().equals(phoneNum)) {
				flag = false;
			}
			else {
				flag = userService.checkPhoneNum(phoneNum);
			}
		}
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		if (flag) {
			map.put("getdata", "false");
		}
		else {
			map.put("getdata", "true");
		}
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public void save(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		
		if ("".equals(objs) || objs == null) {
			out.print(result);
			return;
		}
		//
		List<Map<String, String>> rows = (List<Map<String, String>>) JSON.parse(objs);
		
		for(int i=0,l=rows.size(); i<l; i++){
			Map<String,String> row = (Map<String,String>)rows.get(i);
	  		  
			String id = row.get("id") != null ? row.get("id").toString() : "";
	        String state = row.get("_state") != null ? row.get("_state").toString() : "";
	        //新增：id为空，或_state为added
	        if(state.equals("added") || id.equals("")) {
	        	insert(row);
	        }
	        else if (state.equals("removed") || state.equals("deleted")) {
	        	delete(id);
	        }
	        //更新：_state为空，或modified
	        else if (state.equals("modified") || state.equals(""))	 {
	            update(row);
	        }
	    }
		out.print(result);
	}
	
	/**
	 * 添加
	 * @param row
	 * @return
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	private String insert(Map<String,String> row) throws IllegalAccessException, InvocationTargetException {
		if (null == row) {
			return "error";
		}
		Public_user user = new Public_user(UUID.randomUUID().toString());
		BeanUtils.populate(user, row);
		
		//验证手机号是否已存在
		boolean flag = userService.checkPhoneNum(user.getPhonenumber());
		if(!flag){
//			user.setId(UUID.randomUUID().toString());
			
			if (user.getIdentity().equals("A")) {
				user.setIdentitymemo("代理");
			}
			else if (user.getIdentity().equals("C")) {
				user.setIdentitymemo("门店");
			}
			else if (user.getIdentity().equals("Z")) {
				user.setIdentitymemo("普通会员");
			}
			user.setSetreturn(0);
			user.setIsopen(0);
			
			Public_user pUser = super.getSessionUser();
			if (!user.getIdentity().equals("Z")) {
				if (null != pUser) {
					user.setParentid(pUser.getId());
				}
			}
			else {
				if (null != pUser) {
					user.setBelongcode(pUser.getCompanycode());
				}
			}
			
			//密码md5
			String pass = MD5.encode("123456");
			user.setPassword(pass);
			user.setCreatetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
			
			int num = userService.insert(user);
			
			if (num > 0) {
				return "success";
			}
			else {
				return "error";
			}
		}else{
			return "isPhoneNum";
		}
	}
	
	/**
	 * 更新
	 * @param row
	 * @return
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	private String update(Map<String,String> row) throws IOException, IllegalAccessException, InvocationTargetException {
		if (null == row) {
			return "error";
		}
		Public_user user = new Public_user();
		BeanUtils.populate(user, row);
		//
		boolean flag = true;
		Public_user pUser = userService.getById(user.getId());
		if(user.getPhonenumber().equals(pUser.getPhonenumber())){
			flag = false;
		}else{
			//验证手机号是否已存在
			flag = userService.checkPhoneNum(user.getPhonenumber());
		}
		
		if(!flag){
			int num = userService.update(user);
			if(num > 0){
				return "success";
			}
			return "error";
		}else{
			return "isPhoneNum";
		}
	}
	
	private void delete(String id) {
		userService.delete(id);
	}
	
	/**
	 * 批量修改机构信息。某个字段
	 * @param updateUserids
	 * @param field
	 * @param fieldValue
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/updateBatch",method=RequestMethod.POST)
	public void updateBatch(String updateUserids,String field,String fieldValue,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String flag = "error";
		
		boolean isok = userService.updateBatch(updateUserids, field, fieldValue);
		
		if (isok) {
			flag = "success";
		}
		
		out.print(flag);
	}
	
	/**
	 * 批量删除机构
	 * @param delUserids
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/delBatch",method=RequestMethod.POST)
	public void delBatch(String delUserids,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String flag = "error";
		
		int isok = userService.delete(delUserids);
		
		if (isok > 0) {
			flag = "success";
		}
		
		out.print(flag);
	}
	
}

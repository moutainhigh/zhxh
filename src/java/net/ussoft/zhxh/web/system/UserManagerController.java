package net.ussoft.zhxh.web.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.service.IPublicUserLinkService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.MD5;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;

@Controller
@RequestMapping(value="userManager")
public class UserManagerController extends BaseConstroller{

	@Resource
	IPublicUserService userService;
	@Resource
	IPublicUserLinkService userlinkService;	//个人中心关联关系
	/*@Resource
	IPublicUserBankService bankService;	//账户
*/	
	/**
	 * 根据ID获取会员
	 * @param id
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/getById",method=RequestMethod.GET)
	public void getById(String id,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		Public_user user = userService.getById(id);
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("data", user);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 搜索手机号
	 * @param phoneNum
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/getByPhoneNum",method=RequestMethod.GET)
	public void getByPhoneNum(String phoneNum,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		Public_user user = userService.getByPhoneNum(phoneNum);
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("data", user);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 个人中心
	 * @param identity 身份
	 * @param parentid 上级
	 * @param belongcode 所属机构代码
	 * @param companycode 机构代码
	 * @param mobile 手机号
	 * @throws IOException
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(String identity,String parentid,String belongcode,String companycode,String mobile,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		//分页
		PageBean<Public_user> pageBean = new PageBean<Public_user>();
		pageBean.setPageSize(pageSize);
		pageBean.setPageNo(pageIndex + 1);
		//查看代理下店、会员
		if("A".equals(identity) && null != parentid){
			//代理下的店 - 通过关联关系查询其下的店
			pageBean = userService.list(parentid,"C", pageBean);
		}else{
			//查询条件
			Map<String, Object> searchmap = new LinkedHashMap<String, Object>();
			searchmap.put("identity =", identity);	//身份
			searchmap.put("belongcode =", belongcode);	//所属机构代码
			searchmap.put("companycode =", companycode);	//机构代码
			searchmap.put("phonenumber =", mobile);	//
			pageBean = userService.list(searchmap, pageBean);
		}
		
		//
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("total", pageBean.getRowCount());
		map.put("data", pageBean.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	

	/**
	 * 修改其上级机构
	 * @param userid
	 * @param oldparentid
	 * @param newparentid
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/upParent",method=RequestMethod.POST)
	public void updateParent(String userid,String oldparentid,String newparentid,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String result = "error";
		if ("".equals(userid) || userid == null) {
			out.print(result);
			return;
		}
		//
		int num = userService.updateParent(userid, oldparentid,newparentid);
		if(num > 0)
			result = "success";
		out.print(result);
	}
	
	/**
	 * 给代理添加已存在的店，建立关系和账户
	 * @param id
	 * @param parentid
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/createlink",method=RequestMethod.POST)
	public void createlink(String userid,String parentid,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String result = "error";
		if ("".equals(userid) || userid == null || "".equals(parentid) || parentid == null) {
			out.print(result);
			return;
		}
		//num:	-1:已存在关联关系，0:创建失败，1:创建成功
		int num = userService.createlink(userid, parentid);
		out.print(num);
	}
	
	
	/**
	 * 保存
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public void save(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "error";
		if ("".equals(objs) || objs == null) {
			out.print(result);
			return;
		}
		//
		Map<String,String> row = (Map<String,String>)JSON.parse(objs);
		String id = row.get("id") != null ? row.get("id").toString() : "";
		if("".equals(id)){
			result = insert(row);	//添加
		}else{
			result = update(row);	//修改
		}
		out.print(result);
	}
	
	/**
	 * 删除。
	 * @param id
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	private void delete(String id,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if (id == null || id.equals("") ) {
			out.print("error");
		}
		int num = userService.delete(id);
		
		if (num <= 0 ) {
			out.print("error");
		}
		out.print("success");
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
		Public_user user = new Public_user();
		BeanUtils.populate(user, row);
		
		//验证手机号是否已存在
		boolean flag = userService.checkPhoneNum(user.getPhonenumber());
		if(!flag){
			user.setId(UUID.randomUUID().toString());
			//密码md5
			String pass = MD5.encode(user.getPassword());
			user.setPassword(pass);
			if(!"".equals(user.getParentid()) && null != user.getParentid()){
				int num = userService.insert(user, user.getParentid());	//添加代理、店
				return num > 0 ? "success":"error";
			}else{
				user = userService.insert(user);	//添加普通会员
				if(user != null){
					return "success";
				}
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
			if(!pUser.getPassword().equals(user.getPassword())){
				String pass = MD5.encode(user.getPassword());
				user.setPassword(pass);
			}
			int num = userService.update(user);
			if(num > 0){
				return "success";
			}
			return "error";
		}else{
			return "isPhoneNum";
		}
	}
	
	 
}

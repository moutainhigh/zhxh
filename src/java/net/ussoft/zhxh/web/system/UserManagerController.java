package net.ussoft.zhxh.web.system;

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
	 * 个人中心
	 * @param parentid 	上级
	 * @param identity 	身份
	 * @param mapObj 	查询map
	 * @param showtype	显示类型  1：正常  0：待关联
	 * @throws IOException
	 */
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
//		//查看代理下店、会员
//		if("A".equals(identity) && null != parentid){
//			//代理下的店 - 通过关联关系查询其下的店
//			pageBean = userService.list(parentid,"C", pageBean);
//		}else if("C".equals(identity)){
//			//非直营店
//			pageBean = userService.list_shop(false, pageBean);
//		}else{
//			//查询条件
//			Map<String, Object> searchmap = new LinkedHashMap<String, Object>();
//			searchmap.put("identity ", identity);	//身份
//			searchmap.put("belongcode ", belongcode);	//所属机构代码
//			searchmap.put("companycode ", companycode);	//机构代码
//			searchmap.put("phonenumber ", mobile);	//
////			searchmap.put("identity =", identity);	//身份
////			searchmap.put("belongcode =", belongcode);	//所属机构代码
////			searchmap.put("companycode =", companycode);	//机构代码
////			searchmap.put("phonenumber =", mobile);	//
//			pageBean = userService.list(searchmap, pageBean);
//		}
		
		//
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("total", pageBean.getRowCount());
		map.put("data", pageBean.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 代管理机构
	 * @throws IOException
	 */
	@RequestMapping(value="/noParentList",method=RequestMethod.POST)
	public void noParentList(int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		//分页
		PageBean<Public_user> pageBean = new PageBean<Public_user>();
		pageBean.setPageSize(pageSize);
		pageBean.setPageNo(pageIndex + 1);
		
		pageBean = userService.noParentList(pageBean);
		//
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("total", pageBean.getRowCount());
		map.put("data", pageBean.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	@RequestMapping(value="/setTuijianList",method=RequestMethod.POST)
	public void setTuijianList(String parentid,String userid,String identity,String mapObj,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
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
		
		pageBean = userService.setTuijianList(parentid, userid, identity, searchMap, pageBean);
		//
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("total", pageBean.getRowCount());
		map.put("data", pageBean.getList());
		
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
		String result = "success";
		if (flag) {
			result = "error";
		}
		
		out.print(result);
		
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
	 * 删除。
	 * @param id
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
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
	 * 初始化密码
	 * @param id
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/initUpdatePass",method=RequestMethod.POST)
	private void initUpdatePass(String id,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if (id == null || id.equals("") ) {
			out.print("error");
		}
		userService.initUpdatePass(id);
		
		out.print("success");
	}
	
	/**
	 * 检查是否有下级，是否可以正常删除。（已改为不需要判断，直接将下级设置为待关联机构。本方法作废）
	 * @param ids
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/checkDel",method=RequestMethod.POST)
	private void checkDel(String ids,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if (ids == null || ids.equals("") ) {
			out.print("error");
		}
		String result = userService.checkDel(ids);
		
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
	public void createlink(String parentid,String userids,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String result = "error";
		if ("".equals(userids) || userids == null || "".equals(parentid) || parentid == null) {
			out.print(result);
			return;
		}
		//num:	-1:已存在关联关系，0:创建失败，1:创建成功
		int num = userService.createlink(parentid,userids);
		out.print(num);
	}
	
	@RequestMapping(value="/outLink",method=RequestMethod.POST)
	private void outLink(String parentid,String userids,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if (userids == null || userids.equals("") ) {
			out.print("success");
		}
		userService.outLink(parentid,userids);
		
		out.print("success");
	}
	
	/**
	 * 移动
	 * @param userid
	 * @param oldparentid
	 * @param newparentid
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/userMove",method=RequestMethod.POST)
	public void userMove(String userids,String oldParentid,String newParentid,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String result = "error";
		if ("".equals(userids) || userids == null) {
			out.print(result);
			return;
		}
		//
		int num = userService.userMove(userids, oldParentid,newParentid);
		if(num > 0)
			result = "success";
		out.print(result);
	}
	
	
	
	
	
	
	
	//==========以下不确定要
	
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
	 * 保存
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/save2",method=RequestMethod.POST)
	public void save2(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
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
	
	
	 
}

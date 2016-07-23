package net.ussoft.zhxh.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Sys_account;
import net.ussoft.zhxh.model.Sys_account_tree;
import net.ussoft.zhxh.model.Sys_org;
import net.ussoft.zhxh.model.Sys_orgowner;
import net.ussoft.zhxh.model.Sys_role;
import net.ussoft.zhxh.model.Sys_templet;
import net.ussoft.zhxh.model.Sys_templetfield;
import net.ussoft.zhxh.model.Sys_tree;
import net.ussoft.zhxh.service.IAccountService;
import net.ussoft.zhxh.service.ICodeService;
import net.ussoft.zhxh.service.IEncryService;
import net.ussoft.zhxh.service.IOrgService;
import net.ussoft.zhxh.service.IRoleService;
import net.ussoft.zhxh.service.ITempletService;
import net.ussoft.zhxh.service.ITreeService;
import net.ussoft.zhxh.util.MD5;

@Controller
@RequestMapping(value="account")
public class AccountController extends BaseConstroller {
	
	@Resource
	private IAccountService accountService;
	@Resource
	private IOrgService orgService;
	@Resource
	private IEncryService encryService;
	@Resource
	private IRoleService roleService;
	@Resource
	private ITreeService treeService;
	@Resource
	private ICodeService codeService;
	@Resource
	private ITempletService templetService;
	
	
	/**
	 * 获取帐户列表
	 * @param orgid		所属组
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(String orgid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		List<Sys_account> accountList = accountService.list(orgid);
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("total", accountList.size());
		map.put("data", accountList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 获取帐户能管理的档案范围。
	 * @param roleid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/getAccountFunTree",method=RequestMethod.POST)
	public void getAccountFunTree(String accountid,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "";
		
		//获取当前组能访问的树节点，用来checkbox勾选
		List<Sys_account_tree> accountTrees = accountService.getAccountTree(accountid);
		
		if (null != accountTrees && accountTrees.size() > 0) {
			for (Sys_account_tree tree : accountTrees) {
//				if (!"top".equals(tree.getTreeid())) {
					result += tree.getTreeid() + ",";
//				}
			}
			
			result = result.substring(0, result.length()-1);
		}
		
		out.print(result);
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
	
	private boolean insert(Map<String,String> row) throws IllegalAccessException, InvocationTargetException {
		if (null == row) {
			return false;
		}
		Sys_account account = new Sys_account();
		BeanUtils.populate(account, row);
		
		account.setId(UUID.randomUUID().toString());
		//生成默认密码md5
		HashMap<String, Object> configMap = getConfig("SYSTEM");
		String pass = configMap.get("PASSWORD").toString();
		if (pass != null && !pass.equals("")) {
			pass = MD5.encode(pass);
		}
		else {
			pass = MD5.encode("password");
		}
		account.setPassword(pass);
		account = accountService.insert(account);		
		return true;
	}
	
	/**
	 * 删除。
	 * @param id
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private boolean delete(String id) throws IOException {
		
		if (id == null || id.equals("") ) {
			return false;
		}
		int num = accountService.delete(id);
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	/**
	 * 更新
	 * @param row
	 * @return
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	private boolean update(Map<String,String> row) throws IOException, IllegalAccessException, InvocationTargetException {
		
		if (null == row) {
			return false;
		}
		Sys_account account = new Sys_account();
		BeanUtils.populate(account, row);
		
		int num = accountService.update(account);
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
	/**
	 * 保存帐户移动
	 * @param id
	 * @param targetid
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/movesave",method=RequestMethod.POST)
	public void movesave(String id,String targetid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		if (null == id || id.equals("") || null == targetid || targetid.equals("")) {
			result = "failure";
			out.print(result);
			return;
		}
		
		Boolean b = accountService.move(id, targetid);
		
		if (!b) {
			result = "failure";
		}
		
		out.print(result);
	}
	
	/**
	 * 为帐户赋权，赋予档案数据访问操作权
	 * @param id		组id
	 * @param value		选择的treeid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/setAuth")
	public void setAuth(String id,String value,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String[] valueArr = value.split(",");
		
//		List<String> treeList = (List<String>) JSON.parse(treeids);
		Boolean b = accountService.saveaccounttree(id, valueArr);

		String result = "success";
		
		out.print(result);
	}
	
	/**
	 * 保存当前帐户的树节点辅助权限（全文浏览权、全文下载权、全文打印权、节点下数据访问权）
	 * @param org_tree
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/saveDocAuth")
	public void saveDocAuth(Sys_account_tree account_tree,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		
		Boolean b = accountService.saveTreeAuth(account_tree);
		
		if (b) {
			result = "success";
		}
		//获取组和树的对应
		out.print(result);
	}
	
	@RequestMapping(value="/saveAllDocFileAuth")
	public void saveAllDocFileAuth(boolean isok,String accountid,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		
		Boolean b = accountService.saveAllTreeAuth(isok,accountid);
		
		if (b) {
			result = "success";
		}
		//获取组和树的对应
		out.print(result);
	}
	
	@RequestMapping(value="/saveAllDocAuth")
	public void saveAllDocAuth(String docAuthid,String docAuthvalue,String accountid,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		
		Boolean b = accountService.saveAllDocAuth(docAuthid,docAuthvalue,accountid);
		
		if (b) {
			result = "success";
		}
		//获取组和树的对应
		out.print(result);
	}
	
	/**
	 * 保存组的高级权限
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/saveAccountAuth",method=RequestMethod.POST)
	public void saveAccountAuth(String objs,String accountid,String treeid,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
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
		insertAccountAuth(rows,accountid,treeid);
		out.print(result);
	}
	
	private boolean insertAccountAuth(List<Map<String, String>> rows,String accountid,String treeid) throws IllegalAccessException, InvocationTargetException {
		if (null == rows) {
			return false;
		}
		
		List<Map<String,String>> accountAuthList = new ArrayList<Map<String,String>>();
		for (Map<String, String> map : rows) {
			String state = map.get("_state") != null ? map.get("_state").toString() : "";
			if (state.equals("removed") || state.equals("deleted")) {
				continue;
			}
			map.put("id", UUID.randomUUID().toString());
			map.remove("_id");
			map.remove("_state");
			map.remove("_uid");
			accountAuthList.add(map);
		}
		
		//获取sys_org_tree对象
		Sys_account_tree account_tree = accountService.getTreeAuth(accountid, treeid);
		
		if (null == account_tree) {
			return false;
		}
		if (accountAuthList.size() == 0) {
			account_tree.setFilter("");
		}
		else {
			account_tree.setFilter(JSON.toJSONString(accountAuthList));
		}
		
		accountService.saveTreeAuth(account_tree);
		return true;
	}
	
	/**
	 * 执行更新帐户密码
	 * @param id
	 * @param password
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value="/toupdatepass",method=RequestMethod.POST)
	public void toupdatepass(String id,String password,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		
		Sys_account account = accountService.getById(id);
		
		if (account == null || password.equals("")) {
			out.print(result);
			return;
		}
		
		account.setPassword(MD5.encode(password).toString());
		
		int num = accountService.update(account);
		if (num > 0 ) {
			result = "success";
		}
		out.print(result);
	}
	
	
	
	
	
	
	
	
	//===========以下不确定要===============
	
	
	/**
	 * 打开帐户编辑页面
	 * @param id
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="/edit",method=RequestMethod.GET)
	public ModelAndView edit(String id,ModelMap modelMap) {
		Sys_account account = accountService.getById(id);
		modelMap.put("account", account);
		
		return new ModelAndView("/view/auth/account/edit", modelMap);
	}
	
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public void update(Sys_account account,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		if (account == null ) {
			out.print(result);
			return;
		}
		int num = accountService.update(account);
		if (num > 0 ) {
			result = "success";
		}
		out.print(result);
	}
	
	/**
	 * 打开修改帐户密码页
	 * @param id
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="/updatepass",method=RequestMethod.GET)
	public ModelAndView updatepass(String id,ModelMap modelMap) {
		Sys_account account = accountService.getById(id);
		modelMap.put("account", account);
		
		return new ModelAndView("/view/auth/account/updatepass", modelMap);
	}
	/**
	 * 打开移动帐户页面
	 * @param id
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="/move",method=RequestMethod.GET)
	public ModelAndView move(String id,ModelMap modelMap) {
		Sys_account account = super.getSessionAccount();
		List<Sys_org> orgList = orgService.orgownerList(account.getId());
		
		String orgListString = JSON.toJSONString(orgList);
		modelMap.put("orgList", orgListString);
		
		modelMap.put("id", id);
		return new ModelAndView("/view/auth/account/move",modelMap);
	}
	/**
	 * 保存帐户移动
	 * @param id
	 * @param targetid
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/movesave2",method=RequestMethod.POST)
	public void movesave2(String id,String targetid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		if (null == id || id.equals("") || null == targetid || targetid.equals("")) {
			result = "failure";
			out.print(result);
			return;
		}
		
		Boolean b = accountService.move(id, targetid);
		
		if (!b) {
			result = "failure";
		}
		
		out.print(result);
	}
	
	/**
	 * 删除。
	 * @param id
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/delete2",method=RequestMethod.POST)
	public void delete2(String id,HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		if (id == null || id.equals("") ) {
			out.print(result);
			return;
		}
		
		int num = accountService.delete(id);
		
		
		if (num > 0) {
			result = "success";
		}
		
		out.print(result);
	}
	
	/**
	 * 更改帐户状态
	 * @param id
	 * @param state
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/updatestate",method=RequestMethod.POST)
	public void updatestate(String id,Integer state,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		if (id == null || id.equals("") || state == null || state.equals("")) {
			out.print(result);
			return;
		}
		
		//获取帐户实体
		Sys_account account = accountService.getById(id);
		if (account == null) {
			out.print(result);
			return;
		}
		account.setAccountstate(state);
		int num = accountService.update(account);
		
		if (num > 0) {
			result = "success";
		}
		
		out.print(result);
	}
	
	/**
	 * 帐户管理列表。要适应各种版本的管理（集团版，网络版）不分页.
	 * 帐户是跟组走的，只要控制了组的显示，集团版和普通版是一样的
	 * @param orgid
	 * @param type
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView list(String orgid,String type,ModelMap modelMap) throws Exception {
		
		String version = "no";
		
		String urlString = "/view/auth/account/list";
		List<Sys_org> orgList = new ArrayList<Sys_org>();
		//如果是集团版本
		if (null != type && "group".equals(type) && encryService.getInit("ISGROUP")) {
			version = "group";
//			modelMap = super.getModelMap("GROUP","GROUPACCOUNT");
			//获取当前帐户能管理的组织机构
			Sys_account account = super.getSessionAccount();
			orgList = orgService.orgownerList(account.getId());
		}
		else {
//			modelMap = super.getModelMap("AUTH","ACCOUNT");
			orgList = orgService.list();
		}
		
		String orgListString = JSON.toJSONString(orgList);
		modelMap.put("orgList", orgListString);
		
		List<HashMap<String, String>> accounts = new ArrayList<HashMap<String,String>>();
		
		//获取选择的组下的帐户
		if (null != orgid && !orgid.equals("")) {
			accounts = accountService.getChildList(orgid);
		}
		modelMap.put("accounts", accounts);
		modelMap.put("version", version);
		modelMap.put("orgid", orgid);			
		return new ModelAndView(urlString,modelMap);
	}
	
	/**
	 * 打开添加页面
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(String orgid,ModelMap modelMap) {
		modelMap.put("orgid", orgid);
		return "/view/auth/account/add";
	}
	/**
	 * 保存新帐户
	 * @param account
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/save2",method=RequestMethod.POST)
	public void save2(Sys_account account,HttpServletRequest request,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		if (account == null ) {
			result = "failure";
			out.print(result);
			return;
		}
		account.setId(UUID.randomUUID().toString());
		//生成默认密码md5
		HashMap<String, Object> configMap = getConfig("SYSTEM");
		String pass = configMap.get("PASSWORD").toString();
		if (pass != null && !pass.equals("")) {
			pass = MD5.encode(pass);
		}
		else {
			pass = MD5.encode("password");
		}
		account.setPassword(pass);
		account = accountService.insert(account);
		
		if (account == null ) {
			result = "failure";
			out.print(result);
			return;
		}
		out.print(result);
	}
	
	
	/**
	 * 打开设置帐户角色页面
	 * @param id
	 * @param modelMap
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/setrole",method=RequestMethod.GET)
	public ModelAndView setrole(String id,String type,ModelMap modelMap) throws Exception {
		//获取帐户对象
		Sys_account account = accountService.getById(id);
		//获取选中帐户的角色,供页面实现和删除
		Sys_role role = null;
		if (null != account.getRoleid() && !account.getRoleid().equals("")) {
			role = roleService.getById(account.getRoleid());
		}
		modelMap.put("role", role);
		modelMap.put("account", account);
		
		//获取角色供选择
//		List<Sys_role> sys_roles = roleService.list();
		
		//获取数据
		List<Sys_role> roleList = new ArrayList<Sys_role>();
		
		//如果是集团版本，并且当前点击的是集团角色管理
		if (null != type && "group".equals(type) && encryService.getInit("ISGROUP")) {
			
			//获取当前帐户能管理的组织机构
			Sys_account tmpAccount = super.getSessionAccount();
			List<Sys_orgowner> orgList = orgService.getOrgowner(account.getId());
			
			if (orgList.size() > 0) {
				StringBuilder sb = new StringBuilder("select * from sys_role where ");
				for (int i =0 ;i<orgList.size();i++) {
					if (i == orgList.size() -1) {
						sb.append(" orgid like '").append(orgList.get(i).getOrgid()).append("'");
					}
					else {
						sb.append(" orgid like '").append(orgList.get(i).getOrgid()).append("' or ");
					}
				}
				
				roleList = roleService.selectByWhere(sb.toString(), new ArrayList<Object>());
			}
		}
		else {
			//获取数据
			roleList = roleService.list();
		}
		
		modelMap.put("sys_roles", roleList);
		
		return new ModelAndView("/view/auth/account/setrole",modelMap);
	}
	/**
	 * 保存组的角色
	 * @param orgid
	 * @param roleid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/saverole",method=RequestMethod.POST)
	public void saverole(String id,String roleid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		if (id == null || id.equals("") || roleid == null || roleid.equals("")) {
			result = "failure";
			out.print(result);
			return;
		}
		
		Boolean b = accountService.saverole(id, roleid);
		
		if (!b) {
			result = "failure";
		}
		
		out.print(result);
	}
	/**
	 * 移除帐户的角色
	 * @param id
	 * @param roleid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/removerole",method=RequestMethod.POST)
	public void removerole(String id,String roleid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		if (id == null || id.equals("") || roleid == null || roleid.equals("")) {
			result = "failure";
			out.print(result);
			return;
		}
		
		Boolean b = accountService.removerole(id, roleid);
		
		if (!b) {
			result = "failure";
		}
		
		out.print(result);
	}
	
	//提供给账户赋权用，根据当前系统版本来获取当前账户能管理的组的树
	private String getTree(String type) throws Exception {
		
		String where = "";
		List<Object> values = new ArrayList<Object>();
		//如果是集团组管理
		if (null != type && "group".equals(type) && encryService.getInit("ISGROUP")) {
			//集团版，获取档案树节点的方式不一样。
			Sys_account account = super.getSessionAccount();
			//集团版 。首先获得当前账户能管理的档案库
			String tmpWhere = " where owner = ?";
			values.add(account.getId());
			List<Sys_templet> tmpTempletList = templetService.list(tmpWhere, values, null);
			
			values.clear();
			//获取档案库对应的树节点，获取节点的treenode，再根据treenode获取本级及下级节点。
			tmpWhere = "";
			List<Sys_tree> tmpTrees = new ArrayList<Sys_tree>();
			if (tmpTempletList.size() > 0) {
				tmpWhere += " where ";
				for (Sys_templet tmp : tmpTempletList) {
					//以下2句，是只显示owner下节点，不包括owner上级节点
					tmpWhere += "templetid = ?";
					tmpWhere += " or ";
					values.add(tmp.getId());
				}
				
				tmpWhere = tmpWhere.substring(0, tmpWhere.length() - 4);
				tmpTrees = treeService.list(tmpWhere, values, null);
			}
			values.clear();
			if (tmpTrees.size() > 0) {
				where += " where ";
				for (Sys_tree tmp : tmpTrees) {
					//以下2句，是只显示owner下节点，不包括owner上级节点
					where += "treenode = ? or treenode like '"+tmp.getTreenode()+"#%'";
					where += " or ";
					values.add(tmp.getTreenode());
				}
				
				where = where.substring(0, where.length() - 4);
			}
			else {
				if (account.getRoleid().equals("1")) {
					
				}
				else {
					String jsonString = "[]";
					return jsonString;
				}
			}
		}
		
		String order = " order by sort asc";
		
		List<Sys_tree> trees = treeService.list(where, values, order);
		String resultsString = JSON.toJSONString(trees);
		
		String basePath = getProjectBasePath();
		String jsonString = treeService.createTreeJson(resultsString, basePath);
		return jsonString;
	}
	
	
	/**
	 * 点击树节点，显示当前帐户的树节点辅助权限（全文浏览权、全文下载权、全文打印权、节点下数据访问权、电子全文浏览范围代码）
	 * @param id
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/getTreeAuth")
	public void getTreeAuth(String id,String treeid,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		Sys_account_tree account_tree = accountService.getTreeAuth(id, treeid);
		
		if (null == account_tree) {
			out.print("");
			return;
		}
		
		String result = JSON.toJSONString(account_tree);
		//获取组和树的对应
		out.print(result);
	}
	
	
	/**
	 * 打开帐户针对树节点的数据访问权添加页面
	 * @param id
	 * @param treeid
	 * @param tabletype
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="/showSetDataAuthWindow",method=RequestMethod.GET)
	public ModelAndView showSetDataAuthWindow(String id,String treeid,String tabletype,ModelMap modelMap) {
		//获取组对象
		Sys_account account = accountService.getById(id);
		modelMap.put("account", account);
		
		//获取树对象
		Sys_tree tree = treeService.getById(treeid);
		modelMap.put("tree", tree);
		
		modelMap.put("tabletype", tabletype);
		
		//获取tree对应的模版字段列表
		List<Sys_templetfield> templetfields = treeService.geTempletfields(treeid, tabletype);
		modelMap.put("templetfields", templetfields);
		
		return new ModelAndView("/view/auth/account/setdataauth",modelMap);
	}
	/**
	 * 保存帐户的数据访问权限
	 * @param account_tree
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="saveDataAuth",method=RequestMethod.POST)
	public void saveDataAuth(Sys_account_tree account_tree,String tabletype,String filter,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		
		if (null == account_tree || tabletype.equals("") || filter.equals("")) {
			out.print(result);
			return;
		}
		//去掉org_tree的filter，可能前台传入的时候会自动加到类里，这样查询不出来
		account_tree.setFilter(null);
		Boolean b = accountService.saveDataAuth(account_tree,tabletype,filter);
		
		if (b) {
			result = "success";
		}
		//获取组和树的对应
		out.print(result);
	}
	/**
	 * 删除帐户与树关联的数据访问权限
	 * @param accounttreeid
	 * @param id
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="removeDataAuth",method=RequestMethod.POST)
	public void removeDataAuth(String accounttreeid,String id,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		
		if (null == accounttreeid || accounttreeid.equals("") || null == id || id.equals("")) {
			out.print(result);
			return;
		}
		Boolean b = accountService.removeDataAuth(accounttreeid, id);
		
		if (b) {
			result = "success";
		}
		//获取组和树的对应
		out.print(result);
	}
	
	/**
	 * 保存帐户的树节点下电子全文浏览范围权限
	 * @param account_tree
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/saveDocAuth2")
	public void saveDocAuth2(Sys_account_tree account_tree,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		
		Boolean b = accountService.saveDocAuth(account_tree);
		
		if (b) {
			result = "success";
		}
		//获取组和树的对应
		out.print(result);
	}
	
	
}

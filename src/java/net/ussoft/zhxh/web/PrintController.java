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
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Sys_print_column_list;
import net.ussoft.zhxh.model.Sys_print_column_out;
import net.ussoft.zhxh.model.Sys_print_table;
import net.ussoft.zhxh.model.Sys_print_title;
import net.ussoft.zhxh.service.IPrintColumnListService;
import net.ussoft.zhxh.service.IPrintColumnOutService;
import net.ussoft.zhxh.service.IPrintTableService;
import net.ussoft.zhxh.service.IPrintTitleService;

/**
 * 参数设置
 * @author wangf
 *
 */

@Controller
@RequestMapping(value="print")
public class PrintController extends BaseConstroller {
	
	
	@Resource
	private IPrintTableService printTableService;
	@Resource
	private IPrintTitleService printTitleService;
	@Resource
	private IPrintColumnListService printColumnListService;
	@Resource
	private IPrintColumnOutService printColumnOutService;
	
	
	/**
	 * 获取打印管理表
	 * @param tabletype	报表分类  1：可自定义  0：固定报表
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/print_table_list",method=RequestMethod.POST)
	public void print_table_list(int tabletype,String isAll,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String sql = "";
		List<Object> values = new ArrayList<Object>();
		if (null == isAll || "".equals(isAll)) {
			sql = "select * from sys_print_table where tabletype =? order by sort";
			values.add(tabletype);
		}
		else {
			sql = "select * from sys_print_table order by sort";
		}
		
		List<Sys_print_table> list = printTableService.list(sql, values);
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("total", list.size());
		map.put("data", list);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	/**
	 * 获取标题
	 * @param parentid		报表管理表id
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/print_title_list",method=RequestMethod.POST)
	public void print_title_list(String parentid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String sql = "select * from sys_print_title where parentid =? order by sort";
		List<Object> values = new ArrayList<Object>();
		
		values.add(parentid);
		
		List<Sys_print_title> list = printTitleService.list(sql, values);
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("total", list.size());
		map.put("data", list);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	/**
	 * 获取数据列
	 * @param parentid		报表管理表id
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/print_column_list",method=RequestMethod.POST)
	public void print_column_list(String parentid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String sql = "select * from sys_print_column_list where parentid =? order by columnsort";
		List<Object> values = new ArrayList<Object>();
		
		values.add(parentid);
		
		List<Sys_print_column_list> list = printColumnListService.list(sql, values);
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("total", list.size());
		map.put("data", list);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	/**
	 * 获取标题
	 * @param parentid		报表管理表id
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/print_column_out",method=RequestMethod.POST)
	public void print_column_out(String parentid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String sql = "select * from sys_print_column_out where parentid =? order by columnsort";
		List<Object> values = new ArrayList<Object>();
		
		values.add(parentid);
		
		List<Sys_print_column_out> list = printColumnOutService.list(sql, values);
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("total", list.size());
		map.put("data", list);
		
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
	@RequestMapping(value="/save_table",method=RequestMethod.POST)
	public void save_table(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
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
	        	insert_table(row);
	        }
	        else if (state.equals("removed") || state.equals("deleted")) {
	        	delete_table(id);
	        }
	        //更新：_state为空，或modified
	        else if (state.equals("modified") || state.equals(""))	 {
	            update_table(row);
	        }
	    }
		out.print(result);
	}
	
	private boolean insert_table(Map<String,String> row) throws IllegalAccessException, InvocationTargetException {
		if (null == row) {
			return false;
		}
		Sys_print_table printTable = new Sys_print_table();
		BeanUtils.populate(printTable, row);
		printTable.setId(UUID.randomUUID().toString());
		
		printTable = printTableService.insert(printTable);
		
		if (printTable == null ) {
			return false;
		}
		return true;
	}
	
	/**
	 * 删除。
	 * @param id
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public boolean delete_table(String id) throws IOException {
		
		if (id == null || id.equals("") ) {
			return false;
		}
		
		int num = printTableService.delete(id);
		if (num <= 0) {
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
	public boolean update_table(Map<String,String> row) throws IOException, IllegalAccessException, InvocationTargetException {
		
		if (null == row) {
			return false;
		}
		
		Sys_print_table printTable = new Sys_print_table();
		BeanUtils.populate(printTable, row);
		
		int num = printTableService.update(printTable);
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
	/**
	 * 保存标题
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/save_title",method=RequestMethod.POST)
	public void save_title(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
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
	        if (state.equals("modified") || state.equals(""))	 {
	            update_title(row);
	        }
	    }
		out.print(result);
	}
	
	/**
	 * 更新
	 * @param row
	 * @return
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public boolean update_title(Map<String,String> row) throws IOException, IllegalAccessException, InvocationTargetException {
		
		if (null == row) {
			return false;
		}
		
		Sys_print_title printTitle = new Sys_print_title();
		BeanUtils.populate(printTitle, row);
		
		int num = printTitleService.update(printTitle);
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
	
	/**
	 * 保存
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/save_list",method=RequestMethod.POST)
	public void save_list(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
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
		String tableid = "";
		for(int i=0,l=rows.size(); i<l; i++){
			Map<String,String> row = (Map<String,String>)rows.get(i);
	  		  
			String id = row.get("id") != null ? row.get("id").toString() : "";
	        String state = row.get("_state") != null ? row.get("_state").toString() : "";
	        tableid = row.get("parentid");
	        //新增：id为空，或_state为added
	        if(state.equals("added") || id.equals("")) {
	        	insert_list(row);
	        }
	        else if (state.equals("removed") || state.equals("deleted")) {
	        	delete_list(id);
	        }
	        //更新：_state为空，或modified
	        else if (state.equals("modified") || state.equals(""))	 {
	            update_list(row);
	        }
	    }
		
		//更新table的html
		Sys_print_table printTable = printTableService.selectById(tableid);
		printTableService.update(printTable);
		
		out.print(result);
	}
	
	private boolean insert_list(Map<String,String> row) throws IllegalAccessException, InvocationTargetException {
		if (null == row) {
			return false;
		}
		Sys_print_column_list printList = new Sys_print_column_list();
		BeanUtils.populate(printList, row);
		printList.setId(UUID.randomUUID().toString());
		
		printList = printColumnListService.insert(printList);
		
		if (printList == null ) {
			return false;
		}
		return true;
	}
	
	/**
	 * 删除。
	 * @param id
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public boolean delete_list(String id) throws IOException {
		
		if (id == null || id.equals("") ) {
			return false;
		}
		
		int num = printColumnListService.delete(id);
		if (num <= 0) {
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
	public boolean update_list(Map<String,String> row) throws IOException, IllegalAccessException, InvocationTargetException {
		
		if (null == row) {
			return false;
		}
		
		Sys_print_column_list printList = new Sys_print_column_list();
		BeanUtils.populate(printList, row);
		
		int num = printColumnListService.update(printList);
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
	
	/**
	 * 保存
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/save_out",method=RequestMethod.POST)
	public void save_out(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
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
		String tableid = "";
		for(int i=0,l=rows.size(); i<l; i++){
			Map<String,String> row = (Map<String,String>)rows.get(i);
			
			String id = row.get("id") != null ? row.get("id").toString() : "";
			String state = row.get("_state") != null ? row.get("_state").toString() : "";
			tableid = row.get("parentid");
			//新增：id为空，或_state为added
			if(state.equals("added") || id.equals("")) {
				insert_out(row);
			}
			else if (state.equals("removed") || state.equals("deleted")) {
				delete_out(id);
			}
			//更新：_state为空，或modified
			else if (state.equals("modified") || state.equals(""))	 {
				update_out(row);
			}
		}
		
		//更新table的html
		Sys_print_table printTable = printTableService.selectById(tableid);
		printTableService.update(printTable);
		
		out.print(result);
	}
	
	private boolean insert_out(Map<String,String> row) throws IllegalAccessException, InvocationTargetException {
		if (null == row) {
			return false;
		}
		Sys_print_column_out printOut = new Sys_print_column_out();
		BeanUtils.populate(printOut, row);
		printOut.setId(UUID.randomUUID().toString());
		
		printOut = printColumnOutService.insert(printOut);
		
		if (printOut == null ) {
			return false;
		}
		return true;
	}
	
	/**
	 * 删除。
	 * @param id
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	public boolean delete_out(String id) throws IOException {
		
		if (id == null || id.equals("") ) {
			return false;
		}
		
		int num = printColumnOutService.delete(id);
		if (num <= 0) {
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
	public boolean update_out(Map<String,String> row) throws IOException, IllegalAccessException, InvocationTargetException {
		
		if (null == row) {
			return false;
		}
		
		Sys_print_column_out printOut = new Sys_print_column_out();
		BeanUtils.populate(printOut, row);
		
		int num = printColumnOutService.update(printOut);
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
	/**
	 * 更新固定报表代码
	 * @param code
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/upload_code",method=RequestMethod.POST)
	public void upload_code(String id,String code,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		
		Sys_print_table t = printTableService.selectById(id);
		
		t.setHtmlcontent(code);
		
		printTableService.update(t);
		
		out.print(result);
	}
	
	
	//====以下不确定要===========
	
//	/**
//	 * 系统配置页面,读取系统配置表内容
//	 * @param pageIndex
//	 * @param pageSize
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/list",method=RequestMethod.POST)
//	public void list(HttpServletResponse response) throws IOException {
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		//获取config数据
//		List<Sys_config> configList = configService.list();
//		
//		HashMap<String,Object> map = new HashMap<String,Object>();
//		
//		map.put("total", configList.size());
//		map.put("data", configList);
//		
//		String json = JSON.toJSONString(map);
//		out.print(json);
//	}
//	
//	
//	/**
//	 * 保存
//	 * @param objs
//	 * @param response
//	 * @throws IOException
//	 * @throws IllegalAccessException
//	 * @throws InvocationTargetException
//	 */
//	@RequestMapping(value="/save",method=RequestMethod.POST)
//	public void save(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		String result = "success";
//		
//		if ("".equals(objs) || objs == null) {
//			out.print(result);
//			return;
//		}
//		//
//		List<Map<String, String>> rows = (List<Map<String, String>>) JSON.parse(objs);
//		
//		for(int i=0,l=rows.size(); i<l; i++){
//			Map<String,String> row = (Map<String,String>)rows.get(i);
//	  		  
//			String id = row.get("id") != null ? row.get("id").toString() : "";
//	        String state = row.get("_state") != null ? row.get("_state").toString() : "";
//	        //更新：_state为空，或modified
//	        if (state.equals("modified") || state.equals(""))	 {
//	            update(row);
//	        }
//	    }
//		out.print(result);
//	}
//	
//	/**
//	 * 更新
//	 * @param row
//	 * @return
//	 * @throws IOException
//	 * @throws IllegalAccessException
//	 * @throws InvocationTargetException
//	 */
//	public boolean update(Map<String,String> row) throws IOException, IllegalAccessException, InvocationTargetException {
//		
//		if (null == row) {
//			return false;
//		}
//		
//		Sys_config config = new Sys_config();
//		BeanUtils.populate(config, row);
//		
//		int num = configService.update(config);
//		
//		if (num <= 0 ) {
//			return false;
//		}
//		return true;
//	}
//	
//	/**
//	 * 根据key，获取单个value
//	 * @param key
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/getConfigValue",method=RequestMethod.POST)
//	public void getConfigValue(String key,HttpServletResponse response) throws IOException {
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		String result = "";
//		
//		Sys_config config = new Sys_config();
//		
//		config.setConfigkey(key);
//		
//		config = configService.selectByWhere(config);
//		
//		result = config.getConfigvalue();
//		
//		out.print(result);
//	}
//	
//	
//	/**
//	 * 供组或帐户的高级权限，电子全文权限下拉选择
//	 * @param pageIndex
//	 * @param pageSize
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/getDocAuth",method=RequestMethod.POST)
//	public void getDocAuth(HttpServletResponse response) throws IOException {
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		//获取电子全文浏览范围代码，供页面填充select
//		Sys_code code = new Sys_code();
//		code.setTempletfieldid("DOCAUTH");
//		List<Sys_code> codes = codeService.selectByWhere(code);
//		
//		String json = JSON.toJSONString(codes);
//		out.print(json);
//	}
//	
//	
//	//以下不确定要==============
//	
//	
//	
//	/**
//	 * 打开电子文件权限代码设置页
//	 * @return
//	 */
//	@RequestMapping(value="/docauth_index",method=RequestMethod.GET)
//	public ModelAndView docauth_index(ModelMap modelMap) {
//		return new ModelAndView("/view/system/config/docauthlist",modelMap);
//	}
//	
//	/**
//	 * 打开电子文件权限代码设置页
//	 * @throws IOException 
//	 */
//	@RequestMapping(value="/docauthlist",method=RequestMethod.POST)
//	public void docauthlist(HttpServletResponse response) throws IOException {
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		
//		//获取电子全文代码
//		Sys_code code = new Sys_code();
//		code.setTempletfieldid("DOCAUTH");
//		List<Sys_code> codes = codeService.selectByWhere(code);
//		
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		
//		resultMap.put("totalpages", 1);
//		resultMap.put("currpage", 1);
//		resultMap.put("totalrecords", codes.size());
//		resultMap.put("rows", codes);
//		
//		String json = JSON.toJSONString(resultMap);
//		out.print(json);
//	}
//	/**
//	 * 打开电子文件权限代码添加页
//	 * @param modelMap
//	 * @return
//	 */
//	@RequestMapping(value="/docauthadd",method=RequestMethod.GET)
//	public String docauthadd(ModelMap modelMap) {
//		return "/view/system/config/docauthadd";
//	}
//	/**
//	 * 保存新代码
//	 * @param response
//	 * @throws IOException 
//	 */
//	@RequestMapping(value="/savedocauth",method=RequestMethod.POST)
//	public void savedocauth(Sys_code code,HttpServletResponse response) throws IOException {
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		String result = "success";
//		if (code == null ) {
//			result = "failure";
//			out.print(result);
//			return;
//		}
//		code.setId(UUID.randomUUID().toString());
//		code.setTempletfieldid("DOCAUTH");
//		code.setCodeorder(1);
//		code = codeService.insert(code);
//		
//		if (code == null ) {
//			result = "failure";
//			out.print(result);
//			return;
//		}
//		out.print(result);
//	}
//	/**
//	 * 打开更新电子文件浏览权限代码
//	 * @param id
//	 * @param modelMap
//	 * @return
//	 */
//	@RequestMapping(value="/docauthedit",method=RequestMethod.GET)
//	public ModelAndView docauthedit(String id,ModelMap modelMap) {
//		//判断id是否存在
//		if (id == null || id.equals("")) {
//			return null;
//		}
//		//获取对象
//		Sys_code docauth = codeService.selectById(id);
//		modelMap.put("docauth", docauth);
//		return new ModelAndView("/view/system/config/docauthedit",modelMap);
//	}
//	/**
//	 * 执行更新电子文件浏览权限代码
//	 * @param code
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/updatedocauth",method=RequestMethod.POST)
//	public void updatedocauth(Sys_code code,HttpServletResponse response) throws IOException {
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		String result = "success";
//		if (code == null ) {
//			result = "failure";
//			out.print(result);
//			return;
//		}
//		
////		int num = codeService.update(code);
//		
////		if (num <= 0 ) {
////			result = "failure";
////			out.print(result);
////			return;
////		}
//		out.print(result);
//	}
//	/**
//	 * 删除电子文件浏览权限代码
//	 * @param orgid
//	 * @param request
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/docauthdelete",method=RequestMethod.POST)
//	public void docauthdelete(String id,HttpServletResponse response) throws IOException {
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		String result = "success";
//		if (id == null || id.equals("") ) {
//			result = "failure";
//			out.print(result);
//			return;
//		}
//		
//		int num = configService.deleteDocAuth(id);
//		
//		if (num <= 0) {
//			result = "failure";
//		}
//		
//		out.print(result);
//	}
}

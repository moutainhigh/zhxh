package net.ussoft.zhxh.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Sys_account;
import net.ussoft.zhxh.model.Sys_account_tree;
import net.ussoft.zhxh.model.Sys_org_tree;
import net.ussoft.zhxh.model.Sys_table;
import net.ussoft.zhxh.model.Sys_templet;
import net.ussoft.zhxh.model.Sys_templetfield;
import net.ussoft.zhxh.model.Sys_tree;
import net.ussoft.zhxh.service.IAccountService;
import net.ussoft.zhxh.service.ICodeService;
import net.ussoft.zhxh.service.IConfigService;
import net.ussoft.zhxh.service.IDocService;
import net.ussoft.zhxh.service.IDynamicService;
import net.ussoft.zhxh.service.IEncryService;
import net.ussoft.zhxh.service.IOrgService;
import net.ussoft.zhxh.service.ITableService;
import net.ussoft.zhxh.service.ITempletService;
import net.ussoft.zhxh.service.ITempletfieldService;
import net.ussoft.zhxh.service.ITreeService;
import net.ussoft.zhxh.util.ExcelUtil;
import net.ussoft.zhxh.util.ExportExcelUtils;
import net.ussoft.zhxh.util.UploadUtil;
import net.ussoft.zhxh.util.resule.ResultInfo;

/**
 * 档案管理
 * @author wangf
 *
 */

@Controller
@RequestMapping(value="archive")
public class ArchiveController extends BaseConstroller {
	
	@Resource
	private ITreeService treeService;
	@Resource
	private IDynamicService dynamicService;
	@Resource
	private IAccountService accountService;
	@Resource
	private IConfigService configService;
	@Resource
	private ITempletService templetService;
	@Resource
	private ITempletfieldService templetfieldService;
//    @Autowired  
//    private  HttpServletRequest request;  
    @Resource
    private ICodeService codeService;
    
    @Resource
    private IDocService docService;
    @Resource
    private IOrgService orgService;
    @Resource
    private IEncryService encryService;
    @Resource
    private ITableService tableService;
    
//    private static final int BUFFER_SIZE = 2 * 1024;
    
    
    
    /**
	 * 获取左侧的树结构
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/getTree",method=RequestMethod.POST)
	public void getTree(HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		//获取当前session登录帐户
		Sys_account account = getSessionAccount();
		//根据当前帐户id，获取帐户的档案树节点，用来档案管理里画档案树
		List<Sys_tree> trees = treeService.getAuthTree(account.getId());
		
//		if (null == trees || trees.size() == 0) {
//			out.print("");
//			return;
//		}
		
		//获取全部档案类型
		List<Sys_templet> templets = treeService.getAuthTemplet(account.getId());
		
		if (null == templets || templets.size() == 0) {
			out.print("");
			return;
		}
		
		//生成页面需要的templet tree的格式list
		List<HashMap<String,Object>> resultList = new ArrayList<HashMap<String,Object>>();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("id", "top");
		map.put("text", "档案树");
		map.put("isLeaf", false);
		map.put("parentid", "0");
		map.put("asyncLoad", false);
		resultList.add(map);
		
		//生成前台树的结构
		for (Sys_templet templet : templets) {
			HashMap<String,Object> tmpMap = new HashMap<String,Object>();
			tmpMap.put("id", templet.getId());
			tmpMap.put("text", templet.getTempletname());
			tmpMap.put("templetid", templet.getId());
			tmpMap.put("templettype",templet.getTemplettype());
			
			if (null == templet.getParentid() || "".equals(templet.getParentid()) || "4".equals(templet.getParentid())) {
				tmpMap.put("parentid", "top");
			}
			else {
				tmpMap.put("parentid", templet.getParentid());
			}
			
			tmpMap.put("isLeaf", false);
			tmpMap.put("asyncLoad", false);
			
			if ("A".equals(templet.getTemplettype()) || "F".equals(templet.getTemplettype())) {
				tmpMap.put("img", "1.gif");
				tmpMap.put("isClick", true);
				tmpMap.put("isTemplet", true);
			}
			
			resultList.add(tmpMap);
			List<String> tempType = new ArrayList<String>();
			tempType.add("A");
			tempType.add("F");
			
			if (tempType.contains(templet.getTemplettype())) {
				if (null != trees && trees.size() >0 ) {
					for (Sys_tree tree : trees) {
						HashMap<String,Object> childMap = new HashMap<String,Object>();
						if (templet.getId().equals(tree.getTempletid())) {
							if (tree.getTreetype().equals("W")) {
								childMap.put("id",tree.getId());
								childMap.put("text", tree.getTreename());
								childMap.put("parentid",tree.getParentid());
								childMap.put("isLeaf", true);
								childMap.put("treetype", tree.getTreetype());
								childMap.put("templetid", templet.getId());
								childMap.put("templettype",templet.getTemplettype());
								resultList.add(childMap);
							}
							else {
								childMap.put("id",tree.getId());
								childMap.put("text", tree.getTreename());
								childMap.put("parentid",tree.getParentid());
								childMap.put("asyncLoad", false);
								childMap.put("isLeaf", false);
								childMap.put("isClick", true);
								childMap.put("treetype", tree.getTreetype());
								childMap.put("templetid", templet.getId());
								childMap.put("templettype",templet.getTemplettype());
								resultList.add(childMap);
							}
						}
					}
				}
			}
		}
		
		String resultsString = JSON.toJSONString(resultList);
		
		out.print(resultsString);
	}
	
	@RequestMapping(value="/getData",method=RequestMethod.POST)
	public void getData(String treeid,Boolean allwj,String tabletype,String parentid,
			String searchTxt,int state,int pageIndex,int pageSize,String sortField,String sortOrder,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Map<String, Object>> pageBean = new PageBean<Map<String,Object>>();
		
		//获取当前session登录帐户
		Sys_account account = getSessionAccount();
		
		//获取档案类别
		Sys_templet templet = treeService.getTemplet(treeid);
		
		if (pageSize == 0) {
			pageBean.setIsPage(false);
		}
		else {
			pageBean.setIsPage(true);
			pageBean.setPageSize(pageSize);
			pageBean.setPageNo(pageIndex + 1);
		}
		if (null != sortField && !"".equals(sortField)) {
			pageBean.setOrderBy(sortField);
			pageBean.setOrderType(sortOrder);
		}
		else {
			//获取档案字段(先取帐户自己的字段配置，如果没有，获取系统的)
			List<Sys_templetfield> fieldList = templetfieldService.getAccountTempletfields(templet.getId(),tabletype,account.getId());
			pageBean.setOrderBy(getOrderby(fieldList));
		}
		
		//获取当前treeid下数据
		pageBean = dynamicService.archiveList(treeid,templet.getId(),allwj,parentid,tabletype, searchTxt,state,pageBean);
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("total", pageBean.getRowCount());
		map.put("data", pageBean.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	private String getOrderby(List<Sys_templetfield> fieldList) {
		//获取排序规则
		String orderbyString = "";
		for (Sys_templetfield field : fieldList) {
			if (null != field.getOrderby() && !field.getOrderby().equals("")) {
				if (field.getOrderby().equals("GBK")) {
					orderbyString += "CONVERT("+field.getEnglishname()+" USING gbk),";
				}
				else if (field.getOrderby().equals("NUM")) {
					orderbyString += field.getEnglishname() + "+0,";
				}
				else {
					orderbyString += field.getEnglishname() + " " + field.getOrderby() + ",";
				}
//				if (field.getFieldtype().equals("INT")) {
//					orderbyString += field.getEnglishname() + " " + field.getOrderby() + ",";
//				}
//				else {
//					if (field.getOrderby().equals("GBK")) {
//						orderbyString += "CONVERT("+field.getEnglishname()+" USING gbk),";
//					}
//					else {
//						orderbyString += field.getEnglishname() + " " + field.getOrderby() + ",";
//					}
//				}
			}
		}
		if (orderbyString.length() > 0) {
			orderbyString = orderbyString.substring(0, orderbyString.length()-1);
		}
		else {
			orderbyString = "createtime desc";
		}
		return orderbyString;
	}
	
	/**
	 * 获取当前帐户的树节点辅助权限（全文浏览权、全文下载权、全文打印权、节点下数据访问权、电子全文浏览范围代码）
	 * @param id
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/getTreeAuth")
	public void getTreeAuth(String treeid,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		//获取当前session登录帐户
		Sys_account account = getSessionAccount();
		HashMap<String,Object> resultMap = new HashMap<>();
		
		Sys_account_tree account_tree = accountService.getTreeAuth(account.getId(), treeid);
		if (null == account_tree || "".equals(account_tree.getId())) {
			Sys_org_tree org_tree = orgService.getTreeAuth(account.getOrgid(), treeid);
			if (null != org_tree && !"".equals(org_tree.getId())) {
				resultMap.put("id", org_tree.getId());
				resultMap.put("treeid", org_tree.getTreeid());
				resultMap.put("accountid", org_tree.getOrgid());
				resultMap.put("filescan", org_tree.getFilescan());
				resultMap.put("filedown", org_tree.getFiledown());
				resultMap.put("fileprint", org_tree.getFileprint());
				resultMap.put("docauth", org_tree.getDocauth());
				resultMap.put("docauthvalue", org_tree.getDocauthvalue());
				
			}
		}
		else {
			resultMap.put("id", account_tree.getId());
			resultMap.put("treeid", account_tree.getTreeid());
			resultMap.put("accountid", account_tree.getAccountid());
			resultMap.put("filescan", account_tree.getFilescan());
			resultMap.put("filedown", account_tree.getFiledown());
			resultMap.put("fileprint", account_tree.getFileprint());
			resultMap.put("docauth", account_tree.getDocauth());
			resultMap.put("docauthvalue", account_tree.getDocauthvalue());
		}
		
		if (null == resultMap || resultMap.size() == 0) {
			out.print("");
			return;
		}
		
		String result = JSON.toJSONString(resultMap);
		//获取组和树的对应
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
	public void save(String objs,String templetid,String tabletype,int status,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		
		if ("".equals(objs) || objs == null) {
			out.print(result);
			return;
		}
		
		dynamicService.save(objs, templetid, tabletype,status);
		
		out.print(result);
	}
	
	@RequestMapping(value="/getZhujuanAjRow",method=RequestMethod.POST)
	public void getZhujuanAjRow(String objs,String treeid,String templetid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "";
		
		if ("".equals(objs) || objs == null) {
			out.print("");
			return;
		}
		
		List<Map<String, Object>> maps = dynamicService.getZhujuanAjRow(objs, templetid, treeid, "01");
		
		if (null == maps || maps.size() == 0) {
			out.print(result);
		}
		else {
			result = JSON.toJSONString(maps);
			out.print(result);
		}
	}
	
	@RequestMapping(value="/removeWjTo",method=RequestMethod.POST)
	public void removeWjTo(String ids,String tabletype,String templetid,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "";
		
		if (null == ids || "".equals(ids)) {
			out.print("");
			return;
		}
		
		String[] idArr = ids.split(",");
		List<String> idList = Arrays.asList(idArr);
		result = dynamicService.removeWjTo(idList, templetid, tabletype);
		
		out.print(result);
	}
	
	/**
	 * 组卷保存
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/zjSave",method=RequestMethod.POST)
	public void zjSave(String objs,String templetid,String tabletype,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "error";
		
		if ("".equals(objs) || objs == null) {
			out.print(result);
			return;
		}
		
		result = dynamicService.zjSave(objs, templetid, tabletype);
		
		out.print(result);
	}
	/**
	 * 拆卷
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/caijuan",method=RequestMethod.POST)
	public void caijuan(String ids,String templetid,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "error";
		
		if (null == ids || "".equals(ids)) {
			out.print("");
			return;
		}
		
		String[] idArr = ids.split(",");
		List<String> idList = Arrays.asList(idArr);
		result = dynamicService.caijuan(idList, templetid, "01");
		
		out.print(result);
	}
	/**
	 * 归档
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/guidang",method=RequestMethod.POST)
	public void guidang(String ids,String templetid,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "error";
		
		if (null == ids || "".equals(ids)) {
			out.print("");
			return;
		}
		
		String[] idArr = ids.split(",");
		List<String> idList = Arrays.asList(idArr);
		result = dynamicService.guidang(idList, templetid, "01");
		
		out.print(result);
	}
	/**
	 * 文件档案直接归档
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/wjguidang",method=RequestMethod.POST)
	public void wjguidang(String ids,String templetid,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "error";
		
		if (null == ids || "".equals(ids)) {
			out.print("");
			return;
		}
		
		String[] idArr = ids.split(",");
		List<String> idList = Arrays.asList(idArr);
		result = dynamicService.wjguidang(idList, templetid, "01");
		
		out.print(result);
	}
	/**
	 * excel导入保存
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/importSave",method=RequestMethod.POST)
	public void importSave(String objs,String templetid,String tabletype,int status,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		
		if ("".equals(objs) || objs == null) {
			out.print(result);
			return;
		}
		
		dynamicService.importSave(objs, templetid, tabletype,status);
		
		out.print(result);
	}
	
	@RequestMapping(value="/pasteSave",method=RequestMethod.POST)
	public void pasteSave(String objs_target,String oldTempletid,String oldTabletype,String oldTreeid,
			String targetTempletid,String targetTabletype,String targetTreeid,String copyType,boolean isCopyDoc,boolean isCopyWj,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		
		if ("".equals(objs_target) || objs_target == null) {
			out.print(result);
			return;
		}
		dynamicService.pasteSave(objs_target, oldTempletid, oldTabletype, oldTreeid, targetTempletid, 
				targetTabletype, targetTreeid, copyType, isCopyDoc, isCopyWj);
		
		out.print(result);
	}
	
	/**
	 * 导出excel数据
	 * @param treeid		 	档案树节点id
	 * @param tabletype			档案表类型
	 * @param ids				选择的档案数据id，如果为空，就获取全部导出
	 * @param parentid			如果tabletype为02，则获取数据需要parentid
	 * @param request		
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/exportArchive")
	public void exportArchive(String templetid,String treeid,String tabletype,String ids,String parentid,String searchTxt,Integer status,HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		//获取session里的复制codeid
//		ids = (String) CommonUtils.getSessionAttribute(request, "exportSession");
		Sys_account account = getSessionAccount();
		
		
		//获取档案字段(先取帐户自己的字段配置，如果没有，获取系统的)
		List<Sys_templetfield> fields = templetfieldService.getAccountTempletfields(templetid,tabletype,account.getId());
		
		if (null == status || status<0) {
			status = 0;
		}
		
		//获取字段
//		List<Sys_templetfield> fields = getTempletfields(treeid, tabletype);
		//获取排序规则
		String orderby = getOrderby(fields);
		List<Map<String, Object>> maps = new ArrayList<Map<String,Object>>();
		//获取导出数据
		//判断id是否存在
		if (ids != null && !ids.equals("")) {
			String[] idArr = ids.split(",");
			List<String> idList = Arrays.asList(idArr);
			maps = dynamicService.get(templetid,fields,treeid,"", tabletype, idList,orderby,null,null);
		}
		else {
			//如果没有传入导出数据id，获取全部数据导出
			maps = dynamicService.get(templetid,fields,treeid,parentid, tabletype, null,orderby,status,searchTxt);
		}
		
		Date date = new Date();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    String dateString = sdf.format(date);
		
		Sys_tree tree = treeService.getById(treeid);
		
		String title = tree.getTreename()+"-导出数据-"+dateString;
		
		ExportExcelUtils.exportArchive(fields, title, maps, response, request);
		
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public void delete(boolean isAllClean,String treeid,String tabletype,String ids,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		List<String> list = new ArrayList<String>();
		if (!isAllClean) {
			if (null == ids || ids.equals("")) {
				out.print("未获得要删除的数据，请重新操作或与管理员联系。");
				return;
			}
			
			String[] idsStrings = ids.split(",");
			
			list = Arrays.asList(idsStrings);
		}
		
		ResultInfo info = dynamicService.deleteArchive(isAllClean,treeid, tabletype, list);
		
		out.print(info.getMsg());
	}
	
	/**
	 * 恢复回收站里的数据。
	 * @param isAll				全部恢复 true or false
	 * @param treeid			treeid
	 * @param tabletype			表类型  01 or 02
	 * @param ids				如果isAll= false  读取ids
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/recovery",method=RequestMethod.POST)
	public void recovery(boolean isAll,String treeid,String tabletype,String ids,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		List<String> list = new ArrayList<String>();
		//
		if (!isAll) {
			if (null == ids || ids.equals("")) {
				out.print("未获得要恢复的数据，请重新操作或与管理员联系。");
				return;
			}
			
			String[] idsStrings = ids.split(",");
			
			list = Arrays.asList(idsStrings);
		}
		
		ResultInfo info = dynamicService.recoveryArchive(isAll,treeid, tabletype, list);
		
		out.print(info.getMsg());
	}
	
	/**
	 * 文件上传。为导入
	 * @param request
	 * @param response
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	
	@RequestMapping("/upload")
	public void upload(HttpServletRequest request,HttpServletResponse response) throws IllegalStateException, IOException{
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
    	CommonsMultipartResolver multipartResolver  = new CommonsMultipartResolver(request.getSession().getServletContext());
		if(multipartResolver.isMultipart(request)){
			MultipartHttpServletRequest  multiRequest = (MultipartHttpServletRequest)request;
			//获取参数
			String treeid = request.getParameter("treeid");
			String tabletype = request.getParameter("tabletype");
			String parentid = request.getParameter("parentid");
			String templetid = request.getParameter("templetid");
			String status = request.getParameter("status");
			
			
			//获取plupload参数
			Integer chunks = Integer.valueOf(request.getParameter("chunks"));
			String uuid = UUID.randomUUID().toString();
			String name = request.getParameter("name");
			
			//获取扩展名  
	        String ext = name.substring(name.lastIndexOf(".")+1); 
			
	        name = uuid + "." + ext;
	        
			Integer chunk = Integer.valueOf(request.getParameter("chunk"));
			//获取文件列表
			Iterator<String>  iter = multiRequest.getFileNames();
			while(iter.hasNext()){
				//获取文件对象
				MultipartFile file = multiRequest.getFile((String)iter.next());
				//获取临时文件的绝对路径
				String contextPath = getProjectRealPath() + "file" +File.separator + "upload" + File.separator;
				//生成临时文件
		        String dstPath =  contextPath + name;
		        File dstFile = new File(dstPath);
		        // 文件已存在（上传了同名的文件）
		        if (chunk == 0 && dstFile.exists()) {
		            dstFile.delete();
		            dstFile = new File(dstPath);
		        }
		        //合并文件
		        UploadUtil.cat(file, dstFile);
		        // 完成一整个文件;
		        if (chunk == chunks - 1) {
		        	//获取临时文件对象
		        	File newFile =new File(contextPath+name);
		        	
		        	if(newFile != null){
		        		//获取config数据
		        		List<Sys_templetfield> templetfields = templetfieldService.getAccountTempletfields(templetid, tabletype, "SYSTEM");
		        		List<Map<String,Object>> resultList = readExcel(contextPath+name,treeid,tabletype,status,parentid,templetfields);
		        		
		        		String json = JSON.toJSONString(resultList);
		        		newFile.delete();
		        		out.print(json);
//		        		uploadSaveData(archiveid, tabletype, treeid, newFile);
					}
		        }
			}
		}
	}
	
	/*** 
     * 读取单元格的值 
     *  
     * @Title: getCellValue 
     * @Date : 2014-9-11 上午10:52:07 
     * @param cell 
     * @return 
     */  
    private String getCellValue(Cell cell) {  
        Object result = "";  
        if (cell != null) {  
            switch (cell.getCellType()) {  
            case Cell.CELL_TYPE_STRING:  
                result = cell.getStringCellValue();  
                break;  
            case Cell.CELL_TYPE_NUMERIC:  
            	if (HSSFDateUtil.isCellDateFormatted(cell)) {   
			        double d = cell.getNumericCellValue();   
			        Date date = HSSFDateUtil.getJavaDate(d);
			        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//可以方便地修改日期格式
					String hehe = dateFormat.format(date);
					result = hehe;
			    }
				else {
					DecimalFormat df = new DecimalFormat();  
					result = df.format(cell.getNumericCellValue());
//					result = cell.getNumericCellValue(); 
					
				}
                break;  
            case Cell.CELL_TYPE_BOOLEAN:  
                result = cell.getBooleanCellValue();  
                break;  
            case Cell.CELL_TYPE_FORMULA:  
                result = cell.getCellFormula();  
                break;  
            case Cell.CELL_TYPE_ERROR:  
                result = cell.getErrorCellValue();  
                break;  
            case Cell.CELL_TYPE_BLANK:  
                break;  
            default:  
                break;  
            }  
        }  
        return result.toString();  
    }  
	
	private List<Map<String,Object>> readExcel(String path,String treeid,String tabletype,String status,String parentid,List<Sys_templetfield> fieldList) throws IOException {
		ExcelUtil eu = new ExcelUtil();
		List<Row> rows = eu.readExcel(path);
		
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		//获取字段
		List<Map<String,Object>> fList = new ArrayList<Map<String,Object>>();
//		List<Integer> fNumList = new ArrayList<Integer>();
		Row field_row = rows.get(0);
		Iterator<Cell> field_cells = field_row.cellIterator();
		int n = 0;
		while (field_cells.hasNext()) {
			HSSFCell cell = (HSSFCell) field_cells.next();
			for (Sys_templetfield f : fieldList) {
				if (f.getSort() > 0) {
					if (f.getChinesename().equals(cell.getStringCellValue())) {
						Map<String,Object> tmpMap = new HashMap<String,Object>();
						tmpMap.put("num", n);
						tmpMap.put("enName", f.getEnglishname());
						tmpMap.put("cnName", f.getChinesename());
						fList.add(tmpMap);
						break;
					}
				}
			}
			n++;
		}
//		for (int i=1;i<rows.size();i++) {
//			Row row = rows.get(i);
		int rowNum = 0;
		for (Row row : rows) {
			//第一行为字段名，忽略
			if (rowNum == 0) {
				rowNum++;
				continue;
			}
			else {
				rowNum++;
			}
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("TREEID", treeid);
			map.put("ISDOC", 0);
			map.put("STATUS", status);
			if (tabletype.equals("02")) {
				map.put("PARENTID", parentid);
			}
			
			for (int i=0;i<fList.size();i++) {
				String value = getCellValue(row.getCell(Integer.valueOf(fList.get(i).get("num").toString())));
				map.put(fList.get(i).get("enName").toString(), value);
			}
			
//			int colNum = 0;
//			Iterator<Cell> cells = row.cellIterator(); 
//			while (cells.hasNext()) {
//				boolean isImport = false;
//				String enName = "";
//				//判断当前的列是否在导入的Excel里存在
//				for(int i=0;i<fList.size();i++) {
//					if (fList.get(i).get("num").equals(colNum)) {
//						isImport = true;
//						enName = fList.get(i).get("enName").toString();
//					}
//				}
//				colNum++;
//				if (!isImport) {
//					continue;
//				}
//				
//			}
			resultList.add(map);
		}
		
		return resultList;
	}
	
	/**
	 * 全文检索用到的显示全文所属档案信息
	 * @param treeid
	 * @param tableid
	 * @param id
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/show",method=RequestMethod.POST)
	public void show(String treeid,String tableid,String id,HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
		//判断id是否存在
		if (null == id || id.equals("")) {
			out.print("");
			return;
		}
		
		Sys_templet templet = treeService.getTemplet(treeid);
		
		//获取table
		Sys_table table = tableService.get(tableid);
		
//		//获取当前session登录帐户
		Sys_account account = getSessionAccount();
		List<Sys_templetfield> fields = templetfieldService.getAccountTempletfields(templet.getId(),table.getTabletype(),account.getId());
		
		resultMap.put("fields", fields);
		//获取档案信息
		List<String> idList = new ArrayList<String>();
		idList.add(id);
		List<Map<String, Object>> maps = dynamicService.get("","",table.getId(),idList);
		
		if (null == maps || maps.size() == 0) {
			out.print("");
			return;
		}
		resultMap.put("maps", maps);
		
		resultMap.put("tabletype", table.getTabletype());
		resultMap.put("templettype", templet.getTemplettype());
		//如果是文件级，获取案卷级信息，页面仅显示
		if (table.getTabletype().equals("02")) {
			List<Sys_templetfield> ajField = templetfieldService.getAccountTempletfields(templet.getId(),"01",account.getId());
			
			resultMap.put("ajField", ajField);
			//获取档案信息
			idList.clear();
			idList.add(maps.get(0).get("parentid").toString());
			List<Map<String, Object>> ajMaps = dynamicService.get(templet.getId(),"01","",idList);
			
			resultMap.put("ajMaps", ajMaps);
		}
		
		String resultStr = JSON.toJSONString(resultMap);
		
		out.print(resultStr);
		
	}
	
	
	
    
    
    //============以下不确定要==============
	
	
//	@RequestMapping(value="/upload3.do",method=RequestMethod.POST)
//    public ModelAndView upload3(@RequestParam("file") MultipartFile file,String treeid,String tabletype,String status,String parentid,HttpServletRequest request,ModelMap modelMap) throws IOException {
//		
//		//获取临时文件的绝对路径
//		String path = getProjectRealPath() + "file" +File.separator + "upload" + File.separator;
//		File excFile = new File(path+"/"+file.getOriginalFilename());
//        FileCopyUtils.copy(file.getBytes(),excFile);
//        
//		//得到excel表内容
//		Excel e = new Excel();
//        Vector v = null;
//        
//        //读取excel文件，jxl只支持xls格式
//        try {
//            v = e.readFromExcel(excFile);
//        }
//        catch (Exception e1) {
//            modelMap.put("failure", "Excel文件读取错误，请检查Excel文件中是否包含上传数据。");
//            return new ModelAndView("/view/archive/archive2/excel_import",modelMap);
//        }
//        
//      //得到excel表第一行列头，作为字段名称
//		String excelFieldName = "";
//		if (v.size() >= 2) {
//			excelFieldName = (String) v.get(0);
//		}
//		else {
//	      	modelMap.put("failure", "Excel文件读取错误，请检查Excel文件中是否包含上传数据。");
//	      	return new ModelAndView("/view/archive/archive2/excel_import",modelMap);
//		}
//		//字段名是以&分隔的，将字段名转成list
//		List<String> excelField = Arrays.asList(v.get(0).toString().split("&&"));
//        
//		//获取表字段
//		List<Sys_templetfield> fields = getTempletfields(treeid, tabletype);
//		modelMap.put("fields", fields);
//		
//		//存储导入字段
//		List<String> tmpFieldList = new ArrayList<String>();
//		HashMap<Integer,String> tmpFieldMap = new HashMap<Integer,String>();
//		//数据库字段名称与excel列头对比，找出需要导入哪些字段
//		for (int i=0;i<fields.size();i++) {
//			String a = fields.get(i).getChinesename();
//			int num = excelField.indexOf(a);
//			if (num >= 0) {
//                tmpFieldList.add(fields.get(i).getEnglishname());
//                tmpFieldMap.put(num,fields.get(i).getEnglishname());
//			}
//		}
//		
//		if (tmpFieldList.size() == 0) {
//			modelMap.put("failure", "Excel文件里没有获取与当前档案匹配的字段，请确认Excel文件的第一行为字段中文名称。");
//	      	return new ModelAndView("/view/archive/archive2/excel_import",modelMap);
//		}
//		
//		
//		//档案系统字段数据
//		Map<String, String> sysFieldMap = new HashMap<String, String>();
//		//生成粘贴的档案系统参数
//		sysFieldMap.put("treeid", treeid);
//		sysFieldMap.put("tabletype", tabletype);
//		sysFieldMap.put("status", status);
//		sysFieldMap.put("parentid", parentid);
//		
//		List<Map<String, String>> archiveList = new ArrayList<Map<String,String>>();
//		
//		//创建json数据
//		for (int i=1;i<v.size();i++) {
//            HashMap<String,String> archiveMap = new HashMap<String,String>();
//			List<String> row = Arrays.asList(v.get(i).toString().split("&&",-1));
//
//			//生成excel导入字段数据
//            Iterator it = tmpFieldMap.keySet().iterator();
//            while (it.hasNext()) {
//                Object key = it.next();
//                archiveMap.put(tmpFieldMap.get(key).toString(),row.get((Integer)key));
//            }
//            archiveList.add(archiveMap);
//		}
//		
//		ResultInfo info = dynamicService.insertArchive(sysFieldMap, archiveList);
//		
//		List<String> idList = (List<String>) info.getData().get("idsList");
//		
//		String orderbyString = getOrderby(fields);
//		//获取导入的数据，前台显示
//		List<Map<String, Object>> maps = dynamicService.get(treeid, "",tabletype, idList,orderbyString,null,null);
//		modelMap.put("maps", maps);
//		modelMap.put("treeid", treeid);
//		
//		//获取当前session登录帐户
//		Sys_account account = getSessionAccount();
//		//获取每页条数(首先获取帐户自己的页数配置，如果没有设置，读取系统配置)
//		HashMap<String, Object> configMap = getConfig(account.getId());
//		//字段截取标准。（列表里字段长度超过标准，被截取)
//		Integer subString = 10;
//		if (null == configMap || configMap.size() == 0) {
//		}
//		else {
//			subString = Integer.parseInt(configMap.get("SUBSTRING").toString());
//		}
//		//防止数字错误
//		if (subString < 0) {
//			subString = 10;
//		}
//		//用来前台判断文字截取多少个
//		modelMap.put("subString", subString);
//		modelMap.put("failure", "success");
//		return new ModelAndView("/view/archive/archive2/excel_import",modelMap);
//    }
//	
//	/**
//	 * 获取字段
//	 * @param treeid
//	 * @param tabletype
//	 * @return
//	 */
//	private List<Sys_templetfield> getTempletfields(String treeid,String tabletype) {
//		//获取当前session登录帐户
//		Sys_account account = getSessionAccount();
//		
//		//获取档案字段(先取帐户自己的字段配置，如果没有，获取系统的)
//		List<Sys_templetfield> fieldList = new ArrayList<Sys_templetfield>();
//		fieldList = treeService.getTempletfields(treeid, tabletype,account.getId());
//		
//		if (null == fieldList || fieldList.size() == 0) {
//			fieldList = treeService.geTempletfields(treeid, tabletype);
//		}
//		return fieldList;
//	}
//	
//	/**
//	 * 打开档案管理模块首页
//	 * @param modelMap
//	 * @return
//	 */
//	@RequestMapping(value="/index",method=RequestMethod.GET)
//	public ModelAndView index(ModelMap modelMap) {
////		modelMap = super.getModelMap("ARCHIVEMANAGE","");
//		return new ModelAndView("/view/archive/index",modelMap);
//	}
//	
//	
//	/**
//	 * 打开档案管理功能页
//	 * @param modelMap
//	 * @return
//	 */
//	@RequestMapping(value="/list",method=RequestMethod.GET)
//	public ModelAndView list(ModelMap modelMap) {
//		
////		modelMap = super.getModelMap("ARCHIVEMANAGE","ARCHIVE");
//		
//		//获取当前session登录帐户
//		Sys_account account = getSessionAccount();
//		//根据当前帐户id，获取帐户的档案树节点，用来档案管理里画档案树
//		List<Sys_tree> trees = treeService.getAuthTree(account.getId());
//		String treeJson = "";
//		if (null != trees && trees.size() >0 ) {
//			treeJson = JSON.toJSONString(trees);
//		}
//		
//		treeJson = treeService.createTreeJson(treeJson, getProjectBasePath());
//		modelMap.put("treeList", treeJson);
//		modelMap.put("selectid", "0");
//		//返回的url。返回案卷页，或是文件级页
//		String url = "/view/archive/archive2/list2";
//		
//		return new ModelAndView(url,modelMap);
//	}
//	/**
//	 * ajax获取treeid对应的字段，jqgrid专用字段格式
//	 * @param treeid
//	 * @param tabletype
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/getField",method=RequestMethod.POST)
//	public void getField(String treeid,String tabletype,HttpServletResponse response) throws IOException {
//		//获取templet
//		Sys_templet templet = treeService.getTemplet(treeid);
//		
//		//获取档案字段(先取帐户自己的字段配置，如果没有，获取系统的)
//		List<Sys_templetfield> fieldList = getTempletfields(treeid, tabletype);
//		
//		//=======生成jqgrid列
//		List<String> colNames = new ArrayList<String>();
//		List<Map<String, Object>> colModel = new ArrayList<Map<String,Object>>();
//		//添加id
//		colNames.add("ID");
//		Map<String, Object> idMap = new HashMap<String, Object>();
//		idMap.put("name", "ID");
//		idMap.put("index", "ID");
//		idMap.put("width", 10);
//		idMap.put("key", true);
//		idMap.put("hidden", true);
//		idMap.put("frozen", true);
//		idMap.put("sortable", false);
//		colModel.add(idMap);
//		
//		//添加isdoc
//		colNames.add("全文");
//		Map<String, Object> docMap = new HashMap<String, Object>();
//		docMap.put("name", "ISDOC");
//		docMap.put("index", "ISDOC");
//		docMap.put("width", 30);
//		docMap.put("fixed", true);
//		docMap.put("resizable", false);
//		docMap.put("align", "center");
//		if (tabletype.equals("01")) {
//			docMap.put("formatter", "docFormatter");
//		}
//		else if (tabletype.equals("02")) {
//			docMap.put("formatter", "wjdocFormatter");
//		}
//		
//		docMap.put("frozen", true);
//		//docMap.put("sortable", false);
//		colModel.add(docMap);
//		
//		//添加文件级
//		if (!templet.getTemplettype().equals("F") && tabletype.equals("01")) {
//			colNames.add("文件");
//			Map<String, Object> wMap = new HashMap<String, Object>();
//			wMap.put("name", "SHOWWJ");
//			wMap.put("index", "SHOWWJ");
//			wMap.put("width", 30);
//			wMap.put("fixed", true);
//			wMap.put("resizable", false);
//			wMap.put("align", "center");
//			wMap.put("formatter", "wjFormatter");
//			wMap.put("frozen", true);
//			wMap.put("sortable", false);
//			colModel.add(wMap);
//		}
//		
//		
//		//添加操作列
//		colNames.add("操作");
//		Map<String, Object> funMap = new HashMap<String, Object>();
//		funMap.put("name", "FUN");
//		funMap.put("index", "FUN");
//		funMap.put("width", 40);
//		funMap.put("fixed", true);
//		funMap.put("resizable", false);
//		funMap.put("align", "center");
//		funMap.put("frozen", true);
//		funMap.put("sortable", false);
//		if (tabletype.equals("01")) {
//			funMap.put("formatter", "funFormatter");
//		}
//		else if (tabletype.equals("02")) {
//			funMap.put("formatter", "wjfunFormatter");
//		}
//		colModel.add(funMap);
//		
//		for (int i = 0; i < fieldList.size(); i++) {
//			
//			Sys_templetfield field = fieldList.get(i);
//			if (field.getSort() > 0 && field.getIsgridshow() == 1) {
//				colNames.add(field.getChinesename());
//				Map<String, Object> fieldMap = new HashMap<String, Object>();
//				fieldMap.put("name", field.getEnglishname());
//				fieldMap.put("index", field.getEnglishname());
//				fieldMap.put("width", 100);
//				colModel.add(fieldMap);
//			}
//		}
//		
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap.put("colNames", JSON.toJSONString(colNames));
//		resultMap.put("colModel", JSON.toJSONString(colModel));
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		String json = JSON.toJSONString(resultMap);
//		out.print(json);
//		
//	}
//	
//	/**
//	 * ajax方式获取各种参数。
//	 * @param treeid
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/getProperty",method=RequestMethod.POST)
//	public void getPage(String treeid,HttpServletResponse response) throws IOException {
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		//获取当前session登录帐户
//		Sys_account account = getSessionAccount();
//		
//		//获取每页条数(首先获取帐户自己的页数配置，如果没有设置，读取系统配置)
//		HashMap<String, Object> configMap = getConfig(account.getId());
////						List<Sys_config> configs = configService.getAccountConfig(account.getId());
//		//每页行数
//		Integer pageSize = 30;
//		//字段截取标准。（列表里字段长度超过标准，被截取)
//		Integer subString = 10;
//		String imageshow = "IMAGE";
//		if (null == configMap || configMap.size() == 0) {
//			configMap = getConfig("SYSTEM");
//			pageSize = Integer.parseInt(configMap.get("PAGE").toString());
//		}
//		else {
//			pageSize = Integer.parseInt(configMap.get("PAGE").toString());
//		}
//		
//		//获取templet
//		Sys_templet templet = treeService.getTemplet(treeid);
//		
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap.put("pageSize", pageSize);
//		resultMap.put("templetid", templet.getId());
//		resultMap.put("templettype", templet.getTemplettype());
//		
//		String json = JSON.toJSONString(resultMap);
//		out.print(json);
//	}
//	
//	/*
//	 * 点击树节点，打开档案页
//	 */
//	@RequestMapping(value="/getArchiveData",method=RequestMethod.GET)
//	public ModelAndView getArchiveData(String treeid,String searchTxt,ModelMap modelMap) throws IOException {
//		
//		String url = "/view/archive/archive2/listIframe";
//		if (!treeid.equals("0")) {
//			//获取档案类型
//			Sys_templet templet = treeService.getTemplet(treeid);
//			
//			url = "/view/archive/archive2/listIframe";
//			
//			if (templet.getTemplettype().equals("P") ){
//				url = "/view/archive/archive2/listIframe_pic";
//			}
//		}
//		
//		modelMap.put("treeid", treeid);
//		modelMap.put("searchTxt", searchTxt);
//		return new ModelAndView(url,modelMap);
//	}
//	
//	/**
//	 * ajax方式获取档案记录。jqgrid专用格式
//	 * @param treeid
//	 * @param allwj
//	 * @param tabletype
//	 * @param page
//	 * @param parentid
//	 * @param searchTxt
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/getData2",method=RequestMethod.POST)
//	public void getData2(String treeid,Boolean allwj,String tabletype,Integer page,String parentid,String searchTxt,HttpServletResponse response) throws IOException {
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		PageBean<Map<String, Object>> pageBean = new PageBean<Map<String,Object>>();
//		
//		//获取当前session登录帐户
//		Sys_account account = getSessionAccount();
//		
//		//获取每页条数(首先获取帐户自己的页数配置，如果没有设置，读取系统配置)
//		HashMap<String, Object> configMap = getConfig(account.getId());
////				List<Sys_config> configs = configService.getAccountConfig(account.getId());
//		//每页行数
//		Integer pageSize = 30;
//		//字段截取标准。（列表里字段长度超过标准，被截取)
//		Integer subString = 10;
//		String imageshow = "IMAGE";
//		if (null == configMap || configMap.size() == 0) {
//			configMap = getConfig("SYSTEM");
//			pageSize = Integer.parseInt(configMap.get("PAGE").toString());
//		}
//		else {
//			pageSize = Integer.parseInt(configMap.get("PAGE").toString());
//		}
//		
//		//获取档案类别
//		Sys_templet templet = treeService.getTemplet(treeid);
//		
//		if (pageSize == 0) {
//			pageBean.setIsPage(false);
////			pageBean.setIsPage(true);
////			pageBean.setPageSize(4);
////			pageBean.setPageNo(page);
//		}
//		else {
//			pageBean.setIsPage(true);
//			pageBean.setPageSize(pageSize);
//			pageBean.setPageNo(page);
//		}
//		
//		//获取档案字段(先取帐户自己的字段配置，如果没有，获取系统的)
//		List<Sys_templetfield> fieldList = getTempletfields(treeid, tabletype);
//		pageBean.setOrderBy(getOrderby(fieldList));
//		
//		//获取当前treeid下数据
//		pageBean = dynamicService.archiveList(treeid,"",allwj,parentid,tabletype, searchTxt,0,pageBean);
//		
////		List<Map<String, Object>> list = pageBean.getList();
//		
//		List<Map<String,Object>> list = doMaps(fieldList, pageBean.getList());
//		
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		if (pageSize == 0 ) {
////		if (pageSize == 0 || templet.getTemplettype().equals("P")) {
//			resultMap.put("totalpages", 1);
//			resultMap.put("currpage", 1);
//			resultMap.put("totalrecords", pageBean.getRowCount());
//		}
//		else {
//			resultMap.put("totalpages", pageBean.getPageCount());
//			resultMap.put("currpage", pageBean.getPageNo());
//			resultMap.put("totalrecords", pageBean.getRowCount());
//		}
//		resultMap.put("page", pageSize);
//		
//		Sys_account_tree account_tree = accountService.getTreeAuth(account.getId(), treeid);
//		if (null == account_tree) {
//			Sys_org_tree org_tree = orgService.getTreeAuth(account.getOrgid(), treeid);
//			resultMap.put("treeauth", org_tree);
//		}
//		else {
//			resultMap.put("treeauth", account_tree);
//		}
//		
//		resultMap.put("rows", list);
//		
//		String json = JSON.toJSONString(resultMap);
//		System.out.println("===    "+ json);
//		out.print(json);
//	}
//	
//	/**
//	 * 打开添加页面
//	 * @param	treeid		树节点id
//	 * @param	status		状态值，案卷级-状态：0为正常，1为组卷  。文件级-状态：0为正常，1为组卷，2为零散文件
//	 * @param	parentid	如果是案卷，没有用。如果是文件，案卷级的id
//	 * @param	tabletype	01 or 02
//	 * @return
//	 */
//	@RequestMapping(value="/add",method=RequestMethod.GET)
//	public String add(String treeid,Integer status,String parentid,String tabletype,ModelMap modelMap) {
//		
//		if (null == tabletype || tabletype.equals("")) {
//			tabletype = "01";
//		}
//		
//		List<Sys_templetfield> fieldList = getTempletfields(treeid, tabletype);
//		
//		//获取字段代码，前台页面上生成select
//		Map<String, List<Sys_code>> codeMap =  getFieldCode(fieldList);
//		modelMap.put("codeMap", codeMap);
//		modelMap.put("fields", fieldList);
//		modelMap.put("treeid", treeid);
//		modelMap.put("tabletype", tabletype);
//		if (null == status || status < 0) {
//			status = 0;
//		}
//		modelMap.put("status", status);
//		if (null != parentid && !parentid.equals("")) {
//			modelMap.put("parentid", parentid);
//		}
//		
//		String resultsString = JSON.toJSONString(fieldList);
//		modelMap.put("fieldjson", resultsString);
//		
//		return "/view/archive/archive2/add";
//	}
//	/**
//	 * 添加保存
//	 * @param data
//	 * @param sys
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/save2",method=RequestMethod.POST)
//	public void save2(String data,String sys,HttpServletResponse response) throws IOException {
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		//档案数据
//		Map<String, String> archiveMap = (Map<String, String>) JSON.parse(data);
//		//档案系统字段数据
//		Map<String, String> sysFieldMap = (Map<String, String>) JSON.parse(sys);
//		
//		List<Map<String, String>> archiveList = new ArrayList<Map<String,String>>();
//		archiveList.add(archiveMap);
//		ResultInfo info = dynamicService.insertArchive(sysFieldMap, archiveList);
//		
//		out.print(info.getMsg());
//	}
//	
//	/**
//	 * 打开编辑页面
//	 * @param treeid		档案树节点id
//	 * @param tabletype		表类型  01 or 02
//	 * @param id			档案记录id
//	 * @param multiple		批量编辑。（单个档案编辑、批量编辑）
//	 * @param modelMap
//	 * @return
//	 */
//	@RequestMapping(value="/edit",method=RequestMethod.GET)
//	public ModelAndView edit(String treeid,String tabletype,String id,Boolean multiple,ModelMap modelMap) {
//		//判断id是否存在
//		if (id == null || id.equals("")) {
//			return null;
//		}
//		
//		List<Sys_templetfield> fields = getTempletfields(treeid, tabletype);
//		
//		modelMap.put("fields", fields);
//		
//		//获取信息
//		String[] idArr = id.split(",");
//		List<String> idList = Arrays.asList(idArr);
////		List<String> idList = new ArrayList<String>();
////		idList.add(id);
//		String orderby = getOrderby(fields);
//		List<Map<String, Object>> maps = dynamicService.get(treeid,"", tabletype, idList,orderby,null,null);
//		modelMap.put("maps", maps);
//		
//		String resultsString = JSON.toJSONString(fields);
//		modelMap.put("fieldjson", resultsString);
//		modelMap.put("treeid", treeid);
//		modelMap.put("tabletype", tabletype);
//		
//		//获取字段代码，前台页面上生成select
//		Map<String, List<Sys_code>> codeMap =  getFieldCode(fields);
//		modelMap.put("codeMap", codeMap);
//		
//		//获取templet
//		Sys_templet templet = treeService.getTemplet(treeid);
//		modelMap.put("templet", templet);
//		
//		String url = "/view/archive/archive2/edit";
//		if (null != multiple && multiple == true) {
//			Sys_account account = getSessionAccount();
//			//获取每页条数(首先获取帐户自己的页数配置，如果没有设置，读取系统配置)
//			HashMap<String, Object> configMap = getConfig(account.getId());
//			//字段截取标准。（列表里字段长度超过标准，被截取)
//			Integer subString = 10;
//			if (null == configMap || configMap.size() == 0) {
//			}
//			else {
//				subString = Integer.parseInt(configMap.get("SUBSTRING").toString());
//			}
//			//防止数字错误
//			if (subString < 0) {
//				subString = 10;
//			}
//			//用来前台判断文字截取多少个
//			modelMap.put("subString", subString);
//			
//			url = "/view/archive/archive2/edit_multiple";
//		}
//			
//		
//		//获取对象
//		return new ModelAndView(url,modelMap);
//	}
//	
//	@RequestMapping(value="/update",method=RequestMethod.POST)
//	public void update(String data,String tabletype,HttpServletResponse response) throws IOException {
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		@SuppressWarnings("unchecked")
//		Map<String, String> map = (Map<String, String>) JSON.parse(data);
//		
//		List<Map<String, String>> archiveList = new ArrayList<Map<String,String>>();
//		archiveList.add(map);
//		ResultInfo info = dynamicService.updateArchive(tabletype, archiveList);
//		
//		out.print(info.getMsg());
//	}
//	
//	@RequestMapping(value="/update_multiple",method=RequestMethod.POST)
//	public void update_multiple(String data,HttpServletResponse response) throws IOException {
//		//链接2个字段内容，可中间插入字符sql
////		update A_74 set pass = CONCAT_WS('-', pass,name)
//		//替换字段部分内容sql
////		update A_74 set name = replace(name,"实际","aa")
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		@SuppressWarnings("unchecked")
//		Map<String, String> parMap = (Map<String, String>) JSON.parse(data);
//		
//		String ids = parMap.get("ids");
//		String tc_th_field = parMap.get("tc_th_field");
//		String treeid = parMap.get("treeid");
//		String tabletype = parMap.get("tabletype");
//		String tc_radio = parMap.get("tc_radio");
//		
//		ResultInfo info = new ResultInfo();
//		
//		//如果是填充
//		if (tc_radio.equals("tc") || tc_radio.equals("zk")) {
//			String tc = parMap.get("tc");
//			List<Map<String, String>> archiveList = new ArrayList<Map<String,String>>();
//			
//			String[] idArr = ids.split(",");
//			
//			for (String id : idArr) {
//				Map<String, String> map = new HashMap<String, String>();
//				map.put("id", id);
//				map.put("treeid", treeid);
//				map.put(tc_th_field, tc);
//				archiveList.add(map);
//			}
//			info = dynamicService.updateArchive(tabletype, archiveList);
//		}
//		else if (tc_radio.equals("th")) {
//			//如果是替换
//			String th_key = parMap.get("th_key");
//			String th_value = parMap.get("th_value");
//			
//			if (null == th_value) {
//				th_value = "";
//			}
//			
//			String[] idArr = ids.split(",");
//			List<String> idList = Arrays.asList(idArr);
//			info = dynamicService.updateReplace(treeid, tabletype, idList, tc_th_field, th_key, th_value);
//		}
//		else if (tc_radio.equals("gj")) {
//			//如果是高级修改
//			String firstField = parMap.get("firstField");
//			String txt = parMap.get("txt");
//			String secondField = parMap.get("secondField");
//			
//			String[] idArr = ids.split(",");
//			List<String> idList = Arrays.asList(idArr);
//			
//			info = dynamicService.updateHigh(treeid, tabletype, idList, tc_th_field, firstField, txt, secondField);
//		}
//		else if (tc_radio.equals("xl")) {
//			//如果是序列修改
//			
//			String xl_first = parMap.get("xl_first");
//			String xl_txt = parMap.get("xl_txt");
//			Integer xl_begin = Integer.valueOf(parMap.get("xl_begin"));
//			Integer xl_size = Integer.valueOf(parMap.get("xl_size"));
//			
//			if ("".equals(xl_first) && "".equals(xl_txt)) {
//				List<Map<String, String>> archiveList = new ArrayList<Map<String,String>>();
//				
//				String[] idArr = ids.split(",");
//				
//				Integer num = xl_begin;
//				for (int i=0;i<idArr.length;i++) {
//					
//					Map<String, String> map = new HashMap<String, String>();
//					map.put("id", idArr[i]);
//					map.put("treeid", treeid);
//					map.put(tc_th_field, num.toString());
//					archiveList.add(map);
//					num += xl_size;
//				}
//				info = dynamicService.updateArchive(tabletype, archiveList);
//			}
//			else {
//				//如果序列更新里，包含了序列字段、序列值
//				String[] idArr = ids.split(",");
//				List<String> idList = Arrays.asList(idArr);
//				
//				List<Sys_templetfield> fields = getTempletfields(treeid, tabletype);
//				String orderby = getOrderby(fields);
//				
//				List<Map<String, Object>> archiveList = dynamicService.get(treeid, "", tabletype, idList, orderby, null, null);
//				
//				List<Map<String, String>> updateMaps = new ArrayList<Map<String,String>>();
//				Integer num = xl_begin;
//				for (int i=0;i<archiveList.size();i++) {
//					String first = "";
//					if (!"".equals(xl_first)) {
//						first = archiveList.get(i).get(xl_first).toString();
//					}
//					
//					String updateValue = first + xl_txt + num.toString();
//					
//					Map<String, String> map = new HashMap<String, String>();
//					map.put("id", archiveList.get(i).get("id").toString());
//					map.put("treeid", treeid);
//					map.put(tc_th_field, updateValue);
//					updateMaps.add(map);
//					num += xl_size;
//				}
//				info = dynamicService.updateArchive(tabletype, updateMaps);
//			}
//			
//		}
//		
//		out.print(info.getMsg());
//	}
//	
//	@RequestMapping(value="/show",method=RequestMethod.GET)
//	public ModelAndView show(String treeid,String tabletype,String id,Integer readonly,ModelMap modelMap) throws Exception {
//		//判断id是否存在
//		if (null == id || id.equals("")) {
//			return null;
//		}
//		//readonly作为判断打开的详细页，是否显示功能按钮。例如档案里的文件详细，应该有上传按钮
//		//readonly为0，是包含上传按钮
//		if (null == readonly) {
//			readonly = 0;
//		}
//		modelMap.put("readonly", readonly);
////		//获取当前session登录帐户
//		Sys_account account = getSessionAccount();
////		
//		List<Sys_templetfield> fields = getTempletfields(treeid, tabletype);
//		
//		modelMap.put("fields", fields);
//		//获取档案信息
//		List<String> idList = new ArrayList<String>();
//		idList.add(id);
//		List<Map<String, Object>> maps = dynamicService.get(treeid,"", tabletype, idList,null,null,null);
//		
//		
//		if (null == maps || maps.size() == 0) {
//			return null;
//		}
//		modelMap.put("maps", maps);
//		
//		
//		//如果是文件级，获取案卷级信息，页面仅显示
//		if (tabletype.equals("02")) {
//			List<Sys_templetfield> ajField = getTempletfields(treeid, "01");
//			
//			modelMap.put("ajField", ajField);
//			//获取档案信息
//			idList.clear();
//			idList.add(maps.get(0).get("parentid").toString());
//			List<Map<String, Object>> ajMaps = dynamicService.get(treeid,"", "01", idList,null,null,null);
//			
//			modelMap.put("ajMaps", ajMaps);
//		}
//		
//		
//		Sys_account_tree account_tree = accountService.getTreeAuth(account.getId(), treeid);
//		if (null == account_tree) {
//			Sys_org_tree org_tree = orgService.getTreeAuth(account.getOrgid(), treeid);
//			modelMap.put("treeauth", org_tree);
//		}
//		else {
//			modelMap.put("treeauth", account_tree);
//		}
//		
//		//获取docauth的code，用于前台doc列表填充
//		Sys_code code = new Sys_code();
//		code.setTempletfieldid("DOCAUTH");
//		List<Sys_code> codes = codeService.selectByWhere(code);
//		HashMap<String, String> codeMap = new HashMap<String, String>();
//		for (Sys_code sys_code : codes) {
//			codeMap.put(sys_code.getId(), sys_code.getColumndata());
//		}
//		modelMap.put("codeMap", codeMap);
//		
//		String resultsString = JSON.toJSONString(fields);
//		modelMap.put("fieldjson", resultsString);
//		modelMap.put("treeid", treeid);
//		modelMap.put("tabletype", tabletype);
//		
//		Sys_tree tree = treeService.getById(treeid);
//		
//		//获取table
//		Sys_table table = new Sys_table();
//		table.setTempletid(tree.getTempletid());
//		table.setTabletype(tabletype);
//		table = tableService.selectByWhere(table);
//		
//		List<Sys_doc> docs = new ArrayList<Sys_doc>();
//		//获取档案的电子全文  TODO 要获取当前帐户电子全文权限范围的
//		if (maps.get(0).get("isdoc").toString().equals("1")) {
//			String sql = "select * from sys_doc where tableid=? and fileid=?";
//			List<Object> values = new ArrayList<Object>();
//			values.clear();
//			values.add(table.getId());
//			values.add(id);
//			docs = docService.exeSql(sql, values);
//		}
//		Boolean isFileShow = false;
//		//获取有没有全文浏览器，如果没有，前台不显示查看按钮
//		if (encryService.getInit(24)) {
//			isFileShow = true;
//		}
//		modelMap.put("isFileShow", isFileShow);
//		
//		modelMap.put("docs", docs);
//		
//		Sys_templet templet = treeService.getTemplet(treeid);
//		
//		String url = "/view/archive/archive2/show";
//		if (templet.getTemplettype().equals("P")) {
//			url = "/view/archive/archive2/show_pic";
//		}
//		
//		//获取对象
//		return new ModelAndView(url,modelMap);
//	}
//	
//	@RequestMapping(value="/doc",method=RequestMethod.GET)
//	public ModelAndView doc(String treeid,String tabletype,String id,Integer readonly,Integer isdel,ModelMap modelMap) throws Exception {
//		//判断id是否存在
//		if (null == id || id.equals("")) {
//			return null;
//		}
//		
//		if (null == isdel) {
//			isdel = 0;
//		}
//		
//		modelMap.put("isdel", isdel);
//		modelMap.put("treeid", treeid);
//		modelMap.put("tabletype", tabletype);
//		
//		//readonly作为判断打开的详细页，是否显示功能按钮。例如档案里的文件详细，应该有上传按钮
//		//readonly为0，是包含上传按钮
//		if (null == readonly) {
//			readonly = 0;
//		}
//		modelMap.put("readonly", readonly);
//		
//		Boolean singleArchive = false;
//		String resultUrl = "";
//		
//		Boolean batchDown = false;
//		
//		String[] idArr = id.split(",");
//		//如果就一个档案 或只读取电子文件，转到单个档案全文页面
//		if (idArr.length == 1) {
//			singleArchive = true;
//			resultUrl = "/view/archive/archive2/doc_single";
//		}
//		else {//TODO 批量下载界面，要出现删除按钮，但检索里的批量下载不能有删除。还没解决
//			//如果是多个档案id的电子全文。
//			//如果是只读的，说明不是批量挂接。是显示多个文件下挂接的电子全文集合
//			if (readonly == 1) {
//				singleArchive = true;
//				batchDown = true;
//				resultUrl = "/view/archive/archive2/doc_single";
//			}
//			else {
//				//多个档案，转到批量挂接页面
//				resultUrl = "/view/archive/archive2/doc_multiple";
//			}
//			
//		}
//		modelMap.put("batchDown", batchDown);
//		
//		
//		//获取当前session登录帐户
//		Sys_account account = getSessionAccount();
//		Sys_tree tree = treeService.getById(treeid);
//		
//		//获取table
//		Sys_table table = new Sys_table();
//		table.setTempletid(tree.getTempletid());
//		table.setTabletype(tabletype);
//		table = tableService.selectByWhere(table);
//		
//		
//		//获取档案字段(先取帐户自己的字段配置，如果没有，获取系统的)
//		List<Sys_templetfield> fields = getTempletfields(treeid, tabletype);
//		
//		String orderbyString = getOrderby(fields);
//		
//		//获取档案信息
//		List<String> idList = Arrays.asList(idArr);
//		List<Map<String, Object>> maps = dynamicService.get(treeid, "",tabletype, idList,orderbyString,null,null);
//		modelMap.put("maps", maps);
////		modelMap.put("maps_json", JSON.toJSON(maps));
//		
//		//解决档案信息字符转为json后，特殊字符问题。
//		List<Map<String, Object>> tmpMaps = new ArrayList<Map<String,Object>>();
//		tmpMaps = doMaps(fields,maps);
//		modelMap.put("maps_json", JSON.toJSONString(tmpMaps));
//		
//		//获取每页条数(首先获取帐户自己的页数配置，如果没有设置，读取系统配置)
//		HashMap<String, Object> configMap = getConfig(account.getId());
//		//字段截取标准。（列表里字段长度超过标准，被截取)
//		Integer subString = 10;
//		if (null == configMap || configMap.size() == 0) {
//		}
//		else {
//			subString = Integer.parseInt(configMap.get("SUBSTRING").toString());
//		}
//		//防止数字错误
//		if (subString < 0) {
//			subString = 10;
//		}
//		//用来前台判断文字截取多少个
//		modelMap.put("subString", subString);
//		
//		
//		if (singleArchive) {
//			//获取当前帐户与树的权限（下载、查看）
//			Sys_account_tree account_tree = accountService.getTreeAuth(account.getId(), treeid);
//			if (null == account_tree) {
//				Sys_org_tree org_tree = orgService.getTreeAuth(account.getOrgid(), treeid);
//				modelMap.put("treeauth", org_tree);
//			}
//			else {
//				modelMap.put("treeauth", account_tree);
//			}
//			//获取docauth的code，用于前台doc列表填充
//			Sys_code code = new Sys_code();
//			code.setTempletfieldid("DOCAUTH");
//			List<Sys_code> codes = codeService.selectByWhere(code);
//			HashMap<String, String> codeMap = new HashMap<String, String>();
//			for (Sys_code sys_code : codes) {
//				codeMap.put(sys_code.getId(), sys_code.getColumndata());
//			}
//			modelMap.put("codeMap", codeMap);
//			
//			List<Sys_doc> docs = new ArrayList<Sys_doc>();
//			//获取档案的电子全文 
//			StringBuilder sb = new StringBuilder("select * from sys_doc where tableid=? and fileid in (");
////				String sql = "select * from sys_doc where tableid=? and fileid in (";
//			
//			List<Object> values = new ArrayList<Object>();
//			values.clear();
//			values.add(table.getId());
//			
//			//获取单个或多个档案的电子文件
//			String[] arrayStr =new String[]{};
//		    arrayStr = id.split(",");
//			List<String> idLists = Arrays.asList(arrayStr);
//			
//			Serializable[] ss=new Serializable[idLists.size()];
//			Arrays.fill(ss, "?");
//			sb.append(StringUtils.join(ss,','));
//			sb.append(")");
//			values.addAll(idLists);
//			
//			// TODO 获取当前帐户电子全文权限范围的
//			String docauth = account_tree.getDocauth();
//			if (null != docauth && !"".equals(docauth)) {
//				if (!"1".equals(docauth)) {
//					sb.append(" and docauth=?");
//					values.add(docauth);
//				}
//			}
//			
//			
//			docs = docService.exeSql(sb.toString(), values);
//			
//			modelMap.put("docs", docs);
//		}
//		else {
////			List<Sys_templetfield> fields = treeService.geTempletfields(treeid, tabletype,account.getId());
//			modelMap.put("fields", fields);
//		
//			if (null == maps || maps.size() == 0) {
//				return null;
//			}
//			
//			Sys_account sessionAccount = getSessionAccount();
//	    	if (null == sessionAccount) {
//	            return null;
//	        }
//	    	//获取当前帐户上传的未挂接的所有电子全文，作为批量挂接
//	    	List<Sys_doc> docs_no = new ArrayList<Sys_doc>();
//	    	String sql = "select * from sys_doc where createrid=? and fileid=?";
//			List<Object> values = new ArrayList<Object>();
//			values.clear();
//			values.add(sessionAccount.getId());
//			values.add("");
//			docs_no = docService.exeSql(sql, values);
//			modelMap.put("docs_no", docs_no);
//			modelMap.put("doc_no_json", JSON.toJSON(docs_no));
//			
//			String resultsString = JSON.toJSONString(fields);
//			modelMap.put("fieldjson", resultsString);
//		}
//		
//		Boolean isFileShow = false;
//		//获取有没有全文浏览器，如果没有，前台不显示查看按钮
//		if (encryService.getInit(24)) {
//			isFileShow = true;
//		}
//		modelMap.put("isFileShow", isFileShow);
//		//获取对象
//		return new ModelAndView(resultUrl,modelMap);
//	}
//	
//	/**
//	 * 处理map里的特殊字符
//	 * @param fields
//	 * @param maps
//	 * @return
//	 */
//	private List<Map<String, Object>> doMaps(List<Sys_templetfield> fields,List<Map<String, Object>> maps) {
//		List<Map<String, Object>> tmpMaps = new ArrayList<Map<String,Object>>();
//		for (Map<String, Object> map : maps) {
//			for (Sys_templetfield field : fields) {
//				if (!field.getFieldtype().equals("INT") && field.getSort() >= 0) {
//					Object object = map.get(field.getEnglishname());
//					String tmpStr = "";
//					if (null != object) {
//						tmpStr = object.toString();
//					}
//					
//					if (null != tmpStr && !"".equals(tmpStr)) {
//						tmpStr = htmlEscape(tmpStr);
////						tmpStr = tmpStr.replaceAll("\\\\","\\\\\\\\");
////						tmpStr = tmpStr.replace("'","\\\'");
////						tmpStr = tmpStr.replace("\"","\\\"");
////						tmpStr = tmpStr.replaceAll("[\\t\\n\\r]", "");
//					}
//					map.put(field.getEnglishname(), tmpStr);
//				}
//			}
//			tmpMaps.add(map);
//		}
//		return tmpMaps;
//	}
//	
//	public static String htmlEscape(String input) {
//        if(null == input || input.isEmpty()){
//            return input;
//        }
//        input = input.replaceAll("&", "&amp;");
//        input = input.replaceAll("<", "&lt;");
//        input = input.replaceAll(">", "&gt;");
////        input = input.replaceAll(" ", "&nbsp;");
//        input = input.replaceAll("'", "&#39;");   //IE暂不支持单引号的实体名称,而支持单引号的实体编号,故单引号转义成实体编号,其它字符转义成实体名称
//        input = input.replaceAll("\"", "&quot;"); //双引号也需要转义，所以加一个斜线对其进行转义
//        input = input.replaceAll("\n", "<br/>");  //不能把\n的过滤放在前面，因为还要对<和>过滤，这样就会导致<br/>失效了
//        return input;
//    }
//	
//	
//	/**
//	 * 获取字段的代码项
//	 * @return
//	 */
//	private Map<String, List<Sys_code>> getFieldCode(List<Sys_templetfield> fields) {
//		Map<String, List<Sys_code>> codeMap = new HashMap<String, List<Sys_code>>();
//		
//		List<Object> values = new ArrayList<Object>();
//		
//		//判断哪些字段有code
//		for (Sys_templetfield field : fields) {
//			if (field.getIscode() == 1) {
//				values.clear();
//				values.add(field.getId());
//				List<Sys_code> codes = codeService.list("where templetfieldid=?", values, " order by codeorder asc");
//				if (null != codes && codes.size() > 0) {
//					codeMap.put(field.getId(), codes);
//				}
//			}
//		}
//		return codeMap;
//	}
//	
//	/**
//	 * 打开设置帐户，档案页面显示设置
//	 * @return
//	 */
//	@RequestMapping(value="/setshow",method=RequestMethod.GET)
//	public String setshow(String templetid,String tabletype,Integer readonly,ModelMap modelMap) {
//		
//		if (null == readonly) {
//			readonly = 0;
//		}
//		modelMap.put("readonly", readonly);
//		//获取当前session登录帐户
//		Sys_account account = getSessionAccount();
////		modelMap.put("account", account);
//		//帐户页面显示设置有二类。1、帐户config，包括每页显示条数，字符截取数、多媒体档案显示样式（图片显示、列表显示）。2、字段设置，字段显示、字段排序
//		//获取帐户的配置，如果没有，以系统为标准️添加
////		List<Sys_config> configs = configService.getAccountConfig(account.getId());
////		modelMap.put("configs", configs);
//		
//		Sys_templet templet = templetService.getByid(templetid);
//		modelMap.put("templet", templet);
//		
//		List<Sys_templetfield> templetfields = templetfieldService.getAccountTempletfields(templetid, tabletype, account.getId());
//		modelMap.put("templetfields", templetfields);
//		return "/view/archive/archive2/setshow";
//	}
//	
//	/**
//	 * 打开设置帐户的档案页面显示设置，根据档案类型，显示案卷和文件一起设置
//	 * @return
//	 */
//	@RequestMapping(value="/setshow2",method=RequestMethod.GET)
//	public String setshow(String treeid,Integer readonly,ModelMap modelMap) {
//		
//		if (null == readonly) {
//			readonly = 0;
//		}
//		modelMap.put("readonly", readonly);
//		//获取当前session登录帐户
//		Sys_account account = getSessionAccount();
////		modelMap.put("account", account);
//		//帐户页面显示设置有二类。1、帐户config，包括每页显示条数，字符截取数、多媒体档案显示样式（图片显示、列表显示）。2、字段设置，字段显示、字段排序
//		//获取帐户的配置，如果没有，以系统为标准️添加
////		List<Sys_config> configs = configService.getAccountConfig(account.getId());
////		modelMap.put("configs", configs);
//		Sys_templet templet = treeService.getTemplet(treeid);
////		Sys_templet templet = templetService.getByid(templetid);
//		modelMap.put("templet", templet);
//		
//		String templetType = templet.getTemplettype();
//		//如果是标准档案，或者是多媒体档案，读取案卷级和文件级
//		if ("A".equals(templetType) || "P".equals(templetType)) {
//			List<Sys_templetfield> templetfields_aj = templetfieldService.getAccountTempletfields(templet.getId(), "01", account.getId());
//			modelMap.put("templetfields_aj", templetfields_aj);
//			List<Sys_templetfield> templetfields_wj = templetfieldService.getAccountTempletfields(templet.getId(), "02", account.getId());
//			modelMap.put("templetfields_wj", templetfields_wj);
//		}
//		else if ("F".equals(templetType)) {
//			List<Sys_templetfield> templetfields_wj = templetfieldService.getAccountTempletfields(templet.getId(), "01", account.getId());
//			modelMap.put("templetfields_wj", templetfields_wj);
//		}
//		
//		return "/view/archive/archive2/setshow2";
//	}
//	
//	/**
//	 * 打开编辑字段页面
//	 * @param id
//	 * @param modelMap
//	 * @return
//	 */
//	@RequestMapping(value="/fieldedit",method=RequestMethod.GET)
//	public ModelAndView fieldedit(String id,Integer readonly,ModelMap modelMap) {
//		//判断id是否存在
//		if (id == null || id.equals("")) {
//			return null;
//		}
//		if (null == readonly) {
//			readonly = 0;
//		}
//		modelMap.put("readonly", readonly);
//		//获取对象
//		Sys_templetfield templetfield = templetfieldService.getById(id);
//		modelMap.put("field", templetfield);
//		return new ModelAndView("/view/archive/archive2/fieldedit",modelMap);
//	}
//	
//	/**
//	 * 打印页面调用。
//	 * @param treeid		treeid
//	 * @param parentid		如果是文件级打印，需要条件parentid
//	 * @param tabletype		01 or 02
//	 * @param ids			如果是打印选择的，ids就是选择的记录id
//	 * @return
//	 */
//	@RequestMapping(value="/openprint",method=RequestMethod.GET)
//	public ModelAndView openprint(String treeid,String parentid,String tabletype,String ids,String searchTxt, ModelMap modelMap) {
//		//打印编码
//		//1、案卷目录		AJML
//		//2、文件卷内目录
//		
//		modelMap.put("treeid", treeid);
//		modelMap.put("tabletype", tabletype);
//		modelMap.put("ids", ids);
//		modelMap.put("parentid", parentid);
//		modelMap.put("searchTxt", searchTxt);
//		
//		//获取templet，用来判断是否是纯文件级档案类型
//		Sys_templet templet = treeService.getTemplet(treeid);
//		modelMap.put("templet", templet);
//		
//		//获取字段。用来配对打印项
//		List<Sys_templetfield> fields = getTempletfields(treeid, tabletype);
//		
//		modelMap.put("fields", fields);
//		
//		//如果tabletype ＝ 02 并且parentid不为空，是文件级打印，先获取案卷号，为了打印显示
//		if (tabletype.equals("02") && null != parentid && !"".equals(parentid)) {
//			//获取aj级信息
//			String[] pidArr = parentid.split(",");
//			List<String> idList = Arrays.asList(pidArr);
//			
////			List<String> idList = new ArrayList<String>();
////			idList.add(parentid);
//			List<Map<String, Object>> maps = dynamicService.get(treeid,"", "01", idList,null,null,null);
//			modelMap.put("ajh", maps.get(0).get("AJH"));
//			modelMap.put("bgqx", maps.get(0).get("BGQX"));
//			modelMap.put("nd", maps.get(0).get("ND"));
//			
//		}
//		
//		return new ModelAndView("/view/archive/archive2/print",modelMap);
//	}
//	
//	/**
//	 * 获取打印数据
//	 * @param treeid
//	 * @param parentid		如果是文件级打印，需要条件parentid
//	 * @param tabletype
//	 * @param printcode		打印什么，每个打印有自己的编码，例如要打印案卷目录 为 AJML
//	 * @param printtype		打印的类别。打印选择的，或者打印全部  select  or all
//	 * @param ids			如果是打印选择的，ids就是选择的记录id
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/print",method=RequestMethod.POST)
//	public void print(String treeid,String parentid,String tabletype,String printcode,String printtype,String ids,String searchTxt,HttpServletResponse response) throws IOException {
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//
//		List<Sys_templetfield> fields = getTempletfields(treeid, tabletype);
//		String orderby = getOrderby(fields);
//		
//		List<String> idList = new ArrayList<String>();
//		
//		if (null != ids && !"".equals(ids)) {
//			String[] idsStrings = ids.split(",");
//			idList = Arrays.asList(idsStrings);
//		}
//		
//		List<Map<String, Object>> maps = dynamicService.get(treeid, parentid, tabletype, idList, orderby, 0,searchTxt);
//		
//		List<Map<String,Object>> tmpMaps = doMaps(fields, maps);
//		
//		String result = JSON.toJSONString(tmpMaps);
//		
//		out.print(result);
//	}
//	
//	/**
//	 * 打开导入excel数据页面
//	 * @param data
//	 * @param modelMap
//	 * @return
//	 */
//	@RequestMapping(value="/importArchive.do",method=RequestMethod.GET)
//	public ModelAndView importArchive(String treeid,String tabletype,String status,String parentid,ModelMap modelMap) {
//		
//		modelMap.put("treeid", treeid);
//		modelMap.put("tabletype", tabletype);
//		if (null == status || "".equals(status)) {
//			status = "0";
//		}
//		modelMap.put("status", status);
//		modelMap.put("failure", "");
//		modelMap.put("parentid", parentid);
//		
//		return new ModelAndView("/view/archive/archive2/excel_import",modelMap);
//	}
//	
//	/**
//	 * 上传excel文件，执行导入，返回导入数据
//	 * @param file
//	 * @param treeid		树节点id
//	 * @param tabletype		01 or 02
//	 * @param status		状态值，案卷级-状态：0为正常，1为组卷  。文件级-状态：0为正常，1为组卷，2为零散文件
//	 * @param parentid		如果是文件级，tabletype＝02  的 需要插入parentid
//	 * @param request
//	 * @return
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/upload2.do",method=RequestMethod.POST)
//    public ModelAndView upload2(@RequestParam("file") MultipartFile file,String treeid,String tabletype,String status,String parentid,HttpServletRequest request,ModelMap modelMap) throws IOException {
//		
//		//获取临时文件的绝对路径
//		String path = getProjectRealPath() + "file" +File.separator + "upload" + File.separator;
//		File excFile = new File(path+"/"+file.getOriginalFilename());
//        FileCopyUtils.copy(file.getBytes(),excFile);
//        
//		//得到excel表内容
//		Excel e = new Excel();
//        Vector v = null;
//        
//        //读取excel文件，jxl只支持xls格式
//        try {
//            v = e.readFromExcel(excFile);
//        }
//        catch (Exception e1) {
//            modelMap.put("failure", "Excel文件读取错误，请检查Excel文件中是否包含上传数据。");
//            return new ModelAndView("/view/archive/archive2/excel_import",modelMap);
//        }
//        
//      //得到excel表第一行列头，作为字段名称
//		String excelFieldName = "";
//		if (v.size() >= 2) {
//			excelFieldName = (String) v.get(0);
//		}
//		else {
//	      	modelMap.put("failure", "Excel文件读取错误，请检查Excel文件中是否包含上传数据。");
//	      	return new ModelAndView("/view/archive/archive2/excel_import",modelMap);
//		}
//		//字段名是以&分隔的，将字段名转成list
//		List<String> excelField = Arrays.asList(v.get(0).toString().split("&&"));
//        
//		//获取表字段
//		List<Sys_templetfield> fields = getTempletfields(treeid, tabletype);
//		modelMap.put("fields", fields);
//		
//		//存储导入字段
//		List<String> tmpFieldList = new ArrayList<String>();
//		HashMap<Integer,String> tmpFieldMap = new HashMap<Integer,String>();
//		//数据库字段名称与excel列头对比，找出需要导入哪些字段
//		for (int i=0;i<fields.size();i++) {
//			String a = fields.get(i).getChinesename();
//			int num = excelField.indexOf(a);
//			if (num >= 0) {
//                tmpFieldList.add(fields.get(i).getEnglishname());
//                tmpFieldMap.put(num,fields.get(i).getEnglishname());
//			}
//		}
//		
//		if (tmpFieldList.size() == 0) {
//			modelMap.put("failure", "Excel文件里没有获取与当前档案匹配的字段，请确认Excel文件的第一行为字段中文名称。");
//	      	return new ModelAndView("/view/archive/archive2/excel_import",modelMap);
//		}
//		
//		
//		//档案系统字段数据
//		Map<String, String> sysFieldMap = new HashMap<String, String>();
//		//生成粘贴的档案系统参数
//		sysFieldMap.put("treeid", treeid);
//		sysFieldMap.put("tabletype", tabletype);
//		sysFieldMap.put("status", status);
//		sysFieldMap.put("parentid", parentid);
//		
//		List<Map<String, String>> archiveList = new ArrayList<Map<String,String>>();
//		
//		//创建json数据
//		for (int i=1;i<v.size();i++) {
//            HashMap<String,String> archiveMap = new HashMap<String,String>();
//			List<String> row = Arrays.asList(v.get(i).toString().split("&&",-1));
//
//			//生成excel导入字段数据
//            Iterator it = tmpFieldMap.keySet().iterator();
//            while (it.hasNext()) {
//                Object key = it.next();
//                archiveMap.put(tmpFieldMap.get(key).toString(),row.get((Integer)key));
//            }
//            archiveList.add(archiveMap);
//		}
//		
//		ResultInfo info = dynamicService.insertArchive(sysFieldMap, archiveList);
//		
//		List<String> idList = (List<String>) info.getData().get("idsList");
//		
//		String orderbyString = getOrderby(fields);
//		//获取导入的数据，前台显示
//		List<Map<String, Object>> maps = dynamicService.get(treeid, "",tabletype, idList,orderbyString,null,null);
//		modelMap.put("maps", maps);
//		modelMap.put("treeid", treeid);
//		
//		//获取当前session登录帐户
//		Sys_account account = getSessionAccount();
//		//获取每页条数(首先获取帐户自己的页数配置，如果没有设置，读取系统配置)
//		HashMap<String, Object> configMap = getConfig(account.getId());
//		//字段截取标准。（列表里字段长度超过标准，被截取)
//		Integer subString = 10;
//		if (null == configMap || configMap.size() == 0) {
//		}
//		else {
//			subString = Integer.parseInt(configMap.get("SUBSTRING").toString());
//		}
//		//防止数字错误
//		if (subString < 0) {
//			subString = 10;
//		}
//		//用来前台判断文字截取多少个
//		modelMap.put("subString", subString);
//		modelMap.put("failure", "success");
//		return new ModelAndView("/view/archive/archive2/excel_import",modelMap);
//    }
//	
//	@RequestMapping(value="/exportSession")
//	public void exportSession(String ids,HttpServletRequest request,HttpServletResponse response) throws IOException {
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		//将copy的id存入session
//		CommonUtils.setSessionAttribute(request,"exportSession", ids);
//		
//		out.print("");
//	}
//
//	/**
//	 * 导出excel数据
//	 * @param treeid		 	档案树节点id
//	 * @param tabletype			档案表类型
//	 * @param ids				选择的档案数据id，如果为空，就获取全部导出
//	 * @param parentid			如果tabletype为02，则获取数据需要parentid
//	 * @param request		
//	 * @param response
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/exportArchive2")
//	public void exportArchive2(String treeid,String tabletype,String ids,String parentid,String searchTxt,HttpServletRequest request,HttpServletResponse response) throws Exception {
//		
//		//获取session里的复制codeid
//		ids = (String) CommonUtils.getSessionAttribute(request, "exportSession");
//		
//		//获取字段
//		List<Sys_templetfield> fields = getTempletfields(treeid, tabletype);
//		//获取排序规则
//		String orderby = getOrderby(fields);
//		List<Map<String, Object>> maps = new ArrayList<Map<String,Object>>();
//		//获取导出数据
//		//判断id是否存在
//		if (ids != null && !ids.equals("")) {
//			String[] idArr = ids.split(",");
//			List<String> idList = Arrays.asList(idArr);
//			maps = dynamicService.get(treeid,"", tabletype, idList,orderby,0,null);
//		}
//		else {
//			//如果没有传入导出数据id，获取全部数据导出
//			maps = dynamicService.get(treeid,parentid, tabletype, null,orderby,0,searchTxt);
//		}
//		
//		
//		//得到excel表内容
//		//获取临时文件的绝对路径
//		String path = getProjectRealPath() + "file" +File.separator;
//		File tmpFile = new File(path+"/export.xls");
//		
//		Date date = new Date();
//	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//	    String dateString = sdf.format(date);
//	    
//	    Sys_tree tree = treeService.getById(treeid);
//	    
//	    String filename = tree.getTreename()+"-导出数据-"+dateString + ".xls";
//	     
//		File file = new File(path+"/"+filename);
//        FileCopyUtils.copy(tmpFile,file);
//        
//		Excel e = new Excel(file);
//		Vector v = new Vector();
//        
//        e.addSheet("导出数据");
//        
//        //弄字段名
//        String fString = "";
//        for (Sys_templetfield field : fields) {
//			if (field.getSort() > 0) {
//				fString += field.getChinesename() + "&&";
//			}
//		}
//        
//        if (!fString.equals("")) {
//        	fString = fString.substring(0, fString.length()-2);
//        }
//        v.addElement(fString);
//        
//        
//        for (Map<String, Object> map : maps) {
//        	String dString = "";
//        	for (Sys_templetfield field : fields) {
//    			if (field.getSort() > 0) {
//    				Object str = map.get(field.getEnglishname());
//    				if (null == str) {
//    					str = "";
//    				}
//    				
//    				dString += str.toString() + "&&";
//    			}
//    		}
//        	if (!dString.equals("")) {
//        		dString = dString.substring(0, dString.length()-2);
//            }
//        	v.addElement(dString);
//		}
//        e.addContent(v);
//        e.createExcel();
//        
//        //创建后，下载文件
//      //获取doc类型
//        response.setContentType("application/vnd.ms-excel;charset=utf-8");
//        
//        String userAgent = request.getHeader("User-Agent");
//        response.reset();
//        if(userAgent != null && userAgent.indexOf("MSIE") == -1) {
//            // FF
//        	String enableFileName = "=?UTF-8?B?" + (new String(org.apache.commons.codec.binary.Base64.encodeBase64(filename.getBytes("UTF-8")))) + "?=";  
//            response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName); 
//        }else{
//            // IE   
//            String enableFileName = new String(filename.getBytes("GBK"), "ISO-8859-1");   
//            response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName);
//        }
//        
//        request.setCharacterEncoding("UTF-8");  
//        BufferedInputStream bis = null;
//        BufferedOutputStream bos = null;  
//  
//  
//        long fileLength = new File(path+"/"+filename).length();  
//        response.setHeader("Content-Length", String.valueOf(fileLength));
//        
//    	bis = new BufferedInputStream(new FileInputStream(path+"/"+filename));  
//        bos = new BufferedOutputStream(response.getOutputStream());  
//        byte[] buff = new byte[2048];  
//        int bytesRead;  
//        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
//            bos.write(buff, 0, bytesRead);  
//        }  
//        bis.close();  
//        bos.close();
//        
//        
//        //下载完，删除临时文件
//        file.delete();
//	}
//		
//	@RequestMapping(value="/getCopyid",method=RequestMethod.POST)
//	public void getCopyid(HttpServletRequest request,HttpServletResponse response) throws IOException {
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		String result = "";
//		//将copy的id存入session
//		Object resultObject = CommonUtils.getSessionAttribute(request, Constants.data_copy_session);
//		if (resultObject != null) {
//			result = resultObject.toString();
//		}
//		
//		out.print(result);
//	}
//	
//	/**
//	 * 
//	 * @param id
//	 * @param request
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/datacopy",method=RequestMethod.POST)
//	public void datacopy(String treeid,String tabletype,String ids,HttpServletRequest request,HttpServletResponse response) throws IOException {
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		String result = "档案数据复制成功，任意档案树节点下，点击［粘贴］。";
//		
//		if (null == ids || ids.equals("")) {
//			result = "档案数据复制失败，请重新尝试，或与管理员联系。";
//			out.print(result);
//			return;
//		}
//		
//		//将copy的id存入session
//		CommonUtils.setSessionAttribute(request, Constants.data_copy_session, ids);
//		CommonUtils.setSessionAttribute(request, Constants.data_copy_treeid_session, treeid);
//		CommonUtils.setSessionAttribute(request, Constants.data_copy_tabletype_session, tabletype);
//		out.print(result);
//	}
//	
//	/**
//	 * 保存粘贴数据
//	 * @param dy					目标档案类型与源档案类型，字段对应关系
//	 * @param isdoc					是否copy电子文件
//	 * @param targetTreeid			目标档案类型treeid
//	 * @param targetTabletype		目标档案类型的表类型
//	 * @param parentid				如果是文件级，会用到的案卷级id
//	 * @param status				档案的状态
//	 * @param response		
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/datapaster",method=RequestMethod.POST)
//	public void datapaster(String dy,Boolean isdoc,String targetTreeid,String targetTabletype,String parentid,Integer status,HttpServletResponse response) throws IOException {
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		String result = "没有获得足够参数，请重新登录，再尝试操作。";
//		if (null == targetTreeid || "".equals(targetTreeid) || null == targetTabletype || "".equals(targetTabletype)) {
//			out.print(result);
//			return;
//		}
//		
//		if (null == dy || "".equals(dy)) {
//			out.print(result);
//			return;
//		}
//		
//		if (null == status || status < 0) {
//			status = 0;
//		}
//		
//		//获取session里的复制codeid
//		String ids = (String) CommonUtils.getSessionAttribute(request, Constants.data_copy_session);
//		String treeid = (String) CommonUtils.getSessionAttribute(request, Constants.data_copy_treeid_session);
//		String tabletype = (String) CommonUtils.getSessionAttribute(request, Constants.data_copy_tabletype_session);
//		
//		if (null == ids || ids.equals("")) {
//			out.print(result);
//			return;
//		}
//		
//		HashMap<String, Object> param = new HashMap<String, Object>();
//		param.put("ids", ids);
//		param.put("treeid", treeid);
//		param.put("tabletype", tabletype);
//		param.put("dy", dy);
//		param.put("targetTreeid", targetTreeid);
//		param.put("targetTabletype", targetTabletype);
//		param.put("parentid", parentid);
//		param.put("isdoc", isdoc);
//		param.put("status", status);
//		
//		ResultInfo info = dynamicService.dataPaster(param);
//		
//		out.print(info.getMsg());
//	}
//	
//	@RequestMapping(value="/opendatapaster",method=RequestMethod.GET)
//	public ModelAndView opendatapaster(String targetTreeid,String targetTabletype,String parentid,HttpServletResponse response,ModelMap modelMap) throws IOException {
//		
//		if (null == targetTreeid || "".equals(targetTreeid) || null == targetTabletype || "".equals(targetTabletype)) {
//			return null;
//		}
//		
//		modelMap.put("targetTreeid", targetTreeid);
//		modelMap.put("targetTabletype", targetTabletype);
//		modelMap.put("parentid", parentid);
//		
//		//获取session里的复制codeid
//		String ids = (String) CommonUtils.getSessionAttribute(request, Constants.data_copy_session);
//		String treeid = (String) CommonUtils.getSessionAttribute(request, Constants.data_copy_treeid_session);
//		String tabletype = (String) CommonUtils.getSessionAttribute(request, Constants.data_copy_tabletype_session);
//		
//		if (null == ids || ids.equals("")) {
//			return null;
//		}
//		
//		//获取档案类型、树节点名称等基本信息
//		Sys_templet templet = treeService.getTemplet(treeid);
//		modelMap.put("templet",templet);
//		Sys_templet targetTemplet = treeService.getTemplet(targetTreeid);
//		modelMap.put("targetTemplet", targetTemplet);
//		
//		Sys_tree tree = treeService.getById(treeid);
//		modelMap.put("tree", tree);
//		Sys_tree targetTree = treeService.getById(targetTreeid);
//		modelMap.put("targetTree", targetTree);
//		
//		String[] idArr = ids.split(",");
//		
//		//获取原档案类型的字段
//		List<Sys_templetfield> fields = getTempletfields(treeid, tabletype);
//		modelMap.put("fields", fields);
//		//获取目标档案类型的字段
//		List<Sys_templetfield> fieldsTarget = getTempletfields(targetTreeid, targetTabletype);
//		modelMap.put("fieldsTarget", fieldsTarget);
//		modelMap.put("fieldsTarget_json", JSON.toJSON(fieldsTarget));
//		
//		String orderbyString = getOrderby(fields);
//		
//		//获取档案信息
//		List<String> idList = Arrays.asList(idArr);
//		List<Map<String, Object>> maps = dynamicService.get(treeid, "",tabletype, idList,orderbyString,null,null);
//		modelMap.put("maps", maps);
//		
//		//获取当前session登录帐户
//		Sys_account account = getSessionAccount();
//		//获取每页条数(首先获取帐户自己的页数配置，如果没有设置，读取系统配置)
//		HashMap<String, Object> configMap = getConfig(account.getId());
//		//字段截取标准。（列表里字段长度超过标准，被截取)
//		Integer subString = 10;
//		if (null == configMap || configMap.size() == 0) {
//		}
//		else {
//			subString = Integer.parseInt(configMap.get("SUBSTRING").toString());
//		}
//		//防止数字错误
//		if (subString < 0) {
//			subString = 10;
//		}
//		//用来前台判断文字截取多少个
//		modelMap.put("subString", subString);
//		
//		return new ModelAndView("/view/archive/archive2/datapaster",modelMap);
//	}
//	
//	/**
//	 * 设置多媒体文件级图片为相册封面
//	 * @param id
//	 * @param treeid
//	 * @param tabletype
//	 * @param response
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/setCover",method=RequestMethod.POST)
//	public void setCover(String id,String treeid,String tabletype,HttpServletResponse response) throws IOException {
//		
//		response.setContentType("text/xml;charset=UTF-8");
//		response.setCharacterEncoding("UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		String result = "没有获得足够参数，请重新登录，再尝试操作。";
//		if (null == treeid || "".equals(treeid) || null == tabletype || "".equals(tabletype)) {
//			out.print(result);
//			return;
//		}
//		
//		if (null == id || "".equals(id)) {
//			out.print(result);
//			return;
//		}
//		
//		//获取对象
//		List<String> idList = new ArrayList<String>();
//		idList.add(id);
//		List<Map<String, Object>> maps = dynamicService.get(treeid,"", tabletype, idList,null,null,null);
//				
//		if (null == maps || maps.size() == 0 || maps.size() > 1) {
//			result = "错误代码：Ar_setCover_1。获取的照片文件有问题，请与管理员联系。";
//			out.print(result);
//			return;
//		}
//		
//		Map<String, Object> map = maps.get(0);
//		
//		if (null == map.get("slt") || map.get("slt").equals("")) {
//			result = "没有设置缩略图，请先上传多媒体文件，再设置封面。";
//			out.print(result);
//			return;
//		}
//		
//		//获取aj级信息
//		idList.clear();
//		idList.add(map.get("parentid").toString());
//		List<Map<String, Object>> ajList = dynamicService.get(treeid,"", "01", idList,null,null,null);
//		
//		if (null == ajList || ajList.size()==0) {
//			result = "错误代码：Ar_setCover_2。获取的照片文件有问题，请与管理员联系。";
//			out.print(result);
//			return;
//		}
//		
//		List<Map<String, String>> updateList = new ArrayList<Map<String,String>>();
//		Map<String, String> updateMap = new HashMap<String, String>();
//		updateMap.put("id", ajList.get(0).get("id").toString());
//		updateMap.put("treeid",ajList.get(0).get("treeid").toString());
//		if (map.get("slttype").equals("IMAGE")) {
//			updateMap.put("slt",map.get("slt").toString() );
//		}
//		else if (map.get("slttype").equals("VIDEO")) {
//			updateMap.put("slt","file/pic/video.jpg");
//		}
//		
//		updateList.add(updateMap);
//		ResultInfo info = dynamicService.updateArchive("01", updateList);
//		out.print(info.getMsg());
//	}
//	
//	/**
//	 * 打开单个上传多媒体文件页面
//	 * @param data
//	 * @param modelMap
//	 * @return
//	 */
//	@RequestMapping(value="/open_upload_pic_single",method=RequestMethod.GET)
//	public ModelAndView upload_pic_single(String treeid,String tabletype,String id,ModelMap modelMap) {
//		
//		modelMap.put("treeid", treeid);
//		modelMap.put("tabletype", tabletype);
//		modelMap.put("id", id);
//		
//		return new ModelAndView("/view/archive/archive2/upload_pic_single",modelMap);
//	}
//	
//	@RequestMapping(value="/upload_pic_single",method=RequestMethod.POST)
//    public ModelAndView upload_pic_single(@RequestParam("file") MultipartFile file,String treeid,String tabletype,String id,String slttype,HttpServletRequest request,ModelMap modelMap) throws Exception {
//		
//		String newName = "";
//		String oldName = "";
//		String thumbName = "";
//		
////		String filepath = "file" +File.separator + "pic" + File.separator + treeid + File.separator;
//		String filepath = "file/pic/" + treeid + "/";
//		//获取临时文件的绝对路径
//		String projectpath = getProjectRealPath();
//		String path = projectpath + filepath;
//		
//		FileOperate.isExist(path);
//		
//		String ext = "";//扩展名
//        oldName = file.getOriginalFilename();
//        //获取扩展名
//        if (oldName.lastIndexOf(".") >= 0) {
//            ext = oldName.substring(oldName.lastIndexOf("."));
//        }
//        
//        String uuidString = UUID.randomUUID().toString();
//		newName = uuidString + ext;
//		thumbName = uuidString + "_thumb.jpg";
//		
//		String result = "";
//        //获取数据对象
//  		List<String> idList = new ArrayList<String>();
//  		idList.add(id);
//  		List<Map<String, Object>> maps = dynamicService.get(treeid,"", tabletype, idList,null,null,null);
//  		
//  		if (null == maps || maps.size() == 0 || maps.size() > 1) {
//			result = "错误代码：Ar_upload_pic_single_1。获取多媒体文件错误，请与管理员联系。";
//			modelMap.put("result", result);
//			
//			modelMap.put("treeid", treeid);
//			modelMap.put("tabletype", tabletype);
//			modelMap.put("id", id);
//			
//			return new ModelAndView("/view/archive/archive2/upload_pic_single",modelMap);
//		}
//		
//		Map<String, Object> map = maps.get(0);
//		
//		File excFile = new File(path + "/" + newName);
//        FileCopyUtils.copy(file.getBytes(),excFile);
//        
//        //创建缩略图
//        if (slttype.equals("IMAGE")) {
//        	ResizeImage riImage = new ResizeImage(path + "/" + newName);
//        	riImage.setDestFile(path + "/" + thumbName);
//        	riImage.resizeFix(500, 300);
//        }
//        
//		//如果slt不是空，先删除
//		if (null != map.get("slt") && !map.get("slt").equals("")) {
//			File oldFile = new File(projectpath+"/"+map.get("slt").toString());
//			if (null != oldFile) {
//				oldFile.delete();
//			}
//			//删除原始图
//			File imgnewname = new File(projectpath+"/"+map.get("imgnewname").toString());
//			if (null != imgnewname) {
//				imgnewname.delete();
//			}
//		}
//		
//		List<Map<String, String>> updateList = new ArrayList<Map<String,String>>();
//		Map<String, String> updateMap = new HashMap<String, String>();
//		updateMap.put("id", map.get("id").toString());
//		updateMap.put("treeid",map.get("treeid").toString());
//		updateMap.put("slttype", slttype);
//		updateMap.put("imgoldname", oldName);
//		updateMap.put("imgnewname", filepath + newName);
//		updateMap.put("slt", filepath + thumbName);
//		
//		updateList.add(updateMap);
//		
//		ResultInfo info = dynamicService.updateArchive(tabletype, updateList);
//		
//		modelMap.put("treeid", treeid);
//		modelMap.put("tabletype", tabletype);
//		modelMap.put("id", id);
//		
//		modelMap.put("result", info.getMsg());
//		
//		return new ModelAndView("/view/archive/archive2/upload_pic_single",modelMap);
//    }
//	
//	@RequestMapping(value="/down_pic")
//	public void down_pic(String treeid,String tabletype,String id,HttpServletRequest request,HttpServletResponse response) throws Exception {
//		
//		List<Map<String, Object>> maps = new ArrayList<Map<String,Object>>();
//		//判断id是否存在
//		if (id != null && !id.equals("")) {
//			String[] arrayStr =new String[]{};
//		    arrayStr = id.split(",");
//			List<String> idList = Arrays.asList(arrayStr);
//			maps = dynamicService.get(treeid,"", tabletype, idList,null,null,null);
//		}
//		//如果获取的电子文件为空，返回
//		if (null == maps || maps.size() == 0 ) {
//			response.setCharacterEncoding("UTF-8");
//            response.sendError(HttpStatus.UNAUTHORIZED.value(),"没有找到下载文件.");  
//			return;
//		}
//		//如果只有一个电子文件下载。
//		if (maps.size() == 1) {
//			//如果电子文件名为空，返回
//			if (null == maps.get(0).get("imgnewname") || "".equals(maps.get(0).get("imgnewname"))) {
//				response.setCharacterEncoding("UTF-8");
//	            response.sendError(HttpStatus.UNAUTHORIZED.value(),"没有找到下载文件.");  
//				return;
//			}
//		}
//		
//		//获取临时文件的绝对路径
////		String path = getProjectRealPath() + "file" + File.separator + "pic" + File.separator  + treeid + File.separator;
//		String path = getProjectRealPath();
//		
//		//处理单个或多个电子文件下载。
//		File tmpFile = null;
//		String filename = "";
//		String downFilePath = "";
//		
//		if (maps.size() == 1) {
//			tmpFile = new File(path + maps.get(0).get("imgnewname"));
//		    filename = maps.get(0).get("imgoldname").toString();
//		    downFilePath = path + maps.get(0).get("imgnewname");
//		}
//		else if (maps.size() > 1) {
//			//将多个文件，先下载到临时文件夹.
//			//创建临时文件夹
//			String tmpPath = path + "file" + File.separator + "tmp";
//			
//			//删除上次的zip和临时文件夹
//			FileOperate.delFileOrDir(tmpPath);
//			FileOperate.delFile(path + "file" + File.separator + "批量下载文件.zip");
//			
//			boolean b = FileOperate.newFolder(path + "file" + File.separator + "tmp");
//			//将选择的文件，copy到临时目录，等待压缩
//			for (int i=0;i<maps.size();i++) {
//				
//				String oldPath = path + maps.get(i).get("imgnewname");
//				String newPath = tmpPath + File.separator + maps.get(i).get("imgoldname");
//				//判断文件是否存在
//				File file = new File(oldPath);
//		        if (!file.exists() || null == maps.get(i).get("imgoldname") || "".equals(maps.get(i).get("imgoldname"))) {
//		            continue;
//		        }
//				
//				FileOperate.copyFile(oldPath, newPath);
//			}
//			
//			filename = "批量下载文件.zip";
//			String zipPath = path + "file" + File.separator;
//			//压缩文件
//			ZipUtil.zip(new File(tmpPath), new File(zipPath + filename));
//			
//			tmpFile = new File(zipPath + filename);
//			
//			downFilePath = path + "file" + File.separator + filename;
//			
//			//将压缩文件下载的文件名增加当前时间
//			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
//			String dateString = df.format(new Date());
//			filename = "批量下载文件("+dateString+").zip";
//		}
//		else {
//			response.setCharacterEncoding("UTF-8");
//            response.sendError(HttpStatus.UNAUTHORIZED.value(),"没有找到下载文件.");  
//			return;
//		}
//		
//	     
//        //下载文件
//        //获取doc类型
//        response.setContentType("text/plain;charset=utf-8");
//        
//        String userAgent = request.getHeader("User-Agent");
//        response.reset();
//        if(userAgent != null && userAgent.indexOf("MSIE") == -1) {
//            // FF
//        	String enableFileName = "=?UTF-8?B?" + (new String(org.apache.commons.codec.binary.Base64.encodeBase64(filename.getBytes("UTF-8")))) + "?=";  
//            response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName); 
//        }else{
//            // IE   
//            String enableFileName = new String(filename.getBytes("GBK"), "ISO-8859-1");   
//            response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName);
//        }
//        
//        request.setCharacterEncoding("UTF-8");  
//        BufferedInputStream bis = null;
//        BufferedOutputStream bos = null;
//  
//  
//        long fileLength = tmpFile.length();  
//        response.setHeader("Content-Length", String.valueOf(fileLength));
//        
//    	bis = new BufferedInputStream(new FileInputStream(downFilePath));  
////    	bis = new BufferedInputStream(new FileInputStream(path+"/"+maps.get(0).get("imgnewname")));  
//        bos = new BufferedOutputStream(response.getOutputStream());  
//        byte[] buff = new byte[2048];  
//        int bytesRead;  
//        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
//            bos.write(buff, 0, bytesRead);  
//        };
//        bis.close();  
//        bos.close();
//	}
//	
//	/**
//	 * 打开多媒体上传图片页面
//	 * @param treeid
//	 * @param tabletype
//	 * @param parentid
//	 * @param modelMap
//	 * @return
//	 */
//	@RequestMapping(value = "/show_upload_pic_multiple", method = RequestMethod.GET)
//	public ModelAndView show_upload_pic_multiple(String treeid,String tabletype,String parentid,String status,String slttype,ModelMap modelMap) {
//		modelMap.put("treeid", treeid);
//		modelMap.put("tabletype", tabletype);
//		modelMap.put("parentid", parentid);
//		modelMap.put("status", status);
//		modelMap.put("slttype", slttype);
//		// 获取数据
//		return new ModelAndView("/view/archive/archive2/upload_pic_multiple", modelMap);
//	}
//	
//	/**
//	 * 执行上传多媒体文件
//	 * @param request
//	 * @param response
//	 * @throws Exception 
//	 */
//	@RequestMapping("/upload_pic_multiple")
//	public void upload_pic_multiple(HttpServletRequest request,HttpServletResponse response) throws Exception{
//		
//    	CommonsMultipartResolver multipartResolver  = new CommonsMultipartResolver(request.getSession().getServletContext());
//		if(multipartResolver.isMultipart(request)){
//			MultipartHttpServletRequest  multiRequest = (MultipartHttpServletRequest)request;
//			//获取参数
//			String treeid = request.getParameter("treeid");
//			String tabletype = request.getParameter("tabletype");
//			String parentid = request.getParameter("parentid");
//			String slttype = request.getParameter("slttype");
//			String status = request.getParameter("status");
//			
//			//获取plupload参数
//			Integer chunks = Integer.valueOf(request.getParameter("chunks"));
//			String name = request.getParameter("name");
//			Integer chunk = Integer.valueOf(request.getParameter("chunk"));
//			//获取文件列表
//			Iterator<String>  iter = multiRequest.getFileNames();
//			while(iter.hasNext()){
//				//获取文件对象
//				MultipartFile file = multiRequest.getFile((String)iter.next());
//				//获取临时文件的绝对路径
//				String contextPath = getProjectRealPath() + "file" +File.separator + "upload" + File.separator;
//				//生成临时文件
//		        String dstPath =  contextPath + name;
//		        File dstFile = new File(dstPath);
//		        // 文件已存在（上传了同名的文件)
//		        if (chunk == 0 && dstFile.exists()) {
//		            dstFile.delete();
//		            dstFile = new File(dstPath);
//		        }
//		        //合并文件
//		        cat(file, dstFile);
//		        // 完成一整个文件;
//		        if (chunk == chunks - 1) {
//		        	//获取临时文件对象
//		        	File newFile =new File(contextPath+name);
//		        	
//		        	if(newFile != null){
//		        		uploadSaveData(parentid, slttype,status,tabletype, treeid, newFile);
//					}
//		        }
//			}
//		}
//	}
//	
//	/**
//     * 将原文件，拼接到目标文件dst
//     * @param file
//     * @param dst
//     */
//    private void cat(MultipartFile file, File dst) {
//        InputStream in = null;
//        OutputStream out = null;
//        try {
//            if (dst.exists()) {
//                out = new BufferedOutputStream(new FileOutputStream(dst, true),BUFFER_SIZE);
//            } else {
//                out = new BufferedOutputStream(new FileOutputStream(dst),BUFFER_SIZE);
//            }
//            in = new BufferedInputStream(file.getInputStream(), BUFFER_SIZE);
//
//            byte[] buffer = new byte[BUFFER_SIZE];
//            int len = 0;
//            while ((len = in.read(buffer)) > 0) {
//                out.write(buffer, 0, len);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (null != in) {
//                try {
//                    in.close();
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//            if (null != out) {
//                try {
//                    out.close();
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//    }
//    /**
//     * 多媒体文件上传完毕，插入记录
//     * @param parentid
//     * @param tabletype
//     * @param treeid
//     * @param tmpFile
//     * @return
//     * @throws Exception 
//     */
//    private String uploadSaveData(String parentid,String slttype,String status,String tabletype,
//    		String treeid,File tmpFile) throws Exception {
//    	
//    	String newName = "";
//		String oldName = "";
//		String thumbName = "";
//		
//		String filepath = "file/pic/" + treeid + "/";
////		String filepath = "file" +File.separator + "pic" + File.separator + treeid + File.separator;
//		//获取临时文件的绝对路径
//		String path = getProjectRealPath();
//		
//		String ext = "";//扩展名
//        oldName = tmpFile.getName();
//        //获取扩展名
//        if (oldName.lastIndexOf(".") >= 0) {
//            ext = oldName.substring(oldName.lastIndexOf("."));
//        }
//        
//		String uuidString = UUID.randomUUID().toString();
//		newName = uuidString + ext;
//		thumbName = uuidString + "_thumb.jpg";
//		
//    	tmpFile.renameTo(new File(path + filepath + newName));
//    	
//    	//创建缩略图
//        if (slttype.equals("IMAGE")) {
//        	ResizeImage riImage = new ResizeImage(path + filepath + newName);
//        	riImage.setDestFile(path + filepath + thumbName);
//        	riImage.resizeFix(500, 300);
//        }
//        
//    	//档案系统字段数据
//		Map<String, String> sysFieldMap = new HashMap<String, String>();
//		//生成粘贴的档案系统参数
//		sysFieldMap.put("treeid", treeid);
//		sysFieldMap.put("tabletype", tabletype);
//		sysFieldMap.put("status", status);
//		sysFieldMap.put("parentid", parentid);
//		
//		List<Map<String, String>> archiveList = new ArrayList<Map<String,String>>();
//		
//		//创建json数据
//        HashMap<String,String> archiveMap = new HashMap<String,String>();
//
//        archiveMap.put("slt", filepath + thumbName);
//        archiveMap.put("slttype", slttype);
//        archiveMap.put("imgoldname", oldName);
//        archiveMap.put("imgnewname", filepath + newName);
//        
//        
//        archiveList.add(archiveMap);
//		
//		ResultInfo info = dynamicService.insertArchive(sysFieldMap, archiveList);
//		
//        return info.getMsg();
//    }
//    
//    /**
//     * 播放多媒体（视频或音频）
//     * @param treeid
//     * @param tabletype
//     * @param id
//     * @param modelMap
//     * @return
//     */
//    @RequestMapping(value="/showvideo.do",method=RequestMethod.GET)
//	public ModelAndView showvideo(String treeid,String tabletype,String id,ModelMap modelMap) {
//		
//		modelMap.put("treeid", treeid);
//		modelMap.put("tabletype", tabletype);
//		modelMap.put("id", id);
//		
//		//获取档案信息
//		List<String> idList = new ArrayList<String>();
//		idList.add(id);
//		List<Map<String, Object>> maps = dynamicService.get(treeid,"", tabletype, idList,null,null,null);
//		
//		
//		if (null == maps || maps.size() == 0 || !maps.get(0).get("slttype").equals("VIDEO")) {
//			modelMap.put("result","未找到多媒体文件，请重新尝试或与管理员联系。");
//			return new ModelAndView("/view/archive/archive/jplayer",modelMap);
//		}
//		if (null == maps.get(0).get("slt") || maps.size() == 0 || !maps.get(0).get("slttype").equals("VIDEO")) {
//			modelMap.put("result","未找到多媒体文件，请重新尝试或与管理员联系。");
//			return new ModelAndView("/view/archive/archive/jplayer",modelMap);
//		}
//		
//		String ext = "";//扩展名
//		String oldName = maps.get(0).get("imgoldname").toString();
//        //获取扩展名
//        if (oldName.lastIndexOf(".") >= 0) {
//            ext = oldName.substring(oldName.lastIndexOf("."));
//        }
//        modelMap.put("title", oldName);
//		if (ext.toLowerCase().equals(".mp4")) {
//			modelMap.put("videotype", "m4v");
//			modelMap.put("supplied", "m4v");
//			modelMap.put("mediatype", "video");
//			modelMap.put("solution", "html,flash");
//		}
//		else if (ext.toLowerCase().equals(".webm")) {
//			modelMap.put("supplied", "webmv");
//			modelMap.put("mediatype", "video");
//			modelMap.put("solution", "html,flash");
//		}
//		else if (ext.toLowerCase().equals(".ogg")) {
//			modelMap.put("supplied", "oga");
//			modelMap.put("mediatype", "video");
//			modelMap.put("solution", "flash,html");
//		}
//		else if (ext.toLowerCase().equals(".flv")) {
//			modelMap.put("supplied", "flv");
//			modelMap.put("mediatype", "video");
//			modelMap.put("solution", "flash,html");
//		}
//		else if (ext.toLowerCase().equals(".mp3")) {
//			modelMap.put("supplied", "mp3");
//			modelMap.put("mediatype", "audio");
//			modelMap.put("solution", "flash,html");
//		}
//		else if (ext.toLowerCase().equals(".wav")) {
//			modelMap.put("supplied", "wav");
//			modelMap.put("mediatype", "audio");
//			modelMap.put("solution", "flash,html");
//		}
//		else {
//			modelMap.put("result","未知多媒体文件格式，请重新尝试或与管理员联系。");
//			return new ModelAndView("/view/archive/archive2/jplayer",modelMap);
//		}
//		
//		modelMap.put("maps", maps);
//		
//		return new ModelAndView("/view/archive/archive2/jplayer",modelMap);
//	}
//    
}

package net.ussoft.zhxh.web.system;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Filesdown;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_content;
import net.ussoft.zhxh.model.Public_pic;
import net.ussoft.zhxh.model.Public_video;
import net.ussoft.zhxh.model.Sys_public;
import net.ussoft.zhxh.service.IPublicContentService;
import net.ussoft.zhxh.service.IPublicPicService;
import net.ussoft.zhxh.service.IPublicVideoService;
import net.ussoft.zhxh.service.IPublicfilesdownService;
import net.ussoft.zhxh.service.ISysPublicService;
import net.ussoft.zhxh.util.Constants;
import net.ussoft.zhxh.util.DateUtil;
import net.ussoft.zhxh.util.FileOperate;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;

/**
 * 内容管理  公共
 * @author guodh
 * 
 * */
@Controller
@RequestMapping(value="public")
public class PublicController extends BaseConstroller{

	@Resource
	IPublicPicService picService;	//公共图片
	@Resource
	private IPublicVideoService videoService;	//公共图片
	
	@Resource
	IPublicContentService contentService;  //富文本
	
	@Resource
	IPublicfilesdownService filesdownService;	//文件
	@Resource
	private ISysPublicService sysPublicService;	//文件
	
	/**
	 * 编辑富文本
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/edit",method=RequestMethod.GET)
	public ModelAndView edit(String id,ModelMap modelMap) throws IOException {

		Public_content content = contentService.getById(id);
		
		modelMap.put("content", content);
		
		return new ModelAndView("/view/system/content/uedit", modelMap);
	}
	
	/**
	 * 编辑富文本
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/edit_o",method=RequestMethod.GET)
	public ModelAndView edit(String parentid,String parenttype,ModelMap modelMap) throws IOException {
		List<Public_content> list = contentService.list(parentid, parenttype);
		Public_content content = new Public_content();
		if(list.size() >0){
			content = list.get(0);
		}else{
			content.setId(UUID.randomUUID().toString());
			content.setParentid(parentid);
			content.setParenttype(parenttype);
			content = contentService.insert(content);
		}
		
		modelMap.put("content", content);
		
		return new ModelAndView("/view/system/content/uedit", modelMap);
	}
	
	/**
	 * 保存富文本
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/memo",method=RequestMethod.POST)
	public void save(Public_content content,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "error";
		int num = contentService.update(content);
		if(num >0)
			result = "success";
		out.print(result);
	}
	
	/**
	 * 公共列表 
	 * @param act 用来区分具体功能模块
	 * @param parentid
	 * @param parenttype
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(String act,String parentid,String parenttype,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		//公共图片获取list
		if(act.equals(Constants.PUBLICPIC)){
			List<Public_pic> list = picService.list(parentid,parenttype,-1);
			
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put("total", list.size());
			map.put("data", list);
			String json = JSON.toJSONString(map);
			out.print(json);
		}
		//公共视频获取list
		else if(act.equals(Constants.PUBLICVIDEO)){
			List<Public_video> list = videoService.list(parentid,parenttype);
			
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put("total", list.size());
			map.put("data", list);
			String json = JSON.toJSONString(map);
			out.print(json);
		}
		//公共图片获取list 分页
		else if(act.equals(Constants.PUBLICPIC_PAGE)){
			PageBean<Public_pic> p = new PageBean<Public_pic>();
			p.setPageSize(pageSize);
			p.setPageNo(pageIndex + 1);
			p.setOrderBy("pic_sort");
			p.setOrderType("asc");
			p = picService.list(p,parentid,parenttype);
			
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put("total", p.getRowCount());
			map.put("data", p.getList());
			String json = JSON.toJSONString(map);
			out.print(json);
		}
		//公共 富文本操作
		else if(act.equals(Constants.PUBLIC_CONTENT)){
			PageBean<Public_content> p = new PageBean<Public_content>();
			p.setPageSize(pageSize);
			p.setPageNo(pageIndex + 1);
			p.setOrderBy("sort asc ,createtime desc");
			p = contentService.list(p,parentid,parenttype);
			
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put("total", p.getRowCount());
			map.put("data", p.getList());
			String json = JSON.toJSONString(map);
			out.print(json);
		}
		else if(Constants.PUBLIC_FILE.equals(act)){
			PageBean<Filesdown> p = new PageBean<Filesdown>();
			p.setPageSize(pageSize);
			p.setPageNo(pageIndex +1);
			p.setOrderBy("sort asc,filetime desc");
			p = filesdownService.list(p, parentid, parenttype);
			
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("total", p.getRowCount());
			map.put("data", p.getList());
			String json = JSON.toJSONString(map);
			out.print(json);
		}
		else if(Constants.SYSPUBLIC.equals(act)){
			List<Sys_public> sysPList= sysPublicService.list();
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("total", sysPList.size());
			map.put("data", sysPList);
			String json = JSON.toJSONString(map);
			out.print(json);
		}
		
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
	public void save(String act,String parentid,String parenttype,String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
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
	        	insert(row,act,parentid,parenttype);
	        }
	        else if (state.equals("removed") || state.equals("deleted")) {
	        	if(act.equals(Constants.PUBLICPIC)){
	        		String filePath = row.get("pic_path");
		        	boolean flag = delete(id,act); //需要删除附件的，要有返回值
		        	if(flag){
		        		FileOperate.delFile(super.getProjectRealPath() + filePath);
		        	}
	        	}
	        	else if(act.equals(Constants.PUBLICVIDEO)){
	        		String mp4Path = row.get("mp4newname");
	        		String webmPath = row.get("webmnewname");
	        		boolean isok = delete(id,act); //需要删除附件的，要有返回值
	        		if (isok) {
	        			FileOperate.delFile(super.getProjectRealPath() + mp4Path);
	        			FileOperate.delFile(super.getProjectRealPath() + webmPath);
	        		}
	        	}
	        	else if(Constants.PUBLIC_FILE.equals(act)){
	        		String filePath = row.get("file_path"); //文件地址
	        		String picPath = row.get("pic");	//文件图片
	        		boolean flag = delete(id,act);
	        		if(flag){
	        			FileOperate.delFile(super.getProjectRealPath() + filePath);
	        			FileOperate.delFile(super.getProjectRealPath() + picPath);
	        		}
	        	}
	        	else if(act.equals(Constants.PUBLIC_CONTENT)){
	        		String pic_url = row.get("pic_url"); //富文本标题图片
	        		boolean flag = delete(id, act);
	        		if(flag){
	        			if(null != pic_url)
	        				FileOperate.delFile(super.getProjectRealPath() + pic_url);
	        		}
	        	}
	        	
	        }
	        //更新：_state为空，或modified
	        else if (state.equals("modified") || state.equals(""))	 {
	            update(row,act);
	        }
	    }
		
		out.print(result);
	}
	
	private boolean insert(Map<String,String> row,String act,String parentid,String parenttype) throws IllegalAccessException, InvocationTargetException {
		if (null == row) {
			return false;
		}
		if(act.equals(Constants.PUBLICPIC)){
			Public_pic pic = new Public_pic();
			BeanUtils.populate(pic, row);
			
			pic.setId(UUID.randomUUID().toString());
			pic.setParentid(parentid);
			pic.setParenttype(parenttype);
			pic = picService.insert(pic);
			return true;
		}	//公共视频表插入
		if(act.equals(Constants.PUBLICVIDEO)){
			Public_video video = new Public_video();
			BeanUtils.populate(video, row);
			
			video.setId(UUID.randomUUID().toString());
			video.setParentid(parentid);
			video.setParenttype(parenttype);
			video = videoService.insert(video);
			return true;
		}
		else if(act.equals(Constants.PUBLIC_CONTENT)){
			Public_content content = new Public_content();
			BeanUtils.populate(content, row);
			
			content.setId(UUID.randomUUID().toString());
			content.setParentid(parentid);
			content.setParenttype(parenttype);
			String createtime = DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss");
			content.setCreatetime(createtime);;
			content = contentService.insert(content);
			return true;
		}else if(Constants.PUBLIC_FILE.equals(act)){
			Filesdown filesdown = new Filesdown();
			BeanUtils.populate(filesdown, row);
			filesdown.setId(UUID.randomUUID().toString());
			filesdown.setParentid(parentid);
			filesdown.setParenttype(parenttype);
			filesdown.setFiletime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
			filesdown = filesdownService.insert(filesdown);
			return true;
		}
		return false;
	}
	
	/**
	 * 删除。
	 * @param id
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private boolean delete(String id,String act) throws IOException {
		if (id == null || id.equals("") ) {
			return false;
		}
		int num = 0;
		if(act.equals(Constants.PUBLICPIC)){
			num = picService.delete(id);
		}
		else if(act.equals(Constants.PUBLICVIDEO)){
			num = videoService.delete(id);
		}
		else if(act.equals(Constants.PUBLIC_CONTENT)){
			num = contentService.delete(id);
		}
		else if(Constants.PUBLIC_FILE.equals(act)){
			num = filesdownService.delete(id);
		}
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
	private boolean update(Map<String,String> row,String act) throws IOException, IllegalAccessException, InvocationTargetException {
		
		if (null == row) {
			return false;
		}
		int num = 0;
		if(act.equals(Constants.PUBLICPIC)){
			Public_pic pic = new Public_pic();
			BeanUtils.populate(pic, row);
			num = picService.update(pic);
		}
		else if(act.equals(Constants.PUBLICVIDEO)){
			Public_video video = new Public_video();
			BeanUtils.populate(video, row);
			num = videoService.update(video);
		}
		else if(act.equals(Constants.PUBLIC_CONTENT)){
			Public_content pic = new Public_content();
			BeanUtils.populate(pic, row);
			num = contentService.update(pic);
		}
		else if(Constants.PUBLIC_FILE.equals(act)){
			Filesdown fd = new Filesdown();
			BeanUtils.populate(fd, row);
			num = filesdownService.update(fd);
		}
		else if(Constants.LOGO.equals(act)){
			Sys_public tmp = new Sys_public();
			BeanUtils.populate(tmp, row);
			num = sysPublicService.update(tmp);
		}
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
	/**
	 * 专为内容页富文本编辑器上传图片用。存储图片到文件夹，返回路径。
	 * @param file
	 * @param editor
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value="/upload_content_pic",method=RequestMethod.POST,produces = "text/html; charset=UTF-8")
	public String upload_content_pic(@RequestParam("file") MultipartFile file,String editor,HttpServletRequest request) throws IOException {
		String uuidString = "";
		String newName = "";
		String oldName = "";
		String newFilePath = "";
		String path = request.getSession().getServletContext().getRealPath("/file/richedit/");
		
        int size = file.getInputStream().available();
		if (size != 0) {
			
	        String ext = "";//扩展名
	        
	        oldName = file.getOriginalFilename();
	        //获取扩展名
	        if (oldName.lastIndexOf(".") >= 0) {
	            ext = oldName.substring(oldName.lastIndexOf("."));
	        }
	        
	        uuidString = UUID.randomUUID().toString();
	        newName = uuidString + ext;
	        newFilePath = path + "/" + newName;
	        File excFile = new File(newFilePath);
	        FileCopyUtils.copy(file.getBytes(),excFile);
		}
		String project_path = getProjectPath();
		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("window.parent.").append(editor).append(".insertContent('<img src=\""+project_path+"/file/richedit/"+newName+"\"/>');");
		sb.append("window.parent."+editor+".plugins.upload.finish();");
		sb.append("</script>");
		return sb.toString();
        
	}
	
	/**
	 * 文件上传
	 * @param file
	 * @param editor
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value="/upload_content_file",method=RequestMethod.POST,produces = "text/html; charset=UTF-8")
	public String upload_content_file(@RequestParam("file") MultipartFile file,String editor,HttpServletRequest request) throws IOException {
		String uuidString = "";
		String newName = "";
		String oldName = "";
		String newFilePath = "";
		String path = request.getSession().getServletContext().getRealPath("/file/richedit/");
		
        int size = file.getInputStream().available();
		if (size != 0) {
			
	        String ext = "";//扩展名
	        
	        oldName = file.getOriginalFilename();
	        //获取扩展名
	        if (oldName.lastIndexOf(".") >= 0) {
	            ext = oldName.substring(oldName.lastIndexOf("."));
	        }
	        
	        uuidString = UUID.randomUUID().toString();
	        newName = uuidString + ext;
	        newFilePath = path + "/" + newName;
	        File excFile = new File(newFilePath);
	        FileCopyUtils.copy(file.getBytes(),excFile);
		}
		String project_path = getProjectPath();
		StringBuffer sb = new StringBuffer();

		return sb.toString();
        
	}
}

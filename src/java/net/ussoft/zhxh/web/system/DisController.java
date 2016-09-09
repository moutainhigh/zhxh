package net.ussoft.zhxh.web.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Public_dis_config;
import net.ussoft.zhxh.service.IPublicDisService;
import net.ussoft.zhxh.util.Constants;

/**
 * 公共利益分配
 * @author guodh
 * 
 * */
@Controller
@RequestMapping(value="dis")
public class DisController extends BaseConstroller{

	@Resource
	private IPublicDisService disConfigService;	//公共利益
	
	
	/**
	 * 公共列表 
	 * @param act 用来区分具体功能模块
	 * @param parentid
	 * @param parenttype
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(String act,String parentid,String parenttype,@RequestParam(value = "pageIndex", required = false, defaultValue = "0")int pageIndex,@RequestParam(value = "pageSize", required = false, defaultValue = "0")int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String json = "";
		if(Constants.DISCONFIG.equals(act)){
			
			Public_dis_config tmp = disConfigService.getById("1");
			if (null == tmp || "".equals(tmp.getId())) {
				//如果记录不存在，创建一条
				Public_dis_config config = new Public_dis_config();
				config.setId("1");
				disConfigService.insert(config);
				json = JSON.toJSONString(config);
			}
			else {
				json = JSON.toJSONString(tmp);
			}
		}
		else if (Constants.USERSTANDARD.equals(act)) {
			//获取采购标准
			//parenttype 在这里传入的就是userid
			if (parenttype.equals("T")) {
				//如果被设置采购标准是平台，说明是通用标准
				List<Map<String,Object>> resultList = disConfigService.listDisStandard(parentid, parenttype);
				
				json = JSON.toJSONString(resultList.get(0));
				
			}
		}
		
		out.print(json);
	}
	
	@RequestMapping(value="/saveDisConfig",method=RequestMethod.POST)
	public void saveDisConfig(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		
		if ("".equals(objs) || objs == null) {
			out.print(result);
			return;
		}
		Map<String, String> row = (Map<String, String>) JSON.parse(objs);
		Public_dis_config disConfig = new Public_dis_config();
		BeanUtils.populate(disConfig, row);
		
		if (null != disConfig && !"".equals(disConfig.getId())) {
			disConfigService.update(disConfig);
		}
		
		out.print("success");
	}
	
	/**
	 * 保存采购标准
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/saveDisStandard",method=RequestMethod.POST)
	public void saveDisStandard(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		
		if ("".equals(objs) || objs == null) {
			out.print(result);
			return;
		}
		Map<String, Object> row = (Map<String, Object>) JSON.parse(objs);
		
		if (null != row && !"".equals(row.get("parentid"))) {
			List<Map<String, Object>> disList = new ArrayList<Map<String, Object>>();
			disList.add(row);
			disConfigService.updateDisStandard(disList);
		}
		
		out.print("success");
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
	        	boolean flag = delete(id,act); //需要删除附件的，要有返回值
	        	
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
//		if(act.equals(Constants.PUBLICPIC)){
//			Public_pic pic = new Public_pic();
//			BeanUtils.populate(pic, row);
//			
//			pic.setId(UUID.randomUUID().toString());
//			pic.setParentid(parentid);
//			pic.setParenttype(parenttype);
//			pic = picService.insert(pic);
//			return true;
//		}	//公共视频表插入
//		if(act.equals(Constants.PUBLICVIDEO)){
//			Public_video video = new Public_video();
//			BeanUtils.populate(video, row);
//			
//			video.setId(UUID.randomUUID().toString());
//			video.setParentid(parentid);
//			video.setParenttype(parenttype);
//			video = videoService.insert(video);
//			return true;
//		}
//		else if(act.equals(Constants.PUBLIC_CONTENT)){
//			Public_content content = new Public_content();
//			BeanUtils.populate(content, row);
//			
//			content.setId(UUID.randomUUID().toString());
//			content.setParentid(parentid);
//			content.setParenttype(parenttype);
//			String createtime = DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss");
//			content.setCreatetime(createtime);;
//			content = contentService.insert(content);
//			return true;
//		}else if(Constants.PUBLIC_FILE.equals(act)){
//			Filesdown filesdown = new Filesdown();
//			BeanUtils.populate(filesdown, row);
//			filesdown.setId(UUID.randomUUID().toString());
//			filesdown.setParentid(parentid);
//			filesdown.setParenttype(parenttype);
//			filesdown.setFiletime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
//			filesdown = filesdownService.insert(filesdown);
//			return true;
//		}
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
//		if(act.equals(Constants.PUBLICPIC)){
//			num = picService.delete(id);
//		}
//		else if(act.equals(Constants.PUBLICVIDEO)){
//			num = videoService.delete(id);
//		}
//		else if(act.equals(Constants.PUBLIC_CONTENT)){
//			num = contentService.delete(id);
//		}
//		else if(Constants.PUBLIC_FILE.equals(act)){
//			num = filesdownService.delete(id);
//		}
//		if (num <= 0 ) {
//			return false;
//		}
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
//		if(act.equals(Constants.PUBLICPIC)){
//			Public_pic pic = new Public_pic();
//			BeanUtils.populate(pic, row);
//			num = picService.update(pic);
//		}
//		else if(act.equals(Constants.PUBLICVIDEO)){
//			Public_video video = new Public_video();
//			BeanUtils.populate(video, row);
//			num = videoService.update(video);
//		}
//		else if(act.equals(Constants.PUBLIC_CONTENT)){
//			Public_content pic = new Public_content();
//			BeanUtils.populate(pic, row);
//			num = contentService.update(pic);
//		}
//		else if(Constants.PUBLIC_FILE.equals(act)){
//			Filesdown fd = new Filesdown();
//			BeanUtils.populate(fd, row);
//			num = filesdownService.update(fd);
//		}
//		else if(Constants.LOGO.equals(act)){
//			Sys_public tmp = new Sys_public();
//			BeanUtils.populate(tmp, row);
//			num = sysPublicService.update(tmp);
//		}
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
}

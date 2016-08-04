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

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_pic;
import net.ussoft.zhxh.service.IPublicPicService;
import net.ussoft.zhxh.util.FileOperate;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	IPublicPicService picService;
	
	private final String PUBLICPIC = "publicpic";		//公共图片获取list
	private final String PUBLICPIC_PAGE = "publicpic_page";	//公共图片获取list 分页
	private final String SUBJECT = "subject";	//专题
	
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
		if(act.equals(PUBLICPIC)){
			List<Public_pic> list = picService.list(parentid,parenttype);
			
			HashMap<String,Object> map = new HashMap<String,Object>();
			
			map.put("total", list.size());
			map.put("data", list);
			String json = JSON.toJSONString(map);
			out.print(json);
		}
		//公共图片获取list 分页
		else if(act.equals(PUBLICPIC_PAGE)){
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
		//专题制作
		else if(act.equals(SUBJECT)){
			
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
	        	boolean flag = false;
	        	String filePath = "";
	        	if(act.equals(PUBLICPIC)){
	        		filePath = row.get("pic_path");
		        	flag = delete(id,act);
	        	}
	        	
	        	if(flag){
	        		FileOperate.delFile(super.getProjectRealPath() + filePath);
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
		if(act.equals(PUBLICPIC)){
			Public_pic pic = new Public_pic();
			BeanUtils.populate(pic, row);
			
			pic.setId(UUID.randomUUID().toString());
			pic.setParentid(parentid);
			pic.setParenttype(parenttype);
			pic = picService.insert(pic);
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
		if(act.equals(PUBLICPIC)){
			num = picService.delete(id);
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
		if(act.equals(PUBLICPIC)){
			Public_pic pic = new Public_pic();
			BeanUtils.populate(pic, row);
			num = picService.update(pic);
		}
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
}

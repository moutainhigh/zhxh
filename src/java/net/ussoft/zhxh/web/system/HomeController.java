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
import net.ussoft.zhxh.model.Public_pic;
import net.ussoft.zhxh.service.IPublicPicService;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;

@Controller
@RequestMapping(value="home")
public class HomeController extends BaseConstroller{

	@Resource
	IPublicPicService picService;
	
	//公共图片parentid 的值
	private String PARENTID = "home_pic";
	
	/**
	 * 首页轮播图列表
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		List<Public_pic> list = picService.list(PARENTID);
		
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
		Public_pic pic = new Public_pic();
		BeanUtils.populate(pic, row);
		
		pic.setId(UUID.randomUUID().toString());
		pic.setParentid(PARENTID);
		
		pic = picService.insert(pic);
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
		int num = picService.delete(id);
		
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
		Public_pic pic = new Public_pic();
		BeanUtils.populate(pic, row);
		
		int num = picService.update(pic);
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
}

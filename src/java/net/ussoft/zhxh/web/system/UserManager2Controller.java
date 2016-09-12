package net.ussoft.zhxh.web.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicUser2Service;

@Controller
@RequestMapping(value="userManager2")
public class UserManager2Controller extends BaseConstroller{

	@Resource
	private IPublicUser2Service userService;
	
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(String parentid,String identity,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		List<Public_user> brandList = userService.list(parentid,identity);
		
		map.put("total", brandList.size());
		map.put("data", brandList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	
	//===========机构与品牌begin=========
	/**
	 * 获取机构能操作的品牌
	 * @param parentid
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/list_user_brand",method=RequestMethod.POST)
	public void list_user_brand(String parentid,String userid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		List<Public_brand> brandList = userService.list_user_brand(parentid, userid);
		
		map.put("total", brandList.size());
		map.put("data", brandList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 为机构选择品牌
	 * @param parentid
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/list_select_brand",method=RequestMethod.POST)
	public void list_select_brand(String parentid,String userid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		List<Public_brand> brandList = userService.list_select_brand(parentid, userid);
		
		map.put("total", brandList.size());
		map.put("data", brandList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 保存机构的品牌对应
	 * @param brandids		选择的品牌id集合
	 * @param parentid		设置者
	 * @param userid		被设置者
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/saveUserBrand",method=RequestMethod.POST)
	public void saveUserBrand(String brandids,String parentid,String userid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		userService.saveUserBrand(brandids,parentid, userid);
		
		out.print("success");
	}
	
	/*
	 * 
	 */
	@RequestMapping(value="/delUserBrand",method=RequestMethod.POST)
	public void delUserBrand(String parentid,String userid,String brandid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		userService.delUserBrand(parentid, userid,brandid);
		
		out.print("success");
	}
	
	/**
	 * 为机构选择规格
	 * @param parentid
	 * @param userid
	 * @param productid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/list_select_size",method=RequestMethod.POST)
	public void list_select_size(String parentid,String userid,String productid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		List<Public_product_size> sizeList = userService.list_select_size(parentid, userid,productid);
		
		map.put("total", sizeList.size());
		map.put("data", sizeList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	@RequestMapping(value="/listUserStandard",method=RequestMethod.POST)
	public void listUserStandard(String parentid,String userid,String productid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		List<Map<String, Object>> userStandardList = userService.listUserStandard(parentid, userid,productid);
		
		map.put("total", userStandardList.size());
		map.put("data", userStandardList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	
	
	/**
	 * 保存机构对应的规格采购标准
	 * @param brandid		品牌id
	 * @param productid		商品id
	 * @param sizeids		选择的sizeid集合
	 * @param parentid		设置者
	 * @param userid		被设置者
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/saveUserSizeStandard",method=RequestMethod.POST)
	public void saveUserSizeStandard(String brandid,String productid,String sizeids,String parentid,String userid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		userService.saveUserSizeStandard(brandid, productid, sizeids, parentid, userid);
		
		out.print("success");
	}
	
	@RequestMapping(value="/saveStandard",method=RequestMethod.POST)
	public void saveStandard(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
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
		
		userService.saveStandard(rows);
		
		out.print("success");
	}
	
	
	//=============end
}

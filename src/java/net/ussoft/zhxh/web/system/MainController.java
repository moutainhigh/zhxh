package net.ussoft.zhxh.web.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.service.ISysMainService;

/*
 * 主要为综合平台首页信息服务
 */

@Controller
@RequestMapping(value="main")
public class MainController extends BaseConstroller {
	
	@Resource
	private ISysMainService mainService;
	
	/**
	 * 获取首先显示的会员信息
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/getUserInfo",method=RequestMethod.POST)
	public void getUserInfo(HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		//获取代理的个数
		int num_a = mainService.getPublicUserNum("identity", "A");
		
		int num_c = mainService.getPublicUserNum("identity", "C");
		
		int num_z = mainService.getPublicUserNum("identity", "Z");
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("num_a", num_a);
		map.put("num_c", num_c);
		map.put("num_z", num_z);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
}

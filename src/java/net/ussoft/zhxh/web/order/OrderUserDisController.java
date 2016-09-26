package net.ussoft.zhxh.web.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.service.IPublicPhoneCodeLogService;
import net.ussoft.zhxh.service.IPublicUser2Service;
import net.ussoft.zhxh.service.IPublicUserLinkService;

/**
 * 机构利益处理active
 * @author wangf
 *
 */

@Controller
@RequestMapping("/orderUserDis")
public class OrderUserDisController extends BaseConstroller {
	
	@Resource
	private IPublicUser2Service userService;
	@Resource
	private IPublicUserLinkService userlinkService;	//个人中心关联关系
	@Resource
	private IPublicPhoneCodeLogService codeLogService;
	
	/**
	 * 获取机构能操作的品牌
	 * @param parentid
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/listUserBrand",method=RequestMethod.POST)
	public void listUserBrand(String parentid,String userid,String brandname,int pageIndex,int pageSize,
			@RequestParam(value="isPage", defaultValue="false") boolean isPage,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		PageBean<Public_brand> p = new PageBean<>();
		if (isPage) {
			p.setPageSize(pageSize);
			p.setPageNo(pageIndex + 1);
		}
		else {
			p.setIsPage(false);
		}
		
		p = userService.list_user_brand(parentid, userid,brandname,p);
		
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	
	@RequestMapping(value="/listUserStandard",method=RequestMethod.POST)
	public void listUserStandard(String parentid,String userid,String brandid,int pageIndex,int pageSize,
			@RequestParam(value="isPage", defaultValue="false") boolean isPage,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		PageBean<Map<String,Object>> p = new PageBean<Map<String,Object>>();
		if (isPage) {
			p.setPageSize(pageSize);
			p.setPageNo(pageIndex + 1);
		}
		else {
			p.setIsPage(false);
		}
		
		p = userService.listUserStandard(parentid, userid, brandid, "", "", "", p);
		
//		List<Map<String, Object>> userStandardList = userService.listUserStandard(parentid, userid,productid,"","");
		
//		map.put("total", userStandardList.size());
//		map.put("data", userStandardList);
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
}

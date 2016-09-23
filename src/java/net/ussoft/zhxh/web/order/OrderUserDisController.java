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

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
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
	
	
	@RequestMapping(value="/listUserStandard",method=RequestMethod.POST)
	public void listUserStandard(String parentid,String userid,String brandid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		List<Map<String, Object>> userStandardList = userService.listUserStandard(parentid, userid,"",brandid,"");
		
		map.put("total", userStandardList.size());
		map.put("data", userStandardList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
}

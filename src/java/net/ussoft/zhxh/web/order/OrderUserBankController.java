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
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.service.IPublicPhoneCodeLogService;
import net.ussoft.zhxh.service.IPublicUser2Service;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.service.IPublicUserLinkService;

/**
 * 机构利益处理active
 * @author wangf
 *
 */

@Controller
@RequestMapping("/orderUserBank")
public class OrderUserBankController extends BaseConstroller {
	
	@Resource
	private IPublicUserBankService userBankService;
	
	/**
	 * 获取机构的资金帐户
	 * @param parentid
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/listUserBank",method=RequestMethod.POST)
	public void listUserBrand(String parentid,String userid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		List<Map<String,Object>> resultList = userBankService.getUserBankList(parentid,userid);
		
		map.put("total", resultList.size());
		map.put("data", resultList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	
	
}

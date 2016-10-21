package net.ussoft.zhxh.web.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_message;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicMessageService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;
import net.ussoft.zhxh.util.DateUtil;

/**
 * 机构利益处理active
 * @author wangf
 *
 */

@Controller
@RequestMapping("/orderMessage")
public class OrderMessageController extends BaseConstroller {
	
	@Resource
	private IPublicMessageService mService;
	@Resource
	private IPublicUserService userService;
	
	/**
	 * 获取消息
	 * @param receiveid			 接收者id
	 * @param pageIndex
	 * @param pageSize
	 * @param mapObj
	 * @param isPage
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void listUserBrand(String receiveid,String messagetype,int pageIndex,int pageSize,String mapObj,
			@RequestParam(value="isPage", defaultValue="true") boolean isPage,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		PageBean<Public_message> p = new PageBean<>();
		if (isPage) {
			p.setPageSize(pageSize);
			p.setPageNo(pageIndex + 1);
		}
		else {
			p.setIsPage(false);
		}
		
		Map<String, Object> searchMap = new HashMap<String,Object>();
		
		if (null != mapObj && !"".equals(mapObj)) {
			searchMap = (Map<String, Object>) JSON.parse(mapObj);
		}
		
		mService.list(receiveid, messagetype, searchMap, p);
		
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 批量修改。某个字段
	 * @param ids
	 * @param field
	 * @param fieldValue
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/updateBatch",method=RequestMethod.POST)
	public void updateBatch(String ids,String field,String fieldValue,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String flag = "error";
		
		boolean isok = mService.updateBatch(ids, field, fieldValue);
		
		if (isok) {
			flag = "success";
		}
		
		out.print(flag);
	}
	
	
	@RequestMapping(value="/getNum",method=RequestMethod.POST)
	public void getNum(String numType,HttpServletResponse response,HttpServletRequest request) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		Public_user userSession = (Public_user) CommonUtils.getSessionAttribute(request, Constants.PC_USER_SESSION);
		
		HashMap<String,Object> numMap = new HashMap<String,Object>();
		
		if (numType.equals("message")) {
			int m0 = mService.getMessageNum(userSession.getId(),0);
			int m1 = mService.getMessageNum(userSession.getId(),1);
			int m2 = mService.getMessageNum(userSession.getId(),2);
			
			CommonUtils.removeSessionAttribute(request, Constants.ORDER_MESSAGE0_SESSION);
			CommonUtils.removeSessionAttribute(request, Constants.ORDER_MESSAGE1_SESSION);
			CommonUtils.removeSessionAttribute(request, Constants.ORDER_MESSAGE2_SESSION);
			
			CommonUtils.setSessionAttribute(request, Constants.ORDER_MESSAGE0_SESSION, m0);
			CommonUtils.setSessionAttribute(request, Constants.ORDER_MESSAGE1_SESSION, m1);
			CommonUtils.setSessionAttribute(request, Constants.ORDER_MESSAGE2_SESSION, m2);
			
			numMap.put("m0", m0);
			numMap.put("m1", m1);
			numMap.put("m2", m2);
		}
		
		String json = JSON.toJSONString(numMap);
		
		out.print(json);
	}
	/**
	 * 删除消息
	 * @param ids
	 * @param response
	 * @param request
	 * @throws IOException
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public void delete(String ids,HttpServletResponse response,HttpServletRequest request) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		mService.delete(ids);
		
		out.print("success");
	}
	
	@RequestMapping(value="/showMessage",method=RequestMethod.POST)
	public void showMessage(String id,HttpServletResponse response,HttpServletRequest request) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		Public_message m = mService.getById(id);
		
		mService.updateBatch(id, "messagestate", "1");
		
		String json = JSON.toJSONString(m);
		
		out.print(json);
		
	}
	
	@RequestMapping(value="/sendMessage",method=RequestMethod.POST)
	public void sendMessage(String receiveid,Integer messagetype,String messagetxt,HttpServletResponse response,HttpServletRequest request) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		Public_user user = getSessionUser();
		
		Public_message m = new Public_message();
		m.setId(UUID.randomUUID().toString());
		m.setMessagestate(0);
		m.setActiveid("");
		m.setMessagetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		m.setMessagetxt(messagetxt);
		m.setMessagetype(messagetype);
		m.setReceiveid(receiveid);
		Public_user receiveUser = userService.getById(receiveid);
		m.setReceivename(receiveUser.getCompanyname());
		m.setSendid(user.getId());
		m.setSendname(user.getCompanyname());
		
		mService.insert(m);
		
		out.print("success");
		
	}
	
	
	
	
	
}

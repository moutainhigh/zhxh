package net.ussoft.zhxh.web.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_order_logistics;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicMessageService;
import net.ussoft.zhxh.service.IPublicOrderLogisticsService;
import net.ussoft.zhxh.service.IPublicOrderPathService;
import net.ussoft.zhxh.service.IPublicOrderProductService;
import net.ussoft.zhxh.service.IPublicOrderService;
import net.ussoft.zhxh.service.IPublicUser2Service;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;


@Controller
@RequestMapping(value="syspo")
public class SysOrderController extends BaseConstroller {
	
	@Resource
	private IPublicOrderService orderService;
	@Resource
	private IPublicUserService userService;
	@Resource
	private IPublicUser2Service user2Service;
	@Resource
	private IPublicUserBankService bankService;
	@Resource
	private IPublicOrderProductService orderProServivce;
	@Resource
	private IPublicOrderPathService orderPathService;
	@Resource
	private IPublicMessageService messageService;
	@Resource
	private IPublicOrderLogisticsService logisticsService;

	@RequestMapping(value="/syspomain")
	public ModelAndView ordermain(ModelMap modelMap,HttpServletRequest request) throws Exception {
		
		CommonUtils.removeSessionAttribute(request, Constants.ORDER_MESSAGE0_SESSION);
		CommonUtils.removeSessionAttribute(request, Constants.ORDER_MESSAGE1_SESSION);
		CommonUtils.removeSessionAttribute(request, Constants.ORDER_MESSAGE2_SESSION);
		
		Public_user userSession = getSessionUser();
		//获取系统消息数量
		int m0 = messageService.getMessageNum(userSession.getId(), 0);
		int m1 = messageService.getMessageNum(userSession.getId(), 1);
		int m2 = messageService.getMessageNum(userSession.getId(), 2);
		
		CommonUtils.setSessionAttribute(request, Constants.ORDER_MESSAGE0_SESSION, m0);
		CommonUtils.setSessionAttribute(request, Constants.ORDER_MESSAGE1_SESSION, m1);
		CommonUtils.setSessionAttribute(request, Constants.ORDER_MESSAGE2_SESSION, m2);
		
		//未处理订单
		int s = 0,s1 = 0,s3 = 0,s4 = 0;
		if(userSession.getIdentity().equals("A")){
			s1 = orderService.getCount(userSession.getId(), 1,"o"); //等待发货
		}
		if(userSession.getId().equals("1")){
			s3 = orderService.getCount(userSession.getId(), 1,"p"); //等待发货
		}
		int s2 = orderService.getCount(userSession.getId(), 2,"o");	//确认收货
		if(!userSession.getId().equals("1")){
			s4 = orderService.getCount(userSession.getId(), 2,"p"); //确认收货(普通会员)
		}
		if(s1>0 || s2>0 || s4 >0){
			s =1;
		}
		
		if (userSession.getId().equals("1") && s3 > 0) {
			s = 1;
		}
		
		CommonUtils.setSessionAttribute(request, Constants.ORDER_STATUS_MSG, s);
		CommonUtils.setSessionAttribute(request, Constants.ORDER_STATUS_MSG1, s1);
		CommonUtils.setSessionAttribute(request, Constants.ORDER_STATUS_MSG2, s2);
		CommonUtils.setSessionAttribute(request, Constants.ORDER_STATUS_MSG3, s3);
		CommonUtils.setSessionAttribute(request, Constants.ORDER_STATUS_MSG4, s4);
		
		
		//判断登录帐户是否为平台，如果是，去处理订单表可以结算的分润订单
		if (userSession.getId().equals("1")) {
			orderService.setIsshare();
		}
		
		return new ModelAndView("/view/order/main", modelMap);
	}

	/**
	 * 采购订单列表
	 * @param type
	 * @param status
	 * @param search
	 * @param ordertime
	 * */
	@RequestMapping(value="/polist",method=RequestMethod.POST)
	public void allpolist(String type,String status,String search, int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HashMap<String,Object> map = new HashMap<String,Object>();
		PageBean<Map<String,Object>> p = new PageBean<Map<String,Object>>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex + 1);
		p.setOrderBy("ordertime");
		p.setOrderType("desc");
		if(null != type && !"".equals(type)){
			p = orderService.orderlist(type, "1", status, search, p);
		}else{
			p = orderService.orderlist("", "", status, search, p);
		}
		map.put("data", p.getList());
		map.put("total", p.getRowCount());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 普通会员订单列表
	 * @param type
	 * @param status
	 * @param search
	 * @param ordertime
	 * */
	@RequestMapping(value="/customerpolist",method=RequestMethod.POST)
	public void customerpolist(String status,String search, int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HashMap<String,Object> map = new HashMap<String,Object>();
		PageBean<Map<String,Object>> p = new PageBean<Map<String,Object>>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex + 1);
		p.setOrderBy("ordertime");
		p.setOrderType("desc");
		p = orderService.customerorderlist(status, search, p);
		map.put("data", p.getList());
		map.put("total", p.getRowCount());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 订单列表
	 * @param orderType
	 * @param ordernum
	 * @param parentid
	 * @param ordertime
	 * */
	/*public void subpolist(String orderType,String status, int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HashMap<String,Object> map = new HashMap<String,Object>();
		PageBean<Public_order> p = new PageBean<Public_order>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex + 1);
		p.setOrderBy("ordertime");
		p.setOrderType("desc");
		
		Map<String, Object> params = new LinkedHashMap<String, Object>();
		params.put("orderstatus= ", status);
		if("a".equals(orderType)){
			orderType = "o";
			params.put("parentid != ", "1");
		}else{
			params.put("parentid= ", "1");
		}
		params.put("ordertype= ", orderType);	//订单类型-订货平台
//		params.put("orderstatus= ", orderstatus);
		params.put("orderstatus > ", 0);
		
		p = orderService.list(params, p);
		
		//赋username
		List<Public_order> orderlist = setOrderUsername(p.getList(), orderType);
		
		map.put("data", orderlist);
		map.put("total", p.getRowCount());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	*/
	
	/**
	 * 给订单中的userid，parentid 赋username
	 * */
	private List<Public_order> setOrderUsername(List<Public_order> list,String orderType){
		List<Public_order> resultlist = new ArrayList<Public_order>();
		Public_user user_obj = null;
		String userid = "";
		for(Public_order order : list){
			if(!order.getUserid().equals(userid)){
				user_obj = userService.getById(order.getUserid());
				userid = order.getUserid();
			}
			
			if("p".equals(orderType)){
				order.setU_companyname(user_obj.getUsername());
			}else{
				order.setU_companyname(user_obj.getCompanyname());
			}
			
			resultlist.add(order);
		}
		return resultlist;
	}
	
	/**
	 * 订单详情
	 * */
	@RequestMapping(value="/podetails",method=RequestMethod.POST)
	public void orderdetails(String orderid, HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(orderid == null || "".equals(orderid)){
			out.print("error");
			return;
		}
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		//订单商品
		Map<String, Object> op_map = new LinkedHashMap<String, Object>();
		op_map.put("orderid = ", orderid);
		List<Public_order_product> proList = orderProServivce.list(op_map);
		//收货地址
//		Public_order_path orderPath = orderPathService.getByOrderId(orderid);
		
		map.put("data", proList);
//		map.put("address", orderPath);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	
	/**
	 * 商品列表
	 * */
	@RequestMapping(value="/prolist",method=RequestMethod.POST)
	public void productlist(String parentid,String brandid,@RequestParam(value="keyword",defaultValue="")String keyword, HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HashMap<String,Object> map = new HashMap<String,Object>();
		Public_user user = getSessionUser();
		PageBean<Map<String,Object>> p = new PageBean<Map<String,Object>>();
		
		p = user2Service.listUserStandard(parentid, user.getId(), brandid,"","1",keyword,p);
		
		map.put("data",p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	/**
	 * 订单物流信息
	 * */
	@RequestMapping(value="/logistics",method=RequestMethod.POST)
	public void orderlogistics(String orderid, HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(orderid == null || "".equals(orderid)){
			out.print("error");
			return;
		}
		HashMap<String,Object> map = new HashMap<String,Object>();
		Public_order order = orderService.getById(orderid);
		//物流信息
		List<Public_order_logistics> logisticsList = logisticsService.orderLogistics(order);
		map.put("data",logisticsList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 确认发货
	 * @param orderid
	 * @param deliverynum 快递单号
	 * */
	@RequestMapping(value="/sendout",method=RequestMethod.POST)
	public void sendout(String orderid,String deliverynum, HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if ("".equals(orderid) || orderid == null) {
			out.print("error");
			return;
		}
		Public_user user = userService.getById("1");
		Public_order order = orderService.getAuserOrder(orderid,user);
		order.setDeliverynum(deliverynum);
		int num = bankService.sendoutorder(order);
		if(num >0){
//				Public_user pu = userService.getById(order.getParentid());
//				SendSMS.sendMessage(pu.getPhonenumber(), "");
			out.print("1");	//成功
		}else{
			out.print("0");	//失败
		}
		return;
	}
	
	/**
	 * 对订单进行分润
	 * @param orderid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/onOrderShare",method=RequestMethod.POST)
	public void onOrderShare(String orderid, HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(orderid == null || "".equals(orderid)){
			out.print("error");
			return;
		}
		
		bankService.onOrderShare(orderid);
		out.print("success");
	}
	
}

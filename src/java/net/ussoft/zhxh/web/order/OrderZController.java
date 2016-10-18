package net.ussoft.zhxh.web.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_order_path;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Public_user_bank;
import net.ussoft.zhxh.model.Public_user_path;
import net.ussoft.zhxh.service.IPublicMessageService;
import net.ussoft.zhxh.service.IPublicOrderPathService;
import net.ussoft.zhxh.service.IPublicOrderProductService;
import net.ussoft.zhxh.service.IPublicOrderService;
import net.ussoft.zhxh.service.IPublicUser2Service;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.service.IPublicUserLinkService;
import net.ussoft.zhxh.service.IPublicUserPathService;
import net.ussoft.zhxh.service.IPublicUserService;


@Controller
@RequestMapping("/orderZ")
public class OrderZController extends BaseConstroller {
	
	@Resource
	private IPublicOrderService orderService;
	@Resource
	private IPublicUserService userService;
	@Resource
	private IPublicUser2Service user2Service;
	@Resource
	private IPublicUserPathService userPathService;
	@Resource
	private IPublicUserBankService bankService;
	@Resource
	private IPublicOrderProductService orderProServivce;
	@Resource
	private IPublicOrderPathService orderPathService;
	@Resource
	private IPublicMessageService messageService;
	
	/**
	 * 新增订货单
	 * */
	@RequestMapping(value="/newOrder",method=RequestMethod.GET)
	public ModelAndView newOrder (String userid,ModelMap modelMap) throws Exception {
		Public_user user = getSessionUser();
		//收货地址,后期添加设置默认，目前随机取一条
		List<Public_user_path> userPathList = userPathService.list(userid);
		String address_id = "",address = "";
		if(userPathList.size() > 0){
			Public_user_path userpath = userPathList.get(0);
			address_id = userpath.getId();
			address = "收货人："+userpath.getUsername()+"，联系电话："+userpath.getUserphone()+"，收货地址："+userpath.getUserpath();
		}
		
		modelMap.put("address_id", address_id);
		modelMap.put("address", address);
		modelMap.put("userid", userid);
		
		return new ModelAndView("/view/order/z/createorder", modelMap);
	}
	
	/**
	 * 机构经销的品牌
	 * @param parentid
	 * 
	 * */
	@RequestMapping(value="/brandlist",method=RequestMethod.POST)
	public void brandlist(HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		Public_user user = getSessionUser();
		
		//获取一个上级给设置的采购品牌
		List<Public_user> parentList = userService.listParent(user.getId());
		
		Public_user parentUser = new Public_user();
		if (null != parentList && parentList.size() > 0) {
			parentUser = parentList.get(0);
		}
		
		if ("".equals(parentUser.getId())) {
			map.put("total", 0);
			map.put("data", new ArrayList());
			map.put("parentid", "");
			
			String json = JSON.toJSONString(map);
			out.print(json);
		}
		
		PageBean<Public_brand> p = new PageBean<Public_brand>();
		p.setIsPage(false);
		
		//获取机构经销的品牌
		p = user2Service.list_user_brand(parentUser.getId(), user.getId(),"",p);
		
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		map.put("parentid", parentUser.getId());
		
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
	 * 收货地址
	 * @param parentid
	 * 
	 * */
	@RequestMapping(value="/address",method=RequestMethod.POST)
	public void address(HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HashMap<String,Object> map = new HashMap<String,Object>();
		Public_user user = getSessionUser();
		//收货地址
		List<Public_user_path> userPathList = userPathService.list(user.getId());
		
		map.put("data", userPathList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 新增/编辑地址
	 * */
	@RequestMapping(value="/editaddress",method=RequestMethod.POST)
	public void editaddress(String objs, HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if ("".equals(objs) || objs == null) {
			out.print("error");
			return;
		}
		List<Map<String, String>> rows = (List<Map<String, String>>) JSON.parse(objs);
		for(int i=0,l=rows.size(); i<l; i++){
			Map<String,String> row = (Map<String,String>)rows.get(i);
			Public_user_path userPath = new Public_user_path();
			BeanUtils.populate(userPath, row);
			
			editaddress(userPath);
			
		}
		out.print("success");
	}
	//批量添加/修改，应该在service中完成-
	private String editaddress(Public_user_path userPath){
		if(!"".equals(userPath.getId()) && null != userPath.getId()){
			//修改
			int num = userPathService.update(userPath);
			if(num > 0){
				return "success";
			}
		}else{
			userPath.setId(UUID.randomUUID().toString());
			Public_user user = getSessionUser();
			userPath.setUserid(user.getId());
			Public_user_path obj = userPathService.insert(userPath);
			if(obj != null){
				return "success";
			}
		}
		return "error";
	}
	
	/**
	 * 删除地址
	 * @param id
	 * */
	@RequestMapping(value="/deladdress",method=RequestMethod.POST)
	public void deladdress(String id, HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if ("".equals(id) || id == null) {
			out.print("error");
			return;
		}
		int num = userPathService.delete(id);
		if(num > 0){
			out.print("success");
			return;
		}
		out.print("error");
	}
	
	//==========以下不确定要
	
	/**
	 * 创建订货单
	 * */
	@RequestMapping(value="/createorder",method=RequestMethod.POST)
	public void createorder(String objs,String parentid,String addressid,HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if ("".equals(objs) || objs == null || "".equals(parentid) || null == parentid || "".equals(addressid) || null == addressid) {
			out.print("error");
			return;
		}
		List<Public_product_size> psizeList = new ArrayList<Public_product_size>();
		//商品
		List<Map<String, String>> rows = (List<Map<String, String>>) JSON.parse(objs);
		for(int i=0,l=rows.size(); i<l; i++){
			Map<String,String> row = (Map<String,String>)rows.get(i);
			Public_product_size product = new Public_product_size();
			BeanUtils.populate(product, row);
			product.setBrandname(row.get("brandname"));
			psizeList.add(product);
		}
		Public_user user = getSessionUser();
		user.setParentid(parentid); //商家
		user.setAddressid(addressid);
		Public_order order = orderService.createorder(psizeList, user);
		if(order != null){
			out.print("success");
			return;
		}
		out.print("error");
	}
	
	/**
	 * 订货单
	 * */
	@RequestMapping(value="/myorder")
	public ModelAndView myorder (ModelMap modelMap) throws Exception {
		Public_user user = getSessionUser();
		List<Public_user> u_list = userService.listParent(user.getId());
		modelMap.put("u_list", u_list);
		return new ModelAndView("/view/order/order/myorderlist", modelMap);
	}
	
	/**
	 * 订单列表
	 * @param orderType
	 * @param ordernum
	 * @param parentid
	 * @param ordertime
	 * */
	@RequestMapping(value="/orderlist",method=RequestMethod.POST)
	public void orderlist(String orderType,String ordernum,String parentid,String ordertime,String orderstatus, int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HashMap<String,Object> map = new HashMap<String,Object>();
		PageBean<Public_order> p = new PageBean<Public_order>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("ordertime");
		p.setOrderType("desc");
		
		Map<String, Object> params = new LinkedHashMap<String, Object>();
		params.put("ordertype= ", "o");	//订单类型-订货平台
		params.put("ordernumber= ", ordernum);
		params.put("parentid= ", parentid);
		params.put("ordertime= ", ordertime);
		params.put("orderstatus= ", orderstatus);
		Public_user user = getSessionUser();
		if("my".equals(orderType)){
			params.put("userid= ", user.getId());
			p = orderService.list(params, p);
		}else if("sub".equals(orderType)){
			params.put("orderstatus > ", 0);
			params.put("parentid= ", user.getId());
			p = orderService.list(params, p);
		}
		//赋username
		List<Public_order> orderlist = setOrderUsername(p.getList(), orderType);
		
		map.put("data", orderlist);
		map.put("total", p.getRowCount());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	/**
	 * 给订单中的userid，parentid 赋username
	 * */
	private List<Public_order> setOrderUsername(List<Public_order> list,String orderType){
		List<Public_order> resultlist = new ArrayList<Public_order>();
		Public_user user_obj = null;
		if("sub".equals(orderType)){
			String userid = "";
			for(Public_order order : list){
				if(order.getUserid().equals(userid)){
					order.setU_username(user_obj.getUsername());
				}else{
					user_obj = userService.getById(order.getUserid());
					order.setU_username(user_obj.getUsername());
					userid = order.getUserid();
				}
				resultlist.add(order);
			}
		}else if("my".equals(orderType)){
			String parentid = "";
			for(Public_order order : list){
				if(order.getParentid().equals(parentid)){
					order.setP_username(user_obj.getUsername());
				}else{
					user_obj = userService.getById(order.getParentid());
					order.setP_username(user_obj.getUsername());
					parentid = order.getParentid();
				}
				resultlist.add(order);
			}
		}
//		else if("all".equals(orderType)) userid,parentid 都获取
		return resultlist;
	}
	
	/**
	 * 订单详情
	 * */
	@RequestMapping(value="/orderdetails",method=RequestMethod.POST)
	public void orderdetails(String orderid, HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(orderid == null || "".equals(orderid)){
			out.print("error");
			return;
		}
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		//订单
		Public_order order = orderService.getById(orderid);
		//订单商品
		Map<String, Object> op_map = new LinkedHashMap<String, Object>();
		op_map.put("orderid = ", orderid);
		List<Public_order_product> proList = orderProServivce.list(op_map);
		//收货地址
		Public_order_path orderPath = orderPathService.getByOrderId(orderid);
		
		
		map.put("order",order);
		map.put("products", proList);
		map.put("address", orderPath);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	
	
	/**
	 * 我的账户余额（可支配账户）
	 * @param orderid
	 * */
	@RequestMapping(value="/mybank",method=RequestMethod.POST)
	public void mybank(String orderid, HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if ("".equals(orderid) || orderid == null) {
			out.print("error");
			return;
		}
		Public_order order = orderService.getById(orderid);
		Public_user user = getSessionUser();
		Public_user_bank bank = bankService.getUserBank(user.getId(), order.getParentid());
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("ordertotal", order.getOrdertotal());	//订单金额
		map.put("havebank", bank.getHavebank());		//可支配账户余额
		map.put("bankstate", bank.getBankstate());	//账户状态，0:冻结，1:正常
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 付款
	 * @param orderid
	 * */
	@RequestMapping(value="/paymentorder",method=RequestMethod.POST)
	public void paymentorder(String orderid, HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if ("".equals(orderid) || orderid == null) {
			out.print("error");
			return;
		}
		Public_user user = getSessionUser();
		Public_order order = orderService.getAuserOrder(orderid,user);
		if(order.getOrderstatus() == 0){	//未支付状态
			Public_user_bank bank = bankService.getUserBank(user.getId(), order.getParentid());
			if(bank.getBankstate() == 1){
				if(bank.getHavebank() > order.getOrdertotal()){
					int num = bankService.paymentorder(bank,order);
					if(num > 0){
//						Public_user pu = userService.getById(order.getParentid());
//						SendSMS.sendMessage(pu.getPhonenumber(), "");
						out.print("1");	//支付成功
					}
				}else{
					out.print("-1");	//余额不足
				}
			}else{
				out.print("0");	//账户已冻结
			}
		}else{
			out.print("2");	//订单不是未支付状态，可能已经支付过又进行了请求-防止重复扣款
		}
		
		return;
	}
	
	/**
	 * 取消订单
	 * @param orderid
	 * */
	@RequestMapping(value="/cancelorder",method=RequestMethod.POST)
	public void cancelorder(String orderid, HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if ("".equals(orderid) || orderid == null) {
			out.print("error");
			return;
		}
		Public_user user = getSessionUser();
		Public_order order = orderService.getAuserOrder(orderid,user);
		if(order.getOrderstatus() == 1){	//待发货状态
			Public_user_bank bank = bankService.getUserBank(user.getId(), order.getParentid());
			int num = bankService.cancelorder(bank,order);
			if(num >0){
//				Public_user pu = userService.getById(order.getParentid());
//				SendSMS.sendMessage(pu.getPhonenumber(), "");
				out.print("1");	//成功
			}else{
				out.print("0");	//失败
			}
		}else{
			out.print("2");	//订单已发货-不能取消订单
		}
		return;
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
		Public_user user = getSessionUser();
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
	 * 确认签收
	 * @param orderid
	 * */
	@RequestMapping(value="/signorder",method=RequestMethod.POST)
	public void signorder(String orderid,HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if ("".equals(orderid) || orderid == null) {
			out.print("error");
			return;
		}
		Public_user user = getSessionUser();
		Public_order order = orderService.getAuserOrder(orderid,user);
		
		int num = bankService.signorder(order);
		if(num >0){
//				Public_user pu = userService.getById(order.getParentid());
//				SendSMS.sendMessage(pu.getPhonenumber(), "");
			out.print("1");	//成功
		}else{
			out.print("0");	//失败
		}
		return;
	}
}

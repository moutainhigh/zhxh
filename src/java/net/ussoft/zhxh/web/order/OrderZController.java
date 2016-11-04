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
import net.ussoft.zhxh.model.Income_bill;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_order_path;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Public_user_bank;
import net.ussoft.zhxh.model.Public_user_path;
import net.ussoft.zhxh.model.Share_bill;
import net.ussoft.zhxh.service.IIncomeBillService;
import net.ussoft.zhxh.service.IPublicMessageService;
import net.ussoft.zhxh.service.IPublicOrderPathService;
import net.ussoft.zhxh.service.IPublicOrderProductService;
import net.ussoft.zhxh.service.IPublicOrderService;
import net.ussoft.zhxh.service.IPublicUser2Service;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.service.IPublicUserPathService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.service.IShareBillService;
import net.ussoft.zhxh.service.impl.ShareBillService;
import net.ussoft.zhxh.util.BillNO;
import net.ussoft.zhxh.util.DateUtil;


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
	@Resource
	private IIncomeBillService incomeBillService;
	
	/**
	 * 新增订货单
	 * */
	@RequestMapping(value="/newOrder",method=RequestMethod.GET)
	public ModelAndView newOrder (String userid,ModelMap modelMap) throws Exception {
		Public_user user = getSessionUser();
		//收货地址,后期添加设置默认，目前随机取一条
		List<Public_user_path> userPathList = userPathService.list(user.getId());
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
	
	/**
	 * 创建订货单
	 * */
	@RequestMapping(value="/createorder",method=RequestMethod.POST)
	public void createorder(String objs,String parentid,String addressid,String buyuserid,HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if ("".equals(objs) || objs == null || "".equals(parentid) || null == parentid || "".equals(addressid) || null == addressid || "".equals(buyuserid) || null == buyuserid) {
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
		Public_order order = orderService.createorder(psizeList, user,buyuserid,parentid);
		
		//插入收入记录表
		Income_bill bill = new Income_bill();
		bill.setId(UUID.randomUUID().toString());
		bill.setBillno(BillNO.getBillNo());	//流水号
		bill.setOrderid(order.getId());
		Public_user p_user = userService.getById(parentid);
		bill.setParentid(parentid);
		bill.setP_username(p_user.getUsername());
		bill.setP_company(p_user.getCompanyname());
//		Public_user user2 = getSessionUser();
		Public_user user2 = userService.getById(buyuserid);
		bill.setUserid(user2.getId());
		bill.setU_username(user2.getUsername());
		bill.setU_company(user.getCompanyname());
		//金额
		bill.setAccount_receivable(order.getOrdertotal());//应收款
		bill.setAccount_real(0f);//实收款
		bill.setDownpayment(0f);//首付款
		bill.setDownpayment_ratio(0f);//首付比例
		bill.setLoan_amount(0f);//贷款额
		bill.setLoan_amount_real(0f);//贷款实收额
		
		bill.setCreatetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		bill.setBanktime("");//支付回执时间
		bill.setStagesbanktime("");//分期回执时间
		
//		bill.setPaytype(paytype);
		bill.setTrantype(0);	//交易类型——1：现金充值，2：货款充值，3：售额（全），4：售额（分期）0:未知
		
		String[] TRANTYPE_TXT = {"未知","现金充值","货款充值","售额（全款）","售额（分期）"};
		bill.setTrantypetxt(TRANTYPE_TXT[0]);
		bill.setStatus(0);	//（-1：支付失败，0：未支付，1：支付回执成功，2：分期回执成功）
		bill.setRemarks("普通会员["+user2.getUsername()+"]在线购买。");
		incomeBillService.insert(bill);
		
		if(order != null){
			out.print("success");
			return;
		}
		out.print("error");
	}
	
	/**
	 * 订单列表
	 * @param orderType
	 * @param ordernum
	 * @param parentid
	 * @param ordertime
	 * */
	@RequestMapping(value="/orderlist",method=RequestMethod.POST)
	public void orderlist(String orderType,String ordernum,String parentid,String buyuserid,String ordertime,String orderstatus, int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
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
		params.put("ordertype= ", "p");	//订单类型-订货平台
		params.put("ordernumber= ", ordernum);
		params.put("parentid= ", parentid);
		params.put("ordertime= ", ordertime);
		params.put("orderstatus= ", orderstatus);
		Public_user user = getSessionUser();
		if ("my".equals(orderType)){
			params.put("submitid=", user.getId());
			p = orderService.list(params, p);
		}
		else if ("buyuser".equals(orderType)) {
			params.put("userid=",buyuserid);
			params.put("submitid=", user.getId());
			p = orderService.list(params, p);
		}
		else if ("sub".equals(orderType)){
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
		Public_user parent_obj = null;
		Public_user submit_obj = null;
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
			for(Public_order order : list){
				parent_obj = userService.getById(order.getParentid());
				order.setP_username(parent_obj.getCompanyname());
				
				user_obj = userService.getById(order.getUserid());
				order.setU_username(user_obj.getUsername());
				
				submit_obj = userService.getById(order.getSubmitid());
				order.setS_username(submit_obj.getCompanyname());
				resultlist.add(order);
			}
		}
		else if ("buyuser".equals(orderType)) {
			for(Public_order order : list){
				parent_obj = userService.getById(order.getParentid());
				order.setP_username(parent_obj.getCompanyname());
				
				user_obj = userService.getById(order.getUserid());
				order.setU_username(user_obj.getUsername());
				
				submit_obj = userService.getById(order.getSubmitid());
				order.setS_username(submit_obj.getCompanyname());
				
				resultlist.add(order);
			}
		}
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
		
		//支付情况
		Income_bill bill = incomeBillService.getByOrderid(order.getId());
		
		//分润流水
		List<Share_bill> sbList = orderService.getOrderSharebill(orderid);
		
		map.put("order",order);
		map.put("products", proList);
		map.put("address", orderPath);
		map.put("income", bill);
		map.put("sbList", sbList);
		
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
		Public_user user = getSessionUser();
		Public_order order = orderService.getAuserOrder(orderid,user);
		order.setDeliverynum(deliverynum);
		int num = bankService.sendoutorder(order);
		if(num >0){
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
		int num = orderService.signorder(order);
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
		if(order.getOrderstatus() == 0){	//待支付状态
			int num = orderService.cancelorder(order);
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
	 * 支付-跳转到第三方支付平台
	 * */
	@RequestMapping(value="/payment")
	public ModelAndView payment (String id, ModelMap modelMap) throws Exception {
		Income_bill bill = incomeBillService.getById(id);
		modelMap.put("bill", bill);
		return new ModelAndView("/view/order/z/payment", modelMap);
	}
	
	@RequestMapping(value="/getOrderIncomeid",method=RequestMethod.POST)
	public void getOrderIncomeid(String orderid, HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if ("".equals(orderid) || orderid == null) {
			out.print("error");
			return;
		}
		//支付情况
		Income_bill bill = incomeBillService.getByOrderid(orderid);
		
		out.print(bill.getId());
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
	
	
	
	//假的。用来演示普通会员订单支付
	@RequestMapping(value="/orderpay",method=RequestMethod.POST)
	public void orderpay(String orderid, HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(orderid == null || "".equals(orderid)){
			out.print("error");
			return;
		}
		
		Public_order order = orderService.getById(orderid);
		
		Income_bill bill = incomeBillService.getByOrderid(orderid);
		bill.setBindCard("12444443"); 		//已绑短卡号,信用卡快捷支付绑定卡信息后返回前六后四位信用卡号
		bill.setBindMobile("13899887777"); 	//已绑短手机尾号,信用卡快捷支付绑定卡信息后返回前三位后四位手机号码
		bill.setPayAmount(order.getOrdertotal()); 		//该金额代表商户快钱账户最终收到的金额
		bill.setAccount_real(order.getOrdertotal());
		bill.setFee(0f); 					//快钱收取商户的手续费，单位为分
		bill.setDealId("2222"); 		//快钱交易号
		bill.setBankDealId("3333"); 	//银行交易号
		bill.setDealTime("2016-10-11"); 		//快钱交易时间
		
		Public_user user = userService.getById(bill.getUserid());
		int num = bankService.rechargeZ(bill, user.getIdentity());
		
		out.print("success");
	}
	
	/**
	 * 订单商品.供分润按钮，打开分润明细
	 * */
	@RequestMapping(value="/orderShareProduct",method=RequestMethod.POST)
	public void orderShareProduct(String orderid, HttpServletResponse response) throws IOException {
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
		
		//分润流水
		List<Share_bill> sbList = orderService.getOrderSharebill(orderid);
		
		//支付情况
		Income_bill bill = incomeBillService.getByOrderid(order.getId());
		
		List<Public_order> orderlist = new ArrayList<Public_order>();
		orderlist.add(order);
		orderlist = setOrderUsername(orderlist, "buyuser");
		map.put("order",orderlist.get(0));
		map.put("products", proList);
		map.put("sbList", sbList);
		map.put("income", bill);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	
	
	//==========以下不确定要
	
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
	
	
}

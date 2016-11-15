package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicCatDao;
import net.ussoft.zhxh.dao.PublicLogDao;
import net.ussoft.zhxh.dao.PublicMessageDao;
import net.ussoft.zhxh.dao.PublicOrderDao;
import net.ussoft.zhxh.dao.PublicOrderPathDao;
import net.ussoft.zhxh.dao.PublicOrderProductDao;
import net.ussoft.zhxh.dao.PublicProductSizeDao;
import net.ussoft.zhxh.dao.PublicSetUserStandardDao;
import net.ussoft.zhxh.dao.PublicUserBankDao;
import net.ussoft.zhxh.dao.PublicUserDao;
import net.ussoft.zhxh.dao.PublicUserLinkDao;
import net.ussoft.zhxh.dao.PublicUserPathDao;
import net.ussoft.zhxh.dao.ShareBillDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_cat;
import net.ussoft.zhxh.model.Public_log;
import net.ussoft.zhxh.model.Public_message;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_order_path;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_set_user_standard;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Public_user_bank;
import net.ussoft.zhxh.model.Public_user_link;
import net.ussoft.zhxh.model.Public_user_path;
import net.ussoft.zhxh.model.Share_bill;
import net.ussoft.zhxh.service.IPublicOrderService;
import net.ussoft.zhxh.util.DateUtil;
import net.ussoft.zhxh.util.MakeQuerySql;
import net.ussoft.zhxh.util.OrderNO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicOrderService implements IPublicOrderService{

	@Resource
	private PublicOrderDao orderDao;
	@Resource
	private PublicOrderProductDao orderProDao;
	@Resource
	private PublicCatDao catDao;
	@Resource
	private PublicProductSizeDao proSizeDao;
	@Resource
	private PublicUserPathDao userPathDao;
	@Resource
	private PublicOrderPathDao orderPathDao;
	@Resource
	private PublicSetUserStandardDao standardDao;	//
	@Resource
	private PublicUserBankDao bankDao;	//账户
	@Resource
	private PublicUserDao userDao;
	@Resource
	private PublicUserLinkDao userlinkDao;
	@Resource
	private PublicLogDao logDao;
	@Resource
	private PublicMessageDao msgDao;
	@Resource
	private ShareBillDao shareBillDao;	//
	
	@Override
	public Public_order getById(String id) {
		return orderDao.get(id);
	}

	@Override
	public Public_order getAuserOrder(String id,Public_user user) {
		Public_order order = orderDao.get(id);
		Public_user puser = userDao.get(order.getParentid());
		order.setU_username(user.getUsername());
		order.setU_companyname(user.getCompanyname());//机构名称
		order.setP_username(puser.getUsername());
		order.setP_companyanme(puser.getCompanyname());	//
		//查找推荐人ID
		String tuijinaid = getUserLink_ID(order.getUserid(), order.getParentid());
		if(tuijinaid != null){
			Public_user tuser = userDao.get(tuijinaid);
			order.setTid(tuser.getId());
			order.setT_username(tuser.getUsername());
			order.setT_companyname(tuser.getCompanyname());
		}
		return order;
	}
	
	@Override
	public int getCount(String userid,int status,String orderType){
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT COUNT(0) FROM public_order WHERE orderstatus=? and ordertype=?");
		List<Object> values = new ArrayList<Object>();
		values.add(status);
		
		values.add(orderType);
		
		if(status == 1){	//代发货 - 等待发货
			sb.append(" AND parentid=?");
			values.add(userid);
		}else if(status == 2){ //已发货-等待确认签收
			if ("p".equals(orderType)) {
				sb.append(" AND submitid=?");
			}
			else {
				sb.append(" AND userid=?");
			}
			
			values.add(userid);
		}
		return orderDao.getCount(sb.toString(), values);
	}
	
	@Override
	public int getCount(String parentid, String userid, int status,String beginDate,String endDate) {
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT COUNT(0) FROM public_order WHERE 1=1 ");
		List<Object> values = new ArrayList<Object>();
		
		if (null != parentid && !"".equals(parentid)) {
			sb.append(" and parentid=?");
			values.add(parentid);
		}
		
		if (null != userid && !"".equals(userid)) {
			sb.append(" and userid=?");
			values.add(userid);
		}
		
		if (status > 0) {
			sb.append(" and orderstatus=?");
			values.add(status);
		}
		
		if (null != beginDate && !"".equals(beginDate)) {
			sb.append(" and ordertime > ?");
			values.add(beginDate);
		}
		if (null != endDate && !"".equals(endDate)) {
			sb.append(" and ordertime < ?");
			values.add(endDate);
		}
		
		return orderDao.getCount(sb.toString(), values);
	}
	
	@Override
	public List<Public_order> list() {
		return orderDao.getAll();
	}
	
	@Override
	public List<Public_order> list(Map<String, Object> map) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_order.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return orderDao.search(sql, values);
	}

	@Override
	public PageBean<Public_order> list(Map<String, Object> map, PageBean<Public_order> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_order.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return orderDao.search(sql, values, pageBean);
	}

	@Transactional("txManager")
	@Override
	public int update(Public_order order) {
		Public_order obj = orderDao.update(order);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		//订单
		orderDao.del(id);
		//订单商品
		List<Public_order_product> list = getOrderProducts(id);
		for(Public_order_product obj : list){
			orderProDao.del(obj.getId());
		}
		//订单-收货地址
		Public_order_path opath = getByOrderId(id);
		orderPathDao.del(opath.getId());
		return 1;
	}

	@Transactional("txManager")
	@Override
	public Public_order insert(List<String> ids,String userid,String addressid) {
		//购物车提交的商品
		List<Public_cat> catList = catDao.getByIds(ids);
//		if(catList != null)
		//生成主订单
		Public_order order = addOrder(catList,userid);
		//添加订单商品
		addOrderProduct(catList, order.getId());
		//订单-发货地址
		addAddress(addressid, order.getId());
		
		return order;
	}
	
	/**
	 * 生成订单
	 * @param idlist 购买的所有商品ID
	 * */
	private Public_order addOrder(List<Public_cat> catList,String userid){
		float subtotal = 0;		//合计价格
		for(Public_cat obj:catList){
			Public_product_size psize = proSizeDao.get(obj.getProductsizeid());
			//如果特价没有，把售价给它-前台统一使用特价
			if(psize.getSaleprice() == 0){
				psize.setSaleprice(psize.getPrice());
			}
			
			//计算价格
			subtotal += psize.getSaleprice() * obj.getBuycount();
		}
		Public_order order = new Public_order();
		order.setId(UUID.randomUUID().toString());
		order.setUserid(userid);
//		order.setParentid(parentid);			//上级ID
		order.setIdentity("Z");			//身份
		String ordernumber = "PO"+OrderNO.getOrderNo();		//订单号
		order.setOrdernumber(ordernumber);
		order.setOrdertotal(subtotal);			//总金额
		order.setOrderstatus(0);				//待支付
		order.setOrdertype("p");	//来源-pc官网
		order.setOrderstatusmemo("待支付");
		order.setOrdertime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));;
		return orderDao.save(order);
	}
	
	/**
	 * 订单商品
	 * @param idlist 购买的所有商品ID
	 * @param orderId 订单ID
	 * */
	private void addOrderProduct(List<Public_cat> catList,String orderId){
		for(Public_cat obj:catList){
			Public_product_size psize = proSizeDao.get(obj.getProductsizeid());
			//订单商品 
			Public_order_product orderPro = new Public_order_product();
			orderPro.setId(UUID.randomUUID().toString());
			orderPro.setOrderid(orderId);
			orderPro.setProductid(psize.getId());
			orderPro.setProductname(psize.getProductname());
			orderPro.setProductpic(psize.getProductpic());
			orderPro.setProductsize(psize.getProductsize());
			orderPro.setProductnum(obj.getBuycount());		//购买数量
			orderPro.setIsoknum(obj.getBuycount());			//可结算数量（退货时冲减）
			float price = psize.getSaleprice() == 0?psize.getPrice():psize.getSaleprice();
			orderPro.setPrice(price);
			orderPro.setProductmemo(psize.getProductmemo());
			orderPro.setOrdertime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
			orderPro.setStatus(0);	//已购买
			orderProDao.save(orderPro);
		}
	}
	
	/**
	 * 订单-订货地址
	 * @param addressid 
	 * @param orderid
	 * */
	private void addAddress(String addressid,String orderid){
		Public_user_path userPath = userPathDao.get(addressid);
		Public_order_path orderPath = new Public_order_path();
		orderPath.setId(UUID.randomUUID().toString());
		orderPath.setOrderid(orderid);
		orderPath.setPostcode(userPath.getPostcode());
		orderPath.setUsername(userPath.getUsername());
		orderPath.setUserpath(userPath.getUserpath());
		orderPath.setUserphone(userPath.getUserphone());
		orderPathDao.save(orderPath);
	}
	
	/**
	 * 订单-收货地址
	 * @param orderid
	 * @return
	 * */
	private Public_order_path getByOrderId(String orderid) {
		String sql = "SELECT * FROM public_order_path WHERE orderid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(orderid);
		List<Public_order_path> opList =  orderPathDao.search(sql, values);
		return opList.size() > 0 ? opList.get(0):new Public_order_path();
	}
	/**
	 * 获取订单商品列表
	 * @param orderid
	 * @return
	 * */
	private List<Public_order_product> getOrderProducts(String orderid){
		String sql = "SELECT * FROM public_order_product WHERE orderid= ?";
		List<Object> values = new ArrayList<Object>();
		values.add(orderid);
		return orderProDao.search(sql, values);
	}
	
	/*------------------------------------------采购---------------------------------------------*/
	
	@Transactional("txManager")
	@Override
	public Public_order createorder(List<Public_product_size> psizeList,Public_user user) {
		//生成主订单
		float subtotal = 0;		//合计价格
		for(Public_product_size obj:psizeList){
			//折扣-是否有折扣计算价格
			Public_set_user_standard standard = getProStandard(user.getId(), user.getParentid(), obj.getId());
			Float buydrdis = standard.getBuyerdis();
			if(buydrdis != null && buydrdis > 0){
				subtotal += obj.getPrice() * buydrdis * obj.getQuantity();	//计算折扣后的价格
			}else{
				subtotal += obj.getPrice() * obj.getQuantity();
			}
		}
		Public_order order = new Public_order();
		order.setId(UUID.randomUUID().toString());
		order.setUserid(user.getId());
		
		order.setParentid(user.getParentid());			//上级ID
		order.setIdentity(user.getIdentity());			//身份
		String ordernumber = "PO"+OrderNO.getOrderNo();		//订单号
		order.setOrdernumber(ordernumber);
		order.setOrdertotal(subtotal);			//总金额
		order.setOrderstatus(0);				//待支付
		order.setOrderstatusmemo("待支付");
		order.setOrdertype("o"); //来源订货平台
		order.setOrdertime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		order.setIsshare(0);
		order.setIsshareover(0);
		order = orderDao.save(order);
		//订单商品
		productOrderSize(order,psizeList);
		//商品返利 - 新增表
		
		//收货地址
		addAddress(user.getAddressid(), order.getId());

		return order;
	}
	
	/*-------------------------------------普通会员采购单----------------------------*/
	
	@Transactional("txManager")
	@Override
	public Public_order createorder(List<Public_product_size> psizeList,Public_user user,String buyuserid,String parentid) {
		//生成主订单
		float subtotal = 0;		//合计价格
		for(Public_product_size obj:psizeList){
			//计算价格。按特价购买
			subtotal += obj.getSaleprice() * obj.getQuantity();	//计算折扣后的价格
//			Public_set_user_standard standard = getProStandard(user.getId(), user.getParentid(), obj.getId());
//			Float buydrdis = standard.getBuyerdis();
//			if(buydrdis != null && buydrdis > 0){
//				subtotal += obj.getPrice() * buydrdis * obj.getQuantity();	//计算折扣后的价格
//			}else{
//				subtotal += obj.getPrice() * obj.getQuantity();
//			}
		}
		Public_user buyUser = userDao.get(buyuserid);
		Public_order order = new Public_order();
		order.setId(UUID.randomUUID().toString());
		order.setUserid(buyuserid);
		order.setSubmitid(user.getId());
		
		order.setParentid(parentid);			//上级ID
		order.setIdentity(buyUser.getIdentity());			//身份
		String ordernumber = "ZO"+OrderNO.getOrderNo();		//订单号
		order.setOrdernumber(ordernumber);
		order.setOrdertotal(subtotal);			//总金额
		order.setOrderstatus(0);				//待支付
		order.setOrderstatusmemo("待支付");
		order.setOrdertype("p"); //来源订货平台
		order.setOrdertime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		order.setIsshare(0);
		order.setIsshareover(0);
		order = orderDao.save(order);
		//订单商品
		productOrderSizeZ(order,psizeList);
		//商品返利 - 新增表
		
		//收货地址
		addAddress(user.getAddressid(), order.getId());
		
		return order;
	}
	
	/**
	 * 普通会员采购-订单商品
	 * @param order 订单
	 * @param quantity	数量
	 * @param psizeList 购买的商品
	 * */
	private void productOrderSizeZ(Public_order order,List<Public_product_size> psizeList){
		for(Public_product_size psize:psizeList){
			//订单商品 
			Public_order_product orderPro = new Public_order_product();
			orderPro.setId(UUID.randomUUID().toString());
			orderPro.setOrderid(order.getId());
			orderPro.setProductid(psize.getId());
			orderPro.setBrandname(psize.getBrandname());
			orderPro.setProductname(psize.getProductname());
			orderPro.setProductpic(psize.getProductpic());
			orderPro.setProductsize(psize.getProductsize());
			orderPro.setProductnum(psize.getQuantity());		//购买数量
			orderPro.setIsoknum(psize.getQuantity());			//可结算数量（退货时冲减）
			orderPro.setPrice(psize.getSaleprice());
			orderPro.setProductmemo(psize.getProductmemo());
			orderPro.setOrdertime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
			orderPro.setStatus(0);	//已购买
			
			orderProDao.save(orderPro);
		}
	}
	
	/**
	 * 采购-订单商品
	 * @param order 订单
	 * @param quantity	数量
	 * @param psizeList 购买的商品
	 * */
	private void productOrderSize(Public_order order,List<Public_product_size> psizeList){
		for(Public_product_size psize:psizeList){
			//折扣
			Public_set_user_standard standard = getProStandard(order.getUserid(), order.getParentid(), psize.getId());
			//订单商品 
			Public_order_product orderPro = new Public_order_product();
			orderPro.setId(UUID.randomUUID().toString());
			orderPro.setOrderid(order.getId());
			orderPro.setProductid(psize.getId());
			orderPro.setBrandname(psize.getBrandname());
			orderPro.setProductname(psize.getProductname());
			orderPro.setProductpic(psize.getProductpic());
			orderPro.setProductsize(psize.getProductsize());
			orderPro.setProductnum(psize.getQuantity());		//购买数量
			orderPro.setIsoknum(psize.getQuantity());			//可结算数量（退货时冲减）
			orderPro.setPrice(psize.getPrice());
			orderPro.setProductmemo(psize.getProductmemo());
			orderPro.setOrdertime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
			orderPro.setStatus(0);	//已购买
			
			orderPro.setBuyerdis(standard.getBuyerdis());
			orderPro.setRebatesdis(standard.getRebatesdis());
			
			//查找推荐人ID,获取推荐人的奖励标准
			String tuijianid = getUserLink_ID(order.getUserid(), order.getParentid());
			if(tuijianid != null){
				Public_set_user_standard tj_standard = getProStandard(tuijianid, order.getParentid(), psize.getId());
				orderPro.setBonusesdis(tj_standard.getBonusesdis()); 	//奖励标准
			}
			
			orderProDao.save(orderPro);
		}
	}
	
	/**
	 * 获取商品的商品折扣
	 * @param userid
	 * @param parentid
	 * @param sizeid
	 * @return
	 * */
	private Public_set_user_standard getProStandard(String userid,String parentid,String sizeid){
		String sql = "SELECT * FROM public_set_user_standard WHERE userid=? AND parentid=? AND sizeid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		values.add(parentid);
		values.add(sizeid);
		List<Public_set_user_standard> list = standardDao.search(sql,values);
		return list.size() > 0 ? list.get(0): new Public_set_user_standard();
	}
	
	/**
	 * 支付-采购单货款
	 * */
	@Transactional("txManager")
	@Override
	public int payment(Public_order order){
		//冲减可支配账户
		Public_user_bank userbank = getUserBank(order.getUserid(), order.getParentid());
		float havebank = userbank.getHavebank();
		userbank.setHavebank(havebank - order.getOrdertotal());
		userbank = bankDao.update(userbank);
		if(userbank != null){
			//修改订单状态
			int num = updateOrderStatus(order.getId(), 1, "待发货");
			if(num > 0)
				return 1;
		}
		return 0;
	}
	
	/**
	 * 获取账户
	 * @param userid
	 * @param parentid
	 * @return
	 * */
	private Public_user_bank getUserBank(String userid,String parentid){
		String sql = "SELECT * FROM public_user_bank WHERE userid=? AND parentid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		values.add(parentid);
		List<Public_user_bank> list = bankDao.search(sql, values);
		return list.size() > 0 ? list.get(0): new Public_user_bank();
	}
	
	/**
	 * 修改订单状态 
	 * @param id
	 * @param orderstatus
	 * @param orderstatusmemo
	 * @return
	 * */
	private int updateOrderStatus(String id,int orderstatus,String orderstatusmemo){
		String sql = "UPDATE public_order SET orderstatus=?,orderstatusmemo=? WHERE id=?";
		List<Object> values = new ArrayList<Object>();
		values.add(String.valueOf(orderstatus));
		values.add(orderstatusmemo);
		values.add(id);
		return orderDao.update(sql, values);
	}
	
	/**
	 * 获取账户的推荐人ID
	 * @param userid
	 * @param parentid
	 * @return userid
	 * */
	public String getUserLink_ID(String userid,String parentid) {
		String sql = "SELECT * FROM public_user_link WHERE userid=? AND parentid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		values.add(parentid);
		List<Public_user_link> list = userlinkDao.search(sql, values);
		if(null != list && list.size() > 0){
			Public_user_link link = list.get(0);
			String tuijianid = link.getTuijianid();
			if(null != tuijianid && !"".equals(tuijianid)){
				return tuijianid;
			}
		}
		return null;
	}

	@Transactional("txManager")
	@Override
	public int signorder(Public_order order) {
		//改变订单状态
		order.setOrderstatus(3);	//已签收
		order.setOrderstatusmemo("已签收");
		//判断是否是普通会员订单
//		if ("p".equals(order.getOrdertype())) {
//			order.setIsshare(1);
//		}
		//增加签收时间
		order.setSigntime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		order = orderDao.update(order);
		if ("p".equals(order.getOrdertype())) {
			Public_user submitUser = userDao.get(order.getSubmitid());
			Public_user pUser = userDao.get(order.getUserid());
			//订单操作日志
			saveLog(order.getSubmitid(), order.getParentid(), "sendorder", order.getOrdernumber()+"-已签收", order.getOrdertotal(), order.getId());
			//订单已签收-消息
			int messagetype = 1;	//业务消息
			String messagetxt = "由机构["+submitUser.getCompanyname()+"]提交的普通会员["+pUser.getUsername()+"]订单["+order.getOrdernumber()+"]已完成签收,订单号："+order.getOrdernumber();
			createMsg(submitUser.getId(), submitUser.getCompanyname(), order.getParentid(), order.getP_username(), messagetype, messagetxt,order.getId());
		}
		else {
			//订单操作日志
			saveLog(order.getUserid(), order.getParentid(), "sendorder", order.getOrdernumber()+"-已签收", order.getOrdertotal(), order.getId());
			//订单已签收-消息
			int messagetype = 1;	//业务消息
			String messagetxt = order.getU_username()+"，的订单已签收！订单号："+order.getOrdernumber();
			createMsg(order.getUserid(), order.getU_username(), order.getParentid(), order.getP_username(), messagetype, messagetxt,order.getId());
		}
		
		return 1;
	}
	
	/**
	 * 订货单-取消订单
	 * @param bank
	 * @param order
	 * */
	@Transactional("txManager")
	@Override
	public int cancelorder(Public_order order){
		//改变订单状态
		order.setOrderstatus(-1);	//取消订单
		order.setOrderstatusmemo("已取消");
		order = orderDao.update(order);
		//日志
		Public_log log = saveLog(order.getSubmitid(), order.getParentid(), "cancelorder", order.getOrdernumber()+"-已取消", order.getOrdertotal(), order.getId());
//		//订单已取消-消息
//		int messagetype = 1;	//业务消息
//		String messagetxt = order.getU_username()+"取消了订单！订单号："+order.getOrdernumber();
//		createMsg(order.getUserid(), order.getU_username(), order.getParentid(), order.getP_username(), messagetype, messagetxt,order.getId());
		if(order !=null && log != null){
			return 1;
		}
		return 0;
	}
	
	/**
	 * 添加日志
	 * @param userid
	 * @param parentid
	 * @param logtype 操作类型
	 * @param logmemo 日志内容描述
	 * @param amount 金额
	 * @param lognum 
	 * @return
	 * */
	private Public_log saveLog(String userid,String parentid,String logtype,String logmemo,float amount,String lognum){
		Public_log log = new Public_log();
		log.setId(UUID.randomUUID().toString());
		log.setUserid(userid);	//主操作人
		log.setTouserid(parentid);			//被操作人
		log.setLogtype(logtype);	//操作类型
		log.setLogmemo(logmemo);
		log.setLogtime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		log.setLognum(lognum);
		log.setLogpay(amount);	//金额
		
		return logDao.save(log);
	}
	
	/**
	 * 业务消息
	 * @param sendid 发送者
	 * @param sendname
	 * @param receiveid 接收者
	 * @param receivename
	 * @param messagetype 消息类型
	 * @param messagetxt 消息内容
	 * @param activeid 关联ID
	 * @return
	 * */
	private Public_message createMsg(String sendid,String sendname,String receiveid,String receivename,int messagetype,String messagetxt,String activeid){
		Public_message msg = new Public_message();
		msg.setId(UUID.randomUUID().toString());
		msg.setSendid(sendid);			//发送者
		msg.setSendname(sendname);
		msg.setReceiveid(receiveid);	//接收者
		msg.setReceivename(receivename);
		msg.setMessagetype(messagetype);
		msg.setMessagetxt(messagetxt);
		msg.setMessagetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		msg.setMessagestate(0);		//状态
		msg.setActiveid(activeid);
		return msgDao.save(msg);
	}

	/*------------------普通会员订单处理---------------*/
	@Transactional("txManager")
	@Override
	public void setIsshare() {
		//获取超过15日的
		String sql = "select * from public_order where orderstatus=? and parentid =? and signtime < ? and isshare=? and isshareover != ?";
		List<Object> values = new ArrayList<Object>();
		
		values.add(3);
		values.add("1");
		String today = DateUtil.getNowTime("yyyy-MM-dd");
		String t = DateUtil.getAfterDate(today,-15);
		values.add(t);
		values.add(0);
		values.add(1);
		
		List<Public_order> orderList = orderDao.search(sql, values);
		
		if (orderList.size() > 0) {
			for (Public_order order : orderList) {
				order.setIsshare(1);
				orderDao.update(order);
			}
			
			Public_user user = userDao.get("1");
			
			String messagetxt = "共有["+orderList.size()+"]个普通会员订单超过15日，可以进行分润，请及时处理。";
			createMsg(user.getId(),user.getCompanyname(),user.getId(),user.getCompanyname(),1,messagetxt,"");
		}
		
	}

	@Override
	public List<Share_bill> getOrderSharebill(String orderid) {
		String sql = "select * from share_bill where orderid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(orderid);
		return shareBillDao.search(sql, values);
		
	}
	
	

}

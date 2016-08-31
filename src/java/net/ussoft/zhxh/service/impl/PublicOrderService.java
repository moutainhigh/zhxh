package net.ussoft.zhxh.service.impl;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicCatDao;
import net.ussoft.zhxh.dao.PublicOrderDao;
import net.ussoft.zhxh.dao.PublicOrderPathDao;
import net.ussoft.zhxh.dao.PublicOrderProductDao;
import net.ussoft.zhxh.dao.PublicProductSizeDao;
import net.ussoft.zhxh.dao.PublicUserPathDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_cat;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_order_path;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_user_path;
import net.ussoft.zhxh.service.IPublicOrderService;
import net.ussoft.zhxh.util.DateUtil;
import net.ussoft.zhxh.util.MakeQuerySql;
import net.ussoft.zhxh.util.OrderNO;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicOrderService implements IPublicOrderService{

	@Resource
	PublicOrderDao orderDao;
	@Resource
	PublicOrderProductDao orderProDao;
	@Resource
	PublicCatDao catDao;
	@Resource
	PublicProductSizeDao proSizeDao;
	@Resource
	PublicUserPathDao userPathDao;
	@Resource
	PublicOrderPathDao orderPathDao;
	
	@Override
	public Public_order getById(String id) {
		return orderDao.get(id);
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
		return orderDao.del(id);
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
//		order.setIdentity(identity);			//身份
		String ordernumber = "PO"+OrderNO.getOrderNo();		//订单号
		order.setOrdernumber(ordernumber);
		order.setOrdertotal(subtotal);			//总金额
		order.setOrderstatus(0);				//待支付
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
			orderPro.setPrice(psize.getSaleprice());		//此处存放的是特价（值已处理-如果特价没有，把售价给它-前台统一使用特价）
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
}

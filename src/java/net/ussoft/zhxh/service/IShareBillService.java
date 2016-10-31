package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Share_bill;
import net.ussoft.zhxh.model.PageBean;

/**
 * 分润交易-账单流水记录
 * @author guodh
 * @version v1.0 2016.10.28
 * */
public interface IShareBillService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Share_bill
	 * */
	public Share_bill getById(String id);
	/**
	 * 根据订单id获取对象
	 * @param id
	 * @return Share_bill
	 * */
	public Share_bill getByOrderid(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Share_bill> list();
	
	/**
	 * 查询所有 分页
	 * @param map
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Share_bill> list(Map<String, Object> map,PageBean<Share_bill> pageBean);
	
	/**
	 * 售额-明细
	 * @param orderproductids 订单商品ID
	 * @return
	 * */
	public List<Public_order_product> orderProlist(String orderproductids);
	
	/**
	 * 添加
	 * @param Share_bill
	 * @return 
	 * */
	public Share_bill insert(Share_bill bill);
	
	/**
	 * 修改
	 * @param Share_bill
	 * @return 
	 * */
	public int update(Share_bill bill);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

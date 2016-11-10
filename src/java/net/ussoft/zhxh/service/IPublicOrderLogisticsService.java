package net.ussoft.zhxh.service;

import java.util.ArrayList;
import java.util.List;

import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_order_logistics;
import net.ussoft.zhxh.util.kuaidi100.pojo.ResultItem;

/**
 * 订单物流
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicOrderLogisticsService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_order_logistics
	 * */
	public Public_order_logistics getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_order_logistics> list();
	
	/**
	 * 查询所有
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_order_logistics> list(String orderid);
	
	/**
	 * 订单物流信息
	 * @param order
	 * @return
	 * */
	public List<Public_order_logistics> orderLogistics(Public_order order);
	
	/**
	 * 添加
	 * @param Public_order_logistics
	 * @return 
	 * */
	public Public_order_logistics insert(Public_order_logistics orderLogistics);
	
	/**
	 * 添加
	 * @param list
	 * @param orderid
	 * @return
	 * */
	public List<Public_order_logistics> insert(ArrayList<ResultItem> list,String orderid);
	
	/**
	 * 修改
	 * @param Public_order_logistics
	 * @return 
	 * */
	public int update(Public_order_logistics orderLogistics);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

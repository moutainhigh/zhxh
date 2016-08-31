package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.Public_order_path;

/**
 * 订单地址
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicOrderPathService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_order_path
	 * */
	public Public_order_path getById(String id);
	
	/**
	 * 根据orderid查询
	 * */
	public Public_order_path getByOrderId(String orderid);
	
	/**
	 * 查询所有
	 * @param orderid 订单ID
	 * @return list
	 * */
	public List<Public_order_path> list(String orderid);
	
	/**
	 * 添加
	 * @param Public_order_path
	 * @return 
	 * */
	public Public_order_path insert(Public_order_path orderPath);
	
	/**
	 * 修改
	 * @param Public_order_path
	 * @return 
	 * */
	public int update(Public_order_path orderPath);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

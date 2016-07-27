package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order_product;

/**
 * 订单商品
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicOrderProductService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_order_product
	 * */
	public Public_order_product getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_order_product> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_order_product> list(PageBean<Public_order_product> pageBean);
	
	/**
	 * 添加
	 * @param Public_order_product
	 * @return 
	 * */
	public int update(Public_order_product orderProduct);
	
	/**
	 * 添加
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

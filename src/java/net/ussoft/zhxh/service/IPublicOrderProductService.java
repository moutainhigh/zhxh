package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

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
	public List<Public_order_product> list(Map<String, Object> map);
	
	/**
	 * 添加
	 * @param Public_order_product
	 * @return 
	 * */
	public Public_order_product insert(Public_order_product orderProduct);
	
	/**
	 * 修改
	 * @param Public_order_product
	 * @return 
	 * */
	public int update(Public_order_product orderProduct);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

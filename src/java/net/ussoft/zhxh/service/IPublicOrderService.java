package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_user;

/**
 * 订单管理
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicOrderService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_order
	 * */
	public Public_order getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_order> list();
	
	/**
	 * 按条件查询
	 * @param map 条件
	 * */
	public List<Public_order> list(Map<String, Object> map);
	
	/**
	 * 查询所有 分页
	 * @param map 条件
	 * @param pageBean
	 * @return list
	 * */
	public PageBean<Public_order> list(Map<String, Object> map, PageBean<Public_order> pageBean);
	
	/**
	 * 添加
	 * @param Public_order
	 * @return 
	 * */
	public Public_order insert(List<String> ids,String userid,String addressid);
	
	/**
	 * 修改
	 * @param Public_order
	 * @return 
	 * */
	public int update(Public_order order);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
	
	/*-----------------------------------------*/
	
	/**
	 * 创建采购单
	 * @param psizeList
	 * @param user
	 * @return
	 * */
	public Public_order createorder(List<Public_product_size> psizeList,Public_user user);
	
	/**
	 * 支付-采购单货款
	 * @param order
	 * */
	public int payment(Public_order order);
	
	
}

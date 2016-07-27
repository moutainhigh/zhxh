package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order_return;

/**
 * 退货单
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicOrderReturnService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_order_return
	 * */
	public Public_order_return getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_order_return> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_order_return> list(PageBean<Public_order_return> pageBean);
	
	/**
	 * 添加
	 * @param Public_order_return
	 * @return 
	 * */
	public int update(Public_order_return orderReturn);
	
	/**
	 * 添加
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_pay;

/**
 * 订单支付
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicPayService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_pay
	 * */
	public Public_pay getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_pay> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_pay> list(PageBean<Public_pay> pageBean);
	
	/**
	 * 添加
	 * @param Public_pay
	 * @return 
	 * */
	public int update(Public_pay pay);
	
	/**
	 * 添加
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_trade_bill;

/**
 * 提现记录
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicTradeBillService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_bankget_list
	 * */
	public Public_trade_bill getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_trade_bill> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_trade_bill> list(PageBean<Public_trade_bill> pageBean);
	
	/**
	 * 添加
	 * @param Public_trade_bill
	 * @return 
	 * */
	public Public_trade_bill insert(Public_trade_bill bankgetList);
	
	/**
	 * 修改
	 * @param Public_trade_bill
	 * @return 
	 * */
	public int update(Public_trade_bill bankgetList);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

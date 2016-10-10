package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

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
	 * 根据流水单号获取对象
	 * @param billid
	 * @return
	 * */
	public Public_trade_bill getByBillid(String billid);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_trade_bill> list();
	
	/**
	 * 查询所有 分页
	 * @param map
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Public_trade_bill> list(Map<String, Object> map,PageBean<Public_trade_bill> pageBean);
	
	/**
	 * 查询所有 分页
	 * @param userid
	 * @param parentid
	 * @param trantype
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Map<String,Object>> list(String userid,String parentid,List<String> trantype,PageBean<Map<String,Object>> pageBean);
	
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

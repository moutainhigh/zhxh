package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.Disposable_bill;
import net.ussoft.zhxh.model.PageBean;

/**
 * 可支配账户-账单流水记录
 * @author guodh
 * @version v1.0 2016.11.10
 * */
public interface IDisposableBillService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Disposable_bill
	 * */
	public Disposable_bill getById(String id);
	/**
	 * 根据订单id获取对象
	 * @param id
	 * @return Disposable_bill
	 * */
	public Disposable_bill getByOrderid(String id);
	
	/**
	 * 根据流水单号获取对象
	 * @param billno
	 * @return
	 * */
	public Disposable_bill getByBillno(String billno);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Disposable_bill> list();
	
	/**
	 * 查询所有 分页
	 * @param map
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Disposable_bill> list(Map<String, Object> map,PageBean<Disposable_bill> pageBean);
	
	/**
	 * 查询所有 分页
	 * @param userid
	 * @param parentid
	 * @param trantype
	 * @param identity
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Map<String,Object>> list(String userid,String parentid,List<String> trantype,String identity,PageBean<Map<String,Object>> pageBean);
	
	/**
	 * 添加
	 * @param Disposable_bill
	 * @return 
	 * */
	public Disposable_bill insert(Disposable_bill bill);
	
	/**
	 * 修改
	 * @param Disposable_bill
	 * @return 
	 * */
	public int update(Disposable_bill bill);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.Income_bill;
import net.ussoft.zhxh.model.PageBean;

/**
 * 收入-账单流水记录
 * @author guodh
 * @version v1.0 2016.10.12
 * */
public interface IIncomeBillService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Income_bill
	 * */
	public Income_bill getById(String id);
	/**
	 * 根据订单id获取对象
	 * @param id
	 * @return Income_bill
	 * */
	public Income_bill getByOrderid(String id);
	
	/**
	 * 根据流水单号获取对象
	 * @param billno
	 * @return
	 * */
	public Income_bill getByBillno(String billno);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Income_bill> list();
	
	/**
	 * 查询所有 分页
	 * @param map
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Income_bill> list(Map<String, Object> map,PageBean<Income_bill> pageBean);
	
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
	 * @param Income_bill
	 * @return 
	 * */
	public Income_bill insert(Income_bill bill);
	
	/**
	 * 修改
	 * @param Income_bill
	 * @return 
	 * */
	public int update(Income_bill bill);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

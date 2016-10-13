package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Spending_bill;

/**
 * 支出-账单流水记录
 * @author guodh
 * @version v1.0 2016.10.12
 * */
public interface ISpendingBillService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Spending_bill
	 * */
	public Spending_bill getById(String id);
	
	/**
	 * 根据流水单号获取对象
	 * @param billno
	 * @return
	 * */
	public Spending_bill getByBillno(String billno);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Spending_bill> list();
	
	/**
	 * 查询所有 分页
	 * @param map
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Spending_bill> list(Map<String, Object> map,PageBean<Spending_bill> pageBean);
	
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
	 * @param Spending_bill
	 * @return 
	 * */
	public Spending_bill insert(Spending_bill bill);
	
	/**
	 * 修改
	 * @param Spending_bill
	 * @return 
	 * */
	public int update(Spending_bill bill);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Quota_bill;

/**
 * 配额-账单流水记录
 * @author guodh
 * @version v1.0 2016.10.12
 * */
public interface IQuotaBillService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Quota_bill
	 * */
	public Quota_bill getById(String id);
	
	/**
	 * 根据流水单号获取对象
	 * @param billno
	 * @return
	 * */
	public Quota_bill getByBillno(String billno);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Quota_bill> list();
	
	/**
	 * 查询所有 分页
	 * @param map
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Quota_bill> list(Map<String, Object> map,PageBean<Quota_bill> pageBean);
	
	/**
	 * 查询所有 分页
	 * @param userid
	 * @param parentid
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Map<String,Object>> list(String userid,String parentid,PageBean<Map<String,Object>> pageBean);
	
	/**
	 * 添加
	 * @param Quota_bill
	 * @return 
	 * */
	public Quota_bill insert(Quota_bill bill);
	
	/**
	 * 修改
	 * @param Quota_bill
	 * @return 
	 * */
	public int update(Quota_bill bill);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

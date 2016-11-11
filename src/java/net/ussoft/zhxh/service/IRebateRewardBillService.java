package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Rebate_reward_bill;

/**
 * 奖励、返利-账单流水记录
 * @author guodh
 * @version v1.0 2016.11.11
 * */
public interface IRebateRewardBillService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Rebate_reward_bill
	 * */
	public Rebate_reward_bill getById(String id);
	/**
	 * 根据订单id获取对象
	 * @param id
	 * @return Rebate_reward_bill
	 * */
	public Rebate_reward_bill getByOrderid(String id);
	
	/**
	 * 根据流水单号获取对象
	 * @param billno
	 * @return
	 * */
	public Rebate_reward_bill getByBillno(String billno);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Rebate_reward_bill> list();
	
	/**
	 * 查询所有 分页
	 * @param map
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Rebate_reward_bill> list(Map<String, Object> map,PageBean<Rebate_reward_bill> pageBean);
	
	/**
	 * 查询所有 分页
	 * @param userid
	 * @param parentid
	 * @param detailstype
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Map<String,Object>> list(String userid,String parentid,int detailstype,PageBean<Map<String,Object>> pageBean);
	
	/**
	 * 添加
	 * @param Rebate_reward_bill
	 * @return 
	 * */
	public Rebate_reward_bill insert(Rebate_reward_bill bill);
	
	/**
	 * 修改
	 * @param Rebate_reward_bill
	 * @return 
	 * */
	public int update(Rebate_reward_bill bill);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.Public_user_bank;

/**
 * 个人账户管理
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicUserBankService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_user_bank
	 * */
	public Public_user_bank getById(String id);
	
	/**
	 * 查询会员，所在其上级的关联账户
	 * @param userid
	 * @param parentid
	 * @return public_user_bank
	 * */
	public Public_user_bank getUserBank(String userid,String parentid);
	
	/**
	 * 查询会员所有账户
	 * @param userid
	 * @return list
	 * */
	public List<Public_user_bank> list(String userid);
	
	/**
	 * 添加
	 * @param Public_user_bank
	 * @return 
	 * */
	public Public_user_bank insert(Public_user_bank userBank);
	
	/**
	 * 修改
	 * @param Public_user_bank
	 * @return 
	 * */
	public int update(Public_user_bank userBank);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
	
	
	/**
	 * 充值
	 * @param prepaid_bill_orderid 充值流水订单号
	 * @return
	 * */
	public int recharge(String prepaid_bill_orderid);
	
	/**
	 * 提现
	 * */
	public int withdrawal(String userid,String parentid);
	
	/**
	 * 设置配额
	 * */
	public int setQuota(String id);
	
	/**
	 * 转货款
	 * */
	public int transfBuyBank(); 
	
}

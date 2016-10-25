package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.Income_bill;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_set_bonuses_ratio;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Public_user_bank;
import net.ussoft.zhxh.model.Spending_bill;

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
	 * 订货单-支付扣款
	 * @param bank
	 * @param order
	 * */
	public int paymentorder(Public_user_bank bank,Public_order order);
	
	/**
	 * 订货单-取消订单
	 * @param bank
	 * @param order
	 * */
	public int cancelorder(Public_user_bank bank,Public_order order);
	
	/**
	 * 订货单-已发货
	 * @param order
	 * */
	public int sendoutorder(Public_order order);
	
	/**
	 * 订货单-已签收
	 * @param order
	 * */
	public int signorder(Public_order order);
	
	/**
	 * 充值
	 * @param bill 充值账单流水
	 * @param identity 身份
	 * @return
	 * */
	public int recharge(Income_bill bill,String identity);
	
	/**
	 * 提现
	 * @param bill	交易流水
	 * @param identity 身份
	 * */
	public int withdrawal(Spending_bill bill,Public_user user);
	
	/**
	 * 设置配额
	 * @param userid
	 * @param parentid
	 * @param amount
	 * @return
	 * */
	public int setQuota(String userid,String parentid,int amount);
	
	/**
	 * 转货款
	 * @param userid
	 * @param parentid
	 * @param amount
	 * @return
	 * */
	public int transfBuyBank(String userid,String parentid,float amount); 
	
	/**
	 * 获取转货款系数
	 * @param userid
	 * @param parentid
	 * @return
	 */
	public Public_set_bonuses_ratio getBonusersRatio(String userid,String parentid);
	
	/**
	 * 返利
	 * */
	public int rebate();
	
	/**
	 * 奖励
	 * */
	public int reward();
	
	/**
	 * 平台售额
	 * */
	public int platformSale();
	
	//=============
		/**
		 * 获取机构的帐户列表。
		 * @param parentid
		 * @param userid
		 * @return
		 */
	public List<Map<String,Object>> getUserBankList(String parentid,String userid);
}

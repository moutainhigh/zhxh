package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.RebateRewardBillDao;
import net.ussoft.zhxh.model.Rebate_reward_bill;

@Repository("rebateRewardBillDao")
public class RebateRewardBillDaoImpl extends BaseDaoMysqlImpl<Rebate_reward_bill, String> implements RebateRewardBillDao {

	public RebateRewardBillDaoImpl() {
		super(Rebate_reward_bill.class);
	}
}

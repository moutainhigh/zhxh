package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.SpendingBillDao;
import net.ussoft.zhxh.model.Spending_bill;

@Repository("spendingBillDao")
public class SpendingBillDaoImpl extends BaseDaoMysqlImpl<Spending_bill, String> implements SpendingBillDao {

	public SpendingBillDaoImpl() {
		super(Spending_bill.class);
	}
}

package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.IncomeBillDao;
import net.ussoft.zhxh.model.Income_bill;

@Repository("incomeBillDao")
public class IncomeBillDaoImpl extends BaseDaoMysqlImpl<Income_bill, String> implements IncomeBillDao {

	public IncomeBillDaoImpl() {
		super(Income_bill.class);
	}
}

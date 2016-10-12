package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.QuotaBillDao;
import net.ussoft.zhxh.model.Quota_bill;

@Repository("quotaBillDao")
public class QuotaBillDaoImpl extends BaseDaoMysqlImpl<Quota_bill, String> implements QuotaBillDao {

	public QuotaBillDaoImpl() {
		super(Quota_bill.class);
	}
}

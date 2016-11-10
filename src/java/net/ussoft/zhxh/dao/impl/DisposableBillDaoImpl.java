package net.ussoft.zhxh.dao.impl;

import net.ussoft.zhxh.dao.DisposableBillDao;
import net.ussoft.zhxh.model.Disposable_bill;

import org.springframework.stereotype.Repository;

@Repository("disposableBillDao")
public class DisposableBillDaoImpl extends BaseDaoMysqlImpl<Disposable_bill, String> implements DisposableBillDao {

	public DisposableBillDaoImpl() {
		super(Disposable_bill.class);
	}
}

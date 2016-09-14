package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicTradeBillDao;
import net.ussoft.zhxh.model.Public_trade_bill;

@Repository("publicBankgetListDao")
public class PublicTradeBillDaoImpl extends BaseDaoMysqlImpl<Public_trade_bill, String> implements PublicTradeBillDao {

	public PublicTradeBillDaoImpl() {
		super(Public_trade_bill.class);
	}
}

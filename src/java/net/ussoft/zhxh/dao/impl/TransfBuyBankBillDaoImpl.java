package net.ussoft.zhxh.dao.impl;

import net.ussoft.zhxh.dao.TransfBuyBankBillDao;
import net.ussoft.zhxh.model.Transf_buy_bank_bill;

import org.springframework.stereotype.Repository;

@Repository("transfBuyBankBillDao")
public class TransfBuyBankBillDaoImpl extends BaseDaoMysqlImpl<Transf_buy_bank_bill, String> implements TransfBuyBankBillDao {

	public TransfBuyBankBillDaoImpl() {
		super(Transf_buy_bank_bill.class);
	}
}

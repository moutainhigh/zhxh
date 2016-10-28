package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.ShareBillDao;
import net.ussoft.zhxh.model.Share_bill;

@Repository("shareBillDao")
public class ShareBillDaoImpl extends BaseDaoMysqlImpl<Share_bill, String> implements ShareBillDao {

	public ShareBillDaoImpl() {
		super(Share_bill.class);
	}
}

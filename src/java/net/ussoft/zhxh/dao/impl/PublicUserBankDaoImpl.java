package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicUserBankDao;
import net.ussoft.zhxh.model.Public_user_bank;

@Repository("publicUserBankDao")
public class PublicUserBankDaoImpl extends BaseDaoMysqlImpl<Public_user_bank, String> implements PublicUserBankDao {

	public PublicUserBankDaoImpl() {
		super(Public_user_bank.class);
	}
}

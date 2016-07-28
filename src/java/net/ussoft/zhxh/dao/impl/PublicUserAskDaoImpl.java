package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicUserAskDao;
import net.ussoft.zhxh.model.Public_user_ask;

@Repository("publicUserAskDao")
public class PublicUserAskDaoImpl extends BaseDaoMysqlImpl<Public_user_ask, String> implements PublicUserAskDao {

	public PublicUserAskDaoImpl() {
		super(Public_user_ask.class);
	}
}

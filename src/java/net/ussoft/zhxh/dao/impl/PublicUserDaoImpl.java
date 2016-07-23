package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicUserDao;
import net.ussoft.zhxh.model.Public_user;

@Repository("publicUserDao")
public class PublicUserDaoImpl extends BaseDaoMysqlImpl<Public_user, String> implements PublicUserDao {

	public PublicUserDaoImpl() {
		super(Public_user.class);
	}
}

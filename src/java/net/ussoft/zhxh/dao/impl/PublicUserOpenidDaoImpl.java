package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicUserOpenidDao;
import net.ussoft.zhxh.model.Public_user_openid;

@Repository("publicUserOpenidDao")
public class PublicUserOpenidDaoImpl extends BaseDaoMysqlImpl<Public_user_openid, String> implements PublicUserOpenidDao {

	public PublicUserOpenidDaoImpl() {
		super(Public_user_openid.class);
	}
}

package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicUserLinkDao;
import net.ussoft.zhxh.model.Public_user_link;

@Repository("publicUserLinkDao")
public class PublicUserLinkDaoImpl extends BaseDaoMysqlImpl<Public_user_link, String> implements PublicUserLinkDao {

	public PublicUserLinkDaoImpl() {
		super(Public_user_link.class);
	}
}

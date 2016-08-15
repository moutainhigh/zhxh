package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicLogDao;
import net.ussoft.zhxh.model.Public_log;

@Repository("publicLogDao")
public class PublicLogDaoImpl extends BaseDaoMysqlImpl<Public_log, String> implements PublicLogDao {

	public PublicLogDaoImpl() {
		super(Public_log.class);
	}
}

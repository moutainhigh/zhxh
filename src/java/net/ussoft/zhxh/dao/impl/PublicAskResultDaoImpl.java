package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicAskResultDao;
import net.ussoft.zhxh.model.Public_ask_result;

@Repository("publicAskResultDao")
public class PublicAskResultDaoImpl extends BaseDaoMysqlImpl<Public_ask_result, String> implements PublicAskResultDao {

	public PublicAskResultDaoImpl() {
		super(Public_ask_result.class);
	}
}

package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicPhoneCodeLogDao;
import net.ussoft.zhxh.model.Public_phone_code_log;

@Repository("publicPhoneCodeLogDao")
public class PublicPhoneCodeLogDaoImpl extends BaseDaoMysqlImpl<Public_phone_code_log, String> implements PublicPhoneCodeLogDao {

	public PublicPhoneCodeLogDaoImpl() {
		super(Public_phone_code_log.class);
	}
}

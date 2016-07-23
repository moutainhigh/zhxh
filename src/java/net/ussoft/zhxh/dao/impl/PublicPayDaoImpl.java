package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicPayDao;
import net.ussoft.zhxh.model.Public_pay;

@Repository("publicPayDao")
public class PublicPayDaoImpl extends BaseDaoMysqlImpl<Public_pay, String> implements PublicPayDao {

	public PublicPayDaoImpl() {
		super(Public_pay.class);
	}
}

package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicMessageDao;
import net.ussoft.zhxh.model.Public_message;

@Repository("publicMessageDao")
public class PublicMessageDaoImpl extends BaseDaoMysqlImpl<Public_message, String> implements PublicMessageDao {

	public PublicMessageDaoImpl() {
		super(Public_message.class);
	}
}

package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicSetUserStandardDao;
import net.ussoft.zhxh.model.Public_set_user_standard;

@Repository("publicSetUserStandardDao")
public class PublicSetUserStandardDaoImpl extends BaseDaoMysqlImpl<Public_set_user_standard, String> implements PublicSetUserStandardDao {

	public PublicSetUserStandardDaoImpl() {
		super(Public_set_user_standard.class);
	}
}

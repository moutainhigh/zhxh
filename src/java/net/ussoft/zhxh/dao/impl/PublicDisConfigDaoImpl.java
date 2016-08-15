package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicDisConfigDao;
import net.ussoft.zhxh.model.Public_dis_config;

@Repository("publicDisConfigDao")
public class PublicDisConfigDaoImpl extends BaseDaoMysqlImpl<Public_dis_config, String> implements PublicDisConfigDao {

	public PublicDisConfigDaoImpl() {
		super(Public_dis_config.class);
	}
}

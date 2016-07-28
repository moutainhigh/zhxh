package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicCatDao;
import net.ussoft.zhxh.model.Public_cat;

@Repository("publicCatDao")
public class PublicCatDaoImpl extends BaseDaoMysqlImpl<Public_cat, String> implements PublicCatDao {

	public PublicCatDaoImpl() {
		super(Public_cat.class);
	}
}

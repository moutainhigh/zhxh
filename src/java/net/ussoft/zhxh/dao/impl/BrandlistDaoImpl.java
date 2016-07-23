package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.BrandlistDao;
import net.ussoft.zhxh.model.Brandlist;

@Repository("brandlistDao")
public class BrandlistDaoImpl extends BaseDaoMysqlImpl<Brandlist, String> implements BrandlistDao {

	public BrandlistDaoImpl() {
		super(Brandlist.class);
	}
}

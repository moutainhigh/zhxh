package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.SysInitDao;
import net.ussoft.zhxh.model.Sys_init;


@Repository("initDao")
public class SysInitDaoImpl extends BaseDaoMysqlImpl<Sys_init, String> implements SysInitDao {

	public SysInitDaoImpl() {
		super(Sys_init.class);
	}
}

package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.SysPublicDao;
import net.ussoft.zhxh.model.Sys_public;

@Repository("sysPublicDao")
public class SysPublicDaoImpl extends BaseDaoMysqlImpl<Sys_public, String> implements SysPublicDao {

	public SysPublicDaoImpl() {
		super(Sys_public.class);
	}
}

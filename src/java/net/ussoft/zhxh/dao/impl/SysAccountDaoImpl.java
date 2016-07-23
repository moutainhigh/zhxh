package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.SysAccountDao;
import net.ussoft.zhxh.model.Sys_account;

@Repository("accountDao")
public class SysAccountDaoImpl extends BaseDaoMysqlImpl<Sys_account, String> implements SysAccountDao {

	public SysAccountDaoImpl() {
		super(Sys_account.class);
	}
}

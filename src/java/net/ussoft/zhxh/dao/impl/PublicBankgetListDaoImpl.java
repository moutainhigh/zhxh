package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicBankgetListDao;
import net.ussoft.zhxh.model.Public_bankget_list;

@Repository("publicBankgetListDao")
public class PublicBankgetListDaoImpl extends BaseDaoMysqlImpl<Public_bankget_list, String> implements PublicBankgetListDao {

	public PublicBankgetListDaoImpl() {
		super(Public_bankget_list.class);
	}
}

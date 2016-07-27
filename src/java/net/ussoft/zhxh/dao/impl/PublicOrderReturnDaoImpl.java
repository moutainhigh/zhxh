package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicOrderReturnDao;
import net.ussoft.zhxh.model.Public_order_return;

@Repository("publicOrderReturnDao")
public class PublicOrderReturnDaoImpl extends BaseDaoMysqlImpl<Public_order_return, String> implements PublicOrderReturnDao {

	public PublicOrderReturnDaoImpl() {
		super(Public_order_return.class);
	}
}

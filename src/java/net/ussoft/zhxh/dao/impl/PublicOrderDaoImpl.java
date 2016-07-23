package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicOrderDao;
import net.ussoft.zhxh.model.Public_order;

@Repository("publicOrderDao")
public class PublicOrderDaoImpl extends BaseDaoMysqlImpl<Public_order, String> implements PublicOrderDao {

	public PublicOrderDaoImpl() {
		super(Public_order.class);
	}
}

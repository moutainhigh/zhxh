package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicOrderLogisticsDao;
import net.ussoft.zhxh.model.Public_order_logistics;

@Repository("publicOrderLogisticsDao")
public class PublicOrderLogisticsDaoImpl extends BaseDaoMysqlImpl<Public_order_logistics, String> implements PublicOrderLogisticsDao {

	public PublicOrderLogisticsDaoImpl() {
		super(Public_order_logistics.class);
	}
}

package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicOrderProductDao;
import net.ussoft.zhxh.model.Public_order_product;

@Repository("publicOrderProductDao")
public class PublicOrderProductDaoImpl extends BaseDaoMysqlImpl<Public_order_product, String> implements PublicOrderProductDao {

	public PublicOrderProductDaoImpl() {
		super(Public_order_product.class);
	}
}

package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicProductDao;
import net.ussoft.zhxh.model.Public_product;

@Repository("publicProductDao")
public class PublicProductDaoImpl extends BaseDaoMysqlImpl<Public_product, String> implements PublicProductDao {

	public PublicProductDaoImpl() {
		super(Public_product.class);
	}
}

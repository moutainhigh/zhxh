package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicProductSizeDao;
import net.ussoft.zhxh.model.Public_product_size;

@Repository("publicProductSizeDao")
public class PublicProductSizeDaoImpl extends BaseDaoMysqlImpl<Public_product_size, String> implements PublicProductSizeDao {

	public PublicProductSizeDaoImpl() {
		super(Public_product_size.class);
	}
}

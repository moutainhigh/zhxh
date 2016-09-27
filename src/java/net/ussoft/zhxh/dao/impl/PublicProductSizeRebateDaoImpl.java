package net.ussoft.zhxh.dao.impl;

import net.ussoft.zhxh.dao.PublicProductSizeRebateDao;
import net.ussoft.zhxh.model.Public_product_size_rebate;

import org.springframework.stereotype.Repository;

@Repository("publicProductSizeRebateDao")
public class PublicProductSizeRebateDaoImpl extends BaseDaoMysqlImpl<Public_product_size_rebate, String> implements PublicProductSizeRebateDao {

	public PublicProductSizeRebateDaoImpl() {
		super(Public_product_size_rebate.class);
	}
}

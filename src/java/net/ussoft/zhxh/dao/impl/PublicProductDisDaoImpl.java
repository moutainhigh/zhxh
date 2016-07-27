package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicProductDisDao;
import net.ussoft.zhxh.model.Public_product_dis;

@Repository("publicProductDisDao")
public class PublicProductDisDaoImpl extends BaseDaoMysqlImpl<Public_product_dis, String> implements PublicProductDisDao {

	public PublicProductDisDaoImpl() {
		super(Public_product_dis.class);
	}
}

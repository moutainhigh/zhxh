package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicBrandDao;
import net.ussoft.zhxh.model.Public_brand;

@Repository("publicBrandDao")
public class PublicBrandDaoImpl extends BaseDaoMysqlImpl<Public_brand, String> implements PublicBrandDao {

	public PublicBrandDaoImpl() {
		super(Public_brand.class);
	}
}

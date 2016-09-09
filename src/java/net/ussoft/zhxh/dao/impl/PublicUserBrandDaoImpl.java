package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicUserBrandDao;
import net.ussoft.zhxh.model.Public_user_brand;

@Repository("publicUserBrandDao")
public class PublicUserBrandDaoImpl extends BaseDaoMysqlImpl<Public_user_brand, String> implements PublicUserBrandDao {

	public PublicUserBrandDaoImpl() {
		super(Public_user_brand.class);
	}
}

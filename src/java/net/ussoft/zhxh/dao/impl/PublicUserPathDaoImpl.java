package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicUserPathDao;
import net.ussoft.zhxh.model.Public_user_path;

@Repository("publicUserPathDao")
public class PublicUserPathDaoImpl extends BaseDaoMysqlImpl<Public_user_path, String> implements PublicUserPathDao {

	public PublicUserPathDaoImpl() {
		super(Public_user_path.class);
	}
}

package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicOrderPathDao;
import net.ussoft.zhxh.model.Public_order_path;

@Repository("publicOrderPathDao")
public class PublicOrderPathDaoImpl extends BaseDaoMysqlImpl<Public_order_path, String> implements PublicOrderPathDao {

	public PublicOrderPathDaoImpl() {
		super(Public_order_path.class);
	}
}

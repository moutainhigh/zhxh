package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicDisDetailsDao;
import net.ussoft.zhxh.model.Public_dis_details;

@Repository("publicDisDetailsDao")
public class PublicDisDetailsDaoImpl extends BaseDaoMysqlImpl<Public_dis_details, String> implements PublicDisDetailsDao {

	public PublicDisDetailsDaoImpl() {
		super(Public_dis_details.class);
	}
}

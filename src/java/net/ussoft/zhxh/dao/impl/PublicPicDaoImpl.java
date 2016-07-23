package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicPicDao;
import net.ussoft.zhxh.model.Public_pic;

@Repository("publicPicDao")
public class PublicPicDaoImpl extends BaseDaoMysqlImpl<Public_pic, String> implements PublicPicDao {

	public PublicPicDaoImpl() {
		super(Public_pic.class);
	}
}

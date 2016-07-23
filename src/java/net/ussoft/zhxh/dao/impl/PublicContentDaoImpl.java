package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicContentDao;
import net.ussoft.zhxh.model.Public_content;

@Repository("publicContentDao")
public class PublicContentDaoImpl extends BaseDaoMysqlImpl<Public_content, String> implements PublicContentDao {

	public PublicContentDaoImpl() {
		super(Public_content.class);
	}
}

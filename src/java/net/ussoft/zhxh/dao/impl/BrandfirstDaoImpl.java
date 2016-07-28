package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.BrandfirstDao;
import net.ussoft.zhxh.model.Brandfirst;

@Repository("brandfirstDao")
public class BrandfirstDaoImpl extends BaseDaoMysqlImpl<Brandfirst, String> implements BrandfirstDao {

	public BrandfirstDaoImpl() {
		super(Brandfirst.class);
	}
}

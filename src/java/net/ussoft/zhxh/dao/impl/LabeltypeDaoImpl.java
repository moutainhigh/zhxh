package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.LabeltypeDao;
import net.ussoft.zhxh.model.Labeltype;

@Repository("labeltypeDao")
public class LabeltypeDaoImpl extends BaseDaoMysqlImpl<Labeltype, String> implements LabeltypeDao {

	public LabeltypeDaoImpl() {
		super(Labeltype.class);
	}
}

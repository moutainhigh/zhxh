package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.LabelListDao;
import net.ussoft.zhxh.model.Label_list;

@Repository("labelListDao")
public class LabelListDaoImpl extends BaseDaoMysqlImpl<Label_list, String> implements LabelListDao {

	public LabelListDaoImpl() {
		super(Label_list.class);
	}
}

package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.FilesdownDao;
import net.ussoft.zhxh.model.Filesdown;

@Repository("filesdownDao")
public class FilesdownDaoImpl extends BaseDaoMysqlImpl<Filesdown, String> implements FilesdownDao {

	public FilesdownDaoImpl() {
		super(Filesdown.class);
	}
}

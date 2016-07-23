package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicVideoDao;
import net.ussoft.zhxh.model.Public_video;

@Repository("publicVideoDao")
public class PublicVideoDaoImpl extends BaseDaoMysqlImpl<Public_video, String> implements PublicVideoDao {

	public PublicVideoDaoImpl() {
		super(Public_video.class);
	}
}

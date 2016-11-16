package net.ussoft.zhxh.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicLogDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_log;
import net.ussoft.zhxh.service.IPublicLogService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicLogService implements IPublicLogService{
	
	@Resource
	private PublicLogDao mDao;

	@Override
	public Public_log getById(String id) {
		return mDao.get(id);
	}

	@Override
	public List<Public_log> list() {
		return mDao.getAll();
	}
	
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUserService#list(java.lang.String, java.lang.String, java.util.Map, net.ussoft.zhxh.model.PageBean)
	 */
	@Override
	public PageBean<Public_log> list(Map<String, Object> map,PageBean<Public_log> pageBean) {
		return pageBean;
	}
	
	@Transactional("txManager")
	@Override
	public boolean delete(String id) {
		String[] ids = id.split(",");
		for(int i=0;i<ids.length;i++){
			mDao.del(id);
		}
		return true;
	}
	
	@Transactional("txManager")
	@Override
	public Public_log insert(Public_log message) {
		return mDao.save(message);
	}

}

package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicDisConfigDao;
import net.ussoft.zhxh.model.Public_dis_config;
import net.ussoft.zhxh.service.IPublicDisService;

@Service
public class PublicDisService implements IPublicDisService {
	
	@Resource
	private PublicDisConfigDao disConfigDao;
	

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicDisConfigService#getById(java.lang.String)
	 */
	@Override
	public Public_dis_config getById(String id) {
		return disConfigDao.get(id);
	}
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicDisConfigService#list()
	 */
	@Override
	public List<Public_dis_config> list() {
		return disConfigDao.getAll();
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicDisConfigService#insert(net.ussoft.zhxh.model.Public_dis_config)
	 */
	@Transactional("txManager")
	@Override
	public Public_dis_config insert(Public_dis_config tmp) {
		disConfigDao.save(tmp);
		return tmp;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicDisConfigService#update(net.ussoft.zhxh.model.Public_dis_config)
	 */
	@Transactional("txManager")
	@Override
	public int update(Public_dis_config tmp) {
		tmp = disConfigDao.update(tmp);
		if (null != tmp) {
			return 1;
		}
		return 0;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicDisConfigService#delete(java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return disConfigDao.del(id);
	}

}

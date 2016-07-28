package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicUserDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicUserService;

@Service
public class PublicUserService implements IPublicUserService{
	
	@Resource
	PublicUserDao userDao;

	@Override
	public Public_user getById(String id) {
		// TODO Auto-generated method stub
		return userDao.get(id);
	}

	@Override
	public List<Public_user> list() {
		// TODO Auto-generated method stub
		return userDao.getAll();
	}

	@Override
	public List<Public_user> list(PageBean<Public_user> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional("txManager")
	@Override
	public int update(Public_user user) {
		// TODO Auto-generated method stub
		Public_user obj = userDao.update(user);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return userDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_user insert(Public_user user) {
		// TODO Auto-generated method stub
		userDao.save(user);
		return user;
	}

}

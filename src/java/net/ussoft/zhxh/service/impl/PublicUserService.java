package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
		return null;
	}

	@Override
	public List<Public_user> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_user> list(PageBean<Public_user> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_user user) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

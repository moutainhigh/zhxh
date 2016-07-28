package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicUserAskDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user_ask;
import net.ussoft.zhxh.service.IPublicUserAskService;

@Service
public class PublicUserAskService implements IPublicUserAskService{
	
	@Resource
	PublicUserAskDao userAskDao;

	@Override
	public Public_user_ask getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_user_ask> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_user_ask> list(PageBean<Public_user_ask> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_user_ask userAsk) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Public_user_ask insert(Public_user_ask userAsk) {
		// TODO Auto-generated method stub
		return null;
	}

}

package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicUserPathDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user_path;
import net.ussoft.zhxh.service.IPublicUserPathService;

@Service
public class PublicUserPathService implements IPublicUserPathService{

	@Resource
	PublicUserPathDao userPathDao;
	
	@Override
	public Public_user_path getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_user_path> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_user_path> list(PageBean<Public_user_path> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_user_path userPath) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

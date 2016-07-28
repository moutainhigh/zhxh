package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicPicDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_pic;
import net.ussoft.zhxh.service.IPublicPicService;

@Service
public class PublicPicService implements IPublicPicService{

	@Resource
	PublicPicDao picDao;
	
	@Override
	public Public_pic getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_pic> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_pic> list(PageBean<Public_pic> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_pic pic) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Public_pic insert(Public_pic pic) {
		// TODO Auto-generated method stub
		return null;
	}

}

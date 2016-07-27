package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicOrderPathDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order_path;
import net.ussoft.zhxh.service.IPublicOrderPathService;

@Service
public class PublicOrderPathService implements IPublicOrderPathService{

	@Resource
	PublicOrderPathDao orderPathDao;
	
	@Override
	public Public_order_path getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_order_path> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_order_path> list(PageBean<Public_order_path> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_order_path orderPath) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

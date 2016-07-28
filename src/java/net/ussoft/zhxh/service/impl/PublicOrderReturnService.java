package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicOrderReturnDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order_return;
import net.ussoft.zhxh.service.IPublicOrderReturnService;

@Service
public class PublicOrderReturnService implements IPublicOrderReturnService{

	@Resource
	PublicOrderReturnDao returnDao;
	
	@Override
	public Public_order_return getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_order_return> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_order_return> list(PageBean<Public_order_return> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_order_return orderReturn) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Public_order_return insert(Public_order_return orderReturn) {
		// TODO Auto-generated method stub
		return null;
	}

}

package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicOrderDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.service.IPublicOrderService;

@Service
public class PublicOrderService implements IPublicOrderService{

	@Resource
	PublicOrderDao orderDao;
	
	@Override
	public Public_order getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_order> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_order> list(PageBean<Public_order> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_order order) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicOrderLogisticsDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order_logistics;
import net.ussoft.zhxh.service.IPublicOrderLogisticsService;

@Service
public class PublicOrderLogisticsService implements IPublicOrderLogisticsService{

	@Resource
	PublicOrderLogisticsDao orderLogisticsDao;
	
	@Override
	public Public_order_logistics getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_order_logistics> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_order_logistics> list(
			PageBean<Public_order_logistics> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_order_logistics orderLogistics) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Public_order_logistics insert(Public_order_logistics orderLogistics) {
		// TODO Auto-generated method stub
		return null;
	}

}

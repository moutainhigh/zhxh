package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicOrderProductDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.service.IPublicOrderProductService;

@Service
public class PublicOrderProductService implements IPublicOrderProductService{

	@Resource
	PublicOrderProductDao orderProductDao;
	
	@Override
	public Public_order_product getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_order_product> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_order_product> list(
			PageBean<Public_order_product> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_order_product orderProduct) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

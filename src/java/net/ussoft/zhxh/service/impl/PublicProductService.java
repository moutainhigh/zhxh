package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicProductDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_product;
import net.ussoft.zhxh.service.IPublicProductService;

@Service
public class PublicProductService implements IPublicProductService{
	
	@Resource
	PublicProductDao productDao;

	@Override
	public Public_product getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_product> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_product> list(PageBean<Public_product> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_product product) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Public_product insert(Public_product product) {
		// TODO Auto-generated method stub
		return null;
	}

}

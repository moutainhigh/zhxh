package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicProductDisDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_product_dis;
import net.ussoft.zhxh.service.IPublicProductDisService;

@Service
public class PublicProductDisService implements IPublicProductDisService{

	@Resource
	PublicProductDisDao productDisDao;
	
	@Override
	public Public_product_dis getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_product_dis> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_product_dis> list(PageBean<Public_product_dis> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_product_dis product_dis) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

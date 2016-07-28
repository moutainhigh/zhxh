package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicProductSizeDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.service.IPublicProductSizeService;

@Service
public class PublicProductSizeService implements IPublicProductSizeService{

	@Resource
	PublicProductSizeDao productSizeDao;
	
	@Override
	public Public_product_size getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_product_size> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_product_size> list(PageBean<Public_product_size> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_product_size product_size) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Public_product_size insert(Public_product_size product_size) {
		// TODO Auto-generated method stub
		return null;
	}

}

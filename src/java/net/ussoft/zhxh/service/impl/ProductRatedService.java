package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.ProductRatedDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Product_rated;
import net.ussoft.zhxh.service.IProductRatedService;

@Service
public class ProductRatedService implements IProductRatedService{

	@Resource
	ProductRatedDao ratedDao;	//评价
	
	@Override
	public Product_rated getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product_rated> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product_rated> list(PageBean<Product_rated> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Product_rated rated) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
		return ratedDao.get(id);
	}

	@Override
	public List<Product_rated> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PageBean<Product_rated> list(PageBean<Product_rated> pageBean,String parentid,int isshow) {
		String sql = "select * from product_rated where parentid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		if(isshow == 0 || isshow == 1){
			sql += " and isshow = ?";
			values.add(isshow);
		}
		pageBean = ratedDao.search(sql, values, pageBean);
		
		return pageBean;
	}

	@Transactional("txManager")
	@Override
	public int update(Product_rated rated) {
		Product_rated obj = ratedDao.update(rated);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return ratedDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Product_rated insert(Product_rated rated) {
		return ratedDao.save(rated);
	}

}

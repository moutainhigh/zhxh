package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicContentDao;
import net.ussoft.zhxh.dao.PublicProductDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_product;
import net.ussoft.zhxh.service.IPublicProductService;

@Service
public class PublicProductService implements IPublicProductService{
	
	@Resource
	private PublicProductDao productDao;
	@Resource
	private PublicContentDao contentDao;  //富文本

	@Override
	public Public_product getById(String id) {
		return productDao.get(id);
	}

	@Override
	public List<Public_product> list() {
		return productDao.getAll("sort");
	}

	@Override
	public List<Public_product> list(PageBean<Public_product> pageBean,String brandid) {
		String sql = "select * from public_product where brandid=?";
		List<Object> values = new ArrayList<Object>();
		
		values.add(brandid);
		pageBean = productDao.search(sql, values, pageBean);
		
		return pageBean.getList();
	}

	@Transactional("txManager")
	@Override
	public int update(Public_product product) {
		Public_product obj = productDao.update(product);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		//删除商品，同时删除该商品的富文本表关联内容
		String sql = "delete from public_content where parentid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(id);
		contentDao.del(sql, values);
		
		return productDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_product insert(Public_product product) {
		return productDao.save(product);
	}

}

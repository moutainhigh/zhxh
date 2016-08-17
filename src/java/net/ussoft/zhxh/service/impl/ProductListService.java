package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.LabelListDao;
import net.ussoft.zhxh.dao.ProductListDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Product_list;
import net.ussoft.zhxh.service.IProductListService;

@Service
public class ProductListService implements IProductListService{

	@Resource
	private ProductListDao pListDao;
	@Resource
	private LabelListDao labelListDao;
	
	@Override
	public Product_list getById(String id) {
		return pListDao.get(id);
	}

	@Override
	public List<Product_list> list(String parentid) {
		String sql = "select * from product_list where parentid=?";
		List<Object> values = new ArrayList<Object>();
		
		values.add(parentid);
		return pListDao.search(sql, values);
	}

	@Override
	public PageBean<Product_list> list(PageBean<Product_list> pageBean,String parentid) {
		String sql = "select * from product_list where parentid=?";
		List<Object> values = new ArrayList<Object>();
		
		values.add(parentid);
		pageBean = pListDao.search(sql, values, pageBean);
		
		return pageBean;
	}

	@Transactional("txManager")
	@Override
	public int update(Product_list obj) {
		Product_list tmp = pListDao.update(obj);
		if(tmp != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		//首先删除列表页，对应的关联商品id，关联表删除
		String sql = "delete from label_list where parentid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(id);
		
		labelListDao.del(sql, values);
		
		return pListDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Product_list insert(Product_list obj) {
		return pListDao.save(obj);
	}

}

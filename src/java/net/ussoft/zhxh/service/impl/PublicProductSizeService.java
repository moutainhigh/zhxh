package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
		return productSizeDao.get(id);
	}

	@Override
	public List<Public_product_size> list(String parentid) {
		String sql = "select * from public_product_size where productid = ? order by sizesort";
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		return productSizeDao.search(sql, values);
	}

	@Override
	public PageBean<Public_product_size> list(PageBean<Public_product_size> pageBean,String parentid) {
		String sql = "select * from public_product_size where productid = ? ";
		List<Object> values = new ArrayList<Object>();
		
		values.add(parentid);
		pageBean = productSizeDao.search(sql, values, pageBean);
		
		return pageBean;
	}

	@Transactional("txManager")
	@Override
	public int update(Public_product_size product_size) {
		Public_product_size obj = productSizeDao.update(product_size);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return productSizeDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_product_size insert(Public_product_size product_size) {
		return productSizeDao.save(product_size);
	}

}

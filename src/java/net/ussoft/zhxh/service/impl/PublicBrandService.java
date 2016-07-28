package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicBrandDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.service.IPublicBrandService;

@Service
public class PublicBrandService implements IPublicBrandService{
	
	@Resource
	private PublicBrandDao brandDao;

	@Override
	public Public_brand getById(String id) {
		// TODO Auto-generated method stub
		return brandDao.get(id);
	}

	@Override
	public List<Public_brand> list() {
		// TODO Auto-generated method stub
		return brandDao.getAll();
	}

	@Override
	public int update(Public_brand brand) {
		// TODO Auto-generated method stub
		Public_brand obj = brandDao.update(brand);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return brandDao.del(id);
	}

	@Override
	public List<Public_brand> list(PageBean<Public_brand> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Public_brand insert(Public_brand brand) {
		// TODO Auto-generated method stub
		return null;
	}

}

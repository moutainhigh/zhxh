package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicBrandDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.service.IPublicBrandService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicBrandService implements IPublicBrandService{
	
	@Resource
	private PublicBrandDao brandDao;

	@Override
	public Public_brand getById(String id) {
		return brandDao.get(id);
	}

	@Override
	public List<Public_brand> list() {
		return brandDao.getAll("sort");
	}
	
	@Override
	public List<Public_brand> list(int isshow) {
		Public_brand brand = new Public_brand();
		brand.setIsshow(isshow);
		PageBean<Public_brand> p = new PageBean<Public_brand>();
		p.setIsPage(false);
		p.setOrderBy("sort");
		p.setOrderType("asc");
		p = brandDao.search(brand,p);
		return p.getList();
	}

	@Transactional("txManager")
	@Override
	public int update(Public_brand brand) {
		Public_brand obj = brandDao.update(brand);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id ) {
		//删除时要删除品牌logo
		return brandDao.del(id);
	}

	@Override
	public List<Public_brand> list(PageBean<Public_brand> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional("txManager")
	@Override
	public Public_brand insert(Public_brand brand) {
		return brandDao.save(brand);
	}

}

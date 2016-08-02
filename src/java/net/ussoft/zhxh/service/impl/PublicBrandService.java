package net.ussoft.zhxh.service.impl;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicBrandDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.service.IPublicBrandService;
import net.ussoft.zhxh.util.FileOperate;

@Service
public class PublicBrandService implements IPublicBrandService{
	
	@Resource
	private PublicBrandDao brandDao;
	@Autowired 
	private HttpServletRequest request;

	@Override
	public Public_brand getById(String id) {
		return brandDao.get(id);
	}

	@Override
	public List<Public_brand> list() {
		return brandDao.getAll("sort");
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
		Public_brand brand = brandDao.get(id);
		if (null != brand.getBrandlogo() && !"".equals(brand.getBrandlogo())) {
			FileOperate.delFile(request.getSession().getServletContext().getRealPath("") + File.separator + brand.getBrandlogo());
		}
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

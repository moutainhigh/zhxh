package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.SysPublicDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Sys_public;
import net.ussoft.zhxh.service.ISysPublicService;

@Service
public class SysPublicService implements ISysPublicService{
	
	@Resource
	private SysPublicDao sysPublicDao;

	@Override
	public Sys_public getById(String id) {
		return sysPublicDao.get(id);
	}

	@Override
	public List<Sys_public> list() {
		return sysPublicDao.getAll();
	}

	@Override
	public List<Sys_public> list(PageBean<Sys_public> pageBean) {
//		String sql = "select * from public_product where brandid=?";
//		List<Object> values = new ArrayList<Object>();
//		
//		values.add(brandid);
//		pageBean = productDao.search(sql, values, pageBean);
//		
//		return pageBean.getList();
		return null;
	}

	@Transactional("txManager")
	@Override
	public int update(Sys_public sysPublic) {
		Sys_public obj = sysPublicDao.update(sysPublic);
		if(obj != null){
			return 1;
		}
		return 0;
	}


}

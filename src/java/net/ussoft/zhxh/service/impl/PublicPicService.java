package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicPicDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_pic;
import net.ussoft.zhxh.service.IPublicPicService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicPicService implements IPublicPicService{

	@Resource
	PublicPicDao picDao;
	
	@Override
	public Public_pic getById(String id) {
		return picDao.get(id);
	}

	@Override
	public List<Public_pic> list(String parentid,String parenttype) {
		Public_pic pic = new Public_pic();
		pic.setParentid(parentid);
		pic.setParenttype(parenttype);
		PageBean<Public_pic> p = new PageBean<Public_pic>();
		p.setIsPage(false);
		p.setOrderBy("pic_sort");
		p.setOrderType("asc");
		
		p = picDao.search(pic, p);
		
		return p.getList();
		
	}

	@Override
	public PageBean<Public_pic> list(PageBean<Public_pic> pageBean,String parentid,String parenttype) {
		Public_pic pic = new Public_pic();
		pic.setParentid(parentid);
		pic.setParenttype(parenttype);
		
		pageBean = picDao.search(pic, pageBean);
		
		return pageBean;
	}

	@Transactional("txManager")
	@Override
	public int update(Public_pic pic) {
		Public_pic obj = picDao.update(pic);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return picDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_pic insert(Public_pic pic) {
		return picDao.save(pic);
	}

}

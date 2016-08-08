package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicVideoDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_video;
import net.ussoft.zhxh.service.IPublicVideoService;

@Service
public class PublicVideoService implements IPublicVideoService{

	@Resource
	private PublicVideoDao videoDao;
	
	@Override
	public Public_video getById(String id) {
		return videoDao.get(id);
	}

	@Override
	public List<Public_video> list(String parentid,String parenttype) {
		Public_video video = new Public_video();
		video.setParentid(parentid);
		video.setParenttype(parenttype);
		PageBean<Public_video> p = new PageBean<Public_video>();
		p.setIsPage(false);
		p.setOrderBy("sort");
		p.setOrderType("asc");
		
		p = videoDao.search(video, p);
		
		return p.getList();
		
	}

	@Override
	public PageBean<Public_video> list(PageBean<Public_video> pageBean,String parentid,String parenttype) {
		Public_video video = new Public_video();
		video.setParentid(parentid);
		video.setParenttype(parenttype);
		
		pageBean = videoDao.search(video, pageBean);
		
		return pageBean;
	}

	@Transactional("txManager")
	@Override
	public int update(Public_video video) {
		Public_video obj = videoDao.update(video);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return videoDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_video insert(Public_video video) {
		return videoDao.save(video);
	}


}

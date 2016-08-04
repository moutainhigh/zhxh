package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicContentDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_content;
import net.ussoft.zhxh.model.Public_pic;
import net.ussoft.zhxh.service.IPublicContentService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicContentService implements IPublicContentService{

	@Resource
	PublicContentDao contentDao;	//富文本
	
	@Override
	public Public_content getById(String id) {
		return contentDao.get(id);
	}

	@Override
	public List<Public_content> list(String parentid,String parenttype) {
		Public_content content = new Public_content();
		content.setParentid(parentid);
		content.setParenttype(parenttype);
		PageBean<Public_content> p = new PageBean<Public_content>();
		p.setIsPage(false);
		p.setOrderBy("sort");
		p.setOrderType("asc");
		
		p = contentDao.search(content, p);
		
		return p.getList();
	}

	@Override
	public PageBean<Public_content> list(PageBean<Public_content> pageBean,String parentid,String parenttype) {
		Public_content content = new Public_content();
		content.setParentid(parentid);
		content.setParenttype(parenttype);
		
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		values.add(parenttype);
		String sql = "SELECT id,parentid,parenttype,title,source,createtime,pic_url,top,sort FROM public_content where parentid=? and parenttype=?";
		pageBean = contentDao.search(sql,values, pageBean);
		
		return pageBean;
	}

	@Transactional("txManager")
	@Override
	public int update(Public_content content) {
		Public_content obj = contentDao.update(content);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return contentDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_content insert(Public_content content) {
		return contentDao.save(content);
	}

}

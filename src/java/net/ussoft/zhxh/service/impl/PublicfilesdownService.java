package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.FilesdownDao;
import net.ussoft.zhxh.model.Filesdown;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.service.IPublicfilesdownService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicfilesdownService implements IPublicfilesdownService{

	@Resource
	FilesdownDao filesdownDao;	//文件下载
	
	@Override
	public Filesdown getById(String id) {
		return filesdownDao.get(id);
	}

	@Override
	public List<Filesdown> list(String parentid,String parenttype) {
		Filesdown filesdown = new Filesdown();
		filesdown.setParentid(parentid);
		filesdown.setParenttype(parenttype);
		PageBean<Filesdown> p = new PageBean<Filesdown>();
		p.setIsPage(false);
		p.setOrderBy("sort");
		p.setOrderType("asc");
		
		p = filesdownDao.search(filesdown, p);
		
		return p.getList();
	}

	@Override
	public PageBean<Filesdown> list(PageBean<Filesdown> pageBean,String parentid,String parenttype) {
		Filesdown filesDown = new Filesdown();
		filesDown.setParentid(parentid);
		filesDown.setParenttype(parenttype);
		
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		values.add(parenttype);
		String sql = "SELECT * FROM filesdown where parentid=? and parenttype=?";
		pageBean = filesdownDao.search(sql,values, pageBean);
		
		return pageBean;
	}

	@Transactional("txManager")
	@Override
	public int update(Filesdown filesDown) {
		Filesdown obj = filesdownDao.update(filesDown);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return filesdownDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Filesdown insert(Filesdown filesDown) {
		return filesdownDao.save(filesDown);
	}

}

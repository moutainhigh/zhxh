package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.BrandfirstDao;
import net.ussoft.zhxh.model.Brandfirst;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.service.IBrandfirstService;

@Service
public class BrandfirstService implements IBrandfirstService{

	@Resource
	BrandfirstDao firstDao;	//品牌综合
	
	@Override
	public Brandfirst getById(String id) {
		return firstDao.get(id);
	}

	@Override
	public List<Brandfirst> list(String parentid) {
		String sql = "select * from brandfirst where brandid =? order by sort";
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		return firstDao.search(sql, values);
	}

	@Override
	public PageBean<Brandfirst> list(PageBean<Brandfirst> pageBean,String parentid) {
		String sql = "select * from brandfirst where brandid =? order by sort";
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		return firstDao.search(sql, values, pageBean);
	}

	@Transactional("txManager")
	@Override
	public int update(Brandfirst brandfirst) {
		Brandfirst obj = firstDao.update(brandfirst);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return firstDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Brandfirst insert(Brandfirst brandfirst) {
		return firstDao.save(brandfirst);
	}

}

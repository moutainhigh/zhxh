package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicCatDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_cat;
import net.ussoft.zhxh.service.IPublicCatService;

@Service
public class PublicCatService implements IPublicCatService{

	@Resource
	PublicCatDao catDao;
	
	@Override
	public Public_cat getById(String id) {
		return catDao.get(id);
	}

	@Override
	public Public_cat getPublicCat(String userid,String productsizeid) {
		String sql = "select * from public_cat where userid = ? and productsizeid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		values.add(productsizeid);
		List<Public_cat> list =  catDao.search(sql, values);
		if(list.size() > 0)
			return list.get(0);
		return null;
	}
	
	@Override
	public List<Public_cat> list() {
		return catDao.getAll();
	}
	
	@Override
	public List<Public_cat> list(String userid) {
		String sql = "select * from public_cat where userid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		return catDao.search(sql, values);
	}

	@Override
	public List<Public_cat> list(PageBean<Public_cat> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional("txManager")
	@Override
	public int update(Public_cat cat) {
		Public_cat obj = catDao.update(cat);
		if(obj == null){
			return 0;
		}
		return 1;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return catDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public int delete(List<String> ids) {
		return catDao.delByIds(ids);
	}
	
	@Transactional("txManager")
	@Override
	public Public_cat insert(Public_cat cat) {
		return catDao.save(cat);
	}

}

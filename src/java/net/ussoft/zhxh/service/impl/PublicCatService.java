package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_cat> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_cat> list(PageBean<Public_cat> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_cat cat) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

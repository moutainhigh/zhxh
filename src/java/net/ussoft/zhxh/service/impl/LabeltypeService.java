package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.LabeltypeDao;
import net.ussoft.zhxh.model.Labeltype;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.service.ILabeltypeService;

@Service
public class LabeltypeService implements ILabeltypeService{
	
	@Resource
	LabeltypeDao typeDao;

	@Override
	public Labeltype getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Labeltype> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Labeltype> list(PageBean<Labeltype> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Labeltype labeltype) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Labeltype insert(Labeltype labeltype) {
		// TODO Auto-generated method stub
		return null;
	}

}

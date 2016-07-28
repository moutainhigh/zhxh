package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicPayDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_pay;
import net.ussoft.zhxh.service.IPublicPayService;

@Service
public class PublicPayService implements IPublicPayService{
	
	@Resource
	PublicPayDao payDao;

	@Override
	public Public_pay getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_pay> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_pay> list(PageBean<Public_pay> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_pay pay) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Public_pay insert(Public_pay pay) {
		// TODO Auto-generated method stub
		return null;
	}

}

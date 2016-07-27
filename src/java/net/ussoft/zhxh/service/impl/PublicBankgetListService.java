package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicBankgetListDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_bankget_list;
import net.ussoft.zhxh.service.IPublicBankgetListService;

@Service
public class PublicBankgetListService implements IPublicBankgetListService{

	@Resource
	PublicBankgetListDao bankgetListDao;
	
	@Override
	public Public_bankget_list getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_bankget_list> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_bankget_list> list(PageBean<Public_bankget_list> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_bankget_list bankgetList) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

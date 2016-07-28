package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicUserBankDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user_bank;
import net.ussoft.zhxh.service.IPublicUserBankService;

@Resource
public class PublicUserBankService implements IPublicUserBankService{
	
	@Resource
	PublicUserBankDao userBankDao;

	@Override
	public Public_user_bank getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_user_bank> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_user_bank> list(PageBean<Public_user_bank> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_user_bank userBank) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Public_user_bank insert(Public_user_bank userBank) {
		// TODO Auto-generated method stub
		return null;
	}

}

package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.SysAccountDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Sys_account;
import net.ussoft.zhxh.service.ISysAccountService;

@Service
public class SysAccountService implements ISysAccountService{
	
	@Resource
	SysAccountDao accountDao;

	@Override
	public Sys_account getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Sys_account> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Sys_account> list(PageBean<Sys_account> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Sys_account account) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

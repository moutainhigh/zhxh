package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicAskResultDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_ask_result;
import net.ussoft.zhxh.service.IPublicAskResultService;

@Service
public class PublicAskResultService implements IPublicAskResultService{
	
	@Resource
	PublicAskResultDao askResultDao;

	@Override
	public Public_ask_result getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_ask_result> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_ask_result> list(PageBean<Public_ask_result> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_ask_result askResult) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

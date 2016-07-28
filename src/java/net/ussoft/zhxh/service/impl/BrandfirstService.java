package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Brandfirst> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Brandfirst> list(PageBean<Brandfirst> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Brandfirst brandfirst) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Brandfirst insert(Brandfirst brandfirst) {
		// TODO Auto-generated method stub
		return null;
	}

}

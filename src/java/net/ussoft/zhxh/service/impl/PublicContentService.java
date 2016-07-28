package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicContentDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_content;
import net.ussoft.zhxh.service.IPublicContentService;

@Service
public class PublicContentService implements IPublicContentService{

	@Resource
	PublicContentDao contentDao;	//富文本
	
	@Override
	public Public_content getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_content> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_content> list(PageBean<Public_content> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_content content) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Public_content insert(Public_content content) {
		// TODO Auto-generated method stub
		return null;
	}

}

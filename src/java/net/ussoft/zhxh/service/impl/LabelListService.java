package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.LabelListDao;
import net.ussoft.zhxh.model.Label_list;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.service.ILabelListService;

@Service
public class LabelListService implements ILabelListService{
	
	@Resource
	LabelListDao listDao;

	@Override
	public Label_list getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Label_list> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Label_list> list(PageBean<Label_list> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Label_list label_list) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

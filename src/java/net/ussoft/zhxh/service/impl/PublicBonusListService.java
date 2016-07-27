package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicBonusListDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_bonus_list;
import net.ussoft.zhxh.service.IPublicBonusListService;

@Service
public class PublicBonusListService implements IPublicBonusListService{

	@Resource
	PublicBonusListDao bonusListDao;
	
	@Override
	public Public_bonus_list getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_bonus_list> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_bonus_list> list(PageBean<Public_bonus_list> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_bonus_list bonusList) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

}

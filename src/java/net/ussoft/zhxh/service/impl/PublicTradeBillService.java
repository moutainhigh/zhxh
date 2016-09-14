package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicTradeBillDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_trade_bill;
import net.ussoft.zhxh.service.IPublicTradeBillService;

@Service
public class PublicTradeBillService implements IPublicTradeBillService{

	@Resource
	PublicTradeBillDao bankgetListDao;
	
	@Override
	public Public_trade_bill getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_trade_bill> list() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Public_trade_bill> list(PageBean<Public_trade_bill> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Public_trade_bill bankgetList) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Public_trade_bill insert(Public_trade_bill bankgetList) {
		// TODO Auto-generated method stub
		return null;
	}

}

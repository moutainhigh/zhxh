package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
		return bankgetListDao.get(id);
	}
	
	@Override
	public Public_trade_bill getByBillid(String billid) {
		String sql = "SELECT * FROM public_trade_bill WHERE billid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(billid);
		List<Public_trade_bill> list = bankgetListDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}
	

	@Override
	public List<Public_trade_bill> list() {
		return bankgetListDao.getAll();
	}

	@Override
	public PageBean<Public_trade_bill> list(PageBean<Public_trade_bill> pageBean) {
		return null;
	}

	@Transactional("txManager")
	@Override
	public int update(Public_trade_bill tradebill) {
		Public_trade_bill obj = bankgetListDao.update(tradebill);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return bankgetListDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_trade_bill insert(Public_trade_bill tradebill) {
		return bankgetListDao.save(tradebill);
	}

}

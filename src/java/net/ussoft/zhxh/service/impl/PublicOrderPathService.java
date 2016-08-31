package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicOrderPathDao;
import net.ussoft.zhxh.model.Public_order_path;
import net.ussoft.zhxh.service.IPublicOrderPathService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicOrderPathService implements IPublicOrderPathService{

	@Resource
	PublicOrderPathDao orderPathDao;
	
	@Override
	public Public_order_path getById(String id) {
		return orderPathDao.get(id);
	}

	@Override
	public Public_order_path getByOrderId(String orderid) {
		String sql = "SELECT * FROM public_order_path WHERE orderid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(orderid);
		List<Public_order_path> opList =  orderPathDao.search(sql, values);
		return opList.size() > 0 ? opList.get(0):new Public_order_path();
	}
	
	@Override
	public List<Public_order_path> list(String orderid) {
		String sql = "SELECT * FROM public_order_path WHERE orderid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(orderid);
		return orderPathDao.search(sql, values);
	}

	@Transactional("txManager")
	@Override
	public int update(Public_order_path orderPath) {
		Public_order_path obj = orderPathDao.update(orderPath);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return orderPathDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_order_path insert(Public_order_path orderPath) {
		return orderPathDao.save(orderPath);
	}

}

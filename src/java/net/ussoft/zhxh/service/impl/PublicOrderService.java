package net.ussoft.zhxh.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicOrderDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.service.IPublicOrderService;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicOrderService implements IPublicOrderService{

	@Resource
	PublicOrderDao orderDao;
	
	@Override
	public Public_order getById(String id) {
		return orderDao.get(id);
	}

	@Override
	public List<Public_order> list() {
		return orderDao.getAll();
	}
	
	@Override
	public List<Public_order> list(Map<String, Object> map) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_order.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return orderDao.search(sql, values);
	}

	@Override
	public PageBean<Public_order> list(Map<String, Object> map, PageBean<Public_order> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_order.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return orderDao.search(sql, values, pageBean);
	}

	@Transactional("txManager")
	@Override
	public int update(Public_order order) {
		Public_order obj = orderDao.update(order);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return orderDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_order insert(Public_order order) {
		return orderDao.save(order);
	}

}

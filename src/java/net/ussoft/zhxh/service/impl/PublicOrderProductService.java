package net.ussoft.zhxh.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicOrderProductDao;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.service.IPublicOrderProductService;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicOrderProductService implements IPublicOrderProductService{

	@Resource
	PublicOrderProductDao orderProductDao;
	
	@Override
	public Public_order_product getById(String id) {
		return orderProductDao.get(id);
	}

	@Override
	public List<Public_order_product> list(Map<String, Object> map) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_order_product.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return orderProductDao.search(sql, values);
	}

	@Transactional("txManager")
	@Override
	public int update(Public_order_product orderProduct) {
		Public_order_product obj = orderProductDao.update(orderProduct);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return orderProductDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_order_product insert(Public_order_product orderProduct) {
		return orderProductDao.save(orderProduct);
	}

}

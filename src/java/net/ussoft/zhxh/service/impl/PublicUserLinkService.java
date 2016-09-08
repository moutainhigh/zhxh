package net.ussoft.zhxh.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicUserLinkDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Public_user_link;
import net.ussoft.zhxh.service.IPublicUserLinkService;
import net.ussoft.zhxh.util.MakeQuerySql;

@Service
public class PublicUserLinkService implements IPublicUserLinkService{

	@Resource
	private PublicUserLinkDao userlinkDao;
	
	@Override
	public Public_user_link getById(String id) {
		return userlinkDao.get(id);
	}

	@Override
	public List<Public_user_link> list(Map<String, Object> map) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_user.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return userlinkDao.search(sql, values);
	}

	@Override
	public PageBean<Public_user_link> list(Map<String, Object> map,
			PageBean<Public_user_link> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_user.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return userlinkDao.search(sql, values, pageBean);
	}

	@Transactional("txManager")
	@Override
	public Public_user_link insert(Public_user_link userlink) {
		return userlinkDao.save(userlink);
	}

	@Transactional("txManager")
	@Override
	public int update(Public_user_link userlink) {
		Public_user_link obj = userlinkDao.update(userlink);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return userlinkDao.del(id);
	}

}

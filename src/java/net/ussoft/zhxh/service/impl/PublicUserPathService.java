package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicUserPathDao;
import net.ussoft.zhxh.model.Public_user_path;
import net.ussoft.zhxh.service.IPublicUserPathService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicUserPathService implements IPublicUserPathService{

	@Resource
	PublicUserPathDao userPathDao;
	
	@Override
	public Public_user_path getById(String id) {
		return userPathDao.get(id);
	}

	@Override
	public List<Public_user_path> list(String userid) {
		String sql = "SELECT * FROM public_user_path WHERE userid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		return userPathDao.search(sql, values);
	}

	@Transactional("txManager")
	@Override
	public int update(Public_user_path userPath) {
		Public_user_path obj = userPathDao.update(userPath);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return userPathDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_user_path insert(Public_user_path userPath) {
		return userPathDao.save(userPath);
	}

}

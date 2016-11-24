package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import net.ussoft.zhxh.dao.PublicUserDao;
import net.ussoft.zhxh.service.ISysMainService;

@Service
public class SysMainService implements ISysMainService {
	
	@Resource
	private PublicUserDao userDao;

	
	@Override
	public int getPublicUserNum(String key,String value) {
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("select * from public_user where 1=1");
		
		if (!"".equals(key)) {
			sb.append(" and ").append(key).append("=?");
			values.add(value);
		}
		return userDao.getCount(sb.toString(), values);
		
	}
	
}

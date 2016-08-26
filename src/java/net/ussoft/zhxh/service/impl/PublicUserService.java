package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicUserDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.MD5;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicUserService implements IPublicUserService{
	
	@Resource
	PublicUserDao userDao;

	@Override
	public Public_user getById(String id) {
		// TODO Auto-generated method stub
		return userDao.get(id);
	}

	@Override
	public List<Public_user> list() {
		// TODO Auto-generated method stub
		
		return userDao.getAll();
	}

	@Override
	public PageBean<Public_user> list(String key,PageBean<Public_user> pageBean) {
		
		String sql = "select * from public_user";
		List<Object> values = new ArrayList<Object>();
		
		if (null == key || "".equals(key)) {
			return userDao.search(sql, values, pageBean);
		}
		else {
			sql += " where phonenumber = ?";
			values.add(key);
			return userDao.search(sql, values, pageBean);
		}
	}

	@Override
	public PageBean<Public_user> list(Map<String, Object> map,PageBean<Public_user> pageBean) {
		
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_user.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		
		return userDao.search(sql, values, pageBean);
	}
	
	@Transactional("txManager")
	@Override
	public int update(Public_user user) {
		// TODO Auto-generated method stub
		Public_user obj = userDao.update(user);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int updateParent(String id,String parentid) {
		String sql = "update public_user set parentid = ? where id = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		values.add(id);
		return userDao.update(sql, values);
	}
	
	@Transactional("txManager")
	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		String[] ids = id.split(",");
		for(int i=0;i<ids.length;i++){
			userDao.del(ids[i]);
		}
		return 1;
	}

	@Transactional("txManager")
	@Override
	public Public_user insert(Public_user user) {
		// TODO Auto-generated method stub
		userDao.save(user);
		return user;
	}

	@Override
	public boolean checkPhoneNum(String phoneNum) {
		// TODO Auto-generated method stub
		List<Object> values = new ArrayList<Object>();
		values.add(phoneNum);
		String sql = "select id from public_user where phonenumber=?";
		List<Public_user> list = userDao.search(sql, values);
		if(list.size() > 0)
			return true;
		return false;
	}

	@Override
	public Public_user getByPhoneNum(String phoneNum) {
		List<Object> values = new ArrayList<Object>();
		values.add(phoneNum);
		String sql = "select * from public_user where phonenumber=?";
		List<Public_user> list = userDao.search(sql, values);
		if(list.size() > 0){
			return list.get(0);
		}
		
		return null;
	}

	/*private Map<String, Object> search(Class typeClass,Map<String, Object> map){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String tablename = typeClass.getName().substring(
                typeClass.getName().lastIndexOf(".") + 1);
		
		StringBuffer sql=new StringBuffer("select * from ");
        sql.append(tablename);
        if (map.size()!=0) {
            sql.append(" t where 1=1");//后面只需拼接and条件
        }
        List<Object> values = new ArrayList<Object>();
        
        Set<Entry<String, Object>> set=map.entrySet();
        Iterator iterator=set.iterator();
        for (int i = 0; i < set.size(); i++) {
            Map.Entry mapEntry=(Entry) iterator.next();
            if (null != mapEntry.getValue() && !"".equals(mapEntry.getValue().toString())) {
            	sql.append(" and t."+mapEntry.getKey()+" ?");
            	values.add(mapEntry.getValue());
            }
        }
        resultMap.put("sql", sql.toString());
        resultMap.put("values", values);
        return resultMap;
	}*/
	
}

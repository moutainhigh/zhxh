package net.ussoft.zhxh.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicMessageDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_message;
import net.ussoft.zhxh.service.IPublicMessageService;

@Service
public class PublicMessageService implements IPublicMessageService{
	
	@Resource
	private PublicMessageDao mDao;

	@Override
	public Public_message getById(String id) {
		// TODO Auto-generated method stub
		return mDao.get(id);
	}

	@Override
	public List<Public_message> list() {
		return mDao.getAll();
	}
	
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUserService#list(java.lang.String, java.lang.String, java.util.Map, net.ussoft.zhxh.model.PageBean)
	 */
	@Override
	public PageBean<Public_message> list(String receiveid,String messagetype,Map<String, Object> map,PageBean<Public_message> pageBean) {
		StringBuffer sb = new StringBuffer();
		sb.append("select * from public_message where receiveid=? and messagetype=?");
		
		List<Object> values = new ArrayList<Object>();
		values.add(receiveid);
		values.add(messagetype);
		
		boolean isPage = true;
		
		if (null != map && map.size() > 0) {
			Set<Entry<String, Object>> set=map.entrySet();
	        Iterator iterator=set.iterator();
	        sb.append(" and (");
	        for (int i = 0; i < set.size(); i++) {
	            Map.Entry mapEntry=(Entry) iterator.next();
	            if (null != mapEntry.getValue() && !"".equals(mapEntry.getValue().toString())) {
	            	sb.append(mapEntry.getKey()+" like '%"+mapEntry.getValue()+"%' or ");
	            }
	        }
	        sb.delete(sb.length()-3, sb.length());
	        sb.append(")");
		}
		sb.append(" order by messagetime desc");
		
		pageBean = mDao.search(sb.toString(), values, pageBean);
		
		return pageBean;
	}
	
	@Transactional("txManager")
	@Override
	public boolean delete(String id) {
		String[] ids = id.split(",");
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		for(int i=0;i<ids.length;i++){
			mDao.del(id);
		}
		return true;
	}
	
	
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUserService#updateBatch(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public boolean updateBatch(String ids,String field,String fieldValue) {
		if (null == ids || "".equals(ids)) {
			return false;
		}
		
		String[] idsArr = ids.split(",");
		
		List<String> idsList = Arrays.asList(idsArr);
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		
		sb.append("update public_message set ");
		sb.append(field).append("=?");
		values.add(fieldValue);
		sb.append(" where id in (");
		
		Serializable[] ss=new Serializable[idsList.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(idsList);
		
		int num = mDao.update(sb.toString(), values);
		
		if (num > 0) {
			return true;
		}
		
		return false;
	}

	@Override
	public int getMessageNum(String receiveid, int messagetype) {
		StringBuffer sb = new StringBuffer();
		sb.append("select * from public_message where receiveid=? and messagetype=? and messagestate = ?");
		
		List<Object> values = new ArrayList<Object>();
		values.add(receiveid);
		values.add(messagetype);
		values.add(0);
		
		int num = mDao.getCount(sb.toString(), values);
		return num;
	}

}

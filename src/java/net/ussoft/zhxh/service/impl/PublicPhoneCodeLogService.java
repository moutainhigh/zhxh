package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicPhoneCodeLogDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_phone_code_log;
import net.ussoft.zhxh.service.IPublicPhoneCodeLogService;

@Service
public class PublicPhoneCodeLogService implements IPublicPhoneCodeLogService{

	@Resource
	private PublicPhoneCodeLogDao logDao;
	
	@Override
	public Public_phone_code_log getById(String id) {
		return logDao.get(id);
	}

	@Override
	public List<Public_phone_code_log> list(String phonenumber,String sendtype) {
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("select * from public_phone_code_log where 1=1 ");
		if (null != phonenumber && !"".equals(phonenumber)) {
			sb.append(" and phonenumber =? ");
			values.add(phonenumber);
		}
		
		if (null != sendtype && !"".equals(sendtype)) {
			sb.append(" and sendtype =? ");
			values.add(sendtype);
		}
		
		sb.append(" order by sendtimestr desc");
		
		List<Public_phone_code_log> list = logDao.search(sb.toString(), values);
		
		return list;
	}

	@Override
	public PageBean<Public_phone_code_log> list(PageBean<Public_phone_code_log> pageBean,String phonenumber,String sendtype) {
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("select * from public_phone_code_log where 1=1 ");
		if (null != phonenumber && !"".equals(phonenumber)) {
			sb.append(" and phonenumber =? ");
			values.add(phonenumber);
		}
		
		if (null != sendtype && !"".equals(sendtype)) {
			sb.append(" and sendtype =? ");
			values.add(sendtype);
		}
		
		sb.append(" order by sendtimestr desc");
		
		pageBean = logDao.search(sb.toString(), values, pageBean);
		
		return pageBean;
	}

	@Transactional("txManager")
	@Override
	public int update(Public_phone_code_log log) {
		Public_phone_code_log obj = logDao.update(log);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return logDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_phone_code_log insert(Public_phone_code_log log) {
		return logDao.save(log);
	}

}

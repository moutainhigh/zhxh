package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicDisDetailsDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_dis_details;
import net.ussoft.zhxh.service.IPublicDisDetailsService;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicDisDetailsService implements IPublicDisDetailsService{

	@Resource
	private PublicDisDetailsDao disDetailsDao;

	@Override
	public Public_dis_details getById(String id) {
		return disDetailsDao.get(id);
	}

	@Override
	public Public_dis_details getByBillno(String billno) {
		String sql = "SELECT * FROM Public_dis_details WHERE billno=?";
		List<Object> values = new ArrayList<Object>();
		values.add(billno);
		List<Public_dis_details> list = disDetailsDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}

	@Override
	public List<Public_dis_details> list() {
		return disDetailsDao.getAll();
	}
	
	@Override
	public PageBean<Public_dis_details> list(Map<String, Object> map,
			PageBean<Public_dis_details> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_dis_details.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return disDetailsDao.search(sql, values, pageBean);
	}

	@Override
	public PageBean<Map<String,Object>> list(String userid,String parentid,int detailstype,PageBean<Map<String,Object>> pageBean) {
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("SELECT * FROM Public_dis_details WHERE detailstype=? AND aid=? ");
		values.add(detailstype);
		values.add(parentid);
		if(detailstype == 1){
			sb.append(" AND uid=?");
			values.add(userid);
		}else if(detailstype == 2){
			sb.append(" AND tid=?");
			values.add(userid);
		}else{
			sb.append(" AND 1=0");
		}
		
		return disDetailsDao.searchForMap(sb.toString(), values, pageBean);
	}
	
	@Transactional("txManager")
	@Override
	public Public_dis_details insert(Public_dis_details bill) {
		return disDetailsDao.save(bill);
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return disDetailsDao.del(id);
	}
	
	@Transactional("txManager")
	@Override
	public int update(Public_dis_details bill) {
		bill = disDetailsDao.update(bill);
		if(bill != null){
			return 1;
		}
		return 0;
	}

}

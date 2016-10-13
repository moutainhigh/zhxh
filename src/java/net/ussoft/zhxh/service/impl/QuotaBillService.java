package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.QuotaBillDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Quota_bill;
import net.ussoft.zhxh.service.IQuotaBillService;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class QuotaBillService implements IQuotaBillService{

	@Resource
	private QuotaBillDao quotaBillDao;

	@Override
	public Quota_bill getById(String id) {
		return quotaBillDao.get(id);
	}

	@Override
	public Quota_bill getByBillno(String billno) {
		String sql = "SELECT * FROM Quota_bill WHERE billno=?";
		List<Object> values = new ArrayList<Object>();
		values.add(billno);
		List<Quota_bill> list = quotaBillDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}

	@Override
	public List<Quota_bill> list() {
		return quotaBillDao.getAll();
	}
	
	@Override
	public PageBean<Quota_bill> list(Map<String, Object> map,
			PageBean<Quota_bill> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Quota_bill.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return quotaBillDao.search(sql, values, pageBean);
	}

	@Override
	public PageBean<Map<String,Object>> list(String userid,String parentid,PageBean<Map<String,Object>> pageBean) {
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("SELECT * FROM quota_bill where 1=1 ");
		
		if(null != userid && !"".equals(userid)){
			sb.append(" AND userid= ?");
			values.add(userid);
		}
		if(null != parentid && !"".equals(parentid)){
			sb.append(" AND parentid= ?");
			values.add(parentid);
		}
		
		return quotaBillDao.searchForMap(sb.toString(), values, pageBean);
	}
	
	@Transactional("txManager")
	@Override
	public Quota_bill insert(Quota_bill bill) {
		return quotaBillDao.save(bill);
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return quotaBillDao.del(id);
	}
	
	@Transactional("txManager")
	@Override
	public int update(Quota_bill bill) {
		bill = quotaBillDao.update(bill);
		if(bill != null){
			return 1;
		}
		return 0;
	}

}

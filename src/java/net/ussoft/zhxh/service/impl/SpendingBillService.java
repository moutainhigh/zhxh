package net.ussoft.zhxh.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.SpendingBillDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Spending_bill;
import net.ussoft.zhxh.service.ISpendingBillService;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SpendingBillService implements ISpendingBillService{

	@Resource
	private SpendingBillDao spendingBillDao;

	@Override
	public Spending_bill getById(String id) {
		return spendingBillDao.get(id);
	}

	@Override
	public Spending_bill getByBillno(String billno) {
		String sql = "SELECT * FROM Spending_bill WHERE billno=?";
		List<Object> values = new ArrayList<Object>();
		values.add(billno);
		List<Spending_bill> list = spendingBillDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}

	@Override
	public List<Spending_bill> list() {
		return spendingBillDao.getAll();
	}
	
	@Override
	public PageBean<Spending_bill> list(Map<String, Object> map,
			PageBean<Spending_bill> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Spending_bill.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return spendingBillDao.search(sql, values, pageBean);
	}

	@Override
	public PageBean<Map<String,Object>> list(String userid,String parentid,List<String> trantype,PageBean<Map<String,Object>> pageBean) {
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("SELECT * FROM spending_bill WHERE 1=1 ");
		if(null != trantype && trantype.size() > 0){
			sb.append(" AND trantype in(");
			Serializable[] ss=new Serializable[trantype.size()];
			Arrays.fill(ss, "?");
			sb.append(StringUtils.join(ss,','));
			sb.append(")");
			values.addAll(trantype);
		}
		if(null != userid && !"".equals(userid) && null != parentid && !"".equals(parentid)){
			sb.append(" AND userid= ?");
			values.add(userid);
			sb.append(" AND parentid= ?");
			values.add(parentid);
		}else{
			if(null != parentid && !"".equals(parentid)){
				sb.append(" AND (userid= ? OR parentid=?) ");
				values.add(parentid);
				values.add(parentid);
			}
		}
		return spendingBillDao.searchForMap(sb.toString(), values, pageBean);
	}
	
	@Transactional("txManager")
	@Override
	public Spending_bill insert(Spending_bill bill) {
		return spendingBillDao.save(bill);
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return spendingBillDao.del(id);
	}
	
	@Transactional("txManager")
	@Override
	public int update(Spending_bill bill) {
		bill = spendingBillDao.update(bill);
		if(bill != null){
			return 1;
		}
		return 0;
	}

}

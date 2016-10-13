package net.ussoft.zhxh.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.IncomeBillDao;
import net.ussoft.zhxh.model.Income_bill;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.service.IIncomeBillService;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class IncomeBillService implements IIncomeBillService{

	@Resource
	private IncomeBillDao incomeBillDao;

	@Override
	public Income_bill getById(String id) {
		return incomeBillDao.get(id);
	}

	@Override
	public Income_bill getByBillno(String billno) {
		String sql = "SELECT * FROM income_bill WHERE billno=?";
		List<Object> values = new ArrayList<Object>();
		values.add(billno);
		List<Income_bill> list = incomeBillDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}

	@Override
	public List<Income_bill> list() {
		return incomeBillDao.getAll();
	}
	
	@Override
	public PageBean<Income_bill> list(Map<String, Object> map,
			PageBean<Income_bill> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Income_bill.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return incomeBillDao.search(sql, values, pageBean);
	}

	@Override
	public PageBean<Map<String,Object>> list(String userid,String parentid,List<String> trantype,String identity,PageBean<Map<String,Object>> pageBean) {
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("SELECT * FROM income_bill WHERE STATUS=1 ");
		if(null != trantype && trantype.size() > 0){
			sb.append(" AND trantype in(");
			Serializable[] ss=new Serializable[trantype.size()];
			Arrays.fill(ss, "?");
			sb.append(StringUtils.join(ss,','));
			sb.append(")");
			values.addAll(trantype);
		}
		
		if("A".equals(identity)){
			//代理
			if(!"1".equals(parentid)){
				sb.append(" AND (");
				sb.append(" trantype=1");//现金充值
				sb.append(" AND userid= ?");
				values.add(parentid);
				sb.append(" OR parentid= ?");
				values.add(parentid);
				sb.append(" ) ");
			}else{
				sb.append(" AND userid= ?");
				values.add(userid);
				sb.append(" AND parentid= ?");
				values.add(parentid);
			}
		}else if("C".equals(identity)){
			sb.append(" AND userid= ?");
			values.add(userid);
			sb.append(" AND parentid= ?");
			values.add(parentid);
		}
		
		return incomeBillDao.searchForMap(sb.toString(), values, pageBean);
	}
	
	@Transactional("txManager")
	@Override
	public Income_bill insert(Income_bill bill) {
		return incomeBillDao.save(bill);
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return incomeBillDao.del(id);
	}
	
	@Transactional("txManager")
	@Override
	public int update(Income_bill bill) {
		bill = incomeBillDao.update(bill);
		if(bill != null){
			return 1;
		}
		return 0;
	}

}

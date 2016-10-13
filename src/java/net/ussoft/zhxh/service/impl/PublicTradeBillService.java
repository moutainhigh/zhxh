package net.ussoft.zhxh.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicTradeBillDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_trade_bill;
import net.ussoft.zhxh.service.IPublicTradeBillService;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicTradeBillService implements IPublicTradeBillService{

	@Resource
	PublicTradeBillDao bankgetListDao;
	
	@Override
	public Public_trade_bill getById(String id) {
		return bankgetListDao.get(id);
	}
	
	@Override
	public Public_trade_bill getByBillid(String billid) {
		String sql = "SELECT * FROM public_trade_bill WHERE billid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(billid);
		List<Public_trade_bill> list = bankgetListDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}
	

	@Override
	public List<Public_trade_bill> list() {
		return bankgetListDao.getAll();
	}

	@Override
	public PageBean<Public_trade_bill> list(Map<String, Object> map,PageBean<Public_trade_bill> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_trade_bill.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return bankgetListDao.search(sql, values, pageBean);
	}

	@Override
	public PageBean<Map<String,Object>> list(String userid,String parentid,List<String> trantype,String identity,PageBean<Map<String,Object>> pageBean) {
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("SELECT t.*,p.username AS u_username,p.companyname AS u_companyname,p1.username AS p_username,p1.companyname AS p_companyname FROM public_trade_bill t,public_user p,public_user p1 WHERE t.userid = p.id AND t.parentid = p1.id ");
		if(null != trantype && trantype.size() > 0){
			sb.append(" AND t.trantype in(");
			Serializable[] ss=new Serializable[trantype.size()];
			Arrays.fill(ss, "?");
			sb.append(StringUtils.join(ss,','));
			sb.append(")");
			values.addAll(trantype);
		}
		sb.append(" AND t.status=1");
		
		if("A".equals(identity)){
			//代理
			if(!"1".equals(parentid)){
				sb.append(" AND (");
				sb.append(" t.trantype=2");//现金充值
				sb.append(" AND t.userid= ?");
				values.add(parentid);
				sb.append(" OR t.parentid= ?");
				values.add(parentid);
				sb.append(" ) ");
			}else{
				sb.append(" AND t.parentid= ?");
				values.add(parentid);
			}
		}else if("C".equals(identity)){
			sb.append(" AND t.userid= ?");
			values.add(userid);
			sb.append(" AND t.parentid= ?");
			values.add(parentid);
		}
		
		return bankgetListDao.searchForMap(sb.toString(), values, pageBean);
	}
	
	@Transactional("txManager")
	@Override
	public int update(Public_trade_bill tradebill) {
		Public_trade_bill obj = bankgetListDao.update(tradebill);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return bankgetListDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_trade_bill insert(Public_trade_bill tradebill) {
		return bankgetListDao.save(tradebill);
	}

}

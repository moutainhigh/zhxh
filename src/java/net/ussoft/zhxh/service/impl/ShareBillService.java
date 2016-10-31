package net.ussoft.zhxh.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicOrderProductDao;
import net.ussoft.zhxh.dao.ShareBillDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Share_bill;
import net.ussoft.zhxh.service.IShareBillService;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ShareBillService implements IShareBillService{

	@Resource
	private ShareBillDao shareBillDao;
	@Resource
	private PublicOrderProductDao opDao;

	@Override
	public Share_bill getById(String id) {
		return shareBillDao.get(id);
	}
	
	@Override
	public Share_bill getByOrderid(String id) {
		String sql = "select * from Share_bill where orderid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(id);
		
		List<Share_bill> billList = shareBillDao.search(sql, values);
		
		if (null == billList || billList.size() == 0) {
			return null;
		}
		
		return billList.get(0);
	}

	@Override
	public List<Share_bill> list() {
		return shareBillDao.getAll();
	}
	
	@Override
	public PageBean<Share_bill> list(Map<String, Object> map,
			PageBean<Share_bill> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Share_bill.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return shareBillDao.search(sql, values, pageBean);
	}
	
	@Override
	public List<Public_order_product> orderProlist(String orderproductids){
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT * FROM public_order_product WHERE id IN(");
		List<Object> values = new ArrayList<Object>();
		
		String[] ids = orderproductids.split(",");
		List<String> idsList = Arrays.asList(ids);
		Serializable[] ss=new Serializable[idsList.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(idsList);
		
		return opDao.search(sb.toString(), values);
	}
	
	@Transactional("txManager")
	@Override
	public Share_bill insert(Share_bill bill) {
		return shareBillDao.save(bill);
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return shareBillDao.del(id);
	}
	
	@Transactional("txManager")
	@Override
	public int update(Share_bill bill) {
		bill = shareBillDao.update(bill);
		if(bill != null){
			return 1;
		}
		return 0;
	}

}

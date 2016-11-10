package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.DisposableBillDao;
import net.ussoft.zhxh.model.Disposable_bill;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.service.IDisposableBillService;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DisposableBillService implements IDisposableBillService{

	@Resource
	private DisposableBillDao disposableBillDao;

	@Override
	public Disposable_bill getById(String id) {
		return disposableBillDao.get(id);
	}
	
	@Override
	public Disposable_bill getByOrderid(String id) {
		String sql = "select * from Disposable_bill where orderid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(id);
		
		List<Disposable_bill> billList = disposableBillDao.search(sql, values);
		
		if (null == billList || billList.size() == 0) {
			return null;
		}
		
		return billList.get(0);
	}


	@Override
	public Disposable_bill getByBillno(String billno) {
		String sql = "SELECT * FROM Disposable_bill WHERE billno=?";
		List<Object> values = new ArrayList<Object>();
		values.add(billno);
		List<Disposable_bill> list = disposableBillDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}

	@Override
	public List<Disposable_bill> list() {
		return disposableBillDao.getAll();
	}
	
	@Override
	public PageBean<Disposable_bill> list(Map<String, Object> map,
			PageBean<Disposable_bill> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Disposable_bill.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return disposableBillDao.search(sql, values, pageBean);
	}

	@Override
	public PageBean<Map<String,Object>> list(String userid,String parentid,List<String> trantype,String identity,PageBean<Map<String,Object>> pageBean) {
		//暂不启用
		return null;
	}
	
	@Transactional("txManager")
	@Override
	public Disposable_bill insert(Disposable_bill bill) {
		return disposableBillDao.save(bill);
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return disposableBillDao.del(id);
	}
	
	@Transactional("txManager")
	@Override
	public int update(Disposable_bill bill) {
		bill = disposableBillDao.update(bill);
		if(bill != null){
			return 1;
		}
		return 0;
	}

}

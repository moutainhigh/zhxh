package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.TransfBuyBankBillDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Transf_buy_bank_bill;
import net.ussoft.zhxh.service.ITransfBuyBankBillService;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TransfBuyBankBillService implements ITransfBuyBankBillService{

	@Resource
	private TransfBuyBankBillDao transBillDao;

	@Override
	public Transf_buy_bank_bill getById(String id) {
		return transBillDao.get(id);
	}
	
	@Override
	public Transf_buy_bank_bill getByOrderid(String id) {
		String sql = "select * from transf_buy_bank_bill where orderid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(id);
		
		List<Transf_buy_bank_bill> billList = transBillDao.search(sql, values);
		
		if (null == billList || billList.size() == 0) {
			return null;
		}
		
		return billList.get(0);
	}


	@Override
	public Transf_buy_bank_bill getByBillno(String billno) {
		String sql = "SELECT * FROM transf_buy_bank_bill WHERE billno=?";
		List<Object> values = new ArrayList<Object>();
		values.add(billno);
		List<Transf_buy_bank_bill> list = transBillDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}

	@Override
	public List<Transf_buy_bank_bill> list() {
		return transBillDao.getAll();
	}
	
	@Override
	public PageBean<Transf_buy_bank_bill> list(Map<String, Object> map,
			PageBean<Transf_buy_bank_bill> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Transf_buy_bank_bill.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return transBillDao.search(sql, values, pageBean);
	}
	
	@Transactional("txManager")
	@Override
	public Transf_buy_bank_bill insert(Transf_buy_bank_bill bill) {
		return transBillDao.save(bill);
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return transBillDao.del(id);
	}
	
	@Transactional("txManager")
	@Override
	public int update(Transf_buy_bank_bill bill) {
		bill = transBillDao.update(bill);
		if(bill != null){
			return 1;
		}
		return 0;
	}

}

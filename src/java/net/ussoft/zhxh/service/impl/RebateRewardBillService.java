package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.RebateRewardBillDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Rebate_reward_bill;
import net.ussoft.zhxh.service.IRebateRewardBillService;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class RebateRewardBillService implements IRebateRewardBillService{

	@Resource
	private RebateRewardBillDao rebateRewardBillDao;

	@Override
	public Rebate_reward_bill getById(String id) {
		return rebateRewardBillDao.get(id);
	}
	
	@Override
	public Rebate_reward_bill getByOrderid(String id) {
		String sql = "select * from Rebate_reward_bill where orderid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(id);
		
		List<Rebate_reward_bill> billList = rebateRewardBillDao.search(sql, values);
		
		if (null == billList || billList.size() == 0) {
			return null;
		}
		
		return billList.get(0);
	}


	@Override
	public Rebate_reward_bill getByBillno(String billno) {
		String sql = "SELECT * FROM Rebate_reward_bill WHERE billno=?";
		List<Object> values = new ArrayList<Object>();
		values.add(billno);
		List<Rebate_reward_bill> list = rebateRewardBillDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}

	@Override
	public List<Rebate_reward_bill> list() {
		return rebateRewardBillDao.getAll();
	}
	
	@Override
	public PageBean<Rebate_reward_bill> list(Map<String, Object> map,
			PageBean<Rebate_reward_bill> pageBean) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Rebate_reward_bill.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		return rebateRewardBillDao.search(sql, values, pageBean);
	}

	@Override
	public PageBean<Map<String,Object>> list(String userid,String parentid,int detailstype,PageBean<Map<String,Object>> pageBean) {
		//暂时不用
		return null;
	}
	
	@Transactional("txManager")
	@Override
	public Rebate_reward_bill insert(Rebate_reward_bill bill) {
		return rebateRewardBillDao.save(bill);
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return rebateRewardBillDao.del(id);
	}
	
	@Transactional("txManager")
	@Override
	public int update(Rebate_reward_bill bill) {
		bill = rebateRewardBillDao.update(bill);
		if(bill != null){
			return 1;
		}
		return 0;
	}

}

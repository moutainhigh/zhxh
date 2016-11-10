package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicOrderLogisticsDao;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_order_logistics;
import net.ussoft.zhxh.service.IPublicOrderLogisticsService;
import net.ussoft.zhxh.util.kuaidi100.KdQuery;
import net.ussoft.zhxh.util.kuaidi100.pojo.Result;
import net.ussoft.zhxh.util.kuaidi100.pojo.ResultItem;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicOrderLogisticsService implements IPublicOrderLogisticsService{

	@Resource
	PublicOrderLogisticsDao orderLogisticsDao;
	
	@Override
	public Public_order_logistics getById(String id) {
		return orderLogisticsDao.get(id);
	}

	@Override
	public List<Public_order_logistics> list() {
		return orderLogisticsDao.getAll();
	}

	@Override
	public List<Public_order_logistics> list(String orderid) {
		String sql = "SELECT * FROM Public_order_logistics WHERE orderid=? ORDER BY handletime DESC";
		List<Object> values = new ArrayList<Object>();
		values.add(orderid);
		return orderLogisticsDao.search(sql, values);
	}

	@Transactional("txManager")
	@Override
	public List<Public_order_logistics> orderLogistics(Public_order order){
		List<Public_order_logistics> resultList = new ArrayList<Public_order_logistics>();
		if(null != order.getDeliverynum() && !"".equals(order.getDeliverynum())){
			List<Public_order_logistics> logisticsList = list(order.getId());
			if(logisticsList.size() > 0){
				resultList = logisticsList;
			}else{
				Result result = KdQuery.getNoticeResult(order.getDeliverynum());
				/*快递单当前签收状态，包括0在途中、1已揽收、2疑难、3已签收、4退签、5同城派送中、6退回、7转单等7个状态，其中4-7需要另外开通才有效 */
				if("3".equals(result.getState())){
					// 处理快递结果
					resultList = insert(result.getData(), order.getId());
				}else{
					ArrayList<ResultItem> list = result.getData();
					for(ResultItem item : list){
						Public_order_logistics obj = new Public_order_logistics();
						obj.setHandletime(item.getFtime());
						obj.setHandleresult(item.getContext());
						resultList.add(obj);
					}
				}
			}
		}
		return resultList;
	}
	
	@Transactional("txManager")
	@Override
	public int update(Public_order_logistics orderLogistics) {
		Public_order_logistics obj = orderLogisticsDao.update(orderLogistics);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return orderLogisticsDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_order_logistics insert(Public_order_logistics orderLogistics) {
		return orderLogisticsDao.save(orderLogistics);
	}
	
	@Override
	public List<Public_order_logistics> insert(ArrayList<ResultItem> list,String orderid){
		List<Public_order_logistics> logisticsList = new ArrayList<Public_order_logistics>();
		for(ResultItem item : list){
			Public_order_logistics obj = new Public_order_logistics();
			obj.setId(UUID.randomUUID().toString());
			obj.setOrderid(orderid);
			obj.setHandletime(item.getFtime());
			obj.setHandleresult(item.getContext());
			orderLogisticsDao.save(obj);
			logisticsList.add(obj);
		}
		return logisticsList;
	}

}

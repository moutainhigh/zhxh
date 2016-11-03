package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Transf_buy_bank_bill;

/**
 * 奖励转货款-账单流水记录
 * @author guodh
 * @version v1.0 2016.11.02
 * */
public interface ITransfBuyBankBillService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Transf_buy_bank_bill
	 * */
	public Transf_buy_bank_bill getById(String id);
	/**
	 * 根据订单id获取对象
	 * @param id
	 * @return Transf_buy_bank_bill
	 * */
	public Transf_buy_bank_bill getByOrderid(String id);
	
	/**
	 * 根据流水单号获取对象
	 * @param billno
	 * @return
	 * */
	public Transf_buy_bank_bill getByBillno(String billno);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Transf_buy_bank_bill> list();
	
	/**
	 * 查询所有 分页
	 * @param map
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Transf_buy_bank_bill> list(Map<String, Object> map,PageBean<Transf_buy_bank_bill> pageBean);
	
	/**
	 * 添加
	 * @param Transf_buy_bank_bill
	 * @return 
	 * */
	public Transf_buy_bank_bill insert(Transf_buy_bank_bill bill);
	
	/**
	 * 修改
	 * @param Transf_buy_bank_bill
	 * @return 
	 * */
	public int update(Transf_buy_bank_bill bill);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

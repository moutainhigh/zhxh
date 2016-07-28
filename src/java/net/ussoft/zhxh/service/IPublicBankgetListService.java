package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_bankget_list;

/**
 * 提现记录
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicBankgetListService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_bankget_list
	 * */
	public Public_bankget_list getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_bankget_list> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_bankget_list> list(PageBean<Public_bankget_list> pageBean);
	
	/**
	 * 添加
	 * @param Public_bankget_list
	 * @return 
	 * */
	public Public_bankget_list insert(Public_bankget_list bankgetList);
	
	/**
	 * 修改
	 * @param Public_bankget_list
	 * @return 
	 * */
	public int update(Public_bankget_list bankgetList);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

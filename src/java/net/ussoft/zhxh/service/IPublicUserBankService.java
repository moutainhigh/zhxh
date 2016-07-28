package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user_bank;

/**
 * 个人账户管理
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicUserBankService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_user_bank
	 * */
	public Public_user_bank getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_user_bank> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_user_bank> list(PageBean<Public_user_bank> pageBean);
	
	/**
	 * 添加
	 * @param Public_user_bank
	 * @return 
	 * */
	public Public_user_bank insert(Public_user_bank userBank);
	
	/**
	 * 修改
	 * @param Public_user_bank
	 * @return 
	 * */
	public int update(Public_user_bank userBank);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

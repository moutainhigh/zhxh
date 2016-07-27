package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Sys_account;

/**
 * 系统账户管理
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface ISysAccountService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Sys_account
	 * */
	public Sys_account getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Sys_account> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Sys_account> list(PageBean<Sys_account> pageBean);
	
	/**
	 * 添加
	 * @param Sys_account
	 * @return 
	 * */
	public int update(Sys_account account);
	
	/**
	 * 添加
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

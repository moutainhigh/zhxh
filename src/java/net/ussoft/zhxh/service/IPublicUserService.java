package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user;

/**
 * 用户管理
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicUserService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_user
	 * */
	public Public_user getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_user> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_user> list(PageBean<Public_user> pageBean);
	
	/**
	 * 添加
	 * @param Public_user
	 * @return 
	 * */
	public int update(Public_user user);
	
	/**
	 * 添加
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

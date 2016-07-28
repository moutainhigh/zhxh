package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user_ask;

/**
 * 个人提问
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicUserAskService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_user_ask
	 * */
	public Public_user_ask getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_user_ask> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_user_ask> list(PageBean<Public_user_ask> pageBean);
	
	/**
	 * 添加
	 * @param Public_user_ask
	 * @return 
	 * */
	public Public_user_ask insert(Public_user_ask userAsk);
	
	/**
	 * 修改
	 * @param Public_user_ask
	 * @return 
	 * */
	public int update(Public_user_ask userAsk);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

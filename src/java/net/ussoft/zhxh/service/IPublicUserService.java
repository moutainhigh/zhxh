package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

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
	 * 根据手机号获取对象
	 * @return list
	 * */
	public Public_user getByPhoneNum(String phoneNum);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_user> list();
	
	/**
	 * 条件查询 分页
	 * */
	public PageBean<Public_user> list(Map<String, Object> map,PageBean<Public_user> pageBean);
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public PageBean<Public_user> list(String key,PageBean<Public_user> pageBean);
	
	/**
	 * 添加
	 * @param Public_user
	 * @return 
	 * */
	public Public_user insert(Public_user user);
	
	/**
	 * 修改
	 * @param Public_user
	 * @return 
	 * */
	public int update(Public_user user);
	
	/**
	 * 修改其上级机构
	 * @param id
	 * @param parentid
	 * @return 
	 * */
	public int updateParent(String id,String parentid);
	
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
	
	/**
	 * 验证手机号是否已存在
	 * @param phoneNum
	 * @return true:存在；false:不存在
	 * */
	public boolean checkPhoneNum(String phoneNum);
	
}

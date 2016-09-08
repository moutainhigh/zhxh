package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user_link;

/**
 * 个人中心关系关联表 -一个店有多个上级
 * @author guodh
 * @version v1.0 2016.09.05
 * */
public interface IPublicUserLinkService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_user_link
	 * */
	public Public_user_link getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_user_link> list(Map<String, Object> map);
	
	/**
	 * 条件查询 分页
	 * */
	public PageBean<Public_user_link> list(Map<String, Object> map,PageBean<Public_user_link> pageBean);
	
	
	/**
	 * 添加
	 * @param Public_user_link
	 * @return 
	 * */
	public Public_user_link insert(Public_user_link userlink);
	
	/**
	 * 修改
	 * @param Public_user_link
	 * @return 
	 * */
	public int update(Public_user_link userlink);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
	
}

package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_bonus_list;

/**
 * 分销明细
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicBonusListService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_bonus_list
	 * */
	public Public_bonus_list getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_bonus_list> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_bonus_list> list(PageBean<Public_bonus_list> pageBean);
	
	/**
	 * 添加
	 * @param Public_bonus_list
	 * @return 
	 * */
	public Public_bonus_list insert(Public_bonus_list bonusList);
	
	/**
	 * 修改
	 * @param Public_bonus_list
	 * @return 
	 * */
	public int update(Public_bonus_list bonusList);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

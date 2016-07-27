package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_cat;

/**
 * 购物车
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicCatService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_cat
	 * */
	public Public_cat getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_cat> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_cat> list(PageBean<Public_cat> pageBean);
	
	/**
	 * 添加
	 * @param Public_cat
	 * @return 
	 * */
	public int update(Public_cat cat);
	
	/**
	 * 添加
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

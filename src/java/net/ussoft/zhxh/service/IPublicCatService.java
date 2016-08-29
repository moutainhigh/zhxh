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
	 * 根据用户ID,规格ID 查询
	 * */
	public Public_cat getPublicCat(String userid,String productsizeid);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_cat> list();
	
	/**
	 * 根据用户ID查询
	 * */
	public List<Public_cat> list(String userid);
	
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
	public Public_cat insert(Public_cat cat);
	
	/**
	 * 修改
	 * @param Public_cat
	 * @return 
	 * */
	public int update(Public_cat cat);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

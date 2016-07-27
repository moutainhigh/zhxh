package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_brand;

/**
 * 品牌管理
 * @author guodh
 * 
 * */
public interface IPublicBrandService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_brand
	 * */
	public Public_brand getById(String id);
	
	/**
	 * 查询所有
	 * 
	 * */
	public List<Public_brand> list();
	
	/**
	 * 查询所有 分页
	 * 
	 * */
	public List<Public_brand> list(PageBean<Public_brand> pageBean);
	
	/**
	 * 添加
	 * @param Public_brand
	 * @return
	 * */
	public int update(Public_brand brand);
	
	/**
	 * 添加
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

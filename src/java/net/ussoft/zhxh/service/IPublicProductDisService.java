package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_product_dis;

/**
 * 三级分销配置
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicProductDisService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_product_dis
	 * */
	public Public_product_dis getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_product_dis> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_product_dis> list(PageBean<Public_product_dis> pageBean);
	
	/**
	 * 添加
	 * @param Public_product_dis
	 * @return 
	 * */
	public Public_product_dis insert(Public_product_dis product_dis);
	
	/**
	 * 修改
	 * @param Public_product_dis
	 * @return 
	 * */
	public int update(Public_product_dis product_dis);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_product;

/**
 * 商品管理
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicProductService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_product
	 * */
	public Public_product getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_product> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_product> list(PageBean<Public_product> pageBean,String brandid);
	
	/**
	 * 添加
	 * @param Public_product
	 * @return 
	 * */
	public Public_product insert(Public_product product);
	
	/**
	 * 修改
	 * @param Public_product
	 * @return 
	 * */
	public int update(Public_product product);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

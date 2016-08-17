package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Product_list;

/**
 * 商品列表页
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IProductListService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Product_list
	 * */
	public Product_list getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Product_list> list(String parentid);
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public PageBean<Product_list> list(PageBean<Product_list> pageBean,String parentid);
	
	/**
	 * 添加
	 * @param Product_list
	 * @return 
	 * */
	public Product_list insert(Product_list obj);
	
	/**
	 * 修改
	 * @param Product_list
	 * @return 
	 * */
	public int update(Product_list obj);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

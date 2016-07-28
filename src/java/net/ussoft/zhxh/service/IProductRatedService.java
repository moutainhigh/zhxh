package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Product_rated;

/**
 * 商品评价
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IProductRatedService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Product_rated
	 * */
	public Product_rated getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Product_rated> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Product_rated> list(PageBean<Product_rated> pageBean);
	
	/**
	 * 添加
	 * @param Product_rated
	 * @return 
	 * */
	public Product_rated insert(Product_rated rated);
	
	/**
	 * 修改
	 * @param Product_rated
	 * @return 
	 * */
	public int update(Product_rated rated);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

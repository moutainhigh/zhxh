package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Product_list;
import net.ussoft.zhxh.model.Public_product_size;

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
	
	/**
	 * 根据商品列表的id，获取列表对应的商品。
	 * @param pageBean
	 * @param productListid
	 * @param isshow 0:隐藏，1:显示，-1查询所有
	 * @return
	 */
	public PageBean<Public_product_size> listLableProduct(PageBean<Public_product_size> pageBean,String productListid,int isshow);
	/**
	 * 根据商品列表的id，获取列表对应的商品。因为客户要列表里的商品排序。所以在列表对应表lable_list增加了sort。
	 * @param pageBean
	 * @param productListid
	 * @param isshow 0:隐藏，1:显示，-1查询所有
	 * @return
	 */
	public PageBean<Map<String,Object>> listLableProductForMap(PageBean<Map<String,Object>> pageBean,String productListid,int isshow);
}

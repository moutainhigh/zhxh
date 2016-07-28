package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.ProductListDao;
import net.ussoft.zhxh.model.Product_list;

@Repository("productListDao")
public class ProductListDaoImpl extends BaseDaoMysqlImpl<Product_list, String> implements ProductListDao {

	public ProductListDaoImpl() {
		super(Product_list.class);
	}
}

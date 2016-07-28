package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.ProductRatedDao;
import net.ussoft.zhxh.model.Product_rated;

@Repository("productRatedDao")
public class ProductRatedDaoImpl extends BaseDaoMysqlImpl<Product_rated, String> implements ProductRatedDao {

	public ProductRatedDaoImpl() {
		super(Product_rated.class);
	}
}

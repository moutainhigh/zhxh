package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.LabelListDao;
import net.ussoft.zhxh.dao.PublicContentDao;
import net.ussoft.zhxh.dao.PublicPicDao;
import net.ussoft.zhxh.dao.PublicProductSizeDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_pic;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.service.IPublicProductSizeService;
import net.ussoft.zhxh.util.FileOperate;
import net.ussoft.zhxh.util.MakeQuerySql;

@Service
public class PublicProductSizeService implements IPublicProductSizeService{

	@Resource
	PublicProductSizeDao productSizeDao;
	@Resource
	private PublicContentDao contentDao;  //富文本
	@Resource
	private PublicPicDao picDao;
	@Resource
	private LabelListDao labelListDao;
	
	
	
	@Override
	public Public_product_size getById(String id) {
		return productSizeDao.get(id);
	}
	
	@Override
	public List<Public_product_size> getByIds(List<String> ids) {
		return productSizeDao.getByIds(ids);
	}

	@Override
	public List<Public_product_size> list(String parentid) {
		String sql = "select * from public_product_size where productid = ? order by sizesort";
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		return productSizeDao.search(sql, values);
	}

	@Override
	public List<Public_product_size> list(Map<String, Object> map) {
		Map<String, Object> resultmap = MakeQuerySql.search(Public_product_size.class, map);
		String sql = resultmap.get("sql") + " order by sizesort asc";
		List<Object> values = (List<Object>) resultmap.get("values");
		
		return productSizeDao.search(sql, values);
	}
	
	@Override
	public PageBean<Public_product_size> list(PageBean<Public_product_size> pageBean,String parentid) {
		String sql = "select * from public_product_size where productid = ? ";
		List<Object> values = new ArrayList<Object>();
		
		values.add(parentid);
		pageBean = productSizeDao.search(sql, values, pageBean);
		
		return pageBean;
	}

	@Transactional("txManager")
	@Override
	public int update(Public_product_size product_size) {
		Public_product_size obj = productSizeDao.update(product_size);
		if(obj != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id,String realPath) {
		//首先删除规格对应的富文本
		String sql = "delete from public_content where parentid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(id);
		contentDao.del(sql, values);

		//删除规格对应的公共图片
		sql = "select * from public_pic where parentid=?";
		values.clear();
		values.add(id);
		
		List<Public_pic> pics = picDao.search(sql, values);
		
		for (Public_pic pic : pics) {
			FileOperate.delFile(realPath + pic.getPic_path());
			picDao.del(pic.getId());
		}
		
		//删除商品规格与商品列表页的关联。
		sql = "delete from label_list where listid=?";
		values.clear();
		values.add(id);
		labelListDao.del(sql, values);
		
		//删除商品规格本身
		return productSizeDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_product_size insert(Public_product_size product_size) {
		return productSizeDao.save(product_size);
	}

}

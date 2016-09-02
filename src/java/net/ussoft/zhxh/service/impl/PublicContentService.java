package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicContentDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_content;
import net.ussoft.zhxh.service.IPublicContentService;
import net.ussoft.zhxh.util.DateUtil;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicContentService implements IPublicContentService{

	@Resource
	PublicContentDao contentDao;	//富文本
	
	@Override
	public Public_content getById(String id) {
		return contentDao.get(id);
	}

	@Override
	public List<Public_content> list(Map<String, Object> map) {
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_content.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		sql += " order by sort asc";
		return contentDao.search(sql, values);
	}

	@Override
	public PageBean<Public_content> list(PageBean<Public_content> pageBean,String parentid,String parenttype,int isshow) {
		Public_content content = new Public_content();
		content.setParentid(parentid);
		content.setParenttype(parenttype);
		
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		values.add(parenttype);
		String sql = "SELECT id,parentid,parenttype,title,brief,source,createtime,pic_url,top,sort,isshow FROM public_content where parentid=? and parenttype=?";
		if(isshow == 0 || isshow == 1){
			sql += " AND isshow =?";
			values.add(isshow);
		}
		pageBean = contentDao.search(sql,values, pageBean);
		
		return pageBean;
	}

	@Transactional("txManager")
	@Override
	public int update(Public_content content) {
		Public_content obj = contentDao.update(content);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return contentDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_content insert(Public_content content) {
		content.setIsshow(0);	//初始隐藏
		String createtime = DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss");
		content.setCreatetime(createtime);
		return contentDao.save(content);
	}

}

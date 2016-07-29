package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.LabeltypeDao;
import net.ussoft.zhxh.model.Labeltype;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.service.ILabeltypeService;

@Service
public class LabeltypeService implements ILabeltypeService{
	
	@Resource
	LabeltypeDao typeDao;

	@Override
	public Labeltype getById(String id) {
		return typeDao.get(id);
	}

	@Override
	public List<Labeltype> list(String parentid) {
		Labeltype ltype = new Labeltype();
		ltype.setParentid(parentid);
		PageBean<Labeltype> p = new PageBean<Labeltype>();
		p.setIsPage(false);
		p.setOrderBy("sort");
		p.setOrderType("asc");
		
		p = typeDao.search(ltype, p);
		
		return p.getList();
	}

	@Override
	public List<Labeltype> list(PageBean<Labeltype> pageBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional("txManager")
	@Override
	public int update(Labeltype labeltype) {
		Labeltype tmp = typeDao.update(labeltype);
		if (null != tmp) {
			return 1;
		}
		return 0;
	}
	
	private void deleteLabelList(String labelid) {
		String sql = "";
		List<Object> values = new ArrayList<Object>();
		
		sql = "delete from label_list where labelid=?";
		values.clear();
		values.add(labelid);
		typeDao.del(sql, values);
		
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		
		//判断是一级还是二级标签
		Labeltype l = typeDao.get(id);
		
		String sql = "";
		List<Object> values = new ArrayList<Object>();
		
		if (l.getParentid().equals("0")) {
			sql = "select * from labeltype where parentid=?";
			values.add(l.getId());
			List<Labeltype> childList = typeDao.search(sql, values);
			if (childList.size() > 0) {
				for (Labeltype tmp : childList) {
					deleteLabelList(tmp.getId());
					typeDao.del(tmp.getId());
				}
			}
			typeDao.del(l.getId());
		}
		else {
			deleteLabelList(l.getId());
			typeDao.del(l.getId());
		}
		
		
		return 1;
	}

	@Transactional("txManager")
	@Override
	public Labeltype insert(Labeltype labeltype) {
		Labeltype tmp = typeDao.save(labeltype);
		return tmp;
	}

}

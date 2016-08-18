package net.ussoft.zhxh.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.LabelListDao;
import net.ussoft.zhxh.model.Label_list;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.service.ILabelListService;

@Service
public class LabelListService implements ILabelListService{
	
	@Resource
	LabelListDao listDao;

	@Override
	public Label_list getById(String id) {
		return listDao.get(id);
	}

	@Override
	public List<Label_list> list() {
		return listDao.getAll();
	}

	@Override
	public PageBean<Label_list> list(PageBean<Label_list> pageBean,String lableid) {
		String sql = "select * from labellist where labelid =?";
		List<Object> values = new ArrayList<Object>();
		values.add(lableid);
		return listDao.search(sql, values, pageBean);
	}

	@Transactional("txManager")
	@Override
	public int update(Label_list label_list) {
		Label_list obj = listDao.update(label_list);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return listDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Label_list insert(Label_list label_list) {
		return listDao.save(label_list);
	}

	@Transactional("txManager")
	@Override
	public boolean saveLableList(String objids, String labelid,String tablename) {
		String[] objs = objids.split(",");
		
		//获取标签对应的已存在数据，用来判断是否以存在。存在就不添加了。
		String sql = "select * from label_list where labelid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(labelid);
		List<Label_list> lists = listDao.search(sql, values);
		
		boolean isBe = false;
		
		for (String id : objs) {
			for (Label_list label_list : lists) {
				if (id.equals(label_list.getListid())) {
					isBe = true;
					break;
				}
			}
			if (!isBe) {
				Label_list l = new Label_list();
				l.setId(UUID.randomUUID().toString());
				l.setLabelid(labelid);
				l.setListid(id);
				l.setListtable(tablename);
				listDao.save(l);
			}
		}
		
		return true;
	}

	@Transactional("txManager")
	@Override
	public int deleteLableList(String objids, String labelid) {
		String[] idsArray = objids.split(",");
		
		List<String> idsList = Arrays.asList(idsArray);
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("delete from label_list where labelid=? and listid in (");
		
		values.add(labelid);
		
		Serializable[] ss=new Serializable[idsList.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(idsList);
		
		return listDao.del(sb.toString(), values);
	}

}

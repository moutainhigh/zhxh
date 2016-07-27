package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.Label_list;
import net.ussoft.zhxh.model.PageBean;

/**
 * 标签与列表的关联表
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface ILabelListService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Label_list
	 * */
	public Label_list getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Label_list> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Label_list> list(PageBean<Label_list> pageBean);
	
	/**
	 * 添加
	 * @param Label_list
	 * @return 
	 * */
	public int update(Label_list label_list);
	
	/**
	 * 添加
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

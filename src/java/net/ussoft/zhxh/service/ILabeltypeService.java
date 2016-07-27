package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.Labeltype;
import net.ussoft.zhxh.model.PageBean;

/**
 * 标签分类
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface ILabeltypeService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Labeltype
	 * */
	public Labeltype getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Labeltype> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Labeltype> list(PageBean<Labeltype> pageBean);
	
	/**
	 * 添加
	 * @param Labeltype
	 * @return 
	 * */
	public int update(Labeltype labeltype);
	
	/**
	 * 添加
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

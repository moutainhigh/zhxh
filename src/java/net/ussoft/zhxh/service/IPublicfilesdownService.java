package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.Filesdown;
import net.ussoft.zhxh.model.PageBean;

/**
 * 文件下载
 * @author guodh
 * @version v1.0 2016.08.15
 * */
public interface IPublicfilesdownService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Filesdown
	 * */
	public Filesdown getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Filesdown> list(String parentid,String parenttype);
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public PageBean<Filesdown> list(PageBean<Filesdown> pageBean,String parentid,String parenttype);
	
	/**
	 * 添加
	 * @param Filesdown
	 * @return 
	 * */
	public Filesdown insert(Filesdown filesdown);
	
	/**
	 * 修改
	 * @param Filesdown
	 * @return 
	 * */
	public int update(Filesdown filesdown);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_content;

/**
 * 富文本
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicContentService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_content
	 * */
	public Public_content getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_content> list(String parentid,String parenttype);
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public PageBean<Public_content> list(PageBean<Public_content> pageBean,String parentid,String parenttype);
	
	/**
	 * 添加
	 * @param Public_content
	 * @return 
	 * */
	public Public_content insert(Public_content content);
	
	/**
	 * 修改
	 * @param Public_content
	 * @return 
	 * */
	public int update(Public_content content);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

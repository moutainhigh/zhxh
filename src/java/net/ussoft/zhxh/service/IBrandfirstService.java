package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.Brandfirst;
import net.ussoft.zhxh.model.PageBean;

/**
 * 品牌综合展示
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IBrandfirstService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Brandfirst
	 * */
	public Brandfirst getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Brandfirst> list(String parentid);
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public PageBean<Brandfirst> list(PageBean<Brandfirst> pageBean,String parentid);
	
	/**
	 * 添加
	 * @param Brandfirst
	 * @return 
	 * */
	public Brandfirst insert(Brandfirst brandfirst);
	
	/**
	 * 修改
	 * @param Brandfirst
	 * @return 
	 * */
	public int update(Brandfirst brandfirst);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

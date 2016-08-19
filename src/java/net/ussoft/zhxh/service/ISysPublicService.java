package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Sys_public;

/**
 * 系统公共资源表服务层
 * @author wangf
 * @version v1.0 2016.08.18
 * */
public interface ISysPublicService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Sys_public
	 * */
	public Sys_public getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Sys_public> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Sys_public> list(PageBean<Sys_public> pageBean);
	
	/**
	 * 修改
	 * @param Sys_public
	 * @return 
	 * */
	public int update(Sys_public obj);
	
}

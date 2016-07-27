package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_pic;

/**
 * 公共图片管理
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicPicService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_pic
	 * */
	public Public_pic getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_pic> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_pic> list(PageBean<Public_pic> pageBean);
	
	/**
	 * 添加
	 * @param Public_pic
	 * @return 
	 * */
	public int update(Public_pic pic);
	
	/**
	 * 添加
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

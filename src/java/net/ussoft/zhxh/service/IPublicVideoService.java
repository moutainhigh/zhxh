package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_video;

/**
 * 公共视频服务类
 * @author wangf
 * @version v1.0 2016.08.08
 * */
public interface IPublicVideoService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_video
	 * */
	public Public_video getById(String id);
	
	/**
	 * 查询所有
	 * @param parentid
	 * @param parenttype
	 * @param isshow  -1:显示说有，0:隐藏，1:显示
	 * @return list
	 * */
	public List<Public_video> list(String parentid,String parenttype,int isshow);
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public PageBean<Public_video> list(PageBean<Public_video> pageBean,String parentid,String parenttype);
	
	/**
	 * 添加
	 * @param Public_video
	 * @return 
	 * */
	public Public_video insert(Public_video tmp);
	
	/**
	 * 修改
	 * @param Public_video
	 * @return 
	 * */
	public int update(Public_video tmp);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

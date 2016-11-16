package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_log;

/**
 * 日志管理
 * @author guodh
 * @version v1.0 2016.11.16
 * */
public interface IPublicLogService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_log
	 * */
	public Public_log getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_log> list();
	
	/**
	 * 获取
	 * @param map				查询
	 * @param pageBean
	 * @return
	 */
	public PageBean<Public_log> list(Map<String, Object> map,PageBean<Public_log> pageBean);
	
	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids);

	/**
	 * 添加
	 * */
	public Public_log insert(Public_log log);
}

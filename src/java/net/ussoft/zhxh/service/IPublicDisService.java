package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.Public_dis_config;

/**
 * 公共利益分类
 * @author wangf
 *
 */

public interface IPublicDisService {
	
	/**
	 * 获取对象
	 * @param id
	 * @return
	 */
	public Public_dis_config getById(String id);
	
	/**
	 * 获取全部
	 * @return
	 */
	public List<Public_dis_config> list();
	
	/**
	 * 插入对象
	 * @param tmp
	 * @return
	 */
	public Public_dis_config insert(Public_dis_config tmp);
	
	/**
	 * 更新对象
	 * @param tmp
	 * @return
	 */
	public int update(Public_dis_config tmp);
	/**
	 * 删除对象
	 * @param id
	 * @return
	 */
	public int delete(String id);
	
	
}

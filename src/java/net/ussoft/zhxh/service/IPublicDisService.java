package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

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
	
	//=========采购标准
	
	/**
	 * 采购标准获取
	 * @param parentid
	 * @param userid
	 * @return
	 */
	public List<Map<String,Object>> listDisStandard(String parentid,String userid);
	
	/**
	 * 更新对象
	 * @param tmp
	 * @return
	 */
	public int updateDisStandard(List<Map<String,Object>> disList);
	
	
}

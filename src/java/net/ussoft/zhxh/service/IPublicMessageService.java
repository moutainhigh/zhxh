package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_message;

/**
 * 消息管理
 * @author wangf
 * @version v1.0 2016.10.10
 * */
public interface IPublicMessageService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_message
	 * */
	public Public_message getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_message> list();
	
	/**
	 * 获取
	 * @param receiveid			接收者id
	 * @param map				查询
	 * @param pageBean
	 * @return
	 */
	public PageBean<Public_message> list(String receiveid,String messagetype,Map<String, Object> map,PageBean<Public_message> pageBean);
	
	/**
	 * 为首页获取未读的消息
	 * @param receiveid			接收者id
	 * @param messagetype		消息类型
	 * @return
	 */
	public List<Public_message> list(String receiveid,String messagetype);
	
	public void insert(Public_message message);
	
	/**
	 * 获取消息数量。供session
	 * @param receiveid
	 * @param messagetype
	 * @return
	 */
	public int getMessageNum(String receiveid,int messagetype);
	
	
	/**
	 * 批量修改
	 * @param ids
	 * @param field
	 * @param fieldValue
	 * @return
	 */
	public boolean updateBatch(String ids,String field,String fieldValue);
	
	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	public boolean delete(String ids);

}

package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_ask_result;

/**
 * 个人提问答复
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicAskResultService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_ask_result
	 * */
	public Public_ask_result getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_ask_result> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public List<Public_ask_result> list(PageBean<Public_ask_result> pageBean);
	
	/**
	 * 添加
	 * @param Public_ask_result
	 * @return 
	 * */
	public Public_ask_result insert(Public_ask_result askResult);
	
	/**
	 * 修改
	 * @param Public_ask_result
	 * @return 
	 * */
	public int update(Public_ask_result askResult);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

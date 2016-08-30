package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_phone_code_log;
import net.ussoft.zhxh.model.Public_pic;

/**
 * 短信日志表服务
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicPhoneCodeLogService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_phone_code_log
	 * */
	public Public_phone_code_log getById(String id);
	
	/**
	 * 查询所有
	 * @param parentid
	 * @param parenttype
	 * @return list
	 * */
	public List<Public_phone_code_log> list(String phonenumber,String sendtype);
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public PageBean<Public_pic> list(PageBean<Public_pic> pageBean,String parentid,String parenttype);
	
	/**
	 * 添加
	 * @param Public_pic
	 * @return 
	 * */
	public Public_pic insert(Public_pic pic);
	
	/**
	 * 修改
	 * @param Public_pic
	 * @return 
	 * */
	public int update(Public_pic pic);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

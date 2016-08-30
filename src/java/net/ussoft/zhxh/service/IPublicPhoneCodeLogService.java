package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_phone_code_log;

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
	 * @param phonenumber		手机号码。可以不传入。
	 * @param sendtype			发送类型。可以不传入
	 * @return list
	 * */
	public List<Public_phone_code_log> list(String phonenumber,String sendtype);
	
	/**
	 * 查询所有 分页
	 * @param pageBean			bean
	 * @param phonenumber		手机号码。可不传入
	 * @param sendtype			发送类型。可不传入
	 * @return list
	 * */
	public PageBean<Public_phone_code_log> list(PageBean<Public_phone_code_log> pageBean,String phonenumber,String sendtype);
	
	/**
	 * 添加
	 * @param Public_phone_code_log
	 * @return 
	 * */
	public Public_phone_code_log insert(Public_phone_code_log log);
	
	/**
	 * 修改
	 * @param Public_phone_code_log
	 * @return 
	 * */
	public int update(Public_phone_code_log log);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

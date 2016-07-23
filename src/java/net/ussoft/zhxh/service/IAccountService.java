package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.Sys_account;

/**
 * 系统后台帐户管理服务层
 * @author wangf
 *
 */

public interface IAccountService {
	
	/**
	 * 获取帐户
	 * @param id
	 * @return
	 */
	public Sys_account getById(String id);
	
	/**
	 * 获取全部信息
	 * @return
	 */
	public List<Sys_account> list();
	
	/**
	 * 插入新帐户
	 * @param account
	 * @return
	 */
	public Sys_account insert(Sys_account account);
	
	/**
	 * 更新帐户
	 * @param account
	 * @return
	 */
	public int update(Sys_account account);
	/**
	 * 删除帐户
	 * @param id
	 * @return
	 */
	public int delete(String id);
	
	/**
	 * 帐户登陆验证
	 * @param account
	 * @return
	 */
	public Sys_account login(Sys_account account);
	
	
}

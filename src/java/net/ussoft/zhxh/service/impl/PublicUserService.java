package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.PublicUserBankDao;
import net.ussoft.zhxh.dao.PublicUserDao;
import net.ussoft.zhxh.dao.PublicUserLinkDao;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Public_user_bank;
import net.ussoft.zhxh.model.Public_user_link;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.MD5;
import net.ussoft.zhxh.util.MakeQuerySql;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PublicUserService implements IPublicUserService{
	
	@Resource
	private PublicUserDao userDao;
	@Resource
	private PublicUserLinkDao linkDao;
	@Resource
	private PublicUserBankDao bankDao;

	@Override
	public Public_user getById(String id) {
		// TODO Auto-generated method stub
		return userDao.get(id);
	}

	@Override
	public List<Public_user> list() {
		// TODO Auto-generated method stub
		
		return userDao.getAll();
	}

	@Override
	public PageBean<Public_user> list(String key,PageBean<Public_user> pageBean) {
		
		String sql = "select * from public_user";
		List<Object> values = new ArrayList<Object>();
		
		if (null == key || "".equals(key)) {
			return userDao.search(sql, values, pageBean);
		}
		else {
			sql += " where phonenumber = ?";
			values.add(key);
			return userDao.search(sql, values, pageBean);
		}
	}

	@Override
	public PageBean<Public_user> list(String parentid,String identity,PageBean<Public_user> pageBean) {
		String sql = "SELECT u.* FROM public_user u,public_user_link k WHERE u.id = k.userid AND k.parentid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		if(!"".equals(identity) && null != identity){
			sql += " AND u.identity= ?";
			values.add(identity);
		}
		return userDao.search(sql, values, pageBean);
	}
	
	@Override
	public PageBean<Public_user> list(Map<String, Object> map,PageBean<Public_user> pageBean) {
		
		Map<String, Object> resultMap  = MakeQuerySql.search(Public_user.class, map);
		String sql = (String) resultMap.get("sql");
		List<Object> values = (List<Object>) resultMap.get("values");
		
		return userDao.search(sql, values, pageBean);
	}
	
	@Transactional("txManager")
	@Override
	public int update(Public_user user) {
		// TODO Auto-generated method stub
		Public_user obj = userDao.update(user);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int updateParent(String userid,String oldparentid,String newparentid) {
		/*
		 移动店时
		 1.删除目前的关联关系
		 2.冻结店和上级的账户
		 3.和新的上级创建关联关系和账户 
		 3.1、添加关系时判断是否存在，存在不做任何操作；（出现的情况-代理A和代理B同时应有店X，操作把代理A下的店X移动到代理B下）
		 3.2、账户创建时要验证下是否已创建过，如创建过则不用再创建设置为冻结状态
		 */
		//删除关系
		String del_linkSql = "DELETE FROM public_user_link WHERE parentid=? AND userid=?";
		List<Object> del_values = new ArrayList<Object>();
		del_values.add(oldparentid);
		del_values.add(userid);
		int num = linkDao.del(del_linkSql, del_values);
		
		//冻结账户
		Public_user_bank userBank = getUserBank(userid, oldparentid);
		userBank.setBankstate(0);	//冻结账户
		userBank.setBankstatetxt("冻结");
		userBank = bankDao.update(userBank);
		
		//创建新的关系和账户
		Public_user_link userlink = getUserLink(userid, newparentid);
		if(userlink == null){
			//创建新的关系
			 userlink = addlink(userid, newparentid);
			//创建账户
			Public_user_bank userbank = createbank(userid, newparentid);
			if(num > 0 && userBank != null && userlink != null && userbank != null){
				return 1;
			}
		}
		
		return 0;
	}
	
	@Transactional("txManager")
	@Override
	public int createlink(String userid,String parentid) {
		/*
		  1.关系存在不予操作
		  2.关系不存在，账户不存在--同时创建关系和账户
		  3.关系不存在，账户存在--创建关系，账户设置给冻结状态（由平台去处理）
		 */
		Public_user_link userlink = getUserLink(userid, parentid);
		if(userlink == null){
			//创建个人中心关联关系 （代理、店）
			userlink = addlink(userid, parentid);
			//创建账户
			Public_user_bank userbank = createbank(userid, parentid);
			if(userlink != null && userbank != null){
				return 1;	//创建成功
			}else{
				return 0;	//创建失败
			}
		}
		
		return -1; //已存在关联关系
	}
	
	@Transactional("txManager")
	@Override
	public int delete(String id) {
		String[] ids = id.split(",");
		for(int i=0;i<ids.length;i++){
			userDao.del(ids[i]);
		}
		return 1;
	}

	@Transactional("txManager")
	@Override
	public Public_user insert(Public_user user) {
		userDao.save(user);
		return user;
	}
	
	@Transactional("txManager")
	@Override
	public int insert(Public_user user,String parentid) {
		//创建会员信息
		user = userDao.save(user);
		
		//创建个人中心关联关系 （代理、店）
		Public_user_link userLink = new Public_user_link();
		userLink.setId(UUID.randomUUID().toString());
		userLink.setUserid(user.getId());
		userLink.setParentid(parentid);
		userLink = linkDao.save(userLink);
		
		//创建个人账户-（代理、店）
		Public_user_bank userBank = createbank(user.getId(), parentid);
		if(user != null && userLink != null && userBank != null){
			return 1;
		}
		return 0;
	}

	@Override
	public boolean checkPhoneNum(String phoneNum) {
		List<Object> values = new ArrayList<Object>();
		values.add(phoneNum);
		String sql = "select id from public_user where phonenumber=?";
		List<Public_user> list = userDao.search(sql, values);
		if(list.size() > 0)
			return true;
		return false;
	}

	@Override
	public Public_user getByPhoneNum(String phoneNum) {
		List<Object> values = new ArrayList<Object>();
		values.add(phoneNum);
		String sql = "select * from public_user where phonenumber=?";
		List<Public_user> list = userDao.search(sql, values);
		if(list.size() > 0){
			return list.get(0);
		}
		
		return null;
	}

	@Override
	public Public_user login(String username,String password) {
		Public_user user = getByPhoneNum(username);
		if (user == null ) {
			return null;
		}
		// 将输入的密码与Pojo里的密码MD5后对比，如果不匹配，说明密码不对
		if (!MD5.encode(password).equals(user.getPassword())) {
			return null;
		}
		return user;
	}
	
	/**
	 * 查找店、代理是否已存在关联关系（防止重复插入）
	 * @param userid
	 * @param parentid
	 * @return
	 * */
	private Public_user_link getUserLink(String userid,String parentid){
		String sql = "SELECT * FROM public_user_link WHERE parentid = ? AND userid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		values.add(userid);
		List<Public_user_link> list = linkDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}
	
	/**
	 * 查找账户（店在代理下是否已存在账户）
	 * @param userid
	 * @param parentid
	 * */
	private Public_user_bank getUserBank(String userid,String parentid){
		String sql = "SELECT * FROM public_user_bank WHERE parentid = ? AND userid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		values.add(userid);
		List<Public_user_bank> list = bankDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}
	
	/**
	 * 创建关联关系
	 * @param userid
	 * @param parentid
	 * @return
	 * */
	private Public_user_link addlink(String userid,String parentid){
		//创建新的关系
		Public_user_link userlink = new Public_user_link();
		userlink.setId(UUID.randomUUID().toString());
		userlink.setParentid(parentid);
		userlink.setUserid(userid);
		return linkDao.save(userlink);
	}
	
	/**
	 * 创建金额账户
	 * @param userid
	 * @param parentid
	 * @return
	 * */
	private Public_user_bank createbank(String userid,String parentid){
		Public_user_bank userbank = getUserBank(userid, parentid);
		//不存在就创建
		if(userbank == null){
			//创建账户-（代理、店）
			userbank = new Public_user_bank();
			userbank.setId(UUID.randomUUID().toString());
			userbank.setUserid(userid);
			userbank.setParentid(parentid);
			userbank.setBankstate(1); //账户启用
			userbank.setBankstatetxt("正常");
			userbank = bankDao.save(userbank);
		}
		return userbank;
	}
}

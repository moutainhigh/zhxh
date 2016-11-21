package net.ussoft.zhxh.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUserService#list(java.lang.String, java.lang.String, java.util.Map, net.ussoft.zhxh.model.PageBean)
	 */
	@Override
	public PageBean<Public_user> list(String parentid, String identity, Map<String, Object> map,int showtype,
			PageBean<Public_user> pageBean) {
		StringBuffer sb = new StringBuffer();
		
		if (identity.equals("Z")) {
			sb.append("select DISTINCT(u.id),u.* from public_user u where 1=1");
		}
		else if (identity.equals("C")) {
			if (null != parentid && !"".equals(parentid)) {
				sb.append("select DISTINCT(u.id),u.*,l.parentid as parentid,l.tuijianid as tuijianid,l.tuijianman as tuijianman from public_user u,public_user_link l where 1=1");
			}
			else {
				sb.append("select DISTINCT(u.id),u.*,l.tuijianid as tuijianid,l.tuijianman as tuijianman from public_user u,public_user_link l where 1=1 and l.userid =u.id ");
			}
		}
		else {
			sb.append("select DISTINCT(u.id),u.* from public_user u,public_user_link l where 1=1");
		}
		
		List<Object> values = new ArrayList<Object>();
		
		boolean isPage = true;
		
		if (showtype == 1) {
			if (null != parentid && !"".equals(parentid) && !identity.equals("Z")) {
				sb.append(" and l.parentid = ? and l.userid =u.id ");
				values.add(parentid);
			}
		}
		else if (showtype == 0) {
			isPage = false;
			if (null != parentid && !"".equals(parentid) && !identity.equals("Z")) {
				sb.append(" and l.parentid = ? and l.userid <> u.id ");
				values.add(parentid);
			}
			else if (identity.equals("C")){
				sb.append(" and u.id not in (select userid from public_user_link) ");
			}
		}
		
		
		if(null != identity && !"".equals(identity)) {
			if (identity.equals("Z")) {
				//获取普通会员
				if (showtype == 0) {
					sb.append(" and (u.belongcode='' or belongcode is null)");
				}
				else if (showtype == 1) {
					Public_user parentUser = userDao.get(parentid);
					sb.append(" and u.belongcode=? ");
					values.add(parentUser.getCompanycode());
				}
			}
			
			//为了普通会员的移动。这里传入的identity可以是 A,C 。用来获取所有代理和门店
			String[] identityArr = identity.split(",");
			if (identityArr.length > 1) {
				sb.append(" and (");
				for (String str : identityArr) {
					sb.append(" u.identity = ? or");
					values.add(str);
				}
				
				sb.delete(sb.length()-3, sb.length());
		        sb.append(")");
			}
			else {
				sb.append(" and u.identity = ?");
				values.add(identity);
			}
			
		}
		
		if (null != map && map.size() > 0) {
			Set<Entry<String, Object>> set=map.entrySet();
	        Iterator iterator=set.iterator();
	        sb.append(" and (");
	        for (int i = 0; i < set.size(); i++) {
	            Map.Entry mapEntry=(Entry) iterator.next();
	            if (null != mapEntry.getValue() && !"".equals(mapEntry.getValue().toString())) {
	            	sb.append(" u."+mapEntry.getKey()+" like '%"+mapEntry.getValue()+"%' or");
	            }
	        }
	        sb.delete(sb.length()-3, sb.length());
	        sb.append(")");
		}
		
		//添加状态为-1。状态值说明：0：禁用（禁止登录），1：正常  -1：删除的。所有机构不真实删除，仅做删除标记。
		sb.append(" and isopen <> -1 order by sort");
		
		if (isPage) {
			pageBean = userDao.search(sb.toString(), values, pageBean);
		}
		else {
			List<Public_user> userList = userDao.search(sb.toString(), values);
			pageBean.setList(userList);
			pageBean.setRowCount(userList.size());
		}
		
		return pageBean;
	}
	
	@Override
	public PageBean<Public_user> tuijianList(String parentid, PageBean<Public_user> pageBean) {
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		
		//1获取关联的帐户。如果没有，直接返回
		sb.append("select * from public_user_link where tuijianid = ?");
		values.add(parentid);
		List<Public_user_link> userLinkList = linkDao.search(sb.toString(), values);
		
		if (null == userLinkList || userLinkList.size() == 0) {
			return pageBean;
		}
		
		List<String> userid = new ArrayList<String>();
		for (Public_user_link userLink : userLinkList) {
			userid.add(userLink.getUserid());
		}
				
		//2.如果有检索。
		List<Public_user> tmpUserList = new ArrayList<Public_user>();
		sb.setLength(0);
		values.clear();
		sb.append("select * from public_user where 1=1");
		sb.append(" and isopen <> -1 and id in (");
        Serializable[] ss=new Serializable[userid.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(userid);
		
        pageBean = userDao.search(sb.toString(), values,pageBean);
        
        if (pageBean.getList().size() > 0) {
        	Public_user pUser = userDao.get(parentid);
        	List<Public_user> tmpList = pageBean.getList();
        	for (Public_user user : tmpList) {
				user.setTuijianid(parentid);
				user.setTuijianman(pUser.getCompanyname());
			}
        	pageBean.setList(tmpList);
        }
        
        return pageBean;
	}
	
	@Override
	public PageBean<Public_user> getParentlist(String userid, Map<String, Object> map, PageBean<Public_user> pageBean) {
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		
		sb.append("select * from public_user_link where userid=?");
		values.add(userid);
		List<Public_user_link> uList = linkDao.search(sb.toString(), values);
		
		if (null == uList || uList.size() == 0) {
			return pageBean;
		}
		
		sb.setLength(0);
		sb.append("select * from public_user where id in (");
		values.clear();
		List<String> idsList = new ArrayList<String>();
		for (Public_user_link link : uList) {
			idsList.add(link.getParentid());
		}
		
		Serializable[] ss=new Serializable[idsList.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(idsList);
		
		if (null != map && map.size() > 0) {
			Set<Entry<String, Object>> set=map.entrySet();
	        Iterator iterator=set.iterator();
	        sb.append(" and (");
	        for (int i = 0; i < set.size(); i++) {
	            Map.Entry mapEntry=(Entry) iterator.next();
	            if (null != mapEntry.getValue() && !"".equals(mapEntry.getValue().toString())) {
	            	sb.append(mapEntry.getKey()+" like '%"+mapEntry.getValue()+"%' or ");
	            }
	        }
	        sb.delete(sb.length()-3, sb.length());
	        sb.append(")");
		}
		
		//添加状态为-1。状态值说明：0：禁用（禁止登录），1：正常  -1：删除的。所有机构不真实删除，仅做删除标记。
		sb.append(" and isopen <> -1 order by sort");

		
		pageBean = userDao.search(sb.toString(), values, pageBean);
		
		return pageBean;
	}
	
	
	
	@Transactional("txManager")
	@Override
	public int insert(Public_user user) {
		//创建会员信息
		user = userDao.save(user);
		
		if (null != user.getParentid() && !"".equals(user.getParentid())) {
			//创建个人中心关联关系 （代理、店）
			Public_user_link userLink = new Public_user_link();
			userLink.setId(UUID.randomUUID().toString());
			userLink.setUserid(user.getId());
			userLink.setParentid(user.getParentid());
			userLink.setTuijianid("");
			userLink.setTuijianman("");
			
			if (null != user.getTuijianid() && !"".equals(user.getTuijianid())) {
				userLink.setTuijianid(user.getTuijianid());
				userLink.setTuijianman(user.getTuijianman());
			}
			
			userLink = linkDao.save(userLink);
			
			//创建个人账户-（代理、店）
//			Public_user_bank userBank = createbank(user.getId(), user.getParentid());
//			if(user != null && userLink != null && userBank != null){
//				return 1;
//			}
		}
		//TODO 确认普通会员是否有金额帐户
		//创建个人账户-（代理、店）
		if (user.getIdentity().equals("Z")) {
			createbank(user.getId(), "1");
		}
		else {
			createbank(user.getId(), user.getParentid());
		}
		
		return 1;
	}
	
	@Override
	public boolean checkPhoneNum(String phoneNum) {
		List<Object> values = new ArrayList<Object>();
		values.add(phoneNum);
		String sql = "select id from public_user where phonenumber=? and isopen <> -1";
		List<Public_user> list = userDao.search(sql, values);
		if(list.size() > 0)
			return true;
		return false;
	}
	
	@Transactional("txManager")
	@Override
	public int update(Public_user user) {
		if (null != user.getIdentity() && !user.getIdentity().equals("Z")) {
			//获取旧数据，判断手机号码是否更改，如果更改了就要批量更改普通会员的所属店代码
			Public_user tmp = userDao.get(user.getId());
			if (!user.getPhonenumber().equals(tmp.getPhonenumber())) {
				String sql = "update public_user set belongcode=? where belongcode=? and isopen <> -1";
				List<Object> values = new ArrayList<Object>();
				values.add(user.getPhonenumber());
				values.add(tmp.getPhonenumber());
				userDao.update(sql, values);
			}
		}
		
		Public_user obj = userDao.update(user);
		
		//判断是否更改了推荐人
		if (null != user.getParentid() && !"".equals(user.getParentid())) {
			Public_user_link userLink = new Public_user_link();
			userLink.setUserid(user.getId());
			userLink.setParentid(user.getParentid());
			userLink = linkDao.searchOne(userLink);
			
			if (null == userLink.getTuijianid() || "".equals(userLink.getTuijianid()) || !userLink.getTuijianid().equals(user.getTuijianid())) {
				userLink.setTuijianid(user.getTuijianid());
				userLink.setTuijianman(user.getTuijianman());
				linkDao.update(userLink);
			}
		}
		if(obj != null) {
			return 1;
		}
			
		return 0;
	}
	
	@Override
	public Public_user getByPhoneNum(String phoneNum) {
		List<Object> values = new ArrayList<Object>();
		values.add(phoneNum);
		String sql = "select * from public_user where phonenumber=? and isopen <> -1";
		List<Public_user> list = userDao.search(sql, values);
		if(list.size() > 0){
			return list.get(0);
		}
		
		return null;
	}
	
	@Transactional("txManager")
	@Override
	public int delete(String id) {
		String[] ids = id.split(",");
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		for(int i=0;i<ids.length;i++){
			//不真实删除，做isopen为-1 表示删除
			Public_user user = userDao.get(ids[i]);
			user.setIsopen(-1);
			userDao.update(user);
			
			//判断机构类型。
			//如果是代理，将下级所有店及普通会员设置取消关联。
			if (!user.getIdentity().equals("Z")) {
				if (user.getIdentity().equals("A")) {
					sb.setLength(0);
					values.clear();
					sb.append("delete from public_user_link where parentid=?");
					values.add(user.getId());
					linkDao.del(sb.toString(), values);
				}
				
				//取消删除机构与普通会员的关联。
				sb.setLength(0);
				values.clear();
				sb.append("update public_user set belongcode='' where belongcode=?");
				values.add(user.getCompanycode());
				userDao.update(sb.toString(), values);
			}
		}
		return 1;
	}
	
	@Override
	public String checkDel(String ids) {
		String[] idArr = ids.split(",");
		String sql = "";
		String companycode = "";
		List<Object> values = new ArrayList<Object>();
		for (String id : idArr) {
			Public_user user = userDao.get(id);
			companycode = user.getCompanycode();
			sql = "select count(id) from public_user where belongcode = ?";
			values.clear();
			values.add(companycode);
			
			int num = userDao.getInt(sql, values);
			System.out.println(num+"=================");
			
			
			
			if (num > 0) {
				return companycode;
			}
		}
		return "";
	}

	
	@Transactional("txManager")
	@Override
	public void initUpdatePass(String id) {
		String[] ids = id.split(",");
		for(int i=0;i<ids.length;i++){
			//不真实删除，做isopen为-1 表示删除
			Public_user user = userDao.get(ids[i]);
			user.setPassword(MD5.encode("123456"));
			userDao.update(user);
//			userDao.del(ids[i]);
		}
		
	}
	
	@Transactional("txManager")
	@Override
	public int createlink(String parentid,String userids) {
		/*
		  1.关系存在不予操作
		  2.关系不存在，账户不存在--同时创建关系和账户
		  3.关系不存在，账户存在--创建关系，账户设置给冻结状态（由平台去处理）
		 */
		String[] ids = userids.split(",");
		for (String id : ids) {
			Public_user_link userlink = getUserLink(id, parentid);
			if(userlink == null){
				//创建个人中心关联关系 （代理、店）
				userlink = addlink(id, parentid);
				//创建账户
				Public_user_bank userbank = createbank(id, parentid);
			}
		}
		return 1; //已存在关联关系
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
//			userbank.setBankstate(1); //账户启用
//			userbank.setBankstatetxt("正常");
			userbank = bankDao.save(userbank);
		}
		return userbank;
	}
	
	/*
	 * 
	 */
	@Transactional("txManager")
	@Override
	public void outLink(String parentid, String userids) {
		String[] idsArr = userids.split(",");
		
		List<String> idsList = Arrays.asList(idsArr);
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		
		//判断是什么类型的接触
		Public_user tmp = userDao.get(idsArr[0]);
		if (tmp.getIdentity().equals("C")) {
			sb.append("delete from public_user_link where parentid=? and userid in (");
			values.add(parentid);
			
			Serializable[] ss=new Serializable[idsList.size()];
			Arrays.fill(ss, "?");
			sb.append(StringUtils.join(ss,','));
			sb.append(")");
			values.addAll(idsList);
			
			linkDao.del(sb.toString(), values);
		}
		else if (tmp.getIdentity().equals("Z")) {
			sb.append("update public_user set belongcode = '' where id in (");
			values.clear();
			Serializable[] ss=new Serializable[idsList.size()];
			Arrays.fill(ss, "?");
			sb.append(StringUtils.join(ss,','));
			sb.append(")");
			values.addAll(idsList);
			
			userDao.update(sb.toString(), values);
		}
	}
	
	@Transactional("txManager")
	@Override
	public int userMove(String userids,String oldParentid,String newParentid) {
		/*
		 移动店时
		 1.删除目前的关联关系
		 2.冻结店和上级的账户
		 3.和新的上级创建关联关系和账户 
		 3.1、添加关系时判断是否存在，存在不做任何操作；（出现的情况-代理A和代理B同时应有店X，操作把代理A下的店X移动到代理B下）
		 3.2、账户创建时要验证下是否已创建过，如创建过则不用再创建设置为冻结状态
		 */
		String[] ids = userids.split(",");
		String identity = "";
		String sql = "";
		List<Object> values = new ArrayList<Object>();
		for (String userid : ids) {
			if (identity.equals("")) {
				Public_user tmp = userDao.get(userid);
				identity = tmp.getIdentity();
			}
			if (identity.equals("C")) {
				if (null != oldParentid && !"".equals(oldParentid)) {
					//删除关系
					sql = "DELETE FROM public_user_link WHERE parentid=? AND userid=?";
					values.clear();
					values.add(oldParentid);
					values.add(userid);
					int num = linkDao.del(sql, values);
					
					//冻结账户
					Public_user_bank userBank = getUserBank(userid, oldParentid);
					userBank.setBankstate(0);	//冻结账户
					userBank.setBankstatetxt("冻结");
					userBank = bankDao.update(userBank);
				}
				
				//创建新的关系和账户
				Public_user_link userlink = getUserLink(userid, newParentid);
				if(userlink == null){
					//创建新的关系
					 userlink = addlink(userid, newParentid);
					//创建账户
					createbank(userid, newParentid);
				}
			}
			else if (identity.equals("Z")) {
				//如果移动的是普通会员.将belongcode设置为新的就可以
				Public_user newParent = userDao.get(newParentid);
				String newCode = newParent.getCompanycode();
				
				sql = "update public_user set belongcode = ? where id =?";
				values.clear();
				values.add(newCode);
				values.add(userid);
				userDao.update(sql, values);
			}
		}
		
		
		return 1;
	}
	
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUserService#updateBatch(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public boolean updateBatch(String parentid,String updateUserids, String field, String fieldValue) {
		if (null == updateUserids || "".equals(updateUserids)) {
			return false;
		}
		
		String[] idsArr = updateUserids.split(",");
		
		List<String> idsList = Arrays.asList(idsArr);
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		
		//如果是批量清空推荐人
		if (field.equals("tuijianman")) {
			sb.append("update public_user_link set ");
			sb.append("tuijianid='',");
			sb.append("tuijianman=''");
			sb.append(" where parentid=? and userid in (");
			
			values.add(parentid);
		}
		else {
			sb.append("update public_user set ");
			sb.append(field).append("=?");
			values.add(fieldValue);
			sb.append(" where id in (");
		}
		
		Serializable[] ss=new Serializable[idsList.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(idsList);
		
		int num = userDao.update(sb.toString(), values);
		
		if (num > 0) {
			return true;
		}
		
		return false;
	}
	
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUserService#listParent(java.lang.String)
	 */
	@Override
	public List<Public_user> listParent(String userid) {
		if (null != userid && !"".equals(userid)) {
			String sql = "select u.* from public_user u,public_user_link k where k.userid=? and k.parentid = u.id order by u.sort";
			List<Object> values = new ArrayList<Object>();
			values.add(userid);
			
			return userDao.search(sql, values);
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
	
	
	
	//========以下不确定要

	@Override
	public PageBean<Public_user> list_shop(boolean flag,PageBean<Public_user> pageBean) {
		
		String sql = "SELECT DISTINCT(u.id),u.* FROM public_user u,public_user_link k WHERE u.id = k.userid AND u.identity = 'C' ";
		List<Object> values = new ArrayList<Object>();
		if(flag){
			sql += " AND k.parentid = ?";	//直营店
		}else{
			sql += " AND k.parentid != ?";	//非直营店
		}
		values.add("1"); //1代表直营店
		return userDao.search(sql, values, pageBean);
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

}

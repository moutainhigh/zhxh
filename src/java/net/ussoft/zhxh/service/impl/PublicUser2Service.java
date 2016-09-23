package net.ussoft.zhxh.service.impl;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicBrandDao;
import net.ussoft.zhxh.dao.PublicProductSizeDao;
import net.ussoft.zhxh.dao.PublicSetBonusesRatioDao;
import net.ussoft.zhxh.dao.PublicSetUserStandardDao;
import net.ussoft.zhxh.dao.PublicUserBankDao;
import net.ussoft.zhxh.dao.PublicUserBrandDao;
import net.ussoft.zhxh.dao.PublicUserDao;
import net.ussoft.zhxh.dao.PublicUserLinkDao;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_set_bonuses_ratio;
import net.ussoft.zhxh.model.Public_set_user_standard;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Public_user_brand;
import net.ussoft.zhxh.model.Public_user_link;
import net.ussoft.zhxh.service.IPublicUser2Service;

@Service
public class PublicUser2Service implements IPublicUser2Service{
	
	@Resource
	private PublicUserDao userDao;
	@Resource
	private PublicUserLinkDao linkDao;
	@Resource
	private PublicUserBrandDao userBrandDao;
	@Resource
	private PublicSetUserStandardDao userStandardDao;
	@Resource
	private PublicSetBonusesRatioDao ratioDao;
	@Resource
	private PublicProductSizeDao sizeDao;
	@Resource
	private PublicBrandDao brandDao;
	@Resource
	private PublicUserBankDao bankDao;

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#getById(java.lang.String)
	 */
	@Override
	public Public_user getById(String id) {
		return userDao.get(id);
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#list(java.lang.String)
	 */
	@Override
	public List<Public_user> list(String parentid,String identity) {
		//1、获取父id下的子id集合
		Public_user_link link = new Public_user_link();
		link.setParentid(parentid);
		
		List<Public_user_link> linkList = linkDao.search(link);
		
		//如果是空的。直接返回空
		if (null == linkList || linkList.size() == 0) {
			List<Public_user> tmpList = new ArrayList<Public_user>();
			return tmpList;
		}
		
		List<String> idsList = new ArrayList<String>();
		
		for (Public_user_link tmp : linkList) {
			idsList.add(tmp.getUserid());
		}
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("select * from public_user where identity=? and id in (");
		
		values.add(identity);
		
		Serializable[] ss=new Serializable[idsList.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(idsList);
		
		sb.append(" order by sort");
		
		return userDao.search(sb.toString(), values);
	}
	
	@Override
	public boolean insert(Public_user user) {
		
		return false;
	}

	@Override
	public int update(Public_user user) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	//=============机构与品牌begin

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#list_user_brand(java.lang.String, java.lang.String)
	 */
	@Override
	public List<Public_brand> list_user_brand(String parentid, String userid) {
		//1、获取父id下的子id集合
		Public_user_brand userBrand = new Public_user_brand();
		userBrand.setParentid(parentid);
		userBrand.setUserid(userid);
		
		List<Public_user_brand> userBrandList = userBrandDao.search(userBrand);
		
		//如果是空的。直接返回空
		if (null == userBrandList || userBrandList.size() == 0) {
			List<Public_brand> tmpList = new ArrayList<Public_brand>();
			return tmpList;
		}
		
		List<String> idsList = new ArrayList<String>();
		
		for (Public_user_brand tmp : userBrandList) {
			idsList.add(tmp.getBrandid());
		}
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("select * from public_brand where id in (");
		
		Serializable[] ss=new Serializable[idsList.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(idsList);
		
		return brandDao.search(sb.toString(), values);
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#list_select_brand(java.lang.String, java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public List<Public_brand> list_select_brand(String parentid, String userid) {
		//TODO ***** 删除品牌、删除商品、删除规格，要清理与机构的关联及采购利益标准
		
		
		//获取全部品牌
		List<Public_brand> brandList = brandDao.getAll("sort");
		if (brandList.size() == 0) {
			return brandList;
		}
		
		String sql = "";
		List<Object> values = new ArrayList<Object>();
		
		//如果parentid为1（平台）。重新将平台的所有品牌赋予1.
		if (parentid.equals("1")) {
			sql = "delete from public_user_brand where userid = ?";
			values.add("1");
			userBrandDao.del(sql, values);
			
			//将所有品牌与平台1对应。赋予平台所有品牌的操作
			Public_user_brand tmp = new Public_user_brand();
			tmp.setParentid("1");
			tmp.setUserid("1");
			for (Public_brand brand : brandList) {
				tmp.setId(UUID.randomUUID().toString());
				tmp.setBrandid(brand.getId());
				userBrandDao.save(tmp);
			}
		}
		
		//获取parentid的机构作为userid能操作几个品牌
//		sql = "select * from public_user_brand where userid = ?";
		sql = "select b.* from public_brand b,public_user_brand u where u.userid = ? and b.id = u.brandid order by b.sort";
		values.clear();
		values.add(parentid);
//		List<Public_user_brand> parentBrandList = userBrandDao.search(sql, values);
		List<Public_brand> parentBrandList = brandDao.search(sql, values);
		
		//1、获取父id下的子id集合
		Public_user_brand userBrand = new Public_user_brand();
		userBrand.setParentid(parentid);
		userBrand.setUserid(userid);
		
		List<Public_user_brand> userBrandList = userBrandDao.search(userBrand);
		
		//如果是空的。直接返回空
		if (null != userBrandList && userBrandList.size() > 0) {
			Iterator<Public_brand> iter = parentBrandList.iterator();
	        while(iter.hasNext()){
	            Public_brand b = iter.next();
	            for (Public_user_brand user_brand : userBrandList) {
					if (b.getId().equals(user_brand.getBrandid())) {
						iter.remove();
						break;
					}
				}
	        }
		}
				
		return parentBrandList;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#saveUserBrand(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public boolean saveUserBrand(String brandids, String parentid, String userid) {
		String[] idArr = brandids.split(",");
		
		if (idArr.length == 0) {
			return true;
		}
		
		Public_user_brand tmp = new Public_user_brand();
		tmp.setParentid(parentid);
		tmp.setUserid(userid);
		for (String string : idArr) {
			tmp.setId(UUID.randomUUID().toString());
			tmp.setBrandid(string);
			userBrandDao.save(tmp);
		}
		
		return true;
	}
	
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#delUserBrand(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public void delUserBrand(String parentid, String userid, String brandid) {
		String sql = "select * from public_user_brand where parentid=? and userid=? and brandid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		values.add(userid);
		values.add(brandid);
		List<Public_user_brand> userBrandList = userBrandDao.search(sql, values);
		
		if (null != userBrandList && userBrandList.size() == 1) {
			//删除关联的所有采购利益设置
			//TODO 这里不删除已设置的采购规则。如果再次添加品牌进来，规则还在。需要注意在获取采购商品时，要先判断该机构能采购什么品牌。再去获取采购商品
//			sql = "delete from public_set_user_standard where parentid = ? and userid=? and brandid=?";
//			userStandardDao.del(sql, values);
			
			//删除本尊
			userBrandDao.del(userBrandList.get(0).getId());
		}
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#list_select_size(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public List<Public_product_size> list_select_size(String parentid, String userid, String productid) {
		
		String sql = "";
		List<Object> values = new ArrayList<Object>();
		
		//获取商品下全部规格
		sql = "select * from public_product_size where productid=? order by sizesort";
		values.add(productid);
		
		
		List<Public_product_size> allSizeList = sizeDao.search(sql, values);
		if (allSizeList.size() == 0) {
			return allSizeList;
		}
		
		//获取parentid,userid   已经赋予了哪些，去除后返回，供前台选择
		sql = "select * from public_set_user_standard where parentid=? and userid=? and productid=?";
		values.clear();
		values.add(parentid);
		values.add(userid);
		values.add(productid);
		List<Public_set_user_standard> userStandardList = userStandardDao.search(sql, values);
		
		//如果是空的。直接返回空
		if (null != userStandardList && userStandardList.size() > 0) {
			Iterator<Public_product_size> iter = allSizeList.iterator();
	        while(iter.hasNext()){
	        	Public_product_size b = iter.next();
	            for (Public_set_user_standard userStandard : userStandardList) {
					if (b.getId().equals(userStandard.getSizeid())) {
						iter.remove();
						break;
					}
				}
	        }
		}
				
		return allSizeList;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#saveUserSizeStandard(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public boolean saveUserSizeStandard(String brandid, String productid, String sizeids, String parentid,
			String userid) {
		String[] idArr = sizeids.split(",");
		
		if (idArr.length == 0) {
			return true;
		}
		
		Public_set_user_standard tmp = new Public_set_user_standard();
		tmp.setParentid(parentid);
		tmp.setUserid(userid);
		tmp.setBrandid(brandid);
		tmp.setProductid(productid);
		for (String string : idArr) {
			tmp.setId(UUID.randomUUID().toString());
			tmp.setSizeid(string);
			userStandardDao.save(tmp);
		}
		
		return true;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#listUserStandard(java.lang.String, java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public List<Map<String, Object>> listUserStandard(String parentid, String userid,String productid,String brandid,String state) {
		
		StringBuffer sb = new StringBuffer();
		sb.append("select up.companyname as parentname,u.username as username,u.companyname,s.id as sizeid,s.productpic,s.productname,s.productsize,s.price,s.sizesort,b.brandname,d.* from public_set_user_standard d");
		sb.append(" left join public_product_size s ON d.sizeid = s.id");
		sb.append(" left join public_user up ON up.id = d.parentid");
		sb.append(" left join public_user u ON u.id = d.userid");
		sb.append(" left join public_brand b On d.brandid = b.id");
		sb.append(" where d.parentid=? and d.userid=?");
		
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		values.add(userid);
		
		if (null != productid && !"".equals(productid)) {
			sb.append(" and d.productid=?");
			values.add(productid);
		}
		
		if (null != brandid && !"".equals(brandid)) {
			sb.append(" and d.brandid=?");
			values.add(brandid);
		}
		
		if (null != state && !"".equals(state)) {
			sb.append(" and d.state=?");
			values.add(state);
		}
		
		sb.append(" order by s.sizesort");
		
		//尝试获取，如果没有获取到。读取parentid 能操作什么品牌。自动加入。
		
		List<Map<String,Object>> resultMap = userStandardDao.searchForMap(sb.toString(), values);
		
		//当为下级设置折扣等利益时，这里是想如果表里没有，自动将parent可操作的商品加入。但考虑到如果让上级主动选择下级能购买的商品，这样可能更符合要求。
		//这里先屏蔽。就是订单选择商品那里，不要选择上级的品牌，直接或者利益表里的数据，并关联到商品。这样小郭要修改了。
//		if (null == resultMap || resultMap.size() == 0) {
//			//首先清除userid 能操作的品牌，并将parentid能操作的品牌赋予它
//			
//			String sql = "select distinct s.* from public_product_size s,public_user_brand b where ";
//			List<Object> tmpValues = new ArrayList<Object>();
//			
//			sql += " b.userid = ? and b.brandid = s.brandid";
//			tmpValues.add(userid);
//			
//			if (null != productid && !"".equals(productid)) {
//				sql += " and s.productid=?";
//				tmpValues.add(productid);
//			}
//			if (null != brandid && !"".equals(brandid)) {
//				sb.append(" and s.brandid=?");
//				tmpValues.add(brandid);
//			}
//			List<Public_product_size> sizeList = sizeDao.search(sql, tmpValues);
//			
//			if (null != sizeList && sizeList.size() > 0) {
//				//循环加入
//				Public_set_user_standard setUserS = new Public_set_user_standard();
//				setUserS.setParentid(parentid);
//				setUserS.setUserid(userid);
//				setUserS.setState(0);
//				setUserS.setState(0);
//				
//				for (Public_product_size size : sizeList) {
//					setUserS.setId(UUID.randomUUID().toString());
//					setUserS.setBrandid(size.getBrandid());
//					setUserS.setProductid(size.getProductid());
//					setUserS.setSizeid(size.getId());
//					userStandardDao.save(setUserS);
//				}
//				
//				resultMap = userStandardDao.searchForMap(sb.toString(), values);
//			}
//		}
		
		return resultMap;
	}
	
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#listUserStandardFromBrand(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public List<Map<String, Object>> listUserStandardFromBrand(String parentid, String userid, String brandid) {
		StringBuffer sb = new StringBuffer();
		sb.append("select up.username as parentname,u.username as username,u.companyname,s.productpic,s.productname,s.productsize,s.price,s.sizesort,d.* from public_set_user_standard d");
		sb.append(" left join public_product_size s ON d.sizeid = s.id");
		sb.append(" left join public_user up ON up.id = d.parentid");
		sb.append(" left join public_user u ON u.id = d.userid");
		sb.append(" where d.parentid=? and d.userid=? and d.brandid=? order by s.sizesort");
		
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		values.add(userid);
		values.add(brandid);
		
		return userStandardDao.searchForMap(sb.toString(), values);
	}

	@Override
	public List<Map<String, Object>> listUserStandardFromBrand(String parentid, String userid, String brandid,String productname) {
		StringBuffer sb = new StringBuffer();
		sb.append("select up.username as parentname,u.username as username,u.companyname,s.productpic,s.productname,s.productsize,s.price,s.sizesort,d.* from public_set_user_standard d");
		sb.append(" left join public_product_size s ON d.sizeid = s.id");
		sb.append(" left join public_user up ON up.id = d.parentid");
		sb.append(" left join public_user u ON u.id = d.userid");
		sb.append(" where d.parentid=? and d.userid=? and d.brandid=? AND s.productname LIKE '%"+productname+"%' order by s.sizesort");
		
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		values.add(userid);
		values.add(brandid);
		
		return userStandardDao.searchForMap(sb.toString(), values);
	}
	
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#saveStandard(java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public boolean saveStandard(List<Map<String, String>> rows) throws IllegalAccessException, InvocationTargetException {
		for(int i=0,l=rows.size(); i<l; i++){
			Map<String,String> row = (Map<String,String>)rows.get(i);
	  		  
			String id = row.get("id") != null ? row.get("id").toString() : "";
	        String state = row.get("_state") != null ? row.get("_state").toString() : "";
	        
	        if (state.equals("removed") || state.equals("deleted")) {
	        	userStandardDao.del(id);
	        }
	        //更新：_state为空，或modified
	        else if (state.equals("modified") || state.equals(""))	 {
	        	Public_set_user_standard s = new Public_set_user_standard();
	        	BeanUtils.populate(s, row);
//	        	Public_set_user_standard s = userStandardDao.get(id);
//	        	s.setBuyerdis(Float.valueOf(row.get("buyerdis").toString()));
//	        	s.setRebatesdis(Float.valueOf(row.get("rebatesdis").toString()));
//	        	s.setBonusesdis(Float.valueOf(row.get("bonusesdis").toString()));
//	        	s.setState(Integer.valueOf(row.get("state").toString()));
	            
	        	userStandardDao.update(s);
	        }
	    }
		
		return true;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#updateUserSizeStandard(java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public boolean updateUserSizeStandard(String parentid, String userid, String updatekey, String updatevalue) {
		String sql = "update public_set_user_standard set " + updatekey + "=? where parentid=? and userid=?";
		
		List<Object> values = new ArrayList<Object>();
		
		values.add(updatevalue);
		values.add(parentid);
		values.add(userid);
		
		userStandardDao.update(sql, values);
		
		return true;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#listUserRatio(java.lang.String, java.lang.String)
	 */
	@Override
	public List<Map<String, Object>> listUserRatio(String parentid) {
		String sql = "select r.*,u.username,u.companyname,u.companyname,u.companypath from public_set_bonuses_ratio r,public_user u where r.userid = u.id and r.parentid=?";
		
		List<Object> values = new ArrayList<Object>();
		values.add(parentid);
		return ratioDao.searchForMap(sql, values);
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#listSelectUserC(java.lang.String)
	 */
	@Override
	public List<Public_user> listSelectUserC(String parentid) {
//		String sql = "select u.* from public_user u ,public_set_bonuses_ratio r,public_user_link l where u.identity='C' "
//				+ "and r.parentid = ? and r.userid <> l.userid and l.parentid = ? and u.id = l.userid";
//		
		List<Object> values = new ArrayList<Object>();
//		values.add(parentid);
//		values.add(parentid);
		
		String sql = "";
		//获取parentid下已配置的机构
		sql = "select * from public_set_bonuses_ratio where parentid = ?";
		values.add(parentid);
		
		List<Public_set_bonuses_ratio> ratioList = ratioDao.search(sql, values);
		
		//获取parentid下为C美容院的机构
		sql = "select u.* from public_user u,public_user_link l where u.identity='C' and l.parentid=? and u.id = l.userid";
		values.clear();
//		values.add('C');
		values.add(parentid);
		
		List<Public_user> userList = userDao.search(sql, values);
		
		//
		if (null != ratioList && ratioList.size() > 0) {
			Iterator<Public_user> iter = userList.iterator();
	        while(iter.hasNext()){
	            Public_user b = iter.next();
	            for (Public_set_bonuses_ratio ratio : ratioList) {
					if (b.getId().equals(ratio.getUserid())) {
						iter.remove();
						break;
					}
				}
	        }
		}
		return userList;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#UserRatioSel(java.lang.String, java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public void UserRatioSel(String ids, String parentid) {
		String[] idArr = ids.split(",");
		
		Public_set_bonuses_ratio ratio = new Public_set_bonuses_ratio();
		
		for (String userid : idArr) {
			ratio.setId(UUID.randomUUID().toString());
			ratio.setParentid(parentid);
			ratio.setUserid(userid);
			ratioDao.save(ratio);
		}
		
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#saveRatio(java.util.List)
	 */
	@Transactional("txManager")
	@Override
	public boolean saveRatio(List<Map<String, String>> rows) throws IllegalAccessException, InvocationTargetException {
		for(int i=0,l=rows.size(); i<l; i++){
			Map<String,String> row = (Map<String,String>)rows.get(i);
	  		  
			String id = row.get("id") != null ? row.get("id").toString() : "";
	        String state = row.get("_state") != null ? row.get("_state").toString() : "";
	        
	        if (state.equals("removed") || state.equals("deleted")) {
	        	ratioDao.del(id);
	        }
	        //更新：_state为空，或modified
	        else if (state.equals("modified") || state.equals(""))	 {
	        	Public_set_bonuses_ratio s = new Public_set_bonuses_ratio();
	        	BeanUtils.populate(s, row);
	        	ratioDao.update(s);
	        }
	    }
		
		return true;
	}

	//============end
	
}

package net.ussoft.zhxh.service.impl;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.Map.Entry;

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
import net.ussoft.zhxh.model.PageBean;
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
	public PageBean<Public_brand> list_user_brand(String parentid, String userid,String brandname,PageBean<Public_brand> p) {
		//1、获取父id下的子id集合
		Public_user_brand userBrand = new Public_user_brand();
		userBrand.setParentid(parentid);
		userBrand.setUserid(userid);
		
		List<Public_user_brand> userBrandList = userBrandDao.search(userBrand);
		
		//如果是空的。直接返回空
		if (null == userBrandList || userBrandList.size() == 0) {
			PageBean<Public_brand> tmpList = new PageBean<Public_brand>();
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
		
		if (null != brandname && !"".equals(brandname)) {
			sb.append(" and brandname like '"+brandname+"'");
		}
		
		sb.append(" order by sort");
		
		if (null == p) {
			List<Public_brand> resultList = brandDao.search(sb.toString(), values);
			PageBean<Public_brand> tmpP = new PageBean<Public_brand>();
			
			tmpP.setList(resultList);
			return tmpP;
		}
		
		return p = brandDao.search(sb.toString(), values, p);
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
	public PageBean<Public_product_size> list_select_size(String parentid, String userid,String brandid, String productid,PageBean<Public_product_size> p) {
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		
		//获取已设置的商品
		sb.append("select * from public_set_user_standard where parentid=? and userid=?");
		
		values.add(parentid);
		values.add(userid);
		
		if (null != brandid && !"".equals(brandid)) {
			sb.append(" and brandid = ?");
			values.add(brandid);
		}
		if (null != productid && !"".equals(productid)) {
			sb.append(" and productid = ?");
			values.add(productid);
		}
		List<Public_set_user_standard> userStandardList = userStandardDao.search(sb.toString(), values);
		
		List<String> isExistsList = new ArrayList<String>();
		if (null != userStandardList && userStandardList.size() > 0) {
			for (Public_set_user_standard s : userStandardList) {
				isExistsList.add(s.getSizeid());
			}
		}
		
		sb.setLength(0);
		values.clear();
		
		sb.append("select * from public_product_size where 1=1");
		
		if (null != brandid && !"".equals(brandid)) {
			sb.append(" and brandid = ?");
			values.add(brandid);
		}
		if (null != productid && !"".equals(productid)) {
			sb.append(" and productid = ?");
			values.add(productid);
		}
		
		if (isExistsList.size() > 0) {
			sb.append(" and id not in (");
			
			Serializable[] ss=new Serializable[isExistsList.size()];
			Arrays.fill(ss, "?");
			sb.append(StringUtils.join(ss,','));
			sb.append(")");
			values.addAll(isExistsList);
		}
		
		sb.append(" order by productname");
		
		List<Public_product_size> resultList = new ArrayList<Public_product_size>();
		if (null == p) {
			resultList = sizeDao.search(sb.toString(), values);
			PageBean<Public_product_size> resultP = new PageBean<Public_product_size>();
			resultP.setList(resultList);
			return resultP;
		}
		else {
			p = sizeDao.search(sb.toString(), values,p);
		}
		return p;
		
//		
//		String sql = "";
//		List<Object> values = new ArrayList<Object>();
//		
//		//获取商品下全部规格
//		sql = "select * from public_product_size where 1=1";
//		
//		if (null != brandid && !"".equals(brandid)) {
//			sql += " and brandid = ?";
//			values.add(brandid);
//		}
//		if (null != productid && !"".equals(productid)) {
//			sql += " and productid = ?";
//			values.add(productid);
//		}
//		sql += "order by sizesort";
//		
//		List<Public_product_size> allSizeList = sizeDao.search(sql, values);
//		if (allSizeList.size() == 0) {
//			return allSizeList;
//		}
//		
//		//获取parentid,userid   已经赋予了哪些，去除后返回，供前台选择
//		sql = "select * from public_set_user_standard where parentid=? and userid=?";
//		values.clear();
//		values.add(parentid);
//		values.add(userid);
//		
//		if (null != brandid && !"".equals(brandid)) {
//			sql += " and brandid = ?";
//			values.add(brandid);
//		}
//		if (null != productid && !"".equals(productid)) {
//			sql += " and productid = ?";
//			values.add(productid);
//		}
//		List<Public_set_user_standard> userStandardList = userStandardDao.search(sql, values);
//		
//		//如果是空的。直接返回空
//		if (null != userStandardList && userStandardList.size() > 0) {
//			Iterator<Public_product_size> iter = allSizeList.iterator();
//	        while(iter.hasNext()){
//	        	Public_product_size b = iter.next();
//	            for (Public_set_user_standard userStandard : userStandardList) {
//					if (b.getId().equals(userStandard.getSizeid())) {
//						iter.remove();
//						break;
//					}
//				}
//	        }
//		}
//				
//		return allSizeList;
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
		if (null != productid && !"".equals(productid)) {
			tmp.setProductid(productid);
		}
		
		for (String string : idArr) {
			tmp.setId(UUID.randomUUID().toString());
			tmp.setSizeid(string);
			
			if (null == productid || "".equals(productid)) {
				Public_product_size size = sizeDao.get(string);
				tmp.setProductid(size.getProductid());
			}
			
			userStandardDao.save(tmp);
		}
		
		return true;
	}
	
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#listUserStandard(java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.String, net.ussoft.zhxh.model.PageBean)
	 */
	@Override
	public PageBean<Map<String, Object>> listUserStandard(String parentid, String userid, String brandid, String productid,
			String state,String productname, PageBean<Map<String,Object>> p) {
		//1.获取被设置者能操作的品牌
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		
		PageBean<Map<String,Object>> resultList = new PageBean<Map<String,Object>>();
		
		sb.append("select * from public_user_brand where parentid=? and userid=?");
		values.add(parentid);
		values.add(userid);
		
		if (null != brandid && !"".equals(brandid)) {
			sb.append(" and brandid=?");
			values.add(brandid);
		}
		
		List<Public_user_brand> uBrandList = userBrandDao.search(sb.toString(), values);
		
		if (null == uBrandList || uBrandList.size() == 0) {
			return resultList;
		}
		
		//2.根据被设置者能操作的品牌，获取利益表数据
		List<String> brandidList = new ArrayList<String>();
		for (Public_user_brand uBrand : uBrandList) {
			brandidList.add(uBrand.getBrandid());
		}
		
		sb.setLength(0);
		values.clear();
		sb.append("select * from public_set_user_standard where parentid=? and userid=? and brandid in (");
		
		values.add(parentid);
		values.add(userid);
		
		Serializable[] ss=new Serializable[brandidList.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(brandidList);
		
		//加入搜索条件
		if (null != productname && !"".equals(productname)) {
			StringBuffer sbSearch = new StringBuffer();
			List<Object> valuesSearch = new ArrayList<Object>();
			sbSearch.append("select * from public_product_size where productname like '%"+productname+"%' and brandid in (");
			
			Serializable[] ss3=new Serializable[brandidList.size()];
			Arrays.fill(ss3, "?");
			sbSearch.append(StringUtils.join(ss3,','));
			sbSearch.append(")");
			valuesSearch.addAll(brandidList);
			
			List<Public_product_size> searchSizeList = sizeDao.search(sbSearch.toString(), valuesSearch);
			
			if (searchSizeList.size() == 0) {
				return resultList;
			}
			
			List<String> searchSizeIdList = new ArrayList<String>();
			for (Public_product_size size : searchSizeList) {
				searchSizeIdList.add(size.getId());
			}
			
			sb.append(" and sizeid in (");
			Serializable[] ss4=new Serializable[searchSizeIdList.size()];
			Arrays.fill(ss4, "?");
			sb.append(StringUtils.join(ss4,','));
			sb.append(")");
			values.addAll(searchSizeIdList);
		}
		
		if (null != productid && !"".equals(productid)) {
			sb.append(" and productid=?");
			values.add(productid);
		}
		if (null != state && !"".equals(state)) {
			sb.append(" and state=?");
			values.add(state);
		}
		
		sb.append(" order by brandid,productid");
		
		PageBean<Map<String,Object>> usPageBean = userStandardDao.searchForMap(sb.toString(), values, p);
		
		if (null == usPageBean || usPageBean.getList().size() == 0) {
			return resultList;
		}
		
		//3.为取出的数据添加设置者信息、被设置者基本信息
		Public_user pUser = userDao.get(parentid);
		Public_user user = userDao.get(userid);
		
		for (Map<String,Object> map : usPageBean.getList()) {
			map.put("parentname", pUser.getCompanyname());
			map.put("username", user.getUsername());
			map.put("companyname", user.getCompanyname());
		}
		
		//4.为取出的数据添加品牌信息
		sb.setLength(0);
		values.clear();
		sb.append("select * from public_brand where id in (");
		
		Serializable[] ss1=new Serializable[brandidList.size()];
		Arrays.fill(ss1, "?");
		sb.append(StringUtils.join(ss1,','));
		sb.append(")");
		values.addAll(brandidList);
		
		List<Public_brand> brandList = brandDao.search(sb.toString(), values);
		//反正循环一次，顺带获取规格id。用在后面添加商品信息
		List<String> sizeidList = new ArrayList<String>();
		for (Map<String,Object> map : usPageBean.getList()) {
			sizeidList.add(map.get("sizeid").toString());
			for (Public_brand brand : brandList) {
				if (map.get("brandid").toString().equals(brand.getId())) {
					map.put("brandname", brand.getBrandname());
					break;
				}
			}
		}
		
		//5.为取出的数据添加商品信息
		sb.setLength(0);
		values.clear();
		sb.append("select * from public_product_size where id in (");
		

		Serializable[] ss2=new Serializable[sizeidList.size()];
		Arrays.fill(ss2, "?");
		sb.append(StringUtils.join(ss2,','));
		sb.append(")");
		values.addAll(sizeidList);
		
		List<Public_product_size> sizeList = sizeDao.search(sb.toString(), values);
		
		for (Map<String,Object> map : usPageBean.getList()) {
			for (Public_product_size size : sizeList) {
				if (map.get("sizeid").toString().equals(size.getId())) {
					map.put("sizeid", size.getId());
					map.put("productpic", size.getProductpic());
					map.put("productname", size.getProductname());
					map.put("productsize", size.getProductsize());
					map.put("price", size.getPrice());
					break;
				}
			}
		}
		
		return usPageBean;
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
		sb.append(" left join public_user_brand ub On d.brandid = ub.id");
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
		
		sb.append(" and productname like '%菁纯新生%'");
		
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
	public PageBean<Map<String, Object>> listUserRatio(String parentid,Map<String, Object> searchMap,PageBean<Map<String,Object>> pageBean) {
//		String sql = "select r.*,u.username,u.companyname,u.companypath from public_set_bonuses_ratio r,public_user u "
//				+ "where r.userid = u.id and r.parentid=?";
		
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		
		//1获取关联的帐户。如果没有，直接返回
		sb.append("select * from public_user_link where parentid = ?");
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
//		List<String> searchUserIdList = new ArrayList<String>();
		List<Public_user> tmpUserList = new ArrayList<Public_user>();
		sb.setLength(0);
		values.clear();
		sb.append("select * from public_user where 1=1");
		if (null != searchMap && searchMap.size() > 0) {
			Set<Entry<String, Object>> set = searchMap.entrySet();
	        Iterator iterator=set.iterator();
	        sb.append(" and (");
	        for (int i = 0; i < set.size(); i++) {
	            Map.Entry mapEntry=(Entry) iterator.next();
	            if (null != mapEntry.getValue() && !"".equals(mapEntry.getValue().toString())) {
	            	sb.append(mapEntry.getKey()+" like '%"+mapEntry.getValue()+"%' or");
	            }
	        }
	        sb.delete(sb.length()-3, sb.length());
	        sb.append(")");
		}
		
		sb.append(" and id in (");
        Serializable[] ss=new Serializable[userid.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(userid);
		
		sb.append(" and identity=?");
		values.add("C");
        
        tmpUserList = userDao.search(sb.toString(), values);
        
        if (null == tmpUserList || tmpUserList.size() == 0) {
        	return pageBean;
        }
        userid.clear();
        for (Public_user user : tmpUserList) {
        	userid.add(user.getId());
		}
        
		sb.setLength(0);
		values.clear();
		
		sb.append("select * from public_set_bonuses_ratio where parentid=?");
		
		values.add(parentid);
		sb.append(" and userid in (");
		Serializable[] ss1=new Serializable[userid.size()];
		Arrays.fill(ss1, "?");
		sb.append(StringUtils.join(ss1,','));
		sb.append(")");
		values.addAll(userid);
		
		pageBean = ratioDao.searchForMap(sb.toString(), values, pageBean);
		PageBean<Map<String,Object>> resultList = new PageBean<Map<String,Object>>();
		if (null == pageBean || pageBean.getList().size() == 0) {
			return resultList;
		}
		
		for (Map<String,Object> map : pageBean.getList()) {
			for (Public_user user : tmpUserList) {
				if (map.get("userid").equals(user.getId())) {
					map.put("username", user.getUsername());
					map.put("companyname", user.getCompanyname());
					map.put("companypath", user.getCompanypath());
				}
			}
		}
		
		return pageBean;
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
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#delRatio(java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public boolean delRatio(String ids) {
		String[] idsArr = ids.split(",");
		
		for (String id : idsArr) {
			ratioDao.del(id);
		}
		return true;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#updateUserSizeStandard(java.lang.String, java.lang.String, java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public boolean updateUserSizeStandard(String ids, String updateKey, String updateValue) {
		String[] idsArr = ids.split(",");
		List<String> idList = Arrays.asList(idsArr);
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("update public_set_user_standard set ");
		sb.append(updateKey).append("=?");
		
		values.add(updateValue);
		sb.append("where id in (");
		
		Serializable[] ss=new Serializable[idList.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(idList);
		
		userStandardDao.update(sb.toString(), values);
		return true;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicUser2Service#delUserStandard(java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public boolean delUserStandard(String ids) {
		String[] idsArr = ids.split(",");
		List<String> idList = Arrays.asList(idsArr);
		StringBuffer sb = new StringBuffer();
		List<Object> values = new ArrayList<Object>();
		sb.append("delete from public_set_user_standard where id in (");
		
		Serializable[] ss=new Serializable[idList.size()];
		Arrays.fill(ss, "?");
		sb.append(StringUtils.join(ss,','));
		sb.append(")");
		values.addAll(idList);
		
		userStandardDao.del(sb.toString(), values);
		
		return true;
	}

	//============end
	
}

package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicDisConfigDao;
import net.ussoft.zhxh.dao.PublicSetBonusesRatioDao;
import net.ussoft.zhxh.dao.PublicSetUserStandardDao;
import net.ussoft.zhxh.model.Public_dis_config;
import net.ussoft.zhxh.model.Public_set_bonuses_ratio;
import net.ussoft.zhxh.model.Public_set_user_standard;
import net.ussoft.zhxh.service.IPublicDisService;

@Service
public class PublicDisService implements IPublicDisService {
	
	@Resource
	private PublicDisConfigDao disConfigDao;
	@Resource
	private PublicSetUserStandardDao userStandardDao;
	@Resource
	private PublicSetBonusesRatioDao bonusesRatioDao;

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicDisConfigService#getById(java.lang.String)
	 */
	@Override
	public Public_dis_config getById(String id) {
		return disConfigDao.get(id);
	}
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicDisConfigService#list()
	 */
	@Override
	public List<Public_dis_config> list() {
		return disConfigDao.getAll();
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicDisConfigService#insert(net.ussoft.zhxh.model.Public_dis_config)
	 */
	@Transactional("txManager")
	@Override
	public Public_dis_config insert(Public_dis_config tmp) {
		disConfigDao.save(tmp);
		return tmp;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicDisConfigService#update(net.ussoft.zhxh.model.Public_dis_config)
	 */
	@Transactional("txManager")
	@Override
	public int update(Public_dis_config tmp) {
		tmp = disConfigDao.update(tmp);
		if (null != tmp) {
			return 1;
		}
		return 0;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicDisConfigService#delete(java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return disConfigDao.del(id);
	}
	
	//============采购标准表
	
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IPublicDisService#list(java.lang.String, java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public List<Map<String, Object>> listDisStandard(String parentid, String userid) {
		
		String sql = "";
		List<Object> values = new ArrayList<Object>();
		List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
		
		if (userid.equals("T")) {
			//如果是通用标准
			
			Map<String,Object> m = new HashMap<String, Object>();
			m.put("parentid", parentid);
			m.put("userid", userid);
			//1 获取平台对代理的标准
			if (parentid.equals("1")) {
				sql = "select * from public_set_user_standard where parentid=? and userid=?";
				values.add(parentid);
				//TA表示平台对代理的通用采购标准设置
				values.add("TA");
				
				List<Public_set_user_standard> listTA = userStandardDao.search(sql, values);
				Public_set_user_standard ta = null;
				if (null == listTA || listTA.size() == 0) {
					ta = new Public_set_user_standard();
					ta.setId(UUID.randomUUID().toString());
					ta.setParentid(parentid);
					ta.setUserid("TA");
					userStandardDao.save(ta);
				}
				else {
					ta = listTA.get(0);
				}
				//将代理的商品折扣存入map
				m.put("buyerdis_TA", ta.getBuyerdis());
				m.put("id_TA", ta.getId());
			}
			
			//2 获取平台对直营店的标准
			values.clear();
			values.add(parentid);
			values.add("TC"); //TC表示平台对直营店的通用标准。T：通用  C:店
			
			List<Public_set_user_standard> listTC = userStandardDao.search(sql, values);
			Public_set_user_standard tc = null;
			if (null == listTC || listTC.size() == 0) {
				tc = new Public_set_user_standard();
				tc.setId(UUID.randomUUID().toString());
				tc.setParentid(parentid);
				tc.setUserid("TC");
				userStandardDao.save(tc);
			}
			else {
				tc = listTC.get(0);
			}
			//将店的商品折扣存入map
			m.put("buyerdis_TC", tc.getBuyerdis());
			//将店的返利标准存入map
			m.put("rebatesdis_TC", tc.getRebatesdis());
			//将店的奖励标准存入map
			m.put("bonusesdis_TC", tc.getBonusesdis());
			m.put("id_TC", tc.getId());
			
			//3获取通用奖励转货款标准bonusesRatioDao
			sql = "select * from public_set_bonuses_ratio where parentid=? and userid=?";
			values.clear();
			values.add(parentid);
			values.add("TC");
			List<Public_set_bonuses_ratio> ratioList = bonusesRatioDao.search(sql, values);
			
			Public_set_bonuses_ratio ratio = null;
			if (null == ratioList || ratioList.size() == 0) {
				ratio = new Public_set_bonuses_ratio();
				ratio.setId(UUID.randomUUID().toString());
				ratio.setParentid(parentid);
				ratio.setUserid("TC");
				bonusesRatioDao.save(ratio);
			}
			else {
				ratio = ratioList.get(0);
			}
			//将平台对直营店的奖励转货款系数存入map
			m.put("ratio_TC", ratio.getBonuses_ratio());
			m.put("ratio_id_TC", ratio.getId());
			
			resultList.add(m);
			
		}
		
		return resultList;
	}
	
	@Transactional("txManager")
	@Override
	public int updateDisStandard(List<Map<String, Object>> disList) {
		
//		String sql = "";
//		List<Object> values = new ArrayList<Object>();
		
		for (Map<String, Object> map : disList) {
			
			if (map.get("userid").equals("T")) {
				Public_set_user_standard s = null;
				//如果要更新通用的标准
				if (map.get("parentid").equals("1")) {
					//如果要更新的设置人为平台。就要设置代理级的折扣
					String id_TA = map.get("id_TA").toString();
					
					s = userStandardDao.get(id_TA);
					s.setBuyerdis(Float.valueOf(map.get("buyerdis_TA").toString()));
					
					userStandardDao.update(s);
				}
				
				//处理店级的标准
				String id_TC = map.get("id_TC").toString();
				s = userStandardDao.get(id_TC);
				s.setBuyerdis(Float.valueOf(map.get("buyerdis_TC").toString()));
				s.setRebatesdis(Float.valueOf(map.get("rebatesdis_TC").toString()));
				s.setBonusesdis(Float.valueOf(map.get("bonusesdis_TC").toString()));
				userStandardDao.update(s);
				
				//处理奖励转贷款
				String ratio_id_TC = map.get("ratio_id_TC").toString();
				Public_set_bonuses_ratio ratio = bonusesRatioDao.get(ratio_id_TC);
				
				ratio.setBonuses_ratio(Float.valueOf(map.get("ratio_TC").toString()));
				
				bonusesRatioDao.update(ratio);
				
			}
		}
		return 1;
	}

}

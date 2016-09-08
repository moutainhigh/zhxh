package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicSetBonusesRatioDao;
import net.ussoft.zhxh.model.Public_set_bonuses_ratio;

@Repository("publicSetBonusesRatioDao")
public class PublicSetBonusesRatioDaoImpl extends BaseDaoMysqlImpl<Public_set_bonuses_ratio, String> implements PublicSetBonusesRatioDao {

	public PublicSetBonusesRatioDaoImpl() {
		super(Public_set_bonuses_ratio.class);
	}
}

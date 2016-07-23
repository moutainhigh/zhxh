package net.ussoft.zhxh.dao.impl;

import org.springframework.stereotype.Repository;

import net.ussoft.zhxh.dao.PublicBonusListDao;
import net.ussoft.zhxh.model.Public_bonus_list;

@Repository("publicBonusListDao")
public class PublicBonusListDaoImpl extends BaseDaoMysqlImpl<Public_bonus_list, String> implements PublicBonusListDao {

	public PublicBonusListDaoImpl() {
		super(Public_bonus_list.class);
	}
}

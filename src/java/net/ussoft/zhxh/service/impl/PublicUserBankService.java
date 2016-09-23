package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.PublicLogDao;
import net.ussoft.zhxh.dao.PublicSetBonusesRatioDao;
import net.ussoft.zhxh.dao.PublicTradeBillDao;
import net.ussoft.zhxh.dao.PublicUserBankDao;
import net.ussoft.zhxh.model.Public_log;
import net.ussoft.zhxh.model.Public_set_bonuses_ratio;
import net.ussoft.zhxh.model.Public_trade_bill;
import net.ussoft.zhxh.model.Public_user_bank;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.util.DateUtil;

@Service
public class PublicUserBankService implements IPublicUserBankService{
	
	@Resource
	PublicUserBankDao userBankDao;
	@Resource
	PublicTradeBillDao billDao;
	@Resource
	PublicLogDao logDao;
	@Resource
	PublicSetBonusesRatioDao ratioDao;
	
	@Override
	public Public_user_bank getById(String id) {
		return userBankDao.get(id);
	}

	@Override
	public Public_user_bank getUserBank(String userid,String parentid){
		String sql = "select * from public_user_bank where 1=1";
		List<Object> values = new ArrayList<Object>();
		if(null != userid && !"".equals(userid)){
			sql += " and userid = ?";
			values.add(userid);
		}
		if(null != parentid && !"".equals(parentid)){
			sql += " and parentid = ?";
			values.add(parentid);
		}
		List<Public_user_bank> list = userBankDao.search(sql,values);
		return list.size() > 0 ? list.get(0) : new Public_user_bank();
	}
	
	@Override
	public List<Public_user_bank> list(String userid) {
		String sql = "select * from public_user_bank where userid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		return userBankDao.search(sql, values);
	}

	@Transactional("txManager")
	@Override
	public int update(Public_user_bank userBank) {
		Public_user_bank obj = userBankDao.update(userBank);
		if(obj != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return userBankDao.del(id);
	}

	@Transactional("txManager")
	@Override
	public Public_user_bank insert(Public_user_bank userBank) {
		return userBankDao.save(userBank);
	}
	
	/**
	 * 充值
	 * */
	@Override
	public int recharge(Public_trade_bill bill,String identity){
		//第三方支付返回成功后执行，此处是否需要添加线程锁-例如服务器返回了两次（应该不会）
		//当前账户
		Public_user_bank bank = getUserBank(bill.getUserid(), bill.getParentid());
		//平台账户,目前不考虑三级的问题  后期可添加上级直属账户ID字段
		Public_user_bank bank_PT = getUserBank("1", "1");
		//代理
		Public_user_bank bank_A = getUserBank(bill.getParentid(), ""); //目前结构，代理的账户是唯一的
		//充值金额
		float amount = bill.getAmount();
		//平台账户变更
		bank_PT.setTakenbank(bank_PT.getTakenbank() + amount);		//增加平台可提现账户
		bank_PT.setIncomebank(bank_PT.getIncomebank() + amount);	//增加平台收入总和
		
		String logmemo = "货款充值";	//日志内容
		if("A".equals(identity)){
			if(bill.getTrantype() == 1)	{
				//货款充值
				bank.setHavebank(bank.getHavebank() + amount);	//增加代理商可支配账户
			}else if(bill.getTrantype() == 2){
				//现金充值
				bank.setTakenbank(bank.getTakenbank() + amount);	//增加代理可提现账户
				bank.setIncomebank(bank.getIncomebank() + amount);	//增加代理收入总和
				logmemo = "现金充值";
			}
		}else if("C".equals(identity)){
			bank.setHavebank(bank.getHavebank() + amount);	//增加店可支配账户
			//非直营店,parentid 不等于1就代表非直营店
			if(!"1".equals(bill.getParentid())){
				bank_A.setTakenbank(bank_A.getTakenbank() + amount);		//增加代理可提现账户
				bank_A.setIncomebank(bank_A.getIncomebank() + amount);	//增加代理收入总和
				//代理账户变更
				bank_A = userBankDao.update(bank_A);
			}
		}
		
		//平台账户变更
		bank_PT = userBankDao.update(bank_PT);
		//当前账户
		bank = userBankDao.update(bank);
		//更新流水表状态
		bill = updateBillStatus(bill);
		//加日志 
		String logtype = "deposit";	//充值
		Public_log log = saveLog(bill, logtype, logmemo);
		
		if(bank_PT != null && bank_A != null && bank != null && bill != null && log != null){
			return 1;
		}
		
		return 0;
	}

	/**
	 * 充值-代理充值
	 * */
	public int rechargeA(Public_trade_bill bill){
		//当前账户
		Public_user_bank bank = getUserBank(bill.getUserid(), bill.getParentid());
		//平台账户,目前不考虑三级的问题  后期可添加上级直属账户ID字段
		Public_user_bank bank_PT = getUserBank("1", "1");
		//充值金额
		float amount = bill.getAmount();
		//平台账户变更
		bank_PT.setTakenbank(bank_PT.getTakenbank() + amount);		//增加平台可提现账户
		bank_PT.setIncomebank(bank_PT.getIncomebank() + amount);	//增加平台收入总和
		
		String logmemo = "";	//日志内容
		if(bill.getTrantype() == 1)	{
			//货款充值
			bank.setHavebank(bank.getHavebank() + amount);	//增加代理商可支配账户
			logmemo = "货款充值";
		}else if(bill.getTrantype() == 2){
			//现金充值
			bank.setTakenbank(bank.getTakenbank() + amount);	//增加代理可提现账户
			bank.setIncomebank(bank.getIncomebank() + amount);	//增加代理收入总和
			logmemo = "现金充值";
		}
		
		//平台账户变更
		bank_PT = userBankDao.update(bank_PT);
		//代理账户变更
		bank = userBankDao.update(bank);
		//更新流水表状态
		bill = updateBillStatus(bill);
		//加日志 
		String logtype = "deposit";	//充值
		Public_log log = saveLog(bill, logtype, logmemo);
		
		if(bank_PT != null && bank != null && bill != null && log != null){
			return 1;
		}
		return 0;
	}
	
	/**
	 * 充值-店充值
	 * @param bill
	 * @param type 1:直营店，2:非直营店
	 * */
	public int rechargeC(Public_trade_bill bill,int type){
		/*
		 一、非直营店
		 1.店可支配账户
		 2.平台可提现账户 增加
		 3.平台收入总和
		 4.代理商可提现账户
		 5.代理商收入总和 
		 二、直营店
		 1.店可支配账户
		 2.平台可提现账户 增加
		 3.平台收入总和
		 */
		
		//当前账户
		Public_user_bank bank = getUserBank(bill.getUserid(), bill.getParentid());
		//平台账户
		Public_user_bank bank_PT = getUserBank("1", "1");
		//充值金额
		float amount = bill.getAmount();
		
		//平台账户变更
		bank_PT.setTakenbank(bank_PT.getTakenbank() + amount);	//增加平台可提现账户
		bank_PT.setIncomebank(bank_PT.getIncomebank() + amount);	//增加平台收入总和
		//店
		bank.setHavebank(bank.getHavebank() + amount);	//增加店可支配账户
		
		String logmemo = "货款充值";	//日志内容
		
		//平台账户变更
		bank_PT = userBankDao.update(bank_PT);
		//店账户变更
		bank = userBankDao.update(bank);
		//更新流水表状态
		bill = updateBillStatus(bill);
		//加日志 
		String logtype = "deposit";	//充值
		Public_log log = saveLog(bill, logtype, logmemo);
				
		if(type == 1)	{
			//直营店
			if(bank_PT != null && bank != null && bill != null && log != null){
				return 1;
			}
		}else if(type == 2){
			//非直营店
			Public_user_bank bank_A = getUserBank(bill.getParentid(), "");//代理
			bank_A.setTakenbank(bank_A.getTakenbank() + amount);		//增加代理可提现账户
			bank_A.setIncomebank(bank_A.getIncomebank() + amount);	//增加代理收入总和
			//代理账户变更
			bank_A = userBankDao.update(bank_A);
			
			if(bank_PT != null && bank_A != null && bank != null && bill != null && log != null){
				return 1;
			}
		}
		return 0;
	}
	
	@Override
	public int withdrawal(String userid, String parentid) {
		//代理提现
		
		//店提提现
		/*
		 1.奖励提现
		 2.平台售额提现
		 */
		
		return 0;
	}

	/**
	 * 代理提现
	 * */
	public int withdrawalA(Public_trade_bill bill) {
		//提现之前是否要先验证下级的可提现账户金额，是否允许提现- 如需要在外面进行验证
		//1.冲减平台可提现账户
		//2.冲减代理、店可提现账户
		//3.增加平台支出（总和)
		//4.加日志
		
		//当前账户
		Public_user_bank bank = getUserBank(bill.getUserid(), bill.getParentid());
		//平台账户
		Public_user_bank bank_PT = getUserBank("1", "1");
		//提现金额
		float amount = bill.getAmount();
		//平台账户变更
		bank_PT.setTakenbank(bank_PT.getTakenbank() - amount);		//冲减平台可提现账户
		bank_PT.setCostbank(bank_PT.getCostbank() + amount);		//增加平台支出总和
		
		String logmemo = "提现";	//日志内容
		//代理
		bank.setTakenbank(bank.getTakenbank() - amount);		//冲减代理可提现账户
		
		//平台账户变更
		bank_PT = userBankDao.update(bank_PT);
		//代理账户变更
		bank = userBankDao.update(bank);
		//更新流水表状态
		bill = updateBillStatus(bill);
		//加日志 
		String logtype = "withdrawal";	//提现
		Public_log log = saveLog(bill, logtype, logmemo);
		
		if(bank_PT != null && bank != null && bill != null && log != null){
			return 1;
		}
		return 0;
	}
	
	/**
	 * 店提现 注意当banktype 为2平台售额，type值永远为1（此时的1不是代表直营店，而是业务不做任何操作），考虑分开
	 * @param bill
	 * @param banktype  提现账户 1:奖励 , 2:平台售额
	 * @param type 1：直营店 ， 2:非直营店
	 * */
	public int withdrawalC(Public_trade_bill bill,int banktype,int type) {
		//奖励可提现账户
		/*
		 一、非直营的店
		 1.冲减店奖励账户
		 2.冲减代理可提现账户
		 3.增加代理商支出（总和）
		 4.冲减平台可提现账户
		 5.增加平台支出（总和）
		 
		 二、直营店
		 1.冲减店奖励账户
		 3.冲减平台可提现账户
		 4.增加平台支出（总和）
		 
		 */
		//平台售额可提现账户 
		/*
		 1.冲减店售额可提现账户
		 3.冲减平台可提现账户
		 4.增加平台支出（总和） 
		 */
		
		//当前账户
		Public_user_bank bank = getUserBank(bill.getUserid(), bill.getParentid());
		//平台账户
		Public_user_bank bank_PT = getUserBank("1", "1");
		//提现金额
		float amount = bill.getAmount();
		//平台账户变更
		bank_PT.setTakenbank(bank_PT.getTakenbank() - amount);		//冲减平台可提现账户
		bank_PT.setCostbank(bank_PT.getCostbank() + amount);		//增加平台支出总和
		String logmemo = "";	//日志内容
		//店
		if(banktype == 1){
			bank.setBonusestakenbank(bank.getBonusestakenbank() - amount);		//冲减店奖励可提现账户
			logmemo = "奖励提现";	//日志内容
		}else if(banktype == 2){
			bank.setSelltakenbank(bank.getSelltakenbank() - amount);		//冲减店平台售额可提现账户
			logmemo = "平台售额提现";	//日志内容
		}
		
		//平台账户变更
		bank_PT = userBankDao.update(bank_PT);
		//店
		bank = userBankDao.update(bank);
		//更新流水表状态
		bill = updateBillStatus(bill);
		//加日志 
		String logtype = "withdrawal";	//提现
		Public_log log = saveLog(bill, logtype, logmemo);
		
		if(type == 1){
			//直营店
			if(bank_PT != null && bank != null && bill != null && log != null){
				return 1;
			}
		}else if(type == 2){
			//非直营店
			Public_user_bank bank_A = getUserBank(bill.getParentid(), "");	//代理账户
			bank_A.setTakenbank(bank_A.getTakenbank() - amount);	//冲减代理可提现账户
			bank_A.setCostbank(bank_A.getCostbank() + amount);		//增加代理支出总和
			//代理账户变更
			bank_A = userBankDao.update(bank_A);
			if(bank_PT != null && bank_A != null && bank != null && bill != null && log != null){
				return 1;
			}
		}
		
		return 0;
	}
	
	/**
	 * 店提现 - 平台售额可提现账户 
	 * */
	public int withdrawalC(Public_trade_bill bill) {
		//平台售额可提现账户 
		/*
		 1.冲减店售额可提现账户
		 3.冲减平台可提现账户
		 4.增加平台支出（总和） 
		 */
		
		//当前账户
		Public_user_bank bank = getUserBank(bill.getUserid(), bill.getParentid());
		//平台账户
		Public_user_bank bank_PT = getUserBank("1", "1");
		//提现金额
		float amount = bill.getAmount();
		//平台账户变更
		bank_PT.setTakenbank(bank_PT.getTakenbank() - amount);		//冲减平台可提现账户
		bank_PT.setCostbank(bank_PT.getCostbank() + amount);		//增加平台支出总和
		//店
		bank.setSelltakenbank(bank.getSelltakenbank() - amount);		//冲减店平台售额可提现账户
		
		String logmemo = "平台售额提现";	//日志内容
		//店
		bank = userBankDao.update(bank);
		//更新流水表状态
		bill = updateBillStatus(bill);
		//加日志 
		String logtype = "withdrawal";	//提现
		Public_log log = saveLog(bill, logtype, logmemo);
		
		if(bank_PT != null && bank != null && bill != null && log != null){
			return 1;
		}
		
		return 0;
	}
	
	@Transactional("txManager")
	@Override
	public int setQuota(String userid,String parentid,float amount) {
		Public_user_bank bank = getUserBank(userid, parentid);
		bank.setQuotabank(bank.getQuotabank() + amount);	//配额累计
		bank.setHavebank(bank.getHavebank() + amount);		//增加可支配账户
		bank = userBankDao.update(bank);
		//日志
		Public_log log = saveLog(userid, parentid, "quota","配额",amount);
		if(bank != null && log != null){
			return 1;
		}
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int transfBuyBank(String userid,String parentid,float amount) {
		//查找转货款对应的系数
		Public_set_bonuses_ratio ratio = getBonusersRatio(userid, parentid);
		
		Public_user_bank bank = getUserBank(userid, parentid);
		bank.setBonusestakenbank(bank.getBonusestakenbank() - amount);	//冲减奖励可提现账户
		//
		if(ratio.getBonuses_ratio() > 0){
			float _amount = amount * ratio.getBonuses_ratio();
			bank.setHavebank(bank.getHavebank() + _amount);	//增加可支配账户
		}else{
			bank.setHavebank(bank.getHavebank() + amount);	//增加可支配账户
		}
		bank = userBankDao.update(bank);
		//日志
		Public_log log = saveLog(userid, parentid, "bonuses_ratio", "奖励转贷款", amount);
		if(bank != null && log != null)
			return 1;
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int rebate() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int reward() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Transactional("txManager")
	@Override
	public int platformSale() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	/**
	 * 修改支付账单流水 状态
	 * @param bill
	 * @return 
	 * */
	private Public_trade_bill updateBillStatus(Public_trade_bill bill){
		bill.setStatus(1);	//支付成功、提现成功
		bill.setBanktime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		return billDao.update(bill);
	}
	
	/**
	 * 添加日志
	 * @param bill  账单流水表
	 * @param logtype	操作类型
	 * @return 
	 * */
	private Public_log saveLog(Public_trade_bill bill,String logtype,String logmemo){
		Public_log log = new Public_log();
		log.setId(UUID.randomUUID().toString());
		log.setUserid(bill.getUserid());	//主操作人
		log.setTouserid(bill.getParentid());			//被操作人
		log.setLogtype(logtype);	//操作类型
		log.setLogmemo(logmemo);
		log.setLogtime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		log.setLognum(bill.getId());		//流水表ID
		log.setLogpay(bill.getAmount());	//金额
		
		return logDao.update(log);
	}
	
	/**
	 * 添加日志
	 * @param userid
	 * @param parentid
	 * @param logtype 操作类型
	 * @param logmemo 日志内容描述
	 * @param amount 金额
	 * @return
	 * */
	private Public_log saveLog(String userid,String parentid,String logtype,String logmemo,float amount){
		Public_log log = new Public_log();
		log.setId(UUID.randomUUID().toString());
		log.setUserid(userid);	//主操作人
		log.setTouserid(parentid);			//被操作人
		log.setLogtype(logtype);	//操作类型
		log.setLogmemo(logmemo);
		log.setLogtime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
//		log.setLognum();		//流水表ID
		log.setLogpay(amount);	//金额
		
		return logDao.update(log);
	}
	
	/**
	 * 查找账户奖励转货款标准
	 * @param userid
	 * @param parentid
	 * @return obj:null
	 * */
	private Public_set_bonuses_ratio getBonusersRatio(String userid,String parentid){
		String sql = "SELECT * FROM public_set_bonuses_ratio WHERE userid = ? AND parentid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		values.add(parentid);
		List<Public_set_bonuses_ratio> list = ratioDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}
	
	/**
	 * 充值/体现-账单流水
	 * @param billid
	 * @return
	 * */
	private Public_trade_bill getTradeBill(String billid){
		String sql = "SELECT * FROM Public_trade_bill WHERE billid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(billid);
		List<Public_trade_bill> list = billDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}
	
}

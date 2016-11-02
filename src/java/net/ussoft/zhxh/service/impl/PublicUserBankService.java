package net.ussoft.zhxh.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import net.ussoft.zhxh.dao.IncomeBillDao;
import net.ussoft.zhxh.dao.PublicDisDetailsDao;
import net.ussoft.zhxh.dao.PublicLogDao;
import net.ussoft.zhxh.dao.PublicMessageDao;
import net.ussoft.zhxh.dao.PublicOrderDao;
import net.ussoft.zhxh.dao.PublicOrderProductDao;
import net.ussoft.zhxh.dao.PublicPhoneCodeLogDao;
import net.ussoft.zhxh.dao.PublicProductSizeRebateDao;
import net.ussoft.zhxh.dao.PublicSetBonusesRatioDao;
import net.ussoft.zhxh.dao.PublicSetUserStandardDao;
import net.ussoft.zhxh.dao.PublicUserBankDao;
import net.ussoft.zhxh.dao.PublicUserDao;
import net.ussoft.zhxh.dao.QuotaBillDao;
import net.ussoft.zhxh.dao.ShareBillDao;
import net.ussoft.zhxh.dao.SpendingBillDao;
import net.ussoft.zhxh.model.Income_bill;
import net.ussoft.zhxh.model.Public_dis_details;
import net.ussoft.zhxh.model.Public_log;
import net.ussoft.zhxh.model.Public_message;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Public_phone_code_log;
import net.ussoft.zhxh.model.Public_product_size_rebate;
import net.ussoft.zhxh.model.Public_set_bonuses_ratio;
import net.ussoft.zhxh.model.Public_set_user_standard;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Public_user_bank;
import net.ussoft.zhxh.model.Quota_bill;
import net.ussoft.zhxh.model.Share_bill;
import net.ussoft.zhxh.model.Spending_bill;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.util.BillNO;
import net.ussoft.zhxh.util.DateUtil;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;

@Service
public class PublicUserBankService implements IPublicUserBankService{
	
	@Resource
	private PublicUserBankDao userBankDao;
	@Resource
	private IncomeBillDao incomeBillDao;
	@Resource
	private SpendingBillDao spendingBillDao;
	@Resource
	private QuotaBillDao quotaBillDao;
	@Resource
	private PublicLogDao logDao;
	@Resource
	private PublicSetBonusesRatioDao ratioDao;
	@Resource
	private PublicPhoneCodeLogDao codelogDao;
	@Resource
	private PublicOrderDao orderDao;
	@Resource
	private PublicOrderProductDao orderProductDao;
	@Resource
	private PublicProductSizeRebateDao rebateDao;
	@Resource
	private PublicMessageDao msgDao;
	@Resource
	private PublicDisDetailsDao disDetailsDao;
	@Resource
	private PublicUserDao userDao;
	@Resource
	private PublicSetUserStandardDao standardDao;	//
	@Resource
	private ShareBillDao shareBillDao;	//
	
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
	 * 订货单-支付扣款
	 * @param bank
	 * @param order
	 * */
	@Transactional("txManager")
	@Override
	public int paymentorder(Public_user_bank bank,Public_order order){
		//扣款
		bank.setHavebank(bank.getHavebank() - order.getOrdertotal());
		bank = userBankDao.update(bank);	//
		//改变订单状态
		order.setOrderstatus(1);	//支付成功-转为 待发货
		order.setOrderstatusmemo("待发货");
		order = orderDao.update(order);
		//日志
		Public_log log = saveLog(bank.getUserid(), bank.getParentid(), "paymentorder", order.getOrdernumber()+"-已付款", order.getOrdertotal(), order.getId());
		//订单已取消-消息
		int messagetype = 1;	//业务消息
		String messagetxt = order.getU_username()+"提交了订单，请及时处理！订单号："+order.getOrdernumber();
		createMsg(order.getUserid(), order.getU_username(), order.getParentid(), order.getP_username(), messagetype, messagetxt,order.getId());
		
		if(bank != null && order !=null && log != null){
			return 1;
		}
		return 0;
	}
	
	/**
	 * 订货单-取消订单
	 * @param bank
	 * @param order
	 * */
	@Transactional("txManager")
	@Override
	public int cancelorder(Public_user_bank bank,Public_order order){
		//退换订单金额
		bank.setHavebank(bank.getHavebank() + order.getOrdertotal());
		bank = userBankDao.update(bank);	//
		//改变订单状态
		order.setOrderstatus(-1);	//取消订单
		order.setOrderstatusmemo("已取消");
		order = orderDao.update(order);
		//日志
		Public_log log = saveLog(bank.getUserid(), bank.getParentid(), "cancelorder", order.getOrdernumber()+"-已取消", order.getOrdertotal(), order.getId());
		//订单已取消-消息
		int messagetype = 1;	//业务消息
		String messagetxt = order.getU_username()+"取消了订单！订单号："+order.getOrdernumber();
		createMsg(order.getUserid(), order.getU_username(), order.getParentid(), order.getP_username(), messagetype, messagetxt,order.getId());
		if(bank != null && order !=null && log != null){
			return 1;
		}
		return 0;
	}
	
	/**
	 * 订货单-已发货
	 * @param order
	 * */
	@Transactional("txManager")
	@Override
	public int sendoutorder(Public_order order){
		//改变订单状态
		order.setOrderstatus(2);	//已发货
		order.setOrderstatusmemo("已发货");
		order = orderDao.update(order);
		
		String userid = order.getUserid();
		String username = order.getU_companyname();
		String parentid = order.getParentid();
		String parentname = order.getP_companyanme();
		
		if ("p".equals(order.getOrdertype())) {
			String submitid = order.getSubmitid();
			Public_user submitUser = userDao.get(submitid);
			userid = submitid;
			username = submitUser.getCompanyname();
		}
		
		//日志
		Public_log log = saveLog(parentid, userid, "sendorder", order.getOrdernumber()+"-已发货", order.getOrdertotal(), order.getId());
		//消息
		int messagetype = 1;	//业务消息
		String messagetxt = "尊敬的客户您好，您的订单已发货，订单号："+order.getOrdernumber();
		Public_message msg = createMsg(parentid, parentname, userid, username, messagetype, messagetxt,order.getId());
		if(order !=null && log != null && msg != null){
			return 1;
		}
		return 0;
	}
	
	/**
	 * 订货单-已签收
	 * @param order
	 * */
	@Transactional("txManager")
	@Override
	public int signorder(Public_order order){
		//改变订单状态
		order.setOrderstatus(3);	//已签收
		order.setOrderstatusmemo("已签收");
		//增加签收时间
		order.setSigntime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		order = orderDao.update(order);
		//订单操作日志
		saveLog(order.getUserid(), order.getParentid(), "sendorder", order.getOrdernumber()+"-已签收", order.getOrdertotal(), order.getId());
		//订单已签收-消息
		int messagetype = 1;	//业务消息
		String messagetxt = order.getU_username()+"，的订单已签收！订单号："+order.getOrdernumber();
		createMsg(order.getUserid(), order.getU_username(), order.getParentid(), order.getP_username(), messagetype, messagetxt,order.getId());
		
		/*是否接收分成：返利、奖励，查看机构的当前状态*/
		Public_user user = userDao.get(order.getUserid());
		Public_user tj_user = userDao.get(order.getTid());
		
		if("C".equals(order.getIdentity())){
			float rebate_total = 0;	//本次返利总额
			float award_total = 0;	//本次奖励总额
			List<Public_order_product> list = getOrderProducts(order.getId());	//订单商品
			for(Public_order_product obj:list){
				//商品返利剩余数量
				Public_product_size_rebate rebate = getProductSizeRebate(order.getUserid(), order.getParentid(), obj.getProductid());
				if(rebate != null){
					int rebate_num = 0;			//本次返利数量
					int next_rebate_num = 0;	//下次返利数量
					if(obj.getProductnum() > rebate.getQuantity()){
						rebate_num = rebate.getQuantity();			//本次返利数量
						next_rebate_num = obj.getProductnum();		//下次返利数量
						rebate.setQuantity(obj.getProductnum());	//重新设置下次返利数量
						rebateDao.update(rebate);
					}else{
						rebate_num = obj.getProductnum();			//本次返利数量
						next_rebate_num = rebate.getQuantity();		//下次返利数量
					}
					//接收分成
					if(user.getSetreturn() == 1){
						//计算本次返利额 = 商品折扣价后 X 返利比例 X 数量
						float rebate_money = obj.getPrice() * obj.getBuyerdis() * obj.getRebatesdis() * rebate_num;
						rebate_total += rebate_money;					//返利金额合计
						//返利奖励明细表
						Public_dis_details rebate_details = setDisDetails(rebate_num, next_rebate_num, rebate_money, 1);
						//添加返利记录
						savePublicDisDetails(rebate_details,order,obj);
					}
					//判断是否有推荐人
					if(order.getTid() != null && !"".equals(order.getTid())){
						//接收分成
						if(tj_user.getSetreturn() == 1){
							//采购各种标准 - 查找推荐人的奖励标准
							Public_set_user_standard standard = getProStandard(order.getTid(), order.getParentid(), obj.getProductid());
							//计算奖励 —— 奖励标准 X 数量(同返利的数量)
							float award_money = standard.getBonusesdis() * rebate_num;
							award_total += award_money;
							Public_dis_details award_details = setDisDetails(rebate_num, next_rebate_num, award_money, 2);
							//添加奖励记录
							savePublicDisDetails(award_details,order,obj);
						}
					}
					
				}else{
					//首次添加-商品返利余额
					Public_product_size_rebate sizerebate = new Public_product_size_rebate();
					sizerebate.setId(UUID.randomUUID().toString());
					sizerebate.setUserid(order.getUserid());
					sizerebate.setParentid(order.getParentid());
					sizerebate.setSizeid(obj.getProductid());
					sizerebate.setQuantity(obj.getProductnum());
					rebateDao.save(sizerebate);
				}
			}
			
			//添加返利账户金额
			if(rebate_total > 0){
				Public_user_bank bank = getUserBank(order.getUserid(), order.getParentid());	//当前的操作账户
				bank.setRebatesbank(bank.getRebatesbank() + rebate_total);	//返利累计账户
				bank.setHavebank(bank.getHavebank() + rebate_total);		//返利金额直接进入到可支配账户中
				userBankDao.update(bank);
				//添加返利消息
				messagetype = 1;	//业务消息
				messagetxt = order.getU_username()+"的订单已返利！订单号："+order.getOrdernumber();
				createMsg(order.getParentid(), order.getP_username(),order.getUserid(), order.getU_username(),  messagetype, messagetxt,order.getId());
			}
			
			//奖励
			if(award_total > 0){
				//奖励(奖励累计、奖励可提现)
				Public_user_bank tbank = getUserBank(order.getTid(),order.getParentid());
				if(tbank != null && !"".equals(tbank.getId())){
					tbank.setBonusesbank(tbank.getBonusesbank() + award_total);				//奖励累计
					tbank.setBonusestakenbank(tbank.getBonusestakenbank() + award_total);	//奖励可提现账户
					userBankDao.update(tbank);
					//添加奖励消息
					messagetype = 1;	//业务消息
					messagetxt = "尊敬的客户您好，您推荐的"+order.getU_username()+"，已产生了订单给予您"+award_total+"元奖励！";
					createMsg(order.getParentid(), order.getP_username(),order.getTid(),order.getT_username(), messagetype, messagetxt,order.getId());
				}
			}
			
		}
		return 1;
	}
	
	/**
	 * 返利、奖励，计数
	 * */
	public Public_dis_details setDisDetails(int rebate_num, int next_rebate_num, float money,int type){
		Public_dis_details rebate_details = new Public_dis_details();
		rebate_details.setDetailsnum(rebate_num); 			//本次返利、奖励数量
		rebate_details.setNextrebatesnum(next_rebate_num);	//下次返利、奖励数量
		rebate_details.setDetailspay(money);		//本次返利、奖励金额
		rebate_details.setDetailstype(type);	//1返利;2奖励
		return rebate_details;
	}
	
	/**
	 * 充值
	 * */
//	@Transactional(isolation = Isolation.REPEATABLE_READ)
	@Transactional("txManager")
	@Override
	public synchronized int recharge(Income_bill bill,String identity){
		if(bill.getStatus() == 1){
			return -1;	//已支付
		}
		//当前账户
		Public_user_bank bank = getUserBank(bill.getUserid(), bill.getParentid());
		//平台账户,目前不考虑三级的问题  后期可添加上级直属账户ID字段
		Public_user_bank bank_PT = getUserBank("1", "1");
		//充值金额
		float amount = bill.getAccount_real(); //实收款
		//平台账户变更
		bank_PT.setTakenbank(bank_PT.getTakenbank() + amount);		//增加平台可提现账户
		bank_PT.setIncomebank(bank_PT.getIncomebank() + amount);	//增加平台收入总和
		bank.setDepositbank(bank.getDepositbank() + amount);		//充值累计（当前操作账户）
		if("A".equals(identity)){
			if(bill.getTrantype() == 2)	{
				//货款充值
				bank.setHavebank(bank.getHavebank() + amount);	//增加代理商可支配账户
			}else if(bill.getTrantype() == 1){
				//现金充值
				bank.setTakenbank(bank.getTakenbank() + amount);	//增加代理可提现账户
				bank.setIncomebank(bank.getIncomebank() + amount);	//增加代理收入总和
			}
		}else if("C".equals(identity)){
			bank.setHavebank(bank.getHavebank() + amount);	//增加店可支配账户
			//非直营店,parentid 不等于1就代表非直营店
			if(!"1".equals(bill.getParentid())){
				//代理
				Public_user_bank bank_A = getUserBank(bill.getParentid(), ""); //目前结构，代理的账户是唯一的
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
		bill.setStatus(1); //成功
		bill.setBanktime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		bill = incomeBillDao.update(bill);
		//添加充值消息
		int messagetype = 1;	//业务消息
		String messagetxt = "【"+bill.getU_company()+"】进行了充值，充值金额为："+amount;
		createMsg(bill.getUserid(), bill.getU_company(),bill.getParentid(),bill.getP_company(), messagetype, messagetxt,bill.getId());
		
		return 1;
	}
	
	@SuppressWarnings("unused")
	private HashMap<String,HashMap<String,Object>> setTmpMap(HashMap<String,HashMap<String,Object>> resultMap,String userid,String parentid,float pay,int num) {
		HashMap<String,Object> m = resultMap.get(userid);
		if (null != m) {
			Float t = (float)m.get("total");
			if (null != t) {
				t = t+pay;
			}
			else {
				t = pay;
			}
			m.put("total", t);
			
			Integer n = (int)m.get("number");
			if (null != n) {
				n = n+num;
			}
			else {
				n = num;
			}
			m.put("number", n);
		}
		else {
			HashMap<String,Object> m1 = new HashMap<String,Object>();
			Public_user user = userDao.get(userid);
			m1.put("username", user.getCompanyname());
			m1.put("total",pay);
			m1.put("number", num);
			m1.put("parentid", parentid);
			resultMap.put(userid, m1);
		}
		
		return resultMap;
	}
	
	/**
	 * 获取商品的商品折扣
	 * @param userid
	 * @param parentid
	 * @param sizeid
	 * @return
	 * */
	private Public_set_user_standard getStandard(String userid,String sizeid){
		String sql = "SELECT * FROM public_set_user_standard WHERE userid=? AND sizeid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		values.add(sizeid);
		List<Public_set_user_standard> list = standardDao.search(sql,values);
		return list.size() > 0 ? list.get(0): new Public_set_user_standard();
	}
	
	@Transactional("txManager")
	@Override
	public int rechargeZ(Income_bill bill, String identity) {
		if(bill.getStatus() == 1){
			return -1;	//已支付
		}
		
		//分润订单
		Public_order order = orderDao.get(bill.getOrderid());
		//提交订单机构
		Public_user submitUser = userDao.get(order.getSubmitid());
		Public_user jUser = userDao.get("1");
		
		//订单商品
		List<Public_order_product> proList = getOrderProducts(order.getId());
		
		if (null == proList || proList.size() == 0) {
			return 0;
		}
		
		HashMap<String,HashMap<String,Object>> resultMap = new HashMap<String,HashMap<String,Object>>();
		
		//循环订单商品。每个商品都去获取各种标准
		for (Public_order_product product : proList) {
			//存储分润的机构及分润各项标准、额。
			List<HashMap<String,HashMap<String,Object>>> shareList = new ArrayList<HashMap<String,HashMap<String,Object>>>();
			//平台
			HashMap<String,HashMap<String,Object>> jMap = new HashMap<String,HashMap<String,Object>>();
			//1、判断提交机构是否为平台.如果是提交机构是平台，那就啥也不用计算tm的了。
			if ("1".equals(submitUser.getId())) {
				HashMap<String,Object> j_shareMap = new HashMap<String,Object>();
				j_shareMap.put("userid", jUser.getId());
				j_shareMap.put("identity", jUser.getIdentity());
				j_shareMap.put("identitymemo", jUser.getIdentitymemo());
				j_shareMap.put("companyname", jUser.getCompanyname());
				j_shareMap.put("userStandard", 1);
				j_shareMap.put("sharepay", product.getPrice()*product.getProductnum());
				j_shareMap.put("productnum", product.getProductnum());
				jMap.put("1", j_shareMap);
				
				shareList.add(jMap);
				
				resultMap = setTmpMap(resultMap,"1","1",product.getPrice()*product.getProductnum(),product.getProductnum());
				continue;
			}
			
			//2、如果提交机构不是平台。计算该商品的各种机构折扣
			//获取当前商品，提交机构的上级采购利益。
			Public_set_user_standard userStandard = getStandard(submitUser.getId(),product.getProductid());
			
			//3、如果有采购标准，判断谁给他设置的。
			//如果是平台设置的
			if ("1".equals(userStandard.getParentid())) {
				//有设置。利润按折扣给平台。
				Float buyerdis = userStandard.getBuyerdis();
				Float totalpay = product.getPrice()*product.getProductnum();
				Float j_sharepay = totalpay*buyerdis;
				Float s_sharepay = totalpay - j_sharepay;
				j_sharepay = (float)(Math.round(j_sharepay*100))/100;//输出小数点2位
				s_sharepay = (float)(Math.round(s_sharepay*100))/100;//输出小数点2位
//				int j_sharepay_int = Math.round(j_sharepay);
//				int a_sharepay_int = Math.round(totalpay) - j_sharepay_int;
				HashMap<String,Object> j_shareMap = new HashMap<String,Object>();
				j_shareMap.put("userid", jUser.getId());
				j_shareMap.put("identity", jUser.getIdentity());
				j_shareMap.put("identitymemo", jUser.getIdentitymemo());
				j_shareMap.put("companyname", jUser.getCompanyname());
				j_shareMap.put("userStandard", buyerdis);
				j_shareMap.put("sharepay", j_sharepay);
				j_shareMap.put("productnum", product.getProductnum());
				jMap.put("1", j_shareMap);
				
				shareList.add(jMap);
				
				resultMap = setTmpMap(resultMap,"1","1",j_sharepay,product.getProductnum());
				
				//处理提交机构的
				HashMap<String,HashMap<String,Object>> sMap = new HashMap<String,HashMap<String,Object>>();
				HashMap<String,Object> s_shareMap = new HashMap<String,Object>();
				s_shareMap.put("userid", submitUser.getId());
				s_shareMap.put("identity", submitUser.getIdentity());
				s_shareMap.put("identitymemo", submitUser.getIdentitymemo());
				s_shareMap.put("companyname", submitUser.getCompanyname());
				s_shareMap.put("userStandard", 1 - buyerdis);
				s_shareMap.put("sharepay", s_sharepay);
				s_shareMap.put("productnum", product.getProductnum());
				sMap.put(submitUser.getId(), s_shareMap);
				
				shareList.add(sMap);
				resultMap = setTmpMap(resultMap,submitUser.getId(),"1",s_sharepay,product.getProductnum());
			}
			else {
				//如果不是平台设置的。就需要取中间的那个机构的
				Public_set_user_standard aStandard = getProStandard(userStandard.getParentid(),"1",product.getProductid());
				
				//中间的肯定是代理。那么如果平台没有给代理设置。代理那部分，都归平台
				if (null == aStandard || "".equals(aStandard.getId())) {
					//有设置。利润按折扣给平台。
					Float buyerdis = userStandard.getBuyerdis();
					Float totalpay = product.getPrice()*product.getProductnum();
					Float j_sharepay = totalpay*buyerdis;
					Float s_sharepay = totalpay - j_sharepay;
					j_sharepay = (float)(Math.round(j_sharepay*100))/100;//输出小数点2位
					s_sharepay = (float)(Math.round(s_sharepay*100))/100;//输出小数点2位
//					int j_sharepay_int = Math.round(j_sharepay);
//					int a_sharepay_int = Math.round(totalpay) - j_sharepay_int;
					HashMap<String,Object> j_shareMap = new HashMap<String,Object>();
					j_shareMap.put("userid", jUser.getId());
					j_shareMap.put("identity", jUser.getIdentity());
					j_shareMap.put("identitymemo", jUser.getIdentitymemo());
					j_shareMap.put("companyname", jUser.getCompanyname());
					j_shareMap.put("userStandard", buyerdis);
					j_shareMap.put("sharepay", j_sharepay);
					j_shareMap.put("productnum", product.getProductnum());
					jMap.put("1", j_shareMap);
					
					shareList.add(jMap);
					
					resultMap = setTmpMap(resultMap,"1","1",j_sharepay,product.getProductnum());
					//处理提交机构的
					HashMap<String,HashMap<String,Object>> sMap = new HashMap<String,HashMap<String,Object>>();
					HashMap<String,Object> s_shareMap = new HashMap<String,Object>();
					s_shareMap.put("userid", submitUser.getId());
					s_shareMap.put("identity", submitUser.getIdentity());
					s_shareMap.put("identitymemo", submitUser.getIdentitymemo());
					s_shareMap.put("companyname", submitUser.getCompanyname());
					s_shareMap.put("userStandard", 1 - buyerdis);
					s_shareMap.put("sharepay", s_sharepay);
					s_shareMap.put("productnum", product.getProductnum());
					sMap.put(submitUser.getId(), s_shareMap);
					
					shareList.add(sMap);
					resultMap = setTmpMap(resultMap,submitUser.getId(),"1",s_sharepay,product.getProductnum());
				}
				else {
					//如果有设置。就计算三方的分润
					//1、首先计算平台的。
					Float jBuyerdis = aStandard.getBuyerdis();
					Float totalpay = product.getPrice()*product.getProductnum();
					Float j_sharepay = totalpay*jBuyerdis;
					
					//2、计算店的。
					Float sBuyerdis = 1-userStandard.getBuyerdis();
					sBuyerdis = (float)(Math.round(sBuyerdis*100))/100;//输出小数点2位
					Float s_sharepay = totalpay*sBuyerdis;
					
					//3、剩余就是代理的
					Float a_sharepay = totalpay - j_sharepay - s_sharepay;
					
					j_sharepay = (float)(Math.round(j_sharepay*100))/100;//输出小数点2位
					s_sharepay = (float)(Math.round(s_sharepay*100))/100;//输出小数点2位
					a_sharepay = (float)(Math.round(a_sharepay*100))/100;//输出小数点2位
					
					//写入平台
					HashMap<String,Object> j_shareMap = new HashMap<String,Object>();
					j_shareMap.put("userid", jUser.getId());
					j_shareMap.put("identity", jUser.getIdentity());
					j_shareMap.put("identitymemo", jUser.getIdentitymemo());
					j_shareMap.put("companyname", jUser.getCompanyname());
					j_shareMap.put("userStandard", jBuyerdis);
					j_shareMap.put("sharepay", j_sharepay);
					j_shareMap.put("productnum", product.getProductnum());
					jMap.put("1", j_shareMap);
					
					shareList.add(jMap);
					resultMap = setTmpMap(resultMap,"1","1",j_sharepay,product.getProductnum());
					
					//处理提交机构的
					HashMap<String,HashMap<String,Object>> sMap = new HashMap<String,HashMap<String,Object>>();
					HashMap<String,Object> s_shareMap = new HashMap<String,Object>();
					s_shareMap.put("userid", submitUser.getId());
					s_shareMap.put("identity", submitUser.getIdentity());
					s_shareMap.put("identitymemo", submitUser.getIdentitymemo());
					s_shareMap.put("companyname", submitUser.getCompanyname());
					s_shareMap.put("userStandard", sBuyerdis);
					s_shareMap.put("sharepay", s_sharepay);
					s_shareMap.put("productnum", product.getProductnum());
					sMap.put(submitUser.getId(), s_shareMap);
					
					shareList.add(sMap);
					
					resultMap = setTmpMap(resultMap,submitUser.getId(),aStandard.getUserid(),s_sharepay,product.getProductnum());
					
					//处理代理
					Public_user aUser = userDao.get(aStandard.getUserid());
					HashMap<String,HashMap<String,Object>> aMap = new HashMap<String,HashMap<String,Object>>();
					HashMap<String,Object> a_shareMap = new HashMap<String,Object>();
					a_shareMap.put("userid", aUser.getId());
					a_shareMap.put("identity", aUser.getIdentity());
					a_shareMap.put("identitymemo", aUser.getIdentitymemo());
					a_shareMap.put("companyname", aUser.getCompanyname());
					a_shareMap.put("userStandard", aStandard.getBuyerdis());
					a_shareMap.put("sharepay", a_sharepay);
					a_shareMap.put("productnum", product.getProductnum());
					aMap.put(aUser.getId(), a_shareMap);
					
					shareList.add(aMap);
					
					resultMap = setTmpMap(resultMap,aUser.getId(),"1",a_sharepay,product.getProductnum());
				}
			}
			
			//将单个利润分配json，存入订单商品
			String json = JSON.toJSONString(shareList);
			product.setSharekey(json);
			
			String shareValue = "";
			for (HashMap<String, HashMap<String, Object>> tmpMap : shareList) {
				for (Map.Entry<String, HashMap<String,Object>> entry : tmpMap.entrySet()) {
					HashMap<String,Object> map =  entry.getValue();
					shareValue += "[" + map.get("companyname") + "] 折扣 [" + map.get("userStandard") + "] 数量 [" + map.get("productnum") + "] 分润 [" + map.get("sharepay") + "].";
				}
			}
			product.setSharevalue(shareValue);
			orderProductDao.update(product);
			
		}
		
		//获取订单商品的id集合
		StringBuilder sb = new StringBuilder();  
	    if (proList != null && proList.size() > 0) {  
	        for (int i = 0; i < proList.size(); i++) {  
	            if (i < proList.size() - 1) {  
	                sb.append(proList.get(i).getId() + ",");
	            } else {  
	                sb.append(proList.get(i).getId());  
	            }  
	        }  
	    }  
		
		//接下来该写入sharebill表和bank表
		//处理bank
		for (Map.Entry<String, HashMap<String,Object>> entry : resultMap.entrySet()) {
		    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
		    String userid = entry.getKey();
		    HashMap<String,Object> tmpMap = entry.getValue();
		    String parentid = tmpMap.get("parentid").toString();
		    String total = tmpMap.get("total").toString();
		    String number = tmpMap.get("number").toString();
		    String username = tmpMap.get("username").toString();
		    
//		    在第三方回调时要增加
//			1、平台收入总计、平台售额累计
//			2、代理售额累计
//			3、店售额累计
//			
//			在分润时，要增加
//			1、平台可提现帐户
//			2、代理收入总计、代理可提现帐户
//			3、店的平台售额可提现帐户
		    
		    //获取bank
		    Public_user_bank bank = getUserBank(userid,parentid);
		    //判断是否是平台。如果是平台，增加收入总计
		    if ("1".equals(userid)) {
		    	Float income = bank.getIncomebank() + Float.valueOf(total);
		    	income = (float)(Math.round(income*100))/100;//输出小数点2位
			    //平台售额累计
			    bank.setIncomebank(income);
		    }
		    Float sellbank = bank.getSellbank() + Float.valueOf(total);
		    sellbank = (float)(Math.round(sellbank*100))/100;//输出小数点2位
		    //平台售额累计
		    bank.setSellbank(sellbank);
		    
		    userBankDao.update(bank);
		    
		    //处理sharebill
		    Share_bill sBill = new Share_bill();
		    sBill.setId(UUID.randomUUID().toString());
		    sBill.setOrderid(order.getId());
		    sBill.setOrdernumber(order.getOrdernumber());
		    sBill.setBankid(bank.getId());
		    sBill.setUserid(userid);
		    sBill.setUsername(username);
			sBill.setOrderproductids(sb.toString());
			sBill.setSharepay(Float.valueOf(total));
			sBill.setSharenumber(Integer.valueOf(number));
			sBill.setSharetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
			sBill.setShareovertime("");
			sBill.setSharestate(0);
			sBill.setRemarks("");
			sBill.setSubmitname(submitUser.getCompanyname());
			
			shareBillDao.save(sBill);
		}
		
		//更改订单状态
		order.setOrderstatus(1);
		order.setOrderstatusmemo("待发货");
		order.setIsshare(0);
		order.setIsshareover(0);
		orderDao.update(order);
		
		//更改第三方支付交易流水
		bill.setStatus(1); //成功
		bill.setTrantype(3);
		bill.setTrantypetxt("售额(全款)");
		bill.setBanktime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		bill = incomeBillDao.update(bill);
		
		//添加消息
		int messagetype = 1;	//业务消息
		String messagetxt = "由机构["+bill.getU_company()+"]提交的普通会员["+bill.getU_username()+"]订单["+order.getOrdernumber()+"]已完成支付，并经过第三方支付机构返回成功结果，金额为："+order.getOrdertotal();
		createMsg(submitUser.getId(), submitUser.getCompanyname(),"1",bill.getP_company(), messagetype, messagetxt,order.getId());
		
		return 1;
	}
	
	@Override
	public boolean onOrderShare(String orderid) {
		String sql = "select * from Share_bill where orderid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(orderid);
		
		List<Share_bill> shareBillList = shareBillDao.search(sql, values);
		
		if (null == shareBillList || shareBillList.size() == 0) {
			return true;
		}
		
		
		
		
		
		for (Share_bill bill : shareBillList) {
			Public_user_bank uBank = userBankDao.get(bill.getBankid());
			Float sharepay = bill.getSharepay();
			
//			uBank.
		}
		return false;
	}

	/**
	 * 提现
	 * @param bill	交易流水
	 * @param identity 身份
	 * */
	@Transactional("txManager")
	@Override
	public synchronized int withdrawal(Spending_bill bill,Public_user user) {
		//判断上级机构的可提现账户金额是否充足
		Public_user_bank p_bank = getUserBank(bill.getParentid(),"");	//目前结构，代理的账户是唯一的
		if(bill.getAmount() > p_bank.getTakenbank()){
			return 0;
		}
		//交易流水账单
		bill = inserSpending_bill(bill, user);
		//平台账户
		Public_user_bank bank_PT = getUserBank("1", "1");
		//提现金额
		float amount = bill.getAmount();
		//平台账户变更
		bank_PT.setTakenbank(bank_PT.getTakenbank() - amount);		//冲减平台可提现账户
		bank_PT.setCostbank(bank_PT.getCostbank() + amount);		//增加平台支出总和
		if(!bill.getUserid().equals("1")){	//非平台账户
			//当前账户
			Public_user_bank bank = getUserBank(bill.getUserid(), bill.getParentid());
			if("A".equals(user.getIdentity())){
				//可提现账户-提现
				bank.setTakenbank(bank.getTakenbank() - amount);		//冲减可提现账户 - 当前操作账户
			}else if("C".equals(user.getIdentity())){
				//trantype——1：平台可提现账户提现，2：代理可提现账户提现，3：店平台售额提现，4：店奖励可提现账户提现
				if(bill.getTrantype() == 4){
					//奖励账户-提现
					bank.setBonusestakenbank(bank.getBonusestakenbank() - amount);		//冲减店奖励可提现账户
					//非直营店
					if(!"1".equals(bill.getParentid())){
						Public_user_bank bank_A = getUserBank(bill.getParentid(), "");	//代理账户
						bank_A.setTakenbank(bank_A.getTakenbank() - amount);	//冲减代理可提现账户
						bank_A.setCostbank(bank_A.getCostbank() + amount);		//增加代理支出总和
						//代理账户变更
						bank_A = userBankDao.update(bank_A);
					}
				}else if(bill.getTrantype() == 3){
					//平台售额-提现
					bank.setSelltakenbank(bank.getSelltakenbank() - amount);		//冲减店平台售额可提现账户
				}
			}
			//当前账户
			bank = userBankDao.update(bank);
		}
		
		//平台账户变更
		bank_PT = userBankDao.update(bank_PT);
/*			//更新流水表状态
			bill.setStatus(1);	//成功
			bill.setBanktime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
			bill = spendingBillDao.update(bill);
*/			
		//添加提现消息
		int messagetype = 1;	//业务消息
		String messagetxt = "【"+bill.getU_company()+"】进行了提现，提现金额为："+amount;
		createMsg(bill.getUserid(), bill.getU_company(),bill.getParentid(),bill.getP_company(), messagetype, messagetxt,bill.getId());
		
		return 1;
	}
	
	/**
	 * 支出账单流水
	 * @param bill
	 * @param user
	 * @return
	 * */
	private Spending_bill inserSpending_bill(Spending_bill bill,Public_user user){
		bill.setId(UUID.randomUUID().toString());
		bill.setBillno(BillNO.getBillNo());
		bill.setUserid(user.getId());
		bill.setU_username(user.getUsername());
		bill.setU_company(user.getCompanyname());
		Public_user p_user = userDao.get(bill.getParentid());
		bill.setParentid(bill.getParentid());
		bill.setP_username(p_user.getUsername());
		bill.setP_company(p_user.getCompanyname());
		bill.setAmount(bill.getAmount());
		bill.setCreatetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		bill.setTrantype(bill.getTrantype()); //1：平台可提现账户提现，2：代理可提现账户提现，3：店平台售额提现，4：店奖励可提现账户提现
		String[] TRANTYPE_TXT = {"","平台可提现账户提现","代理可提现账户提现","店平台售额提现","店奖励可提现账户提现"};
		bill.setTrantypetxt(TRANTYPE_TXT[bill.getTrantype()]);
		bill.setStatus(0);	//-1:失败，0：提交申请，1：成功
		bill = spendingBillDao.save(bill);
		return bill;
	}
	
	@Transactional("txManager")
	@Override
	public int setQuota(String userid,String parentid,int amount) {
		Public_user uuser = userDao.get(userid);	//
		Public_user puser = userDao.get(parentid);
		
		Public_user_bank bank = getUserBank(userid, parentid);
		float before_amount = bank.getQuotabank();
		float after_amount = bank.getQuotabank() + amount;
		bank.setQuotabank(bank.getQuotabank() + amount);	//配额累计
		bank.setHavebank(bank.getHavebank() + amount);		//增加可支配账户
		bank = userBankDao.update(bank);
		
		//添加配额-账单流水
		Quota_bill bill = new Quota_bill();
		bill.setId(UUID.randomUUID().toString());
		bill.setBillno(BillNO.getBillNo());
		bill.setParentid(parentid);
		bill.setP_username(puser.getUsername());
		bill.setP_company(puser.getCompanyname());
		bill.setUserid(userid);
		bill.setU_username(uuser.getUsername());
		bill.setU_company(uuser.getCompanyname());
		bill.setAmount(amount);
		bill.setBefore_amount((int)before_amount);	//配额前
		bill.setAfter_amount((int)after_amount);	//配额后
		bill.setCreatetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		bill = quotaBillDao.save(bill);

		//业务消息
		int messagetype = 1;	//业务消息
		String messagetxt = "尊敬的客户您好，【"+puser.getCompanyname()+"】给您设置了配额，金额："+amount;
		createMsg(puser.getId(), puser.getUsername(), uuser.getId(), uuser.getUsername(), messagetype, messagetxt,"");
		if(bank != null && bill != null){
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
		//金额验证
		if(bank.getBonusestakenbank() > amount){
			bank.setBonusestakenbank(bank.getBonusestakenbank() - amount);	//冲减奖励可提现账户
			//
			if(ratio != null){
				if(ratio.getBonuses_ratio() > 0){
					float _amount = amount * ratio.getBonuses_ratio();
					bank.setHavebank(bank.getHavebank() + _amount);	//增加可支配账户
				}else{
					bank.setHavebank(bank.getHavebank() + amount);	//增加可支配账户
				}
			}else{
				bank.setHavebank(bank.getHavebank() + amount);	//增加可支配账户
			}
			
			bank = userBankDao.update(bank);
			//日志
			Public_log log = saveLog(userid, parentid, "bonuses_ratio", "奖励转贷款", amount,"");
			//业务消息
			//还未添加
			if(bank != null && log != null)
				return 1;	//成功
		}else{
			return -1;	//金额不足
		}
		
		return 0;	//失败
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
	 * 添加日志
	 * @param userid
	 * @param parentid
	 * @param logtype 操作类型
	 * @param logmemo 日志内容描述
	 * @param amount 金额
	 * @param lognum 
	 * @return
	 * */
	private Public_log saveLog(String userid,String parentid,String logtype,String logmemo,float amount,String lognum){
		Public_log log = new Public_log();
		log.setId(UUID.randomUUID().toString());
		log.setUserid(userid);	//主操作人
		log.setTouserid(parentid);			//被操作人
		log.setLogtype(logtype);	//操作类型
		log.setLogmemo(logmemo);
		log.setLogtime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		log.setLognum(lognum);
		log.setLogpay(amount);	//金额
		
		return logDao.save(log);
	}
	
	/**
	 * 业务消息
	 * @param sendid 发送者
	 * @param sendname
	 * @param receiveid 接收者
	 * @param receivename
	 * @param messagetype 消息类型
	 * @param messagetxt 消息内容
	 * @param activeid 关联ID
	 * @return
	 * */
	private Public_message createMsg(String sendid,String sendname,String receiveid,String receivename,int messagetype,String messagetxt,String activeid){
		Public_message msg = new Public_message();
		msg.setId(UUID.randomUUID().toString());
		msg.setSendid(sendid);			//发送者
		msg.setSendname(sendname);
		msg.setReceiveid(receiveid);	//接收者
		msg.setReceivename(receivename);
		msg.setMessagetype(messagetype);
		msg.setMessagetxt(messagetxt);
		msg.setMessagetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		msg.setMessagestate(0);		//状态
		msg.setActiveid(activeid);
		return msgDao.save(msg);
	}
	
	/**
	 * 返利奖励明细表
	 * @param details
	 * @param order
	 * @param product
	 * @return
	 * */
	private Public_dis_details savePublicDisDetails(Public_dis_details details,Public_order order,Public_order_product product){
		Public_dis_details dis_details = new Public_dis_details();
		dis_details.setId(UUID.randomUUID().toString());
		dis_details.setDetailsnum(details.getDetailsnum()); 			//本次返利数量
		dis_details.setNextrebatesnum(details.getNextrebatesnum());	//下次返利数量
		dis_details.setDetailspay(details.getDetailspay());		//本次返利金额
		dis_details.setDetailstype(details.getDetailstype());	//类别 1:返利，2:奖励
		dis_details.setSizeid(product.getProductid());	//规格ID
		dis_details.setProductname(product.getProductname()); //商品名称
		dis_details.setOrderid(order.getId());
		dis_details.setOrdernumber(order.getOrdernumber());
		dis_details.setAid(order.getParentid());
		dis_details.setAcompanyname(order.getP_companyanme());
		dis_details.setUid(order.getUserid());
		dis_details.setUname(order.getU_username());
		dis_details.setUcompanyname(order.getU_companyname());
		dis_details.setTid(order.getTid());
		dis_details.setTname(order.getT_username());
		dis_details.setTcompanyname(order.getT_companyname());
		dis_details.setCreatetime(DateUtil.getNowTime("yyy-MM-dd HH:mm:ss"));			//创建时间
		return disDetailsDao.save(dis_details);
	}
	/*private Public_dis_details savePublicDisDetails(Public_dis_details details){
		Public_dis_details obj = new Public_dis_details();
		obj.setId(UUID.randomUUID().toString());
		obj.setAid(details.getAid());						//机构ID
		obj.setAcompanyname(details.getAcompanyname());		//机构名称
		obj.setUid(details.getUid());						//发起者ID
		obj.setUname(details.getUname());					//发起者姓名
		obj.setUcompanyname(details.getUcompanyname());		//发起者机构名称
		obj.setTid(details.getTid());						//推荐人ID
		obj.setTname(details.getTname());					//推荐人姓名
		obj.setTcompanyname(details.getTcompanyname());		//推荐人机构名称
		obj.setDetailstype(details.getDetailstype());		//类别 1:返利，2:奖励
		obj.setDetailsnum(details.getDetailsnum());			//返利数量
		obj.setDetailspay(details.getDetailspay());			//金额
		obj.setNextrebatesnum(details.getNextrebatesnum());	//下次返利数量
		obj.setDetailstxt(details.getDetailstxt());			//描述
		obj.setOrderid(details.getOrderid());				//订单ID
		obj.setSizeid(details.getSizeid());					//商品规格ID
		obj.setCreatetime(DateUtil.getNowTime("yyy-MM-dd HH:mm:ss"));			//创建时间
		return disDetailsDao.save(obj);
	}*/
	
	
	/**
	 * 查找账户奖励转货款标准
	 * @param userid
	 * @param parentid
	 * @return obj:null
	 * */
	@Override
	public Public_set_bonuses_ratio getBonusersRatio(String userid,String parentid){
		String sql = "SELECT * FROM public_set_bonuses_ratio WHERE userid = ? AND parentid = ?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		values.add(parentid);
		List<Public_set_bonuses_ratio> list = ratioDao.search(sql, values);
		return list.size() > 0 ? list.get(0) : null;
	}
	
	/**
	 * 发送短信日志
	 * */
	private void savePhoneCodeLog(String phonenumber,String sendCode,String sendType){

		//当前时间戳
		Long oldTime = System.currentTimeMillis();
		//将发送情况写入日志
		Public_phone_code_log codeLog = new Public_phone_code_log();
		codeLog.setId(UUID.randomUUID().toString());
		codeLog.setPhonenumber(phonenumber);
		codeLog.setSendcode(sendCode);
		codeLog.setSendtime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		codeLog.setSendtimestr(oldTime.toString());
		codeLog.setSendtype(sendType);	//类型
		codeLog.setIp("");
		codelogDao.save(codeLog);
	}
	
	/**
	 * 返利商品
	 * @param userid
	 * @param parentid
	 * @param sizeid
	 * @return
	 * */
	private Public_product_size_rebate getProductSizeRebate(String userid,String parentid,String sizeid){
		String sql = "SELECT * FROM public_product_size_rebate WHERE userid=? AND parentid=? AND sizeid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		values.add(parentid);
		values.add(sizeid);
		List<Public_product_size_rebate> list = rebateDao.search(sql, values);
		return list.size()>0 ? list.get(0) : null;
	}
	
	/**
	 * 获取商品的商品折扣
	 * @param userid
	 * @param parentid
	 * @param sizeid
	 * @return
	 * */
	private Public_set_user_standard getProStandard(String userid,String parentid,String sizeid){
		String sql = "SELECT * FROM public_set_user_standard WHERE userid=? AND parentid=? AND sizeid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(userid);
		values.add(parentid);
		values.add(sizeid);
		List<Public_set_user_standard> list = standardDao.search(sql,values);
		return list.size() > 0 ? list.get(0): new Public_set_user_standard();
	}
	
	/**
	 * 订单商品
	 * @param orderid
	 * @return
	 * */
	private List<Public_order_product> getOrderProducts(String orderid){
		String sql = "SELECT * FROM public_order_product WHERE orderid=?";
		List<Object> values = new ArrayList<Object>();
		values.add(orderid);
		return orderProductDao.search(sql, values);
	}
	
	//===============
	@Override
	public List<Map<String, Object>> getUserBankList(String parentid, String userid) {
		StringBuffer sb = new StringBuffer();
		sb.append("select k.*,u.companyname,u.identity from public_user_bank k ,public_user u where 1=1");
		List<Object> values = new ArrayList<Object>();
		
		if(null != userid && !"".equals(userid)){
			sb.append(" and k.userid = ?");
			values.add(userid);
			sb.append(" and k.parentid = u.id");
		}
		if(null != parentid && !"".equals(parentid)){
			sb.append(" and k.parentid = ?");
			values.add(parentid);
			sb.append(" and k.userid = u.id");
			//排除普通会员
			sb.append(" and u.identity != ?");
			values.add("Z");
			//排除平台
			sb.append(" and u.id != ?");
			values.add("1");
		}
		
		List<Map<String, Object>> list = userBankDao.searchForMap(sb.toString(),values);
		return list;
	}

	
}

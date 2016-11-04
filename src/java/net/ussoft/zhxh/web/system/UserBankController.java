package net.ussoft.zhxh.web.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Income_bill;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Public_phone_code_log;
import net.ussoft.zhxh.model.Public_set_bonuses_ratio;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Public_user_bank;
import net.ussoft.zhxh.model.Share_bill;
import net.ussoft.zhxh.model.Spending_bill;
import net.ussoft.zhxh.model.Transf_buy_bank_bill;
import net.ussoft.zhxh.pay.kq.ErrorCode;
import net.ussoft.zhxh.pay.kq.KqConfig;
import net.ussoft.zhxh.pay.kq.payment._99bill.www.apipay.services.BatchPayWS.BatchPayServiceLocator;
import net.ussoft.zhxh.pay.kq.payment.bill99.seashell.domain.dto.complatible.BankRequestBean;
import net.ussoft.zhxh.pay.kq.payment.bill99.seashell.domain.dto.complatible.BankResponseBean;
import net.ussoft.zhxh.pay.kq.payment.md5.MD5Util;
import net.ussoft.zhxh.service.IIncomeBillService;
import net.ussoft.zhxh.service.IPublicDisDetailsService;
import net.ussoft.zhxh.service.IPublicPhoneCodeLogService;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.service.IQuotaBillService;
import net.ussoft.zhxh.service.IShareBillService;
import net.ussoft.zhxh.service.ISpendingBillService;
import net.ussoft.zhxh.service.ITransfBuyBankBillService;
import net.ussoft.zhxh.util.BillNO;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;
import net.ussoft.zhxh.util.DateUtil;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;

/**
 * 机构利益处理active
 * @author wangf
 *
 */

@Controller
@RequestMapping("/userBank")
public class UserBankController extends BaseConstroller {
	
	@Resource
	private IPublicUserBankService userBankService;
	@Resource
	private IIncomeBillService incomeBillService;
	@Resource
	private IQuotaBillService quotaBillService;
	@Resource
	private ISpendingBillService spendingBillService;
	@Resource
	private IPublicDisDetailsService disDetailsService;
	@Resource
	private IPublicUserService userService;
	@Resource
	private IPublicPhoneCodeLogService codeLogService;
	@Resource
	private IShareBillService shareBillService;
	@Resource
	private ITransfBuyBankBillService transfService;
	
	/**
	 * 获取机构的资金帐户
	 * @param parentid
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/listUserBank",method=RequestMethod.POST)
	public void listUserBank(String parentid,String userid,String identity,String searchKey,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		List<Map<String,Object>> resultList = userBankService.getUserBankList(parentid,userid,identity,searchKey);
		map.put("total", resultList.size());
		map.put("data", resultList);
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 设置资金账户的状态-开启、冻结
	 * @param userid
	 * @param parentid
	 * @param state
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/multiple_update",method=RequestMethod.POST)
	public void multiple_update(String ids,String field,String value,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(ids == null || "".equals(ids) ){
			out.print("error");
			return;
		}
		String result = "success";
		int num = userBankService.multiple_update(ids, field, value);
		if(num > 0){
			out.print(result);
			return;
		}
		out.print("error");
	}
	
	
	/*---------------以下不确定要---------------*/
	
	/**
	 * 充值
	 * @param parentid
	 * @param amount
	 * @param trantype 交易类型
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/recharge",method=RequestMethod.POST)
	public void recharge(String parentid,float amount,int trantype,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(parentid == null || "".equals(parentid) || amount <=0){
			out.print("error");
			return;
		}
		
		//充值交易流水
		Income_bill bill = new Income_bill();
		bill.setId(UUID.randomUUID().toString());
		bill.setBillno(BillNO.getBillNo());	//流水号
//		bill.setOrderid(orderid);
		Public_user p_user = userService.getById(parentid);
		bill.setParentid(parentid);
		bill.setP_username(p_user.getUsername());
		bill.setP_company(p_user.getCompanyname());
		Public_user user = getSessionUser();
		bill.setUserid(user.getId());
		bill.setU_username(user.getUsername());
		bill.setU_company(user.getCompanyname());
		bill.setAccount_receivable(amount);		//应收款
//		bill.setAccount_real(amount);			//实收款
		bill.setCreatetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
//		bill.setPaytype(paytype);
		bill.setTrantype(trantype);	//交易类型——1：现金充值，2：货款充值，3：售额（全），4：售额（分期）
		String[] TRANTYPE_TXT = {"","现金充值","货款充值","售额（全款）","售额（分期）"};
		bill.setTrantypetxt(TRANTYPE_TXT[trantype]);
		bill.setStatus(0);	//状态：0失败，1成功
		
		Map<String, Object> map = new HashMap<String, Object>();
		bill = incomeBillService.insert(bill);
		if(bill != null){
			map.put("code", "1");
			map.put("data", bill);
		}else{
			map.put("code", 0);
		}
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 支付-跳转到第三方支付平台
	 * */
	@RequestMapping(value="/payment")
	public ModelAndView payment (String id, ModelMap modelMap) throws Exception {
		Income_bill bill = incomeBillService.getById(id);
		modelMap.put("bill", bill);
		return new ModelAndView("/view/order/bank/payment", modelMap);
	}

	/**
	 * 提现
	 * @param parentid
	 * @param amount
	 * @param trantype 交易类型
	 * @param sendcode 验证码
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/withdrawal",method=RequestMethod.POST)
	public void withdrawal(String objs,String sendcode,HttpServletRequest request,HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		//获取验证码session
		HashMap<String,Object> map_session = (HashMap<String,Object>) CommonUtils.getSessionAttribute(request, Constants.CODE_SESSION);
		if(map_session == null || sendcode == null){
			out.print("codeerror");
			return;
		}
		if (!sendcode.equals(map_session.get("sendCode").toString())) {
			out.print("codeerror");
			return;
		}
		if ("".equals(objs) || objs == null) {
			out.print("error");
			return;
		}
		Map<String,String> row = (Map<String,String>)JSON.parse(objs);
		Spending_bill bill = new Spending_bill();
		BeanUtils.populate(bill, row);
		
		if(bill.getParentid() == null || "".equals(bill.getParentid()) || bill.getAmount() <=0){
			out.print("error");
			return;
		}
		
		Public_user user = getSessionUser();
		Public_user_bank bank = userBankService.getUserBank(user.getId(),bill.getParentid());
		int isCheckAmount = checkAmount(bill, bank);
		if(isCheckAmount == 0){
			out.print("3"); //可提现账户余额不足
			return;
		}
			
		if(bank.getBankstate() == 0){
			out.print("2"); //账户已被冻结
			return;
		}
		
		//-1:失败，0:上级机构余额不足，1：成功
		int num = userBankService.withdrawal(bill, user);
		if(num == 1){
			pay2bank(bill); //向快钱发起请求
		}
		out.print(num);
	}
	
	/**
	 * 判断账户余额 是否充足
	 * @return 1:充足，0:余额不足
	 * */
	public int checkAmount(Spending_bill bill,Public_user_bank bank){
		//1：平台可提现账户提现，2：代理可提现账户提现，3：店平台售额提现，4：店奖励可提现账户提现
		if(bill.getTrantype() == 1){
			if(bill.getAmount() > bank.getTakenbank()){
				return 0;
			}
		}else if(bill.getTrantype() == 2){
			if(bill.getAmount() > bank.getTakenbank()){
				return 0;
			}
		}else if(bill.getTrantype() == 3){
			if(bill.getAmount() > bank.getSelltakenbank()){
				return 0;
			}
		}else if(bill.getTrantype() == 4){
			if(bill.getAmount() > bank.getBonusestakenbank()){
				return 0;
			}
		}
		return 1;
	}
	
	/**
	 * 提现 - 快钱提现
	 * @param bill
	 * @throws Exception
	 */
	public void pay2bank(Spending_bill bill) throws Exception{
		//客户编号所对应的密钥。。在账户邮箱中获取
		String key = KqConfig.pay2bank_key;	//"J8A4CKE7H3HE8NUZ";
		//城市,中文字符 主要只需要城市名，不需要省份名。也不要带"市""自治区（县）"等
		String province_city = bill.getProvince_city();
		//银行名称 请填写银行的标准名,详见接口文档
		String bankName = bill.getBankName();
		//银行卡开户行的名称
		String  kaihuhang = bill.getKaihuhang();
		//收款人姓名,收款人的姓名，必须与银行卡账户名相同
		String creditName = bill.getCreditName();
		//银行卡号  
		String bankCardNumber = bill.getBankCardNumber();
		//交易金额  整数或小数  小数为两位以内  但小数点的最后一位不能为0 如：0.10不行。单位为人民币元  
		String amount = CommonUtils.subZeroAndDot(String.valueOf(bill.getAmount())); 
		//交易备注
		String description = bill.getRemarks();    
		//订单号
		String orderId = bill.getBillno();	//"p" + new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
		//组合字符串。。必须按照此顺序组串
		String macVal= bankCardNumber + amount + orderId + key;
		String mac = MD5Util.md5Hex(macVal.getBytes("gb2312")).toUpperCase();

		BankRequestBean requestBean = new BankRequestBean();
		requestBean.setProvince_city(province_city);
		requestBean.setBankName(bankName);
		requestBean.setKaihuhang(kaihuhang);
		requestBean.setCreditName(creditName);
		requestBean.setBankCardNumber(bankCardNumber);
		requestBean.setAmount(Double.parseDouble(amount));
		requestBean.setDescription(description);
		requestBean.setOrderId(orderId);
		requestBean.setMac(mac);
		BankRequestBean[] queryArray = new BankRequestBean[1];
		queryArray[0] = requestBean;

		String merchant_id = KqConfig.merchant_id;	//10012138842
		String merchant_ip = KqConfig.merchant_ip;	//121.42.209.154
		BatchPayServiceLocator locator = new BatchPayServiceLocator();
		BankResponseBean[] responseBean = new BankResponseBean[1];
		responseBean = locator.getBatchPayWS().bankPay(queryArray,merchant_id,merchant_ip);
		
		bill.setDealId(responseBean[0].getDealId()); 				//块钱交易号
		bill.setDealCharge(responseBean[0].getDealCharge());		//块钱手续费
		bill.setDebitCharge(responseBean[0].getDebitCharge());		//付款方费用
		bill.setCreditCharge(responseBean[0].getCreditCharge());	//收款方费用
		boolean resultFlag = responseBean[0].isResultFlag();		//执行结果；true 代表成功，false 代表失败
		int result=0,status=0;
		if(resultFlag){
			result = 1;
			status = 1;
		}else{
			result = 0;
			status = -1;
		}
		bill.setResultFlag(result);
		String failureCause =responseBean[0].getFailureCause(); 
		bill.setFailureCause(failureCause+ "," +ErrorCode.getErrorCodeTxt(failureCause));	//失败原因代码
		
		bill.setBanktime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		bill.setStatus(status);	//（-1，失败，0：提交申请，1：成功）
		
		spendingBillService.update(bill);
	}
	
	/**
	 * 获取手机验证码
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/getCode",method=RequestMethod.POST)
	public void getCode(HttpServletRequest request,HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		Public_user user = getSessionUser();
		String sendCode = CommonUtils.getSix();
		String send_content = "验证码" + sendCode + "用于资金账户提现，请勿提供给任何人，以免造成账户资金损失。";
		String logType = "PAY2BANK";
//		SendSMS.sendMessage(user.getPhonenumber(), send_content);
		savePhoneCodeLog(user.getPhonenumber(), sendCode, logType, request);
		
		out.print(sendCode);
	}
	
	/**
	 * 验证码发送日志
	 * @param phonenumber
	 * @param sendCode
	 * @param sendType
	 * @param request
	 * */
	private void savePhoneCodeLog(String phonenumber,String sendCode,String sendType,HttpServletRequest request){
		//当前时间戳
		Long oldTime = System.currentTimeMillis();
		//s为原时间戳和当前时间戳中间相隔的分钟数
//		Long s = (System.currentTimeMillis() - oldTime) / (1000 * 60);
		CommonUtils.removeSessionAttribute(request, Constants.CODE_SESSION);
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("sendCode", sendCode);
		map.put("phonenumber", phonenumber);
		map.put("codetime", oldTime);
		CommonUtils.setSessionAttribute(request, Constants.CODE_SESSION, map);
		
		//将发送情况写入日志
		Public_phone_code_log codeLog = new Public_phone_code_log();
		codeLog.setId(UUID.randomUUID().toString());
		codeLog.setPhonenumber(phonenumber);
		codeLog.setSendcode(sendCode);
		codeLog.setSendtime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		codeLog.setSendtimestr(oldTime.toString());
		codeLog.setSendtype(sendType);	//类型
		codeLog.setIp(CommonUtils.getRemoteIp(request));
		codeLogService.insert(codeLog);
	}
	
	/**
	 * 设置配额
	 * @param userid
	 * @param amount
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/setQuota",method=RequestMethod.POST)
	public void setQuota(String userid,int amount,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(userid == null || "".equals(userid) || amount <=0){
			out.print("error");
			return;
		}
		Public_user user = getSessionUser();
		int num = userBankService.setQuota(userid, user.getId(), amount);
		if(num > 0){
			out.print("success");
			return;
		}
		out.print("error");
	}
	
	/**
	 * 获取转货款系数
	 * @param parentid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/getTransfCoef",method=RequestMethod.POST)
	public void getTransfCoef(String parentid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(parentid == null || "".equals(parentid)){
			out.print("error");
			return;
		}
		Public_user user = getSessionUser();
		Public_set_bonuses_ratio ratio = userBankService.getBonusersRatio(user.getId(), parentid);
		if(ratio != null){
			out.print(ratio.getBonuses_ratio()+"");
			return;
		}
		out.print("error");
	}
	
	/**
	 * 奖励账户金额转货款
	 * @param parentid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/transfBuyBank",method=RequestMethod.POST)
	public void transfBuyBank(String parentid,float amount,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(parentid == null || "".equals(parentid) || amount <= 0){
			out.print("error");
			return;
		}
		Public_user user = getSessionUser();
		int num = userBankService.transfBuyBank(user.getId(), parentid, amount);
		if(num > 0){
			out.print("success");
			return;
		}
		out.print("error");
	}
	
	/**
	 * 收入总计-账单流水
	 * @param parentid
	 * @param userid
	 * @param trantype
	 * @param identity
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/incomeBillDetail",method=RequestMethod.POST)
	public void incomeBillDetail(String parentid,String userid,String trantype,String identity,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Map<String,Object>> p = new PageBean<Map<String,Object>>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("createtime");
		p.setOrderType("desc");
		List<String> trantypes = new ArrayList<String>();
		if(null != trantype && !"".equals(trantype)){
			String[] arr = trantype.split(",");
			Collections.addAll(trantypes, arr);
		}
		p = incomeBillService.list(userid, parentid, trantypes, identity, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 支出总计-账单流水
	 * @param parentid
	 * @param userid
	 * @param trantype
	 * @param identity
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/spendingBillDetail",method=RequestMethod.POST)
	public void spendingBillDetail(String parentid,String userid,String trantype,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Map<String,Object>> p = new PageBean<Map<String,Object>>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("createtime");
		p.setOrderType("desc");
		List<String> trantypes = new ArrayList<String>();
		if(null != trantype && !"".equals(trantype)){
			String[] arr = trantype.split(",");
			Collections.addAll(trantypes, arr);
		}
		p = spendingBillService.list(userid, parentid, trantypes, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 配额-账单流水
	 * @param parentid
	 * @param userid
	 * @param trantype
	 * @param identity
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/quotaBillDetail",method=RequestMethod.POST)
	public void quotaBillDetail(String parentid,String userid,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Map<String,Object>> p = new PageBean<Map<String,Object>>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("createtime");
		p.setOrderType("desc");
		p = quotaBillService.list(userid, parentid, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 返利、奖励-账单流水
	 * @param parentid
	 * @param userid
	 * @param detailstype 1:返利,2:奖励
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/rebateRewardBill",method=RequestMethod.POST)
	public void rebateRewardBill(String parentid,String userid,int detailstype,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Map<String,Object>> p = new PageBean<Map<String,Object>>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("createtime");
		p.setOrderType("desc");

		p = disDetailsService.list(userid, parentid, detailstype, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 平台售额分润-账单流水
	 * @param userid
	 * @param status
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/shareBill",method=RequestMethod.POST)
	public void shareBill(String userid,String status,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Share_bill> p = new PageBean<Share_bill>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("sharetime");
		p.setOrderType("desc");

		Map<String, Object> values = new LinkedHashMap<String, Object>();
		values.put("userid= ", userid);
		if(null != status && !"".equals(status)){
			values.put("sharestate= ", status);
		}
		
		p = shareBillService.list(values, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 平台售额分润-账单流水-明细
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/shareBillDetails",method=RequestMethod.POST)
	public void shareBillDetails(String userid,String orderproductids,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		List<Public_order_product> list = shareBillService.orderProlist(orderproductids);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("data", list);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 奖励转货款-账单流水
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/transfBill",method=RequestMethod.POST)
	public void transfBill(String userid, int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Transf_buy_bank_bill> p = new PageBean<Transf_buy_bank_bill>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("createtime");
		p.setOrderType("desc");
		Map<String, Object> values = new LinkedHashMap<String, Object>();
		values.put("userid= ", userid);
		p = transfService.list(values, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
}

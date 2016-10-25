package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="income_bill")
public class Income_bill {

	private String id;
	private String billno;				//流水单号
	private String orderid;				//订单id
	private String parentid;			//上级id
	private String p_username;			//姓名
	private String p_company;			//机构名称
	private String userid;				//用户id
	private String u_username;
	private String u_company;			//机构名称
	private Float account_receivable;	//应收款
	private Float account_real;			//实收款
	private Float downpayment;			//首付款（分期）
	private Float downpayment_ratio;	//首付比例
	private Float loan_amount;			//贷款额
	private Float loan_amount_real;		//贷款实收额
	private String createtime;			//创建时间
	private String banktime;			//贷款实收额
	private String stagesbanktime;		//支付回执时间
	private String paytype;				//支付类型（客户）
	private Integer trantype;			//交易类型
	private String trantypetxt;			//交易类型文本
	private Integer status;				//状态
	private String remarks;				//交易描述
	
	private String bindCard;	// 已绑短卡号,信用卡快捷支付绑定卡信息后返回前六后四位信用卡号
	private String bindMobile;	// 已绑短手机尾号,信用卡快捷支付绑定卡信息后返回前三位后四位手机号码
	private Float payAmount;	// 该金额代表商户快钱账户最终收到的金额
	private Float fee;			// 快钱收取商户的手续费，单位为分
	private String dealId;		// 快钱交易号
	private String bankDealId;	// 银行交易号
	private String dealTime;	// 快钱交易时间
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBillno() {
		return billno;
	}
	public void setBillno(String billno) {
		this.billno = billno;
	}
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public Float getAccount_receivable() {
		return account_receivable;
	}
	public void setAccount_receivable(Float account_receivable) {
		this.account_receivable = account_receivable;
	}
	public Float getAccount_real() {
		return account_real;
	}
	public void setAccount_real(Float account_real) {
		this.account_real = account_real;
	}
	public Float getDownpayment() {
		return downpayment;
	}
	public void setDownpayment(Float downpayment) {
		this.downpayment = downpayment;
	}
	public Float getDownpayment_ratio() {
		return downpayment_ratio;
	}
	public void setDownpayment_ratio(Float downpayment_ratio) {
		this.downpayment_ratio = downpayment_ratio;
	}
	public Float getLoan_amount() {
		return loan_amount;
	}
	public void setLoan_amount(Float loan_amount) {
		this.loan_amount = loan_amount;
	}
	public Float getLoan_amount_real() {
		return loan_amount_real;
	}
	public void setLoan_amount_real(Float loan_amount_real) {
		this.loan_amount_real = loan_amount_real;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getBanktime() {
		return banktime;
	}
	public void setBanktime(String banktime) {
		this.banktime = banktime;
	}
	public String getStagesbanktime() {
		return stagesbanktime;
	}
	public void setStagesbanktime(String stagesbanktime) {
		this.stagesbanktime = stagesbanktime;
	}
	public String getPaytype() {
		return paytype;
	}
	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}
	public Integer getTrantype() {
		return trantype;
	}
	public void setTrantype(Integer trantype) {
		this.trantype = trantype;
	}
	public String getTrantypetxt() {
		return trantypetxt;
	}
	public void setTrantypetxt(String trantypetxt) {
		this.trantypetxt = trantypetxt;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getP_username() {
		return p_username;
	}
	public void setP_username(String p_username) {
		this.p_username = p_username;
	}
	public String getU_username() {
		return u_username;
	}
	public void setU_username(String u_username) {
		this.u_username = u_username;
	}
	public String getP_company() {
		return p_company;
	}
	public void setP_company(String p_company) {
		this.p_company = p_company;
	}
	public String getU_company() {
		return u_company;
	}
	public void setU_company(String u_company) {
		this.u_company = u_company;
	}
	public String getBindCard() {
		return bindCard;
	}
	public void setBindCard(String bindCard) {
		this.bindCard = bindCard;
	}
	public String getBindMobile() {
		return bindMobile;
	}
	public void setBindMobile(String bindMobile) {
		this.bindMobile = bindMobile;
	}
	public Float getPayAmount() {
		return payAmount;
	}
	public void setPayAmount(Float payAmount) {
		this.payAmount = payAmount;
	}
	public Float getFee() {
		return fee;
	}
	public void setFee(Float fee) {
		this.fee = fee;
	}
	public String getDealId() {
		return dealId;
	}
	public void setDealId(String dealId) {
		this.dealId = dealId;
	}
	public String getBankDealId() {
		return bankDealId;
	}
	public void setBankDealId(String bankDealId) {
		this.bankDealId = bankDealId;
	}
	public String getDealTime() {
		return dealTime;
	}
	public void setDealTime(String dealTime) {
		this.dealTime = dealTime;
	}
	
}

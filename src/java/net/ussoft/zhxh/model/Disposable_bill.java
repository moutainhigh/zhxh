package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="disposable_bill")
public class Disposable_bill {

	private String id;
	private String billno;
	private String orderid;
	private String orderno;
	private String userid;
	private String parentid;
	private double amount;	//金额
	private double balance;	//余额-暂时不用
	private int trantype;	//交易类型 //类型	1：配额，2：返利，3：奖励转货款，4：退款（取消订单），5：货款（订单），6：平台售额，7：充值，8：提现
	private String trantype_txt;	//类型文本
	private String createtime;	//创建日期
	
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
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public int getTrantype() {
		return trantype;
	}
	public void setTrantype(int trantype) {
		this.trantype = trantype;
	}
	
	public String getTrantype_txt() {
		return trantype_txt;
	}
	public void setTrantype_txt(String trantype_txt) {
		this.trantype_txt = trantype_txt;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	
}

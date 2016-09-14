package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_bankget_list")
public class Public_trade_bill {

	private String id;
	private String billid;					//流水单号
	private String orderid;				 	//订单id
	private String parentid;				//上级id
	private String userid;					//用户id	
	private Float amount;					//金额	
	private String createtime;				//创建时间	
	private String banktime;				//支付回执时间	
	private String paytype;					//支付类型	
	private Integer trantype;				//交易类型	
	private String trantypetxt;				//交易类型文本	
	private Integer status;					//状态
	private String billmemo	;				//交易描述
	
	public Public_trade_bill() {
		this.setAmount(0f);
		this.setTrantype(0);
		this.setStatus(0);
	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBillid() {
		return billid;
	}
	public void setBillid(String billid) {
		this.billid = billid;
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
	public Float getAmount() {
		return amount;
	}
	public void setAmount(Float amount) {
		this.amount = amount;
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
	public String getBillmemo() {
		return billmemo;
	}
	public void setBillmemo(String billmemo) {
		this.billmemo = billmemo;
	}
	
	
}

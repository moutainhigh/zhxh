package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="share_bill")
public class Share_bill {
	
	private String id;
	private String orderid;			//订单id
	private String bankid;			//资金账户id
	private String userid;			//账户id
	private Double sharepay;		//分润金额
	private Integer sharenumber;		//分润数量
	private String sharetime;		//记账时间
	private String shareovertime;	//到帐时间
	private Integer sharestate;		//状态
	private String remarks;			//备注
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public String getBankid() {
		return bankid;
	}
	public void setBankid(String bankid) {
		this.bankid = bankid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public Double getSharepay() {
		return sharepay;
	}
	public void setSharepay(Double sharepay) {
		this.sharepay = sharepay;
	}
	public Integer getSharenumber() {
		return sharenumber;
	}
	public void setSharenumber(Integer sharenumber) {
		this.sharenumber = sharenumber;
	}
	public String getSharetime() {
		return sharetime;
	}
	public void setSharetime(String sharetime) {
		this.sharetime = sharetime;
	}
	public String getShareovertime() {
		return shareovertime;
	}
	public void setShareovertime(String shareovertime) {
		this.shareovertime = shareovertime;
	}
	public Integer getSharestate() {
		return sharestate;
	}
	public void setSharestate(Integer sharestate) {
		this.sharestate = sharestate;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	
}

package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_order_return")
public class Public_order_return {

	private String id;
	private String orderid;
	private String userid;
	private String returnproductid;
	private Integer returnstatus;
	private String returnstatusmemo;
	private String memo;
	
	
	
	
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
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getReturnproductid() {
		return returnproductid;
	}
	public void setReturnproductid(String returnproductid) {
		this.returnproductid = returnproductid;
	}
	public Integer getReturnstatus() {
		return returnstatus;
	}
	public void setReturnstatus(Integer returnstatus) {
		this.returnstatus = returnstatus;
	}
	public String getReturnstatusmemo() {
		return returnstatusmemo;
	}
	public void setReturnstatusmemo(String returnstatusmemo) {
		this.returnstatusmemo = returnstatusmemo;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	
	
}

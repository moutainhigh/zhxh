package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_order")
public class Public_order {

	private String id;
	private String userid;
	private String ordernumber;
	private String ordertime;
	private Float ordertotal;
	private Integer orderstatus;
	private String orderstatusmemo;
	
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getOrdernumber() {
		return ordernumber;
	}
	public void setOrdernumber(String ordernumber) {
		this.ordernumber = ordernumber;
	}
	public String getOrdertime() {
		return ordertime;
	}
	public void setOrdertime(String ordertime) {
		this.ordertime = ordertime;
	}
	public Float getOrdertotal() {
		return ordertotal;
	}
	public void setOrdertotal(Float ordertotal) {
		this.ordertotal = ordertotal;
	}
	public Integer getOrderstatus() {
		return orderstatus;
	}
	public void setOrderstatus(Integer orderstatus) {
		this.orderstatus = orderstatus;
	}
	public String getOrderstatusmemo() {
		return orderstatusmemo;
	}
	public void setOrderstatusmemo(String orderstatusmemo) {
		this.orderstatusmemo = orderstatusmemo;
	}
	
	
}

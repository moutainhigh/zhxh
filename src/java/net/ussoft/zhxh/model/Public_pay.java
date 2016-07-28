package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_pay")
public class Public_pay {

	private String id;
	private String orderid;
	private String paytype;
	private String paybank;
	private Float paynum;
	private Integer paystatus;
	private String settype;
	private String setbank;
	private String paycreatetime;
	private String paytime;
	
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
	public String getPaytype() {
		return paytype;
	}
	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}
	public String getPaybank() {
		return paybank;
	}
	public void setPaybank(String paybank) {
		this.paybank = paybank;
	}
	public Float getPaynum() {
		return paynum;
	}
	public void setPaynum(Float paynum) {
		this.paynum = paynum;
	}
	public Integer getPaystatus() {
		return paystatus;
	}
	public void setPaystatus(Integer paystatus) {
		this.paystatus = paystatus;
	}
	public String getSettype() {
		return settype;
	}
	public void setSettype(String settype) {
		this.settype = settype;
	}
	public String getSetbank() {
		return setbank;
	}
	public void setSetbank(String setbank) {
		this.setbank = setbank;
	}
	public String getPaycreatetime() {
		return paycreatetime;
	}
	public void setPaycreatetime(String paycreatetime) {
		this.paycreatetime = paycreatetime;
	}
	public String getPaytime() {
		return paytime;
	}
	public void setPaytime(String paytime) {
		this.paytime = paytime;
	}
	
	
}

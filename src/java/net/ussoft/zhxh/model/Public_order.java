package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_order")
public class Public_order {

	private String id;
	private String parentid;
	private String userid;
	private String ordernumber;
	private String ordertime;
	private Float ordertotal;
	private Integer orderstatus;
	private String orderstatusmemo;
	private String identity;
	private String deliverynum;
	
	
	
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
	/**
	 * 订单发起机构上级id，用来获取订单
	 * @return
	 */
	public String getParentid() {
		return parentid;
	}
	/**
	 * 订单发起机构上级id，用来获取订单
	 * @param parentid
	 */
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	/**
	 * 订单发起机构身份标识，用来区分订单发起人身份，用来获取订单
	 * @return
	 */
	public String getIdentity() {
		return identity;
	}
	/**
	 * 订单发起机构身份标识，用来区分订单发起人身份，用来获取订单
	 * @param identity
	 */
	public void setIdentity(String identity) {
		this.identity = identity;
	}
	/**
	 * 快递单号
	 * @return
	 */
	public String getDeliverynum() {
		return deliverynum;
	}
	/**
	 * 快递单号
	 * @param deliverynum
	 */
	public void setDeliverynum(String deliverynum) {
		this.deliverynum = deliverynum;
	}
	
	
	
}

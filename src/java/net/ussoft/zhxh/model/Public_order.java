package net.ussoft.zhxh.model;

import java.util.List;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

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
	
	private String ordertype;
	
	private String u_username;	//临时字段-userid对应的username
	private String p_username;	//临时字段-parentid对应的username
	private List<Public_order_product> orderProList;
	
	
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
	
	@Transient
	public List<Public_order_product> getOrderProList() {
		return orderProList;
	}
	public void setOrderProList(List<Public_order_product> orderProList) {
		this.orderProList = orderProList;
	}
	public String getOrdertype() {
		return ordertype;
	}
	public void setOrdertype(String ordertype) {
		this.ordertype = ordertype;
	}
	@Transient
	public String getU_username() {
		return u_username;
	}
	public void setU_username(String u_username) {
		this.u_username = u_username;
	}
	@Transient
	public String getP_username() {
		return p_username;
	}
	public void setP_username(String p_username) {
		this.p_username = p_username;
	}
	
}

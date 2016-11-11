package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="rebate_reward_bill")
public class Rebate_reward_bill {

	private String id;
	private String billno;			//流水单号
	private String parentid;		//上级id
	private String userid;			//用户id
	private String orderid;			//订单ID
	private String order_no;		//订单编号
	private double amount;			//返利、奖励金额
	private String createtime;		//创建时间
	private int type;			//类型
	private String remarks;			//交易描述
	
	private String p_companyname;	//上级机构名称
	private String u_companyname;	//机构名称
	
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
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public String getOrder_no() {
		return order_no;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getP_companyname() {
		return p_companyname;
	}
	public void setP_companyname(String p_companyname) {
		this.p_companyname = p_companyname;
	}
	public String getU_companyname() {
		return u_companyname;
	}
	public void setU_companyname(String u_companyname) {
		this.u_companyname = u_companyname;
	}
	
}

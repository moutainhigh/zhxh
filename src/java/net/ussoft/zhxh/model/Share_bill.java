package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="share_bill")
public class Share_bill {
	
	private String id;
	private String orderid;			//订单id
	private String ordernumber;			//订单编号
	private String bankid;			//资金账户id
	private String userid;			//账户id
	private String username;		//分润机构名称
	private String orderproductids;	//订单商品id集合。用逗号分隔。表示当前机构在当前订单，参与分润的订单商品。
	private Float sharepay;		//分润金额
	private Integer sharenumber;	//分润数量
	private String sharetime;		//记账时间
	private String shareovertime;	//到帐时间
	private Integer sharestate;		//状态		0：等待分润  1：分润完成
	private String remarks;			//备注
	private String submitname;			//下单机构名称
	private String createtime;			//创建时间
	
	
	
	public Share_bill() {
		super();
	}
	
	public Share_bill(String id, String orderid, String ordernumber,String bankid, String userid, String username,String orderproductids, Float sharepay,
			Integer sharenumber, String sharetime, String shareovertime, Integer sharestate, String remarks,String submitname,String createtime) {
		super();
		this.id = id;
		this.orderid = orderid;
		this.ordernumber = ordernumber;
		this.bankid = bankid;
		this.userid = userid;
		this.username = username;
		this.orderproductids = orderproductids;
		this.sharepay = sharepay;
		this.sharenumber = sharenumber;
		this.sharetime = sharetime;
		this.shareovertime = shareovertime;
		this.sharestate = sharestate;
		this.remarks = remarks;
		this.submitname = submitname;
		this.createtime = createtime;
	}
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
	public String getOrdernumber() {
		return ordernumber;
	}
	public void setOrdernumber(String ordernumber) {
		this.ordernumber = ordernumber;
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
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Float getSharepay() {
		return sharepay;
	}

	public void setSharepay(Float sharepay) {
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
	public String getOrderproductids() {
		return orderproductids;
	}
	public void setOrderproductids(String orderproductids) {
		this.orderproductids = orderproductids;
	}

	public String getSubmitname() {
		return submitname;
	}

	public void setSubmitname(String submitname) {
		this.submitname = submitname;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	
	
}

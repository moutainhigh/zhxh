package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_dis_details")
public class Public_dis_details {

	private String id;
	private String aid;
	private String acompanyname;
	private String uid;
	private String uname;
	private String ucompanyname;
	private String tid;
	private String tname;
	private String tcompanyname;
	private Integer detailstype;
	private Integer detailsnum;
	private Float detailspay;
	private Integer nextrebatesnum;
	private String detailstxt;
	private String orderid;
	private String ordernumber;
	private String sizeid;
	private String productname;
	private String createtime;
	
	public Public_dis_details(String id) {
		this.setId(id);
	}
	
	public Public_dis_details() {
		this.setDetailsnum(0);
		this.setDetailstype(0);
		this.setDetailspay(0f);
		this.setNextrebatesnum(0);
	}
	
	
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public String getAcompanyname() {
		return acompanyname;
	}
	public void setAcompanyname(String acompanyname) {
		this.acompanyname = acompanyname;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUcompanyname() {
		return ucompanyname;
	}
	public void setUcompanyname(String ucompanyname) {
		this.ucompanyname = ucompanyname;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getTcompanyname() {
		return tcompanyname;
	}
	public void setTcompanyname(String tcompanyname) {
		this.tcompanyname = tcompanyname;
	}
	public Integer getDetailstype() {
		return detailstype;
	}
	public void setDetailstype(Integer detailstype) {
		this.detailstype = detailstype;
	}
	public Integer getDetailsnum() {
		return detailsnum;
	}
	public void setDetailsnum(Integer detailsnum) {
		this.detailsnum = detailsnum;
	}
	public Float getDetailspay() {
		return detailspay;
	}
	public void setDetailspay(Float detailspay) {
		this.detailspay = detailspay;
	}
	public Integer getNextrebatesnum() {
		return nextrebatesnum;
	}
	public void setNextrebatesnum(Integer nextrebatesnum) {
		this.nextrebatesnum = nextrebatesnum;
	}
	public String getDetailstxt() {
		return detailstxt;
	}
	public void setDetailstxt(String detailstxt) {
		this.detailstxt = detailstxt;
	}
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public String getSizeid() {
		return sizeid;
	}
	public void setSizeid(String sizeid) {
		this.sizeid = sizeid;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getOrdernumber() {
		return ordernumber;
	}

	public void setOrdernumber(String ordernumber) {
		this.ordernumber = ordernumber;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}
	
	
}

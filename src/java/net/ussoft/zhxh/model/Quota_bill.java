package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="quota_bill")
public class Quota_bill {

	private String id;
	private String billno;			//流水单号
	private String parentid;		//上级id
	private String p_username;
	private String p_company;
	private String userid;			//用户id
	private String u_username;
	private String u_company;
	private Integer amount;			//本次配额金额
	private Integer before_amount;	//配额前
	private Integer after_amount;	//配额后
	private String createtime;		//创建时间
	private String remarks;			//交易描述
	
	
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
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public Integer getBefore_amount() {
		return before_amount;
	}
	public void setBefore_amount(Integer before_amount) {
		this.before_amount = before_amount;
	}
	public Integer getAfter_amount() {
		return after_amount;
	}
	public void setAfter_amount(Integer after_amount) {
		this.after_amount = after_amount;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getP_username() {
		return p_username;
	}
	public void setP_username(String p_username) {
		this.p_username = p_username;
	}
	public String getP_company() {
		return p_company;
	}
	public void setP_company(String p_company) {
		this.p_company = p_company;
	}
	public String getU_username() {
		return u_username;
	}
	public void setU_username(String u_username) {
		this.u_username = u_username;
	}
	public String getU_company() {
		return u_company;
	}
	public void setU_company(String u_company) {
		this.u_company = u_company;
	}
	
	
}

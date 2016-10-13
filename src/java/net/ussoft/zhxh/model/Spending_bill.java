package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="spending_bill")
public class Spending_bill {

	private String id;
	private String billno;			//流水单号
	private String parentid;		//上级id
	private String p_username;
	private String p_company;
	private String userid;			//用户id
	private String u_username;
	private String u_company;
	private Float amount;			//金额
	private String createtime;		//创建时间
	private String banktime;		//支出回执时间
	private Integer trantype;		//交易类型
	private String trantypetxt;		//用户id
	private Integer status;			//状态
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
	public Float getAmount() {
		return amount;
	}
	public void setAmount(Float amount) {
		this.amount = amount;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getBanktime() {
		return banktime;
	}
	public void setBanktime(String banktime) {
		this.banktime = banktime;
	}
	
	public Integer getTrantype() {
		return trantype;
	}
	public void setTrantype(Integer trantype) {
		this.trantype = trantype;
	}
	public String getTrantypetxt() {
		return trantypetxt;
	}
	public void setTrantypetxt(String trantypetxt) {
		this.trantypetxt = trantypetxt;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
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

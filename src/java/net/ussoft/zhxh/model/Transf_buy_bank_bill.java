package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="transf_buy_bank_bill")
public class Transf_buy_bank_bill {
	private String id;
	private String billno;	//流水号
	private String userid;	//
	private String u_companyname;
	private String parentid;
	private String p_companyname;
	private double award_amount;	//奖励金额
	private double ratio; 			//转货款系数
	private double last_amount;		//货款金额
	private String createtime;
	
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
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getU_companyname() {
		return u_companyname;
	}
	public void setU_companyname(String u_companyname) {
		this.u_companyname = u_companyname;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getP_companyname() {
		return p_companyname;
	}
	public void setP_companyname(String p_companyname) {
		this.p_companyname = p_companyname;
	}
	public double getAward_amount() {
		return award_amount;
	}
	public void setAward_amount(double award_amount) {
		this.award_amount = award_amount;
	}
	public double getRatio() {
		return ratio;
	}
	public void setRatio(double ratio) {
		this.ratio = ratio;
	}
	public double getLast_amount() {
		return last_amount;
	}
	public void setLast_amount(double last_amount) {
		this.last_amount = last_amount;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	
	
}

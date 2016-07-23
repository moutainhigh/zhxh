package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_bankget_list")
public class Public_bankget_list {

	private String id;
	private String userid;
	private String bankgetcode;
	private String bankgettime;
	private String bankgetnum;
	
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
	public String getBankgetcode() {
		return bankgetcode;
	}
	public void setBankgetcode(String bankgetcode) {
		this.bankgetcode = bankgetcode;
	}
	public String getBankgettime() {
		return bankgettime;
	}
	public void setBankgettime(String bankgettime) {
		this.bankgettime = bankgettime;
	}
	public String getBankgetnum() {
		return bankgetnum;
	}
	public void setBankgetnum(String bankgetnum) {
		this.bankgetnum = bankgetnum;
	}
	
	
	
}

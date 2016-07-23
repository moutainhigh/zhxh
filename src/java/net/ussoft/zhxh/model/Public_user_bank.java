package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_user_bank")
public class Public_user_bank {

	private String id;
	private String userid;
	private Float banktotal;
	private Float bankget;
	private Integer nointonum;
	private Integer totalnum;
	
	
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
	public Float getBanktotal() {
		return banktotal;
	}
	public void setBanktotal(Float banktotal) {
		this.banktotal = banktotal;
	}
	public Float getBankget() {
		return bankget;
	}
	public void setBankget(Float bankget) {
		this.bankget = bankget;
	}
	public Integer getNointonum() {
		return nointonum;
	}
	public void setNointonum(Integer nointonum) {
		this.nointonum = nointonum;
	}
	public Integer getTotalnum() {
		return totalnum;
	}
	public void setTotalnum(Integer totalnum) {
		this.totalnum = totalnum;
	}
	
	
	
	
}

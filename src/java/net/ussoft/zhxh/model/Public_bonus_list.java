package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_bonus_list")
public class Public_bonus_list {

	private String id;
	private String userid;
	private String bonusdate;
	private Float bonusnum;
	private String bonusmemo;
	
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
	public String getBonusdate() {
		return bonusdate;
	}
	public void setBonusdate(String bonusdate) {
		this.bonusdate = bonusdate;
	}
	public Float getBonusnum() {
		return bonusnum;
	}
	public void setBonusnum(Float bonusnum) {
		this.bonusnum = bonusnum;
	}
	public String getBonusmemo() {
		return bonusmemo;
	}
	public void setBonusmemo(String bonusmemo) {
		this.bonusmemo = bonusmemo;
	}
	
	
}

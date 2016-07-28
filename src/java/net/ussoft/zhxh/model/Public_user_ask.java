package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_user_ask")
public class Public_user_ask {

	private String id;
	private String userid;
	private String username;
	private String asktime;
	private String askmemo;
	private Integer askstatus;
	
	
	
	
	
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
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getAsktime() {
		return asktime;
	}
	public void setAsktime(String asktime) {
		this.asktime = asktime;
	}
	public String getAskmemo() {
		return askmemo;
	}
	public void setAskmemo(String askmemo) {
		this.askmemo = askmemo;
	}
	public Integer getAskstatus() {
		return askstatus;
	}
	public void setAskstatus(Integer askstatus) {
		this.askstatus = askstatus;
	}
	
	
	
}

package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_user")
public class Public_user {

	private String id;
	private String usercode;
	private String username;
	private String phonenumber;
	private String userid;
	private String dianid;
	private String shidaiid;
	private String shengdaiid;
	private String tuijianid;
	private String tuijiansort;
	private Integer setreturn;
	private Integer isopen;
	private String password;
	private String openid1;
	private String openid2;
	
	
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsercode() {
		return usercode;
	}
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDianid() {
		return dianid;
	}
	public void setDianid(String dianid) {
		this.dianid = dianid;
	}
	public String getShidaiid() {
		return shidaiid;
	}
	public void setShidaiid(String shidaiid) {
		this.shidaiid = shidaiid;
	}
	public String getShengdaiid() {
		return shengdaiid;
	}
	public void setShengdaiid(String shengdaiid) {
		this.shengdaiid = shengdaiid;
	}
	public String getTuijianid() {
		return tuijianid;
	}
	public void setTuijianid(String tuijianid) {
		this.tuijianid = tuijianid;
	}
	public String getTuijiansort() {
		return tuijiansort;
	}
	public void setTuijiansort(String tuijiansort) {
		this.tuijiansort = tuijiansort;
	}
	public Integer getSetreturn() {
		return setreturn;
	}
	public void setSetreturn(Integer setreturn) {
		this.setreturn = setreturn;
	}
	public Integer getIsopen() {
		return isopen;
	}
	public void setIsopen(Integer isopen) {
		this.isopen = isopen;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getOpenid1() {
		return openid1;
	}
	public void setOpenid1(String openid1) {
		this.openid1 = openid1;
	}
	public String getOpenid2() {
		return openid2;
	}
	public void setOpenid2(String openid2) {
		this.openid2 = openid2;
	}
	
	
}

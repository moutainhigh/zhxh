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
	private String usermemo;
	private String dianid;
	private String shidaiid;
	private String shengdaiid;
	private String tuijianid;
	private String tuijianman;
	private String tuijiansort;
	private Integer setreturn;
	private Integer isopen;
	private String password;
	private String uid;
	private Integer sex;
	private String birthday;
	
	
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
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getTuijianman() {
		return tuijianman;
	}
	public void setTuijianman(String tuijianman) {
		this.tuijianman = tuijianman;
	}
	public String getUsermemo() {
		return usermemo;
	}
	public void setUsermemo(String usermemo) {
		this.usermemo = usermemo;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	
}

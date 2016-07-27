package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_user_openid")
public class Public_user_openid {

	private String id;
	private String parentid;
	private String openid;
	private String weixincode;
	private String tuijianid;
	private String tuijianman;
	private String tuijiansort;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public String getWeixincode() {
		return weixincode;
	}
	public void setWeixincode(String weixincode) {
		this.weixincode = weixincode;
	}
	public String getTuijianid() {
		return tuijianid;
	}
	public void setTuijianid(String tuijianid) {
		this.tuijianid = tuijianid;
	}
	public String getTuijianman() {
		return tuijianman;
	}
	public void setTuijianman(String tuijianman) {
		this.tuijianman = tuijianman;
	}
	public String getTuijiansort() {
		return tuijiansort;
	}
	public void setTuijiansort(String tuijiansort) {
		this.tuijiansort = tuijiansort;
	}
	
	
	
}

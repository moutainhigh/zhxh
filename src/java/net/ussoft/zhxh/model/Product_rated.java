package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="product_rated")
public class Product_rated {

	private String id;
	private String parentid;
	private String ratedmemo;
	private String ratedtime;
	private String userid;
	private String username;
	private Integer isshow;
	
	
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
	public String getRatedmemo() {
		return ratedmemo;
	}
	public void setRatedmemo(String ratedmemo) {
		this.ratedmemo = ratedmemo;
	}
	public String getRatedtime() {
		return ratedtime;
	}
	public void setRatedtime(String ratedtime) {
		this.ratedtime = ratedtime;
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
	public Integer getIsshow() {
		return isshow;
	}
	public void setIsshow(Integer isshow) {
		this.isshow = isshow;
	}
	
	
}

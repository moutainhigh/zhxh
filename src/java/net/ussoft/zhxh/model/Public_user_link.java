package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_user_link")
public class Public_user_link {

	private String id;
	private String parentid;			//用户的父节点id，即该机构与不同上级关联
	private String userid;
	private String tuijianid;
	private String tuijianman;
	
	
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
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
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
	
	
	
}

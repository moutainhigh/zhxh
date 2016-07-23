package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_pic")
public class Public_pic {

	private String id;
	private String parentid;
	private String parenttype;
	private String pic_path;
	private String pic_memo;
	private Integer pic_active;
	private Integer pic_sort;
	private String pic_url;
	
	
	
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
	public String getParenttype() {
		return parenttype;
	}
	public void setParenttype(String parenttype) {
		this.parenttype = parenttype;
	}
	public String getPic_path() {
		return pic_path;
	}
	public void setPic_path(String pic_path) {
		this.pic_path = pic_path;
	}
	public String getPic_memo() {
		return pic_memo;
	}
	public void setPic_memo(String pic_memo) {
		this.pic_memo = pic_memo;
	}
	public Integer getPic_active() {
		return pic_active;
	}
	public void setPic_active(Integer pic_active) {
		this.pic_active = pic_active;
	}
	public Integer getPic_sort() {
		return pic_sort;
	}
	public void setPic_sort(Integer pic_sort) {
		this.pic_sort = pic_sort;
	}
	public String getPic_url() {
		return pic_url;
	}
	public void setPic_url(String pic_url) {
		this.pic_url = pic_url;
	}
	
	
}

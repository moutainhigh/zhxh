package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_brand")
public class Public_brand {

	private String id;
	private String brandname;
	private Integer sort;
	private String brandlogo;
	private String brandpath;
	private String brandcolor;
	private Integer isshow;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBrandname() {
		return brandname;
	}
	public void setBrandname(String brandname) {
		this.brandname = brandname;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public String getBrandlogo() {
		return brandlogo;
	}
	public void setBrandlogo(String brandlogo) {
		this.brandlogo = brandlogo;
	}
	public String getBrandpath() {
		return brandpath;
	}
	public void setBrandpath(String brandpath) {
		this.brandpath = brandpath;
	}
	public String getBrandcolor() {
		return brandcolor;
	}
	public void setBrandcolor(String brandcolor) {
		this.brandcolor = brandcolor;
	}
	public Integer getIsshow() {
		return isshow;
	}
	public void setIsshow(Integer isshow) {
		this.isshow = isshow;
	}
	
	
	
}

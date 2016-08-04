package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="brandfirst")
public class Brandfirst {

	private String id;
	private String brandid;
	private String brandname;
	private String title;
	private String righttitle;
	private String righttitleurl;
	private String firstpic;
	private String firstpicurl;
	private Integer sort;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBrandid() {
		return brandid;
	}
	public void setBrandid(String brandid) {
		this.brandid = brandid;
	}
	public String getBrandname() {
		return brandname;
	}
	public void setBrandname(String brandname) {
		this.brandname = brandname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRighttitle() {
		return righttitle;
	}
	public void setRighttitle(String righttitle) {
		this.righttitle = righttitle;
	}
	public String getRighttitleurl() {
		return righttitleurl;
	}
	public void setRighttitleurl(String righttitleurl) {
		this.righttitleurl = righttitleurl;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public String getFirstpic() {
		return firstpic;
	}
	public void setFirstpic(String firstpic) {
		this.firstpic = firstpic;
	}
	public String getFirstpicurl() {
		return firstpicurl;
	}
	public void setFirstpicurl(String firstpicurl) {
		this.firstpicurl = firstpicurl;
	}
	
	
	
}

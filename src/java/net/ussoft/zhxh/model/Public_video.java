package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_video")
public class Public_video {

	private String id;
	private String videopath;
	private String videooldname;
	private String videonewname;
	private String parentid;
	private String parenttype;
	private String videoext;
	private Integer islocal;
	
	
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getVideopath() {
		return videopath;
	}
	public void setVideopath(String videopath) {
		this.videopath = videopath;
	}
	public String getVideooldname() {
		return videooldname;
	}
	public void setVideooldname(String videooldname) {
		this.videooldname = videooldname;
	}
	public String getVideonewname() {
		return videonewname;
	}
	public void setVideonewname(String videonewname) {
		this.videonewname = videonewname;
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
	public String getVideoext() {
		return videoext;
	}
	public void setVideoext(String videoext) {
		this.videoext = videoext;
	}
	public Integer getIslocal() {
		return islocal;
	}
	public void setIslocal(Integer islocal) {
		this.islocal = islocal;
	}
	
	
	
	
	
}

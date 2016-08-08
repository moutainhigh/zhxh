package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_video")
public class Public_video {

	private String id;
	private String parentid;
	private String parenttype;
	private String videopath;
	private String mp4oldname;
	private String mp4newname;
	private String webmoldname;
	private String webmnewname;
	private Integer islocal;
	private Integer sort;
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
	public String getParenttype() {
		return parenttype;
	}
	public void setParenttype(String parenttype) {
		this.parenttype = parenttype;
	}
	public String getVideopath() {
		return videopath;
	}
	public void setVideopath(String videopath) {
		this.videopath = videopath;
	}
	public String getMp4oldname() {
		return mp4oldname;
	}
	public void setMp4oldname(String mp4oldname) {
		this.mp4oldname = mp4oldname;
	}
	public String getMp4newname() {
		return mp4newname;
	}
	public void setMp4newname(String mp4newname) {
		this.mp4newname = mp4newname;
	}
	public String getWebmoldname() {
		return webmoldname;
	}
	public void setWebmoldname(String webmoldname) {
		this.webmoldname = webmoldname;
	}
	public String getWebmnewname() {
		return webmnewname;
	}
	public void setWebmnewname(String webmnewname) {
		this.webmnewname = webmnewname;
	}
	public Integer getIslocal() {
		return islocal;
	}
	public void setIslocal(Integer islocal) {
		this.islocal = islocal;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public Integer getIsshow() {
		return isshow;
	}
	public void setIsshow(Integer isshow) {
		this.isshow = isshow;
	}
	
	
	
}

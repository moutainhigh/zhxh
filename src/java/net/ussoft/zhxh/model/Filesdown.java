package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="filesdown")
public class Filesdown {

	private String id;
	private String parentid;
	private String title;
	private String filetime;
	private String file_old_name;
	private String file_new_name;
	private String file_ext;
	private String file_size;
	private String file_path;
	private String pic;
	private Integer sort;
	private String parenttype;
	
	
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getFiletime() {
		return filetime;
	}
	public void setFiletime(String filetime) {
		this.filetime = filetime;
	}
	public String getFile_old_name() {
		return file_old_name;
	}
	public void setFile_old_name(String file_old_name) {
		this.file_old_name = file_old_name;
	}
	public String getFile_new_name() {
		return file_new_name;
	}
	public void setFile_new_name(String file_new_name) {
		this.file_new_name = file_new_name;
	}
	public String getFile_ext() {
		return file_ext;
	}
	public void setFile_ext(String file_ext) {
		this.file_ext = file_ext;
	}
	public String getFile_size() {
		return file_size;
	}
	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public String getParenttype() {
		return parenttype;
	}
	public void setParenttype(String parenttype) {
		this.parenttype = parenttype;
	}
	
	
	
	
}

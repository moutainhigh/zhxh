package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_product")
public class Public_product {

	private String id;
	private String brandid;
	private String productname;
	private String productcode;
	private Integer showtype;
	private Float price;
	private String productpic;
	private Integer isshow;
	private String productmemo;
	private String update;
	private Integer ifdis;
	
	
	
	
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
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public String getProductcode() {
		return productcode;
	}
	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}
	public Integer getShowtype() {
		return showtype;
	}
	public void setShowtype(Integer showtype) {
		this.showtype = showtype;
	}
	public Float getPrice() {
		return price;
	}
	public void setPrice(Float price) {
		this.price = price;
	}
	public String getProductpic() {
		return productpic;
	}
	public void setProductpic(String productpic) {
		this.productpic = productpic;
	}
	public Integer getIsshow() {
		return isshow;
	}
	public void setIsshow(Integer isshow) {
		this.isshow = isshow;
	}
	public String getProductmemo() {
		return productmemo;
	}
	public void setProductmemo(String productmemo) {
		this.productmemo = productmemo;
	}
	public String getUpdate() {
		return update;
	}
	public void setUpdate(String update) {
		this.update = update;
	}
	public Integer getIfdis() {
		return ifdis;
	}
	public void setIfdis(Integer ifdis) {
		this.ifdis = ifdis;
	}
	
}

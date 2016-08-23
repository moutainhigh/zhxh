package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_product_size")
public class Public_product_size {

	private String id;
	private String productid;
	private String productname;
	private Integer showtype;
	private String productpic;
	private String productmemo;
	private String productsize;
	private Float price;
	private Integer sizesort;
	private Integer isshow;
	private Float saleprice;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProductid() {
		return productid;
	}
	public void setProductid(String productid) {
		this.productid = productid;
	}
	public String getProductsize() {
		return productsize;
	}
	public void setProductsize(String productsize) {
		this.productsize = productsize;
	}
	public Float getPrice() {
		return price;
	}
	public void setPrice(Float price) {
		this.price = price;
	}
	public Integer getSizesort() {
		return sizesort;
	}
	public void setSizesort(Integer sizesort) {
		this.sizesort = sizesort;
	}
	public Integer getIsshow() {
		return isshow;
	}
	public void setIsshow(Integer isshow) {
		this.isshow = isshow;
	}
	public Float getSaleprice() {
		return saleprice;
	}
	public void setSaleprice(Float saleprice) {
		this.saleprice = saleprice;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public Integer getShowtype() {
		return showtype;
	}
	public void setShowtype(Integer showtype) {
		this.showtype = showtype;
	}
	public String getProductpic() {
		return productpic;
	}
	public void setProductpic(String productpic) {
		this.productpic = productpic;
	}
	public String getProductmemo() {
		return productmemo;
	}
	public void setProductmemo(String productmemo) {
		this.productmemo = productmemo;
	}
	
	
	
}

package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Table(name="public_product_size")
public class Public_product_size {

	private String id;
	private String brandid;
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
	private String linkids;
	
	private int quantity; //临时字段，存放购物车中对应商品的数量和采购单的数量
	private String productcatid;	//购物车对应商品ID
	private String brandname;
	
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
	public String getLinkids() {
		return linkids;
	}
	public void setLinkids(String linkids) {
		this.linkids = linkids;
	}
	
	@Transient
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	@Transient
	public String getProductcatid() {
		return productcatid;
	}
	public void setProductcatid(String productcatid) {
		this.productcatid = productcatid;
	}
	@Transient
	public String getBrandname() {
		return brandname;
	}
	public void setBrandname(String brandname) {
		this.brandname = brandname;
	}
	
}

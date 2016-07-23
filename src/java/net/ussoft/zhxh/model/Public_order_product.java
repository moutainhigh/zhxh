package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_order_product")
public class Public_order_product {

	private String id;
	private String orderid;
	private String productid;
	private String productname;
	private String productpic;
	private Integer productnum;
	private Integer isoknum;
	private Integer ifok;
	private Integer ifover;
	private Float price;
	private String productmemo;
	private String ordertime;
	private Integer status;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public String getProductid() {
		return productid;
	}
	public void setProductid(String productid) {
		this.productid = productid;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public String getProductpic() {
		return productpic;
	}
	public void setProductpic(String productpic) {
		this.productpic = productpic;
	}
	public Integer getProductnum() {
		return productnum;
	}
	public void setProductnum(Integer productnum) {
		this.productnum = productnum;
	}
	public Integer getIsoknum() {
		return isoknum;
	}
	public void setIsoknum(Integer isoknum) {
		this.isoknum = isoknum;
	}
	public Integer getIfok() {
		return ifok;
	}
	public void setIfok(Integer ifok) {
		this.ifok = ifok;
	}
	public Integer getIfover() {
		return ifover;
	}
	public void setIfover(Integer ifover) {
		this.ifover = ifover;
	}
	public Float getPrice() {
		return price;
	}
	public void setPrice(Float price) {
		this.price = price;
	}
	public String getProductmemo() {
		return productmemo;
	}
	public void setProductmemo(String productmemo) {
		this.productmemo = productmemo;
	}
	public String getOrdertime() {
		return ordertime;
	}
	public void setOrdertime(String ordertime) {
		this.ordertime = ordertime;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
}

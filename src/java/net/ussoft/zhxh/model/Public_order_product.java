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
	private String brandname;
	private Integer productnum;
	private Integer isoknum;
	private Integer ifok;
	private Integer ifover;
	private Float price;
	private String productmemo;
	private String ordertime;
	private Integer status;
	private String productsize;
	private Float buyerdis;					//商品采购折扣
	private Float rebatesdis;				//返利标准
	private Float bonusesdis;				//奖励标准
	
	public Public_order_product() {
		this.setProductnum(0);
		this.setIsoknum(0);
		this.setIfok(0);
		this.setIfover(0);
		this.setPrice(0f);
		this.setStatus(0);
		this.setBuyerdis(0f);
		this.setRebatesdis(0f);
		this.setBonusesdis(0f);
	}
	
	
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
	public String getProductsize() {
		return productsize;
	}
	public void setProductsize(String productsize) {
		this.productsize = productsize;
	}
	public Float getBuyerdis() {
		return buyerdis;
	}
	public void setBuyerdis(Float buyerdis) {
		this.buyerdis = buyerdis;
	}
	public Float getRebatesdis() {
		return rebatesdis;
	}
	public void setRebatesdis(Float rebatesdis) {
		this.rebatesdis = rebatesdis;
	}
	public Float getBonusesdis() {
		return bonusesdis;
	}
	public void setBonusesdis(Float bonusesdis) {
		this.bonusesdis = bonusesdis;
	}


	public String getBrandname() {
		return brandname;
	}


	public void setBrandname(String brandname) {
		this.brandname = brandname;
	}
	
	
}

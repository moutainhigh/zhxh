package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="Public_product_dis")
public class Public_product_dis {

	private String id;
	private String productid;
	private Float pernum;
	private Float diannum;
	private Float shinum;
	private Float shengnum;
	private Float tuijiannum;
	private Float limitnum;
	
	
	
	
	
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
	public Float getPernum() {
		return pernum;
	}
	public void setPernum(Float pernum) {
		this.pernum = pernum;
	}
	public Float getDiannum() {
		return diannum;
	}
	public void setDiannum(Float diannum) {
		this.diannum = diannum;
	}
	public Float getShinum() {
		return shinum;
	}
	public void setShinum(Float shinum) {
		this.shinum = shinum;
	}
	public Float getShengnum() {
		return shengnum;
	}
	public void setShengnum(Float shengnum) {
		this.shengnum = shengnum;
	}
	public Float getTuijiannum() {
		return tuijiannum;
	}
	public void setTuijiannum(Float tuijiannum) {
		this.tuijiannum = tuijiannum;
	}
	public Float getLimitnum() {
		return limitnum;
	}
	public void setLimitnum(Float limitnum) {
		this.limitnum = limitnum;
	}
	
}

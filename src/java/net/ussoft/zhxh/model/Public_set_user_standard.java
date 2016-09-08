package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_set_user_standard")
public class Public_set_user_standard {

	private String id;
	private String parentid;				//设置标准的机构
	private String userid;					//被设置标准的机构
	private Float buyerdis;					//商品采购折扣
	private Float rebatesdis;				//返利标准
	private Float bonusesdis;				//奖励标准	
	private String sizeid;					//关联规格id
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	
	/**
	 * 主键
	 * @param id
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * 获取【设置标准的机构】
	 * @return
	 */
	public String getParentid() {
		return parentid;
	}
	/**
	 * set【设置标准的机构】
	 * @param parentid
	 */
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	/**
	 * 被设置标准的机构
	 * @return
	 */
	public String getUserid() {
		return userid;
	}
	/**
	 * 被设置标准的机构
	 * @param userid
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}
	/**
	 * 商品采购折扣
	 * @return
	 */
	public Float getBuyerdis() {
		return buyerdis;
	}
	/**
	 * 商品采购折扣
	 * @param buyerdis
	 */
	public void setBuyerdis(Float buyerdis) {
		this.buyerdis = buyerdis;
	}
	/**
	 * 返利标准
	 * @return
	 */
	public Float getRebatesdis() {
		return rebatesdis;
	}
	/**
	 * 返利标准
	 * @param rebatesdis
	 */
	public void setRebatesdis(Float rebatesdis) {
		this.rebatesdis = rebatesdis;
	}
	/**
	 * 奖励标准
	 * @return
	 */
	public Float getBonusesdis() {
		return bonusesdis;
	}
	/**
	 * 奖励标准
	 * @param bonusesdis
	 */
	public void setBonusesdis(Float bonusesdis) {
		this.bonusesdis = bonusesdis;
	}

	public String getSizeid() {
		return sizeid;
	}

	public void setSizeid(String sizeid) {
		this.sizeid = sizeid;
	}
	
	
}

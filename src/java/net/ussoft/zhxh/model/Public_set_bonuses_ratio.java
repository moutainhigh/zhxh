package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_set_bonuses_ratio")
public class Public_set_bonuses_ratio {

	private String id;
	private String parentid;				//设置标准的机构
	private String userid;					//被设置标准的机构
	private Float bonuses_ratio;			//奖励转货款系数
	
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

	public Float getBonuses_ratio() {
		return bonuses_ratio;
	}

	public void setBonuses_ratio(Float bonuses_ratio) {
		this.bonuses_ratio = bonuses_ratio;
	}
	
}

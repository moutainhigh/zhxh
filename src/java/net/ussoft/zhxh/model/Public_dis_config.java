package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_dis_config")
public class Public_dis_config {

	private String id;
	private Float rebates_down;
	private Float rebates_up;
	private Float bonuses_down;
	private Float bonuses_up;
	private String taken_dian;
	private String taken_daili;
	private Integer quota_down;
	private Integer quota_up;
	private Integer deposit_down;
	private Integer deposit_up;
	private Float bonuses_ratio_down;
	private Float bonuses_ratio_up;
	private Integer balance_date;
	private Float buyerdis_down;
	private Float buyerdis_up;
	private Float taken_down;
	private Float taken_up;
	
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * 	设置返利下限
	 * @return
	 */
	public Float getRebates_down() {
		return rebates_down;
	}
	/**
	 * 	设置返利下限
	 * @param rebates_down
	 */
	public void setRebates_down(Float rebates_down) {
		this.rebates_down = rebates_down;
	}
	/**
	 * 设置返利上限
	 * @return
	 */
	public Float getRebates_up() {
		return rebates_up;
	}
	/**
	 * 设置返利上限
	 * @param rebates_up
	 */
	public void setRebates_up(Float rebates_up) {
		this.rebates_up = rebates_up;
	}
	/**
	 * 设置奖励下限
	 * @return
	 */
	public Float getBonuses_down() {
		return bonuses_down;
	}
	/**
	 * 设置奖励下限
	 * @param bonuses_down
	 */
	public void setBonuses_down(Float bonuses_down) {
		this.bonuses_down = bonuses_down;
	}
	/**
	 * 设置奖励上限
	 * @return
	 */
	public Float getBonuses_up() {
		return bonuses_up;
	}
	/**
	 * 设置奖励上限
	 * @param bonuses_up
	 */
	public void setBonuses_up(Float bonuses_up) {
		this.bonuses_up = bonuses_up;
	}
	/**
	 * 设置店提现日期。整数，2代表每周2
	 * @return
	 */
	public String getTaken_dian() {
		return taken_dian;
	}
	/**
	 * 设置店提现日期。整数，2代表每周2
	 * @param taken_dian
	 */
	public void setTaken_dian(String taken_dian) {
		this.taken_dian = taken_dian;
	}
	/**
	 * 设置代理的提现日期。整数，2代表每周2
	 * @return
	 */
	public String getTaken_daili() {
		return taken_daili;
	}
	/**
	 * 设置代理的提现日期。整数，2代表每周2
	 * @param taken_daili
	 */
	public void setTaken_daili(String taken_daili) {
		this.taken_daili = taken_daili;
	}
	/**
	 * 设置配额下限
	 * @return
	 */
	public Integer getQuota_down() {
		return quota_down;
	}
	/**
	 * 设置配额下限
	 * @param quota_down
	 */
	public void setQuota_down(Integer quota_down) {
		this.quota_down = quota_down;
	}
	/**
	 * 设置配额上限
	 * @return
	 */
	public Integer getQuota_up() {
		return quota_up;
	}
	/**
	 * 设置配额上限
	 * @param quota_up
	 */
	public void setQuota_up(Integer quota_up) {
		this.quota_up = quota_up;
	}
	/**
	 * 设置充值金额下限
	 * @return
	 */
	public Integer getDeposit_down() {
		return deposit_down;
	}
	/**
	 * 设置充值金额下限
	 * @param deposit_down
	 */
	public void setDeposit_down(Integer deposit_down) {
		this.deposit_down = deposit_down;
	}
	/**
	 * 设置充值金额上限
	 * @return
	 */
	public Integer getDeposit_up() {
		return deposit_up;
	}
	/**
	 * 设置充值金额上限
	 * @param deposit_up
	 */
	public void setDeposit_up(Integer deposit_up) {
		this.deposit_up = deposit_up;
	}
	
	public Float getBonuses_ratio_down() {
		return bonuses_ratio_down;
	}
	public void setBonuses_ratio_down(Float bonuses_ratio_down) {
		this.bonuses_ratio_down = bonuses_ratio_down;
	}
	public Float getBonuses_ratio_up() {
		return bonuses_ratio_up;
	}
	public void setBonuses_ratio_up(Float bonuses_ratio_up) {
		this.bonuses_ratio_up = bonuses_ratio_up;
	}
	/**
	 * 设置普通会员购买后，平台分成给代理和店，进入可提现账户的金额的天数，因为存在退货的可能
	 * @return
	 */
	public Integer getBalance_date() {
		return balance_date;
	}
	/**
	 * 设置普通会员购买后，平台分成给代理和店，进入可提现账户的金额的天数，因为存在退货的可能
	 * @param balance_date
	 */
	public void setBalance_date(Integer balance_date) {
		this.balance_date = balance_date;
	}
	public Float getBuyerdis_down() {
		return buyerdis_down;
	}
	public void setBuyerdis_down(Float buyerdis_down) {
		this.buyerdis_down = buyerdis_down;
	}
	public Float getBuyerdis_up() {
		return buyerdis_up;
	}
	public void setBuyerdis_up(Float buyerdis_up) {
		this.buyerdis_up = buyerdis_up;
	}
	public Float getTaken_down() {
		return taken_down;
	}
	public void setTaken_down(Float taken_down) {
		this.taken_down = taken_down;
	}
	public Float getTaken_up() {
		return taken_up;
	}
	public void setTaken_up(Float taken_up) {
		this.taken_up = taken_up;
	}
	public Public_dis_config() {
		this.setRebates_down(0f);
		this.setRebates_up(0f);
		this.setBonuses_down(0f);
		this.setBonuses_up(0f);
		this.setTaken_dian("");
		this.setTaken_daili("");
		this.setQuota_down(0);
		this.setQuota_up(0);
		this.setDeposit_down(0);
		this.setDeposit_up(0);
		this.setBonuses_ratio_down(0f);
		this.setBonuses_ratio_up(0f);
		this.setBalance_date(0);
		this.setBuyerdis_down(0f);
		this.setBonuses_up(0f);
		this.setTaken_down(0f);
		this.setTaken_up(0f);
	}
	
	
}

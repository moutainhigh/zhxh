package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_user_bank")
public class Public_user_bank {

	private String id;
	private String parentid;			//用户的父节点id，即该机构与不同上级（代理或平台）进货，所有的账户只针对父机构
	private String userid;
	private Float incomebank;			//收入总计。平台、代理有
	private Float costbank;				//出总计.平台、代理有
	private Float takenbank;			//可提现账户.平台、代理
	private Float sellbank;				//平台销售额.平台、代理、店
	private Float havebank;				//可支配账户.代理、店
	private Float quotabank;				//配额账户。代理、店
	private Float depositbank;				//充值账户。代理、店
	private Float selltakenbank;				//平台销售额可提现账户。店
	private Float rebatesbank;				//返利账户。店
	private Float bonusesbank;				//奖励账户。店
	private Float bonusestakenbank;				//奖励可提现账户。店
	
	
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
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public Float getIncomebank() {
		return incomebank;
	}
	public void setIncomebank(Float incomebank) {
		this.incomebank = incomebank;
	}
	public Float getCostbank() {
		return costbank;
	}
	public void setCostbank(Float costbank) {
		this.costbank = costbank;
	}
	public Float getTakenbank() {
		return takenbank;
	}
	public void setTakenbank(Float takenbank) {
		this.takenbank = takenbank;
	}
	public Float getSellbank() {
		return sellbank;
	}
	public void setSellbank(Float sellbank) {
		this.sellbank = sellbank;
	}
	public Float getHavebank() {
		return havebank;
	}
	public void setHavebank(Float havebank) {
		this.havebank = havebank;
	}
	public Float getQuotabank() {
		return quotabank;
	}
	public void setQuotabank(Float quotabank) {
		this.quotabank = quotabank;
	}
	public Float getDepositbank() {
		return depositbank;
	}
	public void setDepositbank(Float depositbank) {
		this.depositbank = depositbank;
	}
	public Float getSelltakenbank() {
		return selltakenbank;
	}
	public void setSelltakenbank(Float selltakenbank) {
		this.selltakenbank = selltakenbank;
	}
	public Float getRebatesbank() {
		return rebatesbank;
	}
	public void setRebatesbank(Float rebatesbank) {
		this.rebatesbank = rebatesbank;
	}
	public Float getBonusesbank() {
		return bonusesbank;
	}
	public void setBonusesbank(Float bonusesbank) {
		this.bonusesbank = bonusesbank;
	}
	public Float getBonusestakenbank() {
		return bonusestakenbank;
	}
	public void setBonusestakenbank(Float bonusestakenbank) {
		this.bonusestakenbank = bonusestakenbank;
	}
	
	
	
}

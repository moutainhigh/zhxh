package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_log")
public class Public_log {

	private String id;
	private String userid;
	private String touserid;
	private String logtype;
	private String logmemo;
	private String logtime;
	private String lognum;
	private Float logpay;
	
	
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * 主操作人id
	 * @return
	 */
	public String getUserid() {
		return userid;
	}
	/**
	 * 主操作人id
	 * @param userid
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}
	/**
	 * 被操作人id
	 * @return
	 */
	public String getTouserid() {
		return touserid;
	}
	/**
	 * 被操作人id
	 * @param touserid
	 */
	public void setTouserid(String touserid) {
		this.touserid = touserid;
	}
	/**
	 * 操作类型。（例如登录日志为logoin，充值为deposit，配额为quota，可以扩充，代码意义存入字典）。可以取代取现、充值、配额记录表
	 * @return
	 */
	public String getLogtype() {
		return logtype;
	}
	/**
	 * 操作类型。（例如登录日志为logoin，充值为deposit，配额为quota，可以扩充，代码意义存入字典）。可以取代取现、充值、配额记录表
	 * @param logtype
	 */
	public void setLogtype(String logtype) {
		this.logtype = logtype;
	}
	/**
	 * 日志内容描述
	 * @return
	 */
	public String getLogmemo() {
		return logmemo;
	}
	/**
	 * 日志内容描述
	 * @param logmemo
	 */
	public void setLogmemo(String logmemo) {
		this.logmemo = logmemo;
	}
	/**
	 * 日志日期
	 * @return
	 */
	public String getLogtime() {
		return logtime;
	}
	/**
	 * 日志日期
	 * @param logtime
	 */
	public void setLogtime(String logtime) {
		this.logtime = logtime;
	}
	/**
	 * 日志流水号（有些记录是有流水号的，例如提现流水号）
	 * @return
	 */
	public String getLognum() {
		return lognum;
	}
	/**
	 * 日志流水号（有些记录是有流水号的，例如提现流水号）
	 * @param lognum
	 */
	public void setLognum(String lognum) {
		this.lognum = lognum;
	}
	/**
	 * 日志金额（有些记录是用金额的，例如充值、配额、提现）
	 * @return
	 */
	public Float getLogpay() {
		return logpay;
	}
	/**
	 * 日志金额（有些记录是用金额的，例如充值、配额、提现）
	 * @param logpay
	 */
	public void setLogpay(Float logpay) {
		this.logpay = logpay;
	}
	
	
}

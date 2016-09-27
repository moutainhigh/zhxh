package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_message")
public class Public_message {

	private String id;
	private String sendid;				//发送者id
	private String sendname;			//发送者名称
	private String receiveid;			//接受者id
	private String receivename;			//接收者名称
	private Integer messagetype;		//消息类型。1：系统消息  2：站内信
	private String messagetxt;			//消息内容
	private Integer messagestate;		//消息状态  0：未读	1：已读
	private String messagetime;			//发送时间。精确到秒
	private String activeid;			//业务id。例如订单id。方便从消息直接查看
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSendid() {
		return sendid;
	}
	public void setSendid(String sendid) {
		this.sendid = sendid;
	}
	public String getReceiveid() {
		return receiveid;
	}
	public void setReceiveid(String receiveid) {
		this.receiveid = receiveid;
	}
	public Integer getMessagetype() {
		return messagetype;
	}
	public void setMessagetype(Integer messagetype) {
		this.messagetype = messagetype;
	}
	public String getMessagetxt() {
		return messagetxt;
	}
	public void setMessagetxt(String messagetxt) {
		this.messagetxt = messagetxt;
	}
	public Integer getMessagestate() {
		return messagestate;
	}
	public void setMessagestate(Integer messagestate) {
		this.messagestate = messagestate;
	}
	public String getMessagetime() {
		return messagetime;
	}
	public void setMessagetime(String messagetime) {
		this.messagetime = messagetime;
	}
	public String getSendname() {
		return sendname;
	}
	public void setSendname(String sendname) {
		this.sendname = sendname;
	}
	public String getReceivename() {
		return receivename;
	}
	public void setReceivename(String receivename) {
		this.receivename = receivename;
	}
	public String getActiveid() {
		return activeid;
	}
	public void setActiveid(String activeid) {
		this.activeid = activeid;
	}
	
	
	
}

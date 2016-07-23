package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_order_logistics")
public class Public_order_logistics {

	private String id;
	private String orderid;
	private String handletime;
	private String handleresult;
	private String handleman;
	
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
	public String getHandletime() {
		return handletime;
	}
	public void setHandletime(String handletime) {
		this.handletime = handletime;
	}
	public String getHandleresult() {
		return handleresult;
	}
	public void setHandleresult(String handleresult) {
		this.handleresult = handleresult;
	}
	public String getHandleman() {
		return handleman;
	}
	public void setHandleman(String handleman) {
		this.handleman = handleman;
	}
	
	
}

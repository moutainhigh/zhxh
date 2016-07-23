package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name="public_ask_result")
public class Public_ask_result {

	private String id;
	private String askid;
	private String resulttime;
	private String resultman;
	private String resultmemo;
	
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAskid() {
		return askid;
	}
	public void setAskid(String askid) {
		this.askid = askid;
	}
	public String getResulttime() {
		return resulttime;
	}
	public void setResulttime(String resulttime) {
		this.resulttime = resulttime;
	}
	public String getResultman() {
		return resultman;
	}
	public void setResultman(String resultman) {
		this.resultman = resultman;
	}
	public String getResultmemo() {
		return resultmemo;
	}
	public void setResultmemo(String resultmemo) {
		this.resultmemo = resultmemo;
	}
	
	
}

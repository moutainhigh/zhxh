package net.ussoft.zhxh.model;

import javax.persistence.Table;

@Table(name="disposable_bill")
public class Disposable_bill {

	private String id;
	private String billno;
	private String orderid;
	private String orderno;
	private double amount;	//金额
	private double balance;	//余额
	private int tranytype;	//交易类型 1:收入，2：支出
	private int type;	//类型	1：配额，2：返利，3：奖励转货款，4：退款（取消订单），5：货款（订单）
	private String type_txt;	//类型文本
	private String createtime;	//创建日期
	
}

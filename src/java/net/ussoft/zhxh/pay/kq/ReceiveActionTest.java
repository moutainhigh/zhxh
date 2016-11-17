package net.ussoft.zhxh.pay.kq;

import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.model.Income_bill;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IIncomeBillService;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.DateUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 快钱支付-服务接收
 * @author guodh
 * @version v1.0
 * */

@Controller
public class ReceiveActionTest {
	
	@Resource
	private IIncomeBillService incomeBillService;
	@Resource
	private IPublicUserBankService userBankService;
	@Resource
	private IPublicUserService userService;
	
	/**
	 * 快钱支付-服务接收
	 * */
	@RequestMapping(value="/kq/receive_test")
	public void receive(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		/*
		此处商户可以做业务逻辑处理
		*/
		String payAmount = "100000";
		String fee = "0.18";
		Income_bill bill = incomeBillService.getByBillno("2016111612530003");
//		bill.setBindCard(bindCard); 		//已绑短卡号,信用卡快捷支付绑定卡信息后返回前六后四位信用卡号
//		bill.setBindMobile(bindMobile); 	//已绑短手机尾号,信用卡快捷支付绑定卡信息后返回前三位后四位手机号码
		bill.setPayAmount(Float.parseFloat(payAmount)); 		//该金额代表商户快钱账户最终收到的金额
		bill.setAccount_real(Float.parseFloat(payAmount));
		bill.setFee(Float.parseFloat(fee)); 					//快钱收取商户的手续费，单位为分
//		bill.setDealId(dealId); 		//快钱交易号
//		bill.setBankDealId(bankDealId); 	//银行交易号
		bill.setDealTime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss")); 		//快钱交易时间
		
		Public_user user = userService.getById(bill.getUserid());
		int num = userBankService.recharge(bill, user.getIdentity());
		out.print("is ok");
	}
	
}

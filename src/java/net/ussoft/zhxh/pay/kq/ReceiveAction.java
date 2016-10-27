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

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 快钱支付-服务接收
 * @author guodh
 * @version v1.0
 * */

@Controller
public class ReceiveAction {
	
	@Resource
	private IIncomeBillService incomeBillService;
	@Resource
	private IPublicUserBankService userBankService;
	@Resource
	private IPublicUserService userService;
	
	/**
	 * 快钱支付-服务接收
	 * */
	@RequestMapping(value="/kq/receive")
	public void receive(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		//人民币网关账号，该账号为11位人民币网关商户编号+01,该值与提交时相同。
		String merchantAcctId = request.getParameter("merchantAcctId");
		//网关版本，固定值：v2.0,该值与提交时相同。
		String version = request.getParameter("version");
		//语言种类，1代表中文显示，2代表英文显示。默认为1,该值与提交时相同。
		String language = request.getParameter("language");
		//签名类型,该值为4，代表PKI加密方式,该值与提交时相同。
		String signType = request.getParameter("signType");
		//支付方式，一般为00，代表所有的支付方式。如果是银行直连商户，该值为10,该值与提交时相同。
		String payType = request.getParameter("payType");
		//银行代码，如果payType为00，该值为空；如果payType为10,该值与提交时相同。
		String bankId = request.getParameter("bankId");
		//商户订单号，该值与提交时相同。
		String orderId = request.getParameter("orderId");
		//订单提交时间，格式：yyyyMMddHHmmss，如：20071117020101,该值与提交时相同。
		String orderTime = request.getParameter("orderTime");
		//订单金额，金额以“分”为单位，商户测试以1分测试即可，切勿以大金额测试,该值与支付时相同。
		String orderAmount = request.getParameter("orderAmount");
		//已绑短卡号,信用卡快捷支付绑定卡信息后返回前六后四位信用卡号
		String bindCard = request.getParameter("bindCard");
		//已绑短手机尾号,信用卡快捷支付绑定卡信息后返回前三位后四位手机号码
		String bindMobile = request.getParameter("bindMobile");
		// 快钱交易号，商户每一笔交易都会在快钱生成一个交易号。
		String dealId = request.getParameter("dealId");
		//银行交易号 ，快钱交易在银行支付时对应的交易号，如果不是通过银行卡支付，则为空
		String bankDealId = request.getParameter("bankDealId");
		//快钱交易时间，快钱对交易进行处理的时间,格式：yyyyMMddHHmmss，如：20071117020101
		String dealTime = request.getParameter("dealTime");
		//商户实际支付金额 以分为单位。比方10元，提交时金额应为1000。该金额代表商户快钱账户最终收到的金额。
		String payAmount = request.getParameter("payAmount");
		//费用，快钱收取商户的手续费，单位为分。
		String fee = request.getParameter("fee");
		//扩展字段1，该值与提交时相同。
		String ext1 = request.getParameter("ext1");
		//扩展字段2，该值与提交时相同。
		String ext2 = request.getParameter("ext2");
		//处理结果， 10支付成功，11 支付失败，00订单申请成功，01 订单申请失败
		String payResult = request.getParameter("payResult");
		//错误代码 ，请参照《人民币网关接口文档》最后部分的详细解释。
		String errCode = request.getParameter("errCode");
		//签名字符串 
		String signMsg = request.getParameter("signMsg");
		if(null == signMsg || "".equals(signMsg)){
			out.print("<result>0</result> <redirecturl>ERROR</redirecturl>");
			return;
		}
		
		String merchantSignMsgVal = "";
		merchantSignMsgVal = appendParam(merchantSignMsgVal,"merchantAcctId", merchantAcctId);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "version",version);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "language",language);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "signType",signType);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "payType",payType);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "bankId",bankId);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "orderId",orderId);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "orderTime",orderTime);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "orderAmount",orderAmount);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "bindCard",bindCard);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "bindMobile",bindMobile);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "dealId",dealId);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "bankDealId",bankDealId);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "dealTime",dealTime);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "payAmount",payAmount);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "fee", fee);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "ext1", ext1);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "ext2", ext2);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "payResult",payResult);
		merchantSignMsgVal = appendParam(merchantSignMsgVal, "errCode",errCode);
		Pkipair pki = new Pkipair();
		boolean flag = pki.enCodeByCer(merchantSignMsgVal, signMsg);
		int rtnOK =0;
	  	String rtnUrl="";
	  	if(flag){
	  		switch(Integer.parseInt(payResult))
	  		{
	  			case 10:
  					/*
  					此处商户可以做业务逻辑处理
  					*/
	  				Income_bill bill = incomeBillService.getByBillno(orderId);
	  				bill.setBindCard(bindCard); 		//已绑短卡号,信用卡快捷支付绑定卡信息后返回前六后四位信用卡号
	  				bill.setBindMobile(bindMobile); 	//已绑短手机尾号,信用卡快捷支付绑定卡信息后返回前三位后四位手机号码
	  				bill.setPayAmount(Float.parseFloat(payAmount) / 100); 		//该金额代表商户快钱账户最终收到的金额
	  				bill.setAccount_real(Float.parseFloat(payAmount));
	  				bill.setFee(Float.parseFloat(fee) / 100); 					//快钱收取商户的手续费，单位为分
	  				bill.setDealId(dealId); 		//快钱交易号
	  				bill.setBankDealId(bankDealId); 	//银行交易号
	  				bill.setDealTime(dealTime); 		//快钱交易时间
	  				
	  				Public_user user = userService.getById(bill.getUserid());
	  				int num = userBankService.recharge(bill, user.getIdentity());
	  				if(num > 0){
	  					rtnOK=1;
	  					rtnUrl="http://139.224.0.109/view/order/bank/show.jsp?msg=success";
	  				}else{
	  					rtnOK=0;
	  					rtnUrl="http://139.224.0.109/view/order/bank/show.jsp?msg=false";
	  				}
  					break;
	  			default:
	  					rtnOK=0;
	  					rtnUrl="http://139.224.0.109/view/order/bank/show.jsp?msg=false";
	  					break;
	  		}
	  	}else{
	  		rtnOK=0;
	  		//以下是我们快钱设置的show页面，商户需要自己定义该页面。
	  		rtnUrl="http://139.224.0.109/view/order/bank/show.jsp?msg=error";
	  	}	
	
	
//		out.print("<result>"+rtnOK+"</result> <redirecturl>"+rtnUrl+"</redirecturl>");
		out.print("<result>"+rtnOK+"</result> <redirecturl></redirecturl>");
	}
	
	/**
	 * 拼接参数
	 * */
	private String appendParam(String returns, String paramId, String paramValue) {
		if (!returns.equals("")) {
			if (null != paramValue && !paramValue.equals("")) {
				returns += "&" + paramId + "=" + paramValue;
			}
		}else {
			if (null != paramValue && !paramValue.equals("")) {
				returns = paramId + "=" + paramValue;
			}
		}
		return returns;
	}
}

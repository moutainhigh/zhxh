package net.ussoft.zhxh.pay.kq;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/* *
 *	快钱接口请求提交类
 */
public class KqSubmit {
    
    /**
     * 快钱支付网关地址
     */
    private static final String KQ_GATEWAY_URL = "https://sandbox.99bill.com/gateway/recvMerchantInfoAction.htm";	//"https://sandbox.99bill.com/gateway/recvMerchantInfoAction.htm";
    
    /**
     * 加入签名
     * @param sParaTemp 请求前的参数数组
     * @return 要请求的参数数组
     */
    private static Map<String, String> buildRequestPara(Map<String, String> sParaTemp) {
        //生成签名结果
    	String mysign = KqCore.getSignMsg(sParaTemp);
        //签名结果加入请求提交参数组中
    	sParaTemp.put("signMsg", mysign);
        return sParaTemp;
    }
    
    /**
     * 建立请求，以表单HTML形式构造（默认）
     * @param sParaTemp 请求参数数组
     * @param strMethod 提交方式。两个值可选：post、get
     * @param strButtonName 确认按钮显示文字
     * @return 提交表单HTML文本
     */
    public static String buildRequest(Map<String, String> sParaTemp, String strMethod) {
        //待请求参数数组
        Map<String, String> sPara = buildRequestPara(sParaTemp);
        List<String> keys = new ArrayList<String>(sPara.keySet());

        StringBuffer sbHtml = new StringBuffer();

        sbHtml.append("<form id=\"alipaysubmit\" name=\"alipaysubmit\" action=\"" + KQ_GATEWAY_URL
                      + "\" method=\"" + strMethod
                      + "\">");

        for (int i = 0; i < keys.size(); i++) {
            String name = (String) keys.get(i);
            String value = (String) sPara.get(name);

            sbHtml.append("<input type=\"hidden\" name=\"" + name + "\" value=\"" + value + "\"/>");
        }

        //submit按钮控件请不要含有name属性
        sbHtml.append("<input type=\"submit\" value=\"提交\" style=\"display:none;\"></form>");
        sbHtml.append("<script>document.forms['alipaysubmit'].submit();</script>");

        return sbHtml.toString();
    }
 
}

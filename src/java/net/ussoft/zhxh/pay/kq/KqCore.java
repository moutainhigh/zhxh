package net.ussoft.zhxh.pay.kq;

import java.util.Iterator;
import java.util.Map;

/**
 * 支付接口-参数处理方法
 * @author guodh
 * */
public class KqCore {

	/**
	 * 获取签名
	 * */
	public static String getSignMsg(Map<String, String> params){
		String signMsgVal = "";
		Iterator<String> it = params.keySet().iterator();
	    while(it.hasNext()){
	    	String key=it.next();
	    	String value = params.get(key);
	    	if(null != value && !"".equals(value)){
	    		signMsgVal = appendParam(signMsgVal, key, value);
	    	}
	    }
		Pkipair pki = new Pkipair();
		String signMsg = pki.signMsg(signMsgVal);
		return signMsg;
	}
	
	/**
	 * 参数拼接
	 * */
	public static String appendParam(String returns, String paramId, String paramValue) {
		if (returns != "") {
			if (paramValue != "") {
				returns += "&" + paramId + "=" + paramValue;
			}
		} else {
			if (paramValue != "") {
				returns = paramId + "=" + paramValue;
			}
		}
		return returns;
	}
}

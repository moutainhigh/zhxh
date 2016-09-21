package net.ussoft.zhxh.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;

public class SendSMSbak {
	
	//企业ID
	private static final String USERID = "";
	
	//发送账户
	private static final String ACCOUNT = "xpt10280";
	
	//发送密码-用md5加密方式，md5采用32位大写如abc123加密后为 E99A18C428CB38D5F260853678922E03
	private static final String PASSWORD = MD5.encode("xpt1028044").toUpperCase();
	
	//定时发送时间-为空表示立即发送，定时发送格式2010-10-24 09:08:10（可选）
	private static final String SEND_TIME = "";
	
	
	
	/**
	 * 发送信息
	 * @param mobile 手机号
	 * @param content 内容
	 * @return
	 * */
	public static String sendMessage(String mobile,String content){
		String send_content = encodeUTF8(content + "【众恒信和】");
		return SendMessage(USERID, ACCOUNT, PASSWORD, mobile, send_content, SEND_TIME);
	}
	
	/**
	 * 发送信息
	 * @param mobile 手机号
	 * @param content 内容
	 * @param signature 签名 ，例如：【众恒信和】
	 * */
	public static String sendMessage(String mobile,String content,String signature){
		String send_content = encodeUTF8(content + signature);
		return SendMessage(USERID, ACCOUNT, PASSWORD, mobile, send_content, SEND_TIME);
	}

	
	/**
	 * 发送短信
	 * @param userid
	 * @param account
	 * @param password
	 * @param mobile
	 * @param content
	 * @param sendTime
	 * */
	public static String SendMessage(String userid,String account,String password,String mobile,String content,String sendTime){
		String url = "http://114.113.154.110/smsJson.aspx?action=send&userid="+userid+"&account="+account+"&password="+password+"&mobile="+mobile+"&content="+content+"&sendTime="+sendTime;
		String result = httpClientGet(url);
		return result;
	}
		
	/**
	 * HttpClinet发送请求并结束返回值
	 * @param url
	 * @return json_str
	 * */
	public static String httpClientGet(String url){
		String json_str="";
		try {
			HttpClient client=new HttpClient();
			HttpMethod method=new GetMethod(url);
			client.executeMethod(method);
			json_str=method.getResponseBodyAsString();
			method.releaseConnection(); //释放连接
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json_str;
	}
	
	/**
	 * HttpClinet发送请求并结束返回值
	 * @param url
	 * @return json_str
	 * */
	public static String httpClientPost(String url,NameValuePair[] param){
		String json_str = "";
		
		try {
			HttpClient client = new HttpClient(); 
			PostMethod method = new PostMethod(url);  
			method.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8"); 
			//NameValuePair[] param = { new NameValuePair("param", "eyJ1aWQiOiJ3ZWJtYXN0ZXIiLCJwd2QiOiJjaGluYXNlcnZlXzIwMTQifQ==")};  
			method.setRequestBody(param);  
			int statusCode = client.executeMethod(method);  
			json_str = method.getResponseBodyAsString();
			System.out.println(statusCode);  
			method.releaseConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return json_str;
	}
	
	/**
	 * 内容需要UTF-8编码
	 * */
	private static String encodeUTF8(String content){
		try {
			content = URLEncoder.encode(content.replaceAll("<br/>", " "), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return content;
	}
	
	//发送短信
	/*public static String SendMessage(String userid,String account,String password,String mobile,String content){
		
		//设置发送内容的编码方式
		String send_content = "";
		try {
			send_content=URLEncoder.encode(content.replaceAll("<br/>", " "), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}//发送内容
		String url = "http://114.113.154.110/smsJson.aspx?action=send&userid="+userid+"&account="+account+"&password="+password+"&mobile="+mobile+"&content="+send_content+"&sendTime=";
		String result = httpClientGet(url);
		return result;	
	}*/
	
	public static void main(String[] args) {
//		String password = MD5.encode("xpt1028044").toUpperCase();
//		String result = SendMessage("", "xpt10280", password, "13071115698", "您的验证码：1234567【众恒信和】");
//		System.out.println(result);
		//18611265720
		//
		String result = sendMessage("15010780215", "您的验证码为：15010780215");
		System.out.println(result);
	}
	
}

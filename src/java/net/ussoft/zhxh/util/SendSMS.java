package net.ussoft.zhxh.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;

public class SendSMS {
	
	//帐号
	private static final String ID = "18610344000";
	
	//密码
	private static final String PWD = "1qazzse4";
	
	//请求地址
	private static final String SEND_URL = "http://service.winic.org:8009/sys_port/gateway/index.asp?";
	
	/**
	 * 发送信息
	 * @param mobile 手机号
	 * @param content 内容
	 * @return
	 * */
	public static String sendMessage(String mobile,String content){
		String send_content = encode_gb2312(content + "【集丽科技】");
		return SendMessage(ID, PWD, mobile, send_content, "");
	}
	
	/**
	 * 发送短信
	 * @param id 中正云通信帐号 （中文帐号要求转码为GB2312编码）
	 * @param pwd 中正云通信密码  无需加密
	 * @param to 接收短信号码  多个号码使用英文逗号（,）分隔
	 * @param content 内容
	 * @param time 短信发送时间 	可不填 	为空即时发送，格式：yyyy/mm/dd hh:mm:ss 2016/06/20 11:50:41
	 * */
	public static String SendMessage(String id,String pwd,String to,String content,String time){
		String url = SEND_URL + "id="+id+"&pwd="+pwd+"&to="+to+"&content="+content+"&time=";
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
	private static String encode_gb2312(String content){
		try {
			content = URLEncoder.encode(content.replaceAll("<br/>", " "), "gb2312");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return content;
	}
	
	
	public static void main(String[] args) {
//		String password = MD5.encode("xpt1028044").toUpperCase();
//		String result = SendMessage("", "xpt10280", password, "13071115698", "您的验证码：1234567【众恒信和】");
//		System.out.println(result);
		//18611265720
		//
		/*String result = sendMessage("13041237672", "您的验证码为：15010780215");
		System.out.println(result);*/
	}
	
}

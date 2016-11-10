package net.ussoft.zhxh.util.express;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.util.MD5;
import net.ussoft.zhxh.util.express.pojo.TaskRequest;

public class Poll {

	public static void main(String[] args) {
		TaskRequest task = new TaskRequest();
		task.setKey("cDswUZDo7433");
		task.setCompany("shunfeng");
		task.setNumber("150575632332");	//952349030677
		HashMap<String, String> parameters = new HashMap<String, String>();
		parameters.put("callbackurl", "http://139.224.0.109/kdcall/callback.htmls");
		parameters.put("salt", MD5.encode("150575632333"));
		parameters.put("resultv2", "1");
		task.setParameters(parameters);
		
		System.out.println(task.toString());
		
		String url = "http://poll.kuaidi100.com/poll";
		NameValuePair[] param = {new NameValuePair("schema","json"),
				new NameValuePair("param",task.toString())};
		String result = httpClientPost(url, param);
		System.out.println(result);
	}
	
	public static void main1(String[] args) {
		
		Map<String, String> params = new HashMap<String, String>();
		params.put("com", "shunfeng");
		params.put("num", "150575632333");
		params.put("from", "北京");
		params.put("to", "苏州");
		String pjson = JSON.toJSONString(params);
		
		String url = "http://poll.kuaidi100.com/poll/query.do";
		NameValuePair[] param = {new NameValuePair("customer ","cDswUZDo7433"),
				new NameValuePair("sign",MD5.encode("952349030677")),
				new NameValuePair("param",pjson)};
		String result = httpClientPost(url, param);
		System.out.println(result);
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
	
	
}

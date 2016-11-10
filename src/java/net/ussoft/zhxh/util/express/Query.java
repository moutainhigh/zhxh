package net.ussoft.zhxh.util.express;

import java.util.HashMap;


public class Query {
	public static void main(String[] args) throws Exception {
		
//		 http://www.kuaidi100.com/autonumber/auto?num=906919164534&key=cDswUZDo7433

		String param ="{\"com\":\"yuantong\",\"num\":\"952349030677\"}";
		String customer ="A5A69FCC57E83EECA877C5D09A53AEDB";
		String key = "cDswUZDo7433";
		String sign = MD5.encode(param+key+customer);
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("param",param);
		params.put("sign",sign);
		params.put("customer",customer);
		String resp;
		try {
			resp = new HttpRequest().postData("http://poll.kuaidi100.com/poll/query.do", params, "utf-8").toString();
			System.out.println(resp);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

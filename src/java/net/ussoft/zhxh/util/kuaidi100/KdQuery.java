package net.ussoft.zhxh.util.kuaidi100;

import java.util.HashMap;

import net.ussoft.zhxh.util.kuaidi100.pojo.Result;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;


/**
 * 快递100，单号实时查询
 * @author guodh
 * @version v1 2016-11-08
 * */
public class KdQuery {
	
	/**
	 * 快递单实时查询
	 * @param num 单号
	 * @return
	 * */
	public static Result getNoticeResult(String num){
		Result result = new Result();
		String com = getCom(num);
		if(!"".equals(com)){
//			String param ="{\"com\":\"shunfeng\",\"num\":\"952349030677\"}";
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("com", com);
			map.put("num", num);
			String param = JacksonHelper.toJSON(map);
			String customer ="A5A69FCC57E83EECA877C5D09A53AEDB";
			String key = "cDswUZDo7433";
			String sign = MD5.encode(param+key+customer);
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("param",param);
			params.put("sign",sign);
			params.put("customer",customer);
			try {
				String resp = new HttpRequest().postData("http://poll.kuaidi100.com/poll/query.do", params, "utf-8").toString();
//				System.out.println(resp);
				result = JacksonHelper.fromJSON(resp,Result.class);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	/**
	 * 单号归属公司
	 * @param num
	 * @return
	 * */
	private static String getCom(String num){
		//http://www.kuaidi100.com/autonumber/auto?num=906919164534&key=cDswUZDo7433
		String com = "";
		try {
			String result = new HttpRequest().postData("http://www.kuaidi100.com/autonumber/auto?num="+num+"&key=cDswUZDo7433", "utf-8").toString();
//			System.out.println(result);
			if(result.indexOf("comCode") > 0){
				JSONArray array = JSON.parseArray(result);
				JSONObject obj = array.getJSONObject(0);
				com = obj.get("comCode").toString().trim();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return com;
	}
	
	public static void main(String[] args) {
//		getCom("952349030677");
//		getOrderLogistics("952349030677");
		
		
	}
}

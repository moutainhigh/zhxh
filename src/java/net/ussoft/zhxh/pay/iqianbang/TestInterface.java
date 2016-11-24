package net.ussoft.zhxh.pay.iqianbang;

import java.util.HashMap;
import java.util.Map;

import net.ussoft.zhxh.pay.iqianbang.util.APIHttpClient;
import net.ussoft.zhxh.pay.iqianbang.util.DigestUtils;
import net.ussoft.zhxh.pay.iqianbang.util.SignUtil;

import com.alibaba.fastjson.JSON;

public class TestInterface {
	
    public static void main(String[] args) {
        try {
			CheckAndOrderBean checkAndOrderBean = new CheckAndOrderBean();
			checkAndOrderBean.setAddress("北京市朝阳区");
			checkAndOrderBean.setBankCode("aaa");
			checkAndOrderBean.setBankMobile("13855215521");
			checkAndOrderBean.setBusiness("");
			checkAndOrderBean.setBusinessType("");
			checkAndOrderBean.setCardNo("62284856456465465");
			checkAndOrderBean.setCity("北京");
			checkAndOrderBean.setCompanyAddress("北京市东城区");
			checkAndOrderBean.setCompanyCity("北京");
			checkAndOrderBean.setCompanyName("IQB");
			checkAndOrderBean.setCompanyNature("");
			checkAndOrderBean.setCompanyTel("010-88888888");
			checkAndOrderBean.setCompanyTelAreaNo("");
			checkAndOrderBean.setContactName1("张三");
			checkAndOrderBean.setContactName2("李四");
			checkAndOrderBean.setContactPhone1("18600001000");
			checkAndOrderBean.setContactPhone1("18600001001");
			checkAndOrderBean.setContactRelation1("亲属");
			checkAndOrderBean.setContactRelation2("朋友");
			
			checkAndOrderBean.setContractCallbackUrl("");
			checkAndOrderBean.setDepartment("");
			checkAndOrderBean.setEducation("本科");
			checkAndOrderBean.setEmployType("");
			checkAndOrderBean.setExtOrderId("test12312345");
			checkAndOrderBean.setHomeType("");
			checkAndOrderBean.setHospital_area("北京");
			checkAndOrderBean.setHospital_name("汉庭");
			checkAndOrderBean.setIdNo("111222199307060618");
			checkAndOrderBean.setIncomeMonth("3000");
			checkAndOrderBean.setJob("清洁工");
			checkAndOrderBean.setLoan_money("100000");
			checkAndOrderBean.setLoan_term("12");
			checkAndOrderBean.setMarryStatus("未婚");
			checkAndOrderBean.setMobile("13811112222");
			checkAndOrderBean.setName("鲁特金");
			checkAndOrderBean.setProject_name("整容套餐G");
			checkAndOrderBean.setProject_price("300000");
			checkAndOrderBean.setSign("");
			checkAndOrderBean.setStatusCallbackUrl("");
			checkAndOrderBean.setWorkYear("5");
			//拼装签名
			Map<String, String> data = new HashMap<String, String>();
			data.put("extOrderId", checkAndOrderBean.getExtOrderId());
			data.put("name", checkAndOrderBean.getName());
			data.put("idNo", checkAndOrderBean.getIdNo());
			data.put("mobile", checkAndOrderBean.getMobile());
			data.put("loan_money", checkAndOrderBean.getLoan_money());
			data.put("loan_term", checkAndOrderBean.getLoan_term());
			String reqSignStr = DigestUtils.getSignData("sign", data);
//			String sign = SignUtil.sign(reqSignStr, "D:/pk/gmd_private_key.pem");
			String file = TestInterface.class.getResource("gmd_private_key.pem").toURI().getPath();
			String sign = SignUtil.sign(reqSignStr, file);
			checkAndOrderBean.setSign(sign);//传入签名     
			
			String jsonString = JSON.toJSONString(checkAndOrderBean);
			System.out.println("JSON串为:" + jsonString);
//        String url = "http://127.0.0.1:8080/front.shandianx/foreign/receHtData.do";
			String url = "http://101.201.151.38/front.shandianx/foreign/receHtData.do";
			
			String result = APIHttpClient.post(url, jsonString);
			
			System.out.println("返回结果:" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
}

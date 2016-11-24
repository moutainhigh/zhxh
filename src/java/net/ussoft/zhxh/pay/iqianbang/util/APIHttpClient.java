package net.ussoft.zhxh.pay.iqianbang.util;

import java.io.IOException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

import com.alibaba.fastjson.JSON;

public class APIHttpClient {

    private static Log logger = LogFactory.getLog(APIHttpClient.class);
    private static HttpClient httpClient = new DefaultHttpClient();
    private static HttpPost method = null;
    private static long startTime = 0L;
    private static long endTime = 0L;
    private static int status = 0;

    /**
     * 调用 API
     * 
     * @param parameters
     * @return
     */
    public static String post(String url, String parameters) {
        String body = null;
        logger.info("parameters:" + parameters);
        method = new HttpPost(url);
        if (parameters != null && !"".equals(parameters.trim())) {
            String jsonObject = JSON.toJSONString(parameters);
            logger.info("json:" + jsonObject.toString());
            try {

                // List<NameValuePair> params = new ArrayList<NameValuePair>();
                // 建立一个NameValuePair数组，用于存储欲传送的参数
                // params.add(new BasicNameValuePair("data", parameters));
                // 添加参数
                // method.setEntity(new UrlEncodedFormEntity(params, HTTP.UTF_8));
                method.setEntity(new StringEntity(parameters, HTTP.UTF_8));
                method.setHeader("Content-type","application/json; charset=utf-8");
                method.setHeader("Accept", "application/json");
                startTime = System.currentTimeMillis();

                // 设置编码
                HttpResponse response = httpClient.execute(method);
                endTime = System.currentTimeMillis();
                int statusCode = response.getStatusLine().getStatusCode();
                logger.info("statusCode:" + statusCode);
                logger.info("调用API 花费时间(单位：毫秒)：" + (endTime - startTime));
                if (statusCode != HttpStatus.SC_OK) {
                    logger.error("Method failed:" + response.getStatusLine());
                    status = 1;
                }

                body = EntityUtils.toString(response.getEntity());

            } catch (IOException e) {
                // 发生网络异常
                logger.error("网络异常!\n");
                // 网络错误
                status = 3;
            }

        }
        return body;
    }

    /**
     * 0.成功 1.执行方法失败 2.协议错误 3.网络错误
     * 
     * @return the status
     */
    public int getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(int status) {
        this.status = status;
    }

    /**
     * @return the startTime
     */
    public long getStartTime() {
        return startTime;
    }

    /**
     * @return the endTime
     */
    public long getEndTime() {
        return endTime;
    }
}

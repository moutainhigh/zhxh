package net.ussoft.zhxh.pay.rmb;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

public class HttpClient {
	Map<String, String> parameter=new HashMap<String, String>();
	 HttpServletResponse response;
	 public HttpClient(HttpServletResponse response)
	 {
	    this.response=response;
	 }
	 public void setParameter(String key,String value)
	 {
	    this.parameter.put(key, value);
	 }
	public void sendByPost(String url) throws IOException
	 {
	    this.response.setContentType("text/html");
	    response.setCharacterEncoding("utf-8");
	    PrintWriter out = this.response.getWriter();
	    out.println("<!DOCTYPE HTML");
	    out.println("<HTML>");
	    out.println(" <HEAD><TITLE>sender</TITLE></HEAD>");
	    out.println(" <BODY>");
	    out.println("<form target=\"_blank\" name=\"kqForm\" action=\""+url+"\" method=\"post\">");
	    Iterator<String> it=this.parameter.keySet().iterator();
	    while(it.hasNext()){
	    	String key=it.next();
	    	out.println("<input type=\"hidden\" name=\""+key+"\" value=\""+this.parameter.get(key)+"\"/>");
	    }
	    out.println("</from>");
	    out.println("<script>kqForm.submit();</script> ");
	    out.println(" </BODY>");
	    out.println("</HTML>");
	    out.flush();
	    out.close();
	 }
}

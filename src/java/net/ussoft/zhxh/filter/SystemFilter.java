package net.ussoft.zhxh.filter;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.model.Sys_account;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;
import net.ussoft.zhxh.util.Logger;
  
/** 
 * User: springMVC拦截器 判断session中用户是否过期
 * Date: 13-10-27
 * Time: 下午7:31 
 * @author wangf
 */
  
public class SystemFilter implements Filter {
	
	private Logger log = new Logger(SystemFilter.class);
  
  
    @Override  
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {  
        if (!(servletRequest instanceof HttpServletRequest) || !(servletResponse instanceof HttpServletResponse)) {  
            throw new ServletException("OncePerRequestFilter just supports HTTP requests");  
        }
        log.debug("session filter 启动.");
        HttpServletRequest httpRequest = (HttpServletRequest) servletRequest;  
        HttpServletResponse httpResponse = (HttpServletResponse) servletResponse;
//        HttpSession session = httpRequest.getSession(true);

        String path = httpRequest.getContextPath();
    	String basePath = httpRequest.getScheme() + "://"
    			+ httpRequest.getServerName() + ":" + httpRequest.getServerPort()
    			+ path + "/";
    	
        StringBuffer url = httpRequest.getRequestURL();
        log.debug(url);
        
//        if (url.indexOf("kaptcha") != -1 || url.indexOf("init") != -1 || url.indexOf("page") != -1 || url.indexOf("login") != -1 || url.toString().equals(basePath)) {
//        	filterChain.doFilter(servletRequest, servletResponse);
//        	return;
//        }
//        
//        String servletPath = httpRequest.getServletPath();
//        if (servletPath.indexOf("css") >=0 ||  servletPath.indexOf("js") >=0 || servletPath.indexOf("image") >=0){
//        	filterChain.doFilter(servletRequest, servletResponse);
//        	return;
//        }
        
//        String[] strs = ProsReader.getString("INDICATION_APP_NAME").split("\\|");
        
        if (url.toString().equals(basePath)) {
        	filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
        
        String[] strs = {"kaptcha","init","page","login","css","js","image","pcMain","porder","mMain","file"};
        if (strs != null && strs.length > 0) {  
            for (String str : strs) {
                if (url.indexOf(str) >= 0) {
                    filterChain.doFilter(servletRequest, servletResponse);
                    return;
                }  
            }  
        }
        
//        Object object = session.getAttribute(Constants.user_in_session);
        Object object = CommonUtils.getSessionAttribute(httpRequest, Constants.user_in_session);
        Sys_account account = object == null ? null : (Sys_account) object;  
        if (account == null) {
            boolean isAjaxRequest = isAjaxRequest(httpRequest);
            if (isAjaxRequest) {
            	//TODO ajax提交的请求，session过期后，还是有问题。需要研究
                //httpResponse.setCharacterEncoding("UTF-8");
                //httpResponse.sendError(HttpStatus.UNAUTHORIZED.value(),"您已经太长时间没有操作,请刷新页面");
            	
            	//是ajax请求，则返回个消息给前台
//                PrintWriter printWriter = httpResponse.getWriter();
//                printWriter.print("{sessionState:timeout}");
//                printWriter.flush();
//                printWriter.close();
            	httpResponse.setHeader("sessionstatus", "timeout");  
            	httpResponse.sendError(518, "session timeout.");  
            	
//            	httpResponse.setContentType("text/xml;charset=UTF-8");
//            	httpResponse.setCharacterEncoding("UTF-8");
//        		PrintWriter out = httpResponse.getWriter();
//        		
//            	StringBuilder builder = new StringBuilder(); 
//                builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">"); 
//                builder.append("alert(\"页面过期，请重新登录\");"); 
//                builder.append("window.top.location.href=\""); 
//                builder.append(path); 
//                builder.append("/login.do\";</script>"); 
//                out.print(builder.toString()); 
//                out.close(); 
                return;  
            }
            httpResponse.sendRedirect(path + "/login.htmls");
            return;  
        }
        filterChain.doFilter(servletRequest, servletResponse);
        return;
    }  
  
    /** 
     * 判断是否为Ajax请求 
     * 
     * @param request HttpServletRequest 
     * @return 是true, 否false 
     */  
    public static boolean isAjaxRequest(HttpServletRequest request) {  
//        return request.getRequestURI().startsWith("/api");
        String requestType = request.getHeader("X-Requested-With");  
        return requestType != null && requestType.equals("XMLHttpRequest");  
    }  
  
    @Override  
    public void init(FilterConfig filterConfig) throws ServletException {  
           
    }  
  
    @Override  
    public void destroy() {  
        //To change body of implemented methods use File | Settings | File Templates.  
    }  
  
  
}  
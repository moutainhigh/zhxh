package net.ussoft.zhxh.filter;

import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import net.ussoft.zhxh.model.Sys_account;
import net.ussoft.zhxh.util.Constants;

public class SessionListener implements HttpSessionListener{

	public static HashMap sessionMap = new HashMap();
	
	@Override
	public void sessionCreated(HttpSessionEvent https) {
		System.out.println("s1");
		HttpSession session = https.getSession();
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent https) {
		System.out.println("s2");
		HttpSession session = https.getSession();
		this.DelSession(session);
	}

	public static synchronized void DelSession(HttpSession session) {
		System.out.println("s3");
		if (session != null) {
			// 删除单一登录中记录的变量
	        if(session.getAttribute( Constants.user_in_session)!=null){
	        	Sys_account account =  (Sys_account)session.getAttribute(Constants.user_in_session);
	        	SessionListener.sessionMap.remove(account.getId());     
	        }
		}
	}
	
}

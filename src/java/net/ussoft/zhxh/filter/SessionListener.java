package net.ussoft.zhxh.filter;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.util.Constants;


/**
 * 登录session监听类-处理同一时间只允许账号，单地点登录
 * @author guodh
 * @date 2016-11-14
 */
public class SessionListener implements HttpSessionAttributeListener {
	/**
	 * 用于存放账号和session对应关系的map
	 */
	private Map<String, HttpSession> map = new HashMap<String, HttpSession>();

	/**
	 * 当向session中放入数据触发
	 */
	public void attributeAdded(HttpSessionBindingEvent event) {
		String name = event.getName();
//		System.out.println("当向session中放入数据");
		if (name.equals(Constants.PC_USER_SESSION)) {
			Public_user user = (Public_user) event.getValue();
			if (map.get(user.getId()) != null) {
				HttpSession session = map.get(user.getId());
				session.removeAttribute(Constants.PC_USER_SESSION);
//				session.invalidate();
			}
			map.put(user.getId(), event.getSession());
		}

	}
	/**
	 * 当向session中移除数据触发
	 */
	public void attributeRemoved(HttpSessionBindingEvent event) {
		String name = event.getName();
//		System.out.println("当向session中移除数据");
		if (name.equals(Constants.PC_USER_SESSION)) {
			Public_user user = (Public_user) event.getValue();
			map.remove(user.getId());

		}
	}

	public void attributeReplaced(HttpSessionBindingEvent event) {

	}

	public Map<String, HttpSession> getMap() {
		return map;
	}

	public void setMap(Map<String, HttpSession> map) {
		this.map = map;
	}
}

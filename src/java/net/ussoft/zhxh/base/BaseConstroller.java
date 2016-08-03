package net.ussoft.zhxh.base;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import net.ussoft.zhxh.model.Sys_account;
import net.ussoft.zhxh.service.IAccountService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;

/**
 * 控制器父类
 * 一些系统通用的操作
 * @author wangf
 *
 */
public class BaseConstroller {
	
	
	@Resource
	private IAccountService accountService;
	
	@Autowired  
	private  HttpServletRequest request; 
	
	/**
	 * 获取session里的帐户实体类
	 * @return
	 */
	public Sys_account getSessionAccount() {
		Sys_account accountSession = (Sys_account) CommonUtils.getSessionAttribute(request, Constants.user_in_session);
		return accountSession;
	}
	
	/**
	 * 获取项目根路径  例如 /archive 
	 * @return
	 */
	public String getProjectPath() {
		return request.getContextPath();
	}
	/**
	 * 获取项目绝对路径 例如：d:/aaa
	 * @return
	 */
	public String getProjectRealPath() {
		return request.getSession().getServletContext().getRealPath("/");
	}
	
	/**
	 * 获取项目全路径  例如 http://localhost:8080/archive 
	 * @return
	 */
	public String getProjectBasePath() {
		String path = request.getContextPath();
    	String basePath = request.getScheme() + "://"
    			+ request.getServerName() + ":" + request.getServerPort()
    			+ path + "/";
    	
    	return basePath;
	}
	
	
}

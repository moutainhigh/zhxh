package net.ussoft.zhxh.base;

import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.ussoft.zhxh.filter.SessionListener;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_content;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Sys_account;
import net.ussoft.zhxh.model.Sys_public;
import net.ussoft.zhxh.service.IAccountService;
import net.ussoft.zhxh.service.IPublicBrandService;
import net.ussoft.zhxh.service.IPublicContentService;
import net.ussoft.zhxh.service.ISysPublicService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;

/**
 * 控制器父类
 * 一些系统通用的操作
 * @author wangf
 *
 */
public class BaseConstroller {
	
	
	@Resource
	private IAccountService accountService;
	
	@Resource
	private IPublicBrandService brandService;	//品牌
	
	@Resource
	private IPublicContentService contentService;  //富文本
	
	@Resource
	private ISysPublicService publicService;	//LOGO
	
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
	 * 获取session里的帐户实体类
	 * @return
	 */
	public Public_user getSessionUser() {
		Public_user userSession = (Public_user) CommonUtils.getSessionAttribute(request, Constants.PC_USER_SESSION);
		return userSession;
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
	
	public void init(ModelMap modelMap){
		//首页logo
		Sys_public logo = publicService.getById("1");
		modelMap.put("logo", logo);
		//品牌
		List<Public_brand> brandList = brandService.list(1);
		
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		map.put("parentid = ", "content");
		map.put("parenttype = ", "subject");	//专题-
		map.put("isshow = ", 1);			//显示
		//专题
		List<Public_content> subjectList = contentService.list(map);
		
		modelMap.put("brandList", brandList);
		modelMap.put("subjectList", subjectList);
	}
	
	/**
	 * 初始化购物车 数量
	 * @param flag true:减；false:加
	 * */
	public int catinit(boolean flag,int num){
		int catnum = 0;
		if(flag){
			int catnum_s = (int) CommonUtils.getSessionAttribute(request, Constants.CAT_NUM);
			request.getSession().removeAttribute(Constants.CAT_NUM);
			catnum = catnum_s -num;
			CommonUtils.setSessionAttribute(request, Constants.CAT_NUM, catnum);
		}else{
			int catnum_s = (int) CommonUtils.getSessionAttribute(request, Constants.CAT_NUM);
			request.getSession().removeAttribute(Constants.CAT_NUM);
			catnum = catnum_s + num;
			CommonUtils.setSessionAttribute(request, Constants.CAT_NUM, catnum);
		}
		
		return catnum;
	}
	
	public int getCatnum(){
		int catnum = (int) CommonUtils.getSessionAttribute(request, Constants.CAT_NUM);
		return catnum;
	}
	
	/**
	 * 通过用户ID来强行把已经在线的用户的登录信息
	 * @param uid
	 * @return
	 * */
	public static void forceLogoutUser(String uid) {
		// 删除单一登录中记录的变量
		if(SessionListener.sessionMap.get(uid) != null) {
			Object obj = SessionListener.sessionMap.get(uid);
			if(obj != null){
				HttpSession hs = (HttpSession) SessionListener.sessionMap.get(uid);
				SessionListener.sessionMap.remove(uid);
				Enumeration e = hs.getAttributeNames();
				while (e.hasMoreElements()) {
					String sessionName = (String) e.nextElement();
					// 清空session
					hs.removeAttribute(sessionName);
	           }
//	           hs.invalidate();
			}
		}
	}
}

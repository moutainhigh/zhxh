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
	 * 获取系统配置表（sys_config）内容，形成map类型。供子类
	 */
//	public HashMap<String, Object> getConfig(String accountid) {
//		List<Sys_config> configList = configService.list();
//		
//		HashMap<String, Object> configMap = new HashMap<String, Object>();
//		for (Sys_config config : configList) {
//			configMap.put(config.getConfigkey(), config.getConfigvalue());
//		}
//		return configMap;
//	}
	
	/**
	 * 获取当前帐户的角色，如果帐户没有角色，获取所属组的角色
	 * @param accountid		帐户id
	 * @return
	 */
//	public String getAuthRole(String accountid) {
//		//获取帐户对象
//		Sys_account account = accountService.getById(accountid);
//		String roleid = account.getRoleid();
//		//如果帐户自己的角色为空
//		if (roleid == null || roleid.equals("")) {
//			//获取帐户所属组的角色
//			Sys_org org = orgService.getById(account.getOrgid());
//			roleid = org.getRoleid();
//		}
//		//如果还是为空，返回null
////		if (roleid == null || roleid.equals("")) {
////			return null;
////		}
//		
//		return roleid;
//	}
	
	/**
	 * 根据角色id，获取角色能控制的功能list
	 * @param roleid
	 * @return
	 */
//	public List<Sys_function> getFunctions(String roleid) {
//		return roleService.searchFunctions(roleid);
//	}
	
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

package net.ussoft.zhxh.web;

import java.awt.image.BufferedImage;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Producer;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Sys_account;
import net.ussoft.zhxh.model.Sys_function;
import net.ussoft.zhxh.model.Sys_init;
import net.ussoft.zhxh.service.IAccountService;
import net.ussoft.zhxh.service.IEncryService;
import net.ussoft.zhxh.service.IInitService;
import net.ussoft.zhxh.service.ILoginlogService;
import net.ussoft.zhxh.service.IRoleService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;
import net.ussoft.zhxh.util.EncryptionDecryption;
import net.ussoft.zhxh.util.HardWareUtils;
import net.ussoft.zhxh.util.IndexerTimer;
import net.ussoft.zhxh.util.LogTimer;
import net.ussoft.zhxh.util.Logger;


@Controller
//@RequestMapping("login")
public class LoginController extends BaseConstroller {
	
	private Logger log = new Logger(LoginController.class);
	
	@Resource
	private IAccountService accountService;
	@Resource
	private IRoleService roleService;
	@Resource
	private IInitService initService;
	@Resource
	private ILoginlogService loginlogService;
	
	@Autowired
	private Producer captchaProducer = null;
	
	@Resource
    private IEncryService encryService;
	
	@RequestMapping(value="/login")
	public String login (ModelMap modelMap) throws Exception {
		
		HashMap<String, Object> configMap = getConfig("SYSTEM");
		modelMap.put("sysname", configMap.get("SYSNAME"));
		
		//系统注册验证
		Boolean regist = regist();
//		Boolean regist = true;
		if (regist) {
			return "login";
		}
		else {
			String osCode = getLocalOsCode();
			String createRegistCode = getRegistCode(osCode);
			modelMap.put("registcode", createRegistCode);
			return "regist";
		}
		
	}
	
	//系统注册验证
	public Boolean regist() throws Exception {
		
		Boolean result = false;
		//获取机器码
		String osCode = getLocalOsCode();
		
		String tmp = getRegistCode(osCode);
		
		EncryptionDecryption des = new EncryptionDecryption();
		String createRegistCode = des.encrypt(tmp);
		
		//检查系统注册，如果注册不对，转到注册页.
		Sys_init init = new Sys_init();
		init.setInitkey("registcode");
		init = initService.selectByWhere(init);
		
		if (null != init) {
			String registcode = init.getInitvalue();
			
			//如果注册码为空
			if (!init.getInitvalue().equals("") && createRegistCode.equals(registcode)) {
				result = true;
			}
		}
				
		return result;
	}
	//获取本机mac地址
	public String getLocalOsCode() throws Exception {
		
		String os = System.getProperty("os.name").toLowerCase();
		//计算机器码
		String jiqima = "";
		if (os.startsWith("windows")) {
			jiqima = HardWareUtils.getHardDiskSN("c");
		} else if (os.startsWith("linux") ) {
			jiqima = HardWareUtils.getCPUSerialForLinux();
		} else if (os.startsWith("mac os x")) {
			jiqima = HardWareUtils.getMacosxUUID();
		}
		
		return jiqima;
	}
	
	//生成本机注册码
	public String getRegistCode(String str) throws Exception {
		EncryptionDecryption des = new EncryptionDecryption("regist");
		
		String registCode = des.encrypt(str);
		return registCode;
	}
	
	@RequestMapping(value="/onRegist", method=RequestMethod.POST)
	public String onRegist(String initvalue,String kaptchafield,HttpServletRequest request,ModelMap modelMap) throws Exception {
		
		String kaptchaCode = (String) CommonUtils.getSessionAttribute(request, com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		if (kaptchaCode == null || !kaptchaCode.equals(kaptchafield)) {
			modelMap.put("result", "输入的验证码错误，请重新输入。");
			String mac = getLocalOsCode();
			String createRegistCode = getRegistCode(mac);
			modelMap.put("registcode", createRegistCode);
			return "regist";
		}
		
		//获取对象
		Sys_init init = initService.selectById("6");
		init.setInitvalue(initvalue);
		int num = initService.update(init);
		if (num >0) {
			//modelMap.put("result", "修改成功");
		}
		else {
			//modelMap.put("result", "修改时发生问题，请重新尝试或与管理员联系。");
		}
		List<Sys_init> initList = initService.list();
		for (Sys_init sys_init : initList) {
			modelMap.put(sys_init.getInitkey(), sys_init);
		}
		
		//系统注册验证
		Boolean regist = regist();
		if (regist) {
			return "login";
		}
		else {
			String mac = getLocalOsCode();
			String createRegistCode = getRegistCode(mac);
			modelMap.put("registcode", createRegistCode);
			return "regist";
		}
				
	}
	
	protected String getRemoteIp(HttpServletRequest request){
		
		String remoteIp = request.getHeader("x-forwarded-for");
        if (remoteIp == null || remoteIp.isEmpty() || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp= request.getHeader("X-Real-IP");
        }
        if (remoteIp == null || remoteIp.isEmpty() || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp= request.getHeader("Proxy-Client-IP");
        }
        if (remoteIp == null || remoteIp.isEmpty() || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp= request.getHeader("WL-Proxy-Client-IP");
        }
        if (remoteIp == null || remoteIp.isEmpty() || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp= request.getHeader("HTTP_CLIENT_IP");
        }
        if (remoteIp == null || remoteIp.isEmpty() || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp= request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (remoteIp == null || remoteIp.isEmpty() || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp= request.getRemoteAddr();
        }
        if (remoteIp == null || remoteIp.isEmpty() || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp= request.getRemoteHost();
        }
        return remoteIp;
    }
	
	@RequestMapping(value="/onlogin",method=RequestMethod.POST)
	public ModelAndView onLogin(Sys_account account,String kaptchafield,HttpServletRequest request,ModelMap modelMap) {
		
		log.debug("进入登录。。");
		
		//判断验证码
//		String kaptchaCode = (String)session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		String kaptchaCode = (String) CommonUtils.getSessionAttribute(request, com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		if (kaptchaCode == null || !kaptchaCode.equals(kaptchafield)) {
			modelMap.put("result", "输入的验证码错误，请重新输入。");
			return new ModelAndView("login",modelMap);
		}
		
		//登录时先判断session里是否有该账户,防止同一台机器有2个session登录
//		Sys_account accountSession = (Sys_account) CommonUtils.getSessionAttribute(request, Constants.user_in_session);
		Sys_account accountSession = super.getSessionAccount();
		if (accountSession != null){
			CommonUtils.removeSessionAttribute(request, Constants.user_in_session);
//			request.getSession().removeAttribute(Constants.user_in_session);
		}
		
		if(!CommonUtils.isNotNullAndEmpty(account.getAccountcode(),account.getPassword())){
			//帐号或密码为""或NULL
			modelMap.put("result", "输入的帐户名 或密码错误，请重新输入。");
			return new ModelAndView("login",modelMap);
		}
		
		Sys_account res = accountService.login(account);
		
		if (null != res) {
			HashMap<String, Object> configMap = getConfig("SYSTEM");
			modelMap.put("sysname", configMap.get("SYSNAME"));
			//这里要判断帐户的状态，如果为不启用，就拒绝访问
			if (res.getAccountstate() == 0) {
				modelMap.put("result", "您的帐户已被禁用，请与管理员联系。");
				return new ModelAndView("login",modelMap);
			}
		
			//用户登录成功，将用户实体存入session
			CommonUtils.setSessionAttribute(request, Constants.user_in_session, res);
			//获取帐户角色能访问的功能
			String roleid = super.getAuthRole(res.getId());
			List<Sys_function> functions = super.getFunctions(roleid);
			modelMap.put("functions", functions);
			
			//日志
			String ip = getRemoteIp(request);
			loginlogService.saveAccoutLoginlog(res, ip);
			
			//判断是否有全文检索。开始全文检索定时器
//			try {
//				if (encryService.getInit("ISQWJS") ) {
//					//开启定时任务，每天定时创建电子文件索引
//					IndexerTimer.showTimer();
//				}
//			} catch (Exception e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			
//			//清除日志定时器
//			LogTimer.showTimer();
			
			return new ModelAndView("/view/main", modelMap);
		}else {
			modelMap.put("result", "输入的帐户名 或密码错误，请重新输入。");
			return new ModelAndView("login",modelMap);
		}
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpServletRequest request,ModelMap modelMap) {
		request.getSession().removeAttribute(Constants.user_in_session);
		request.getSession().invalidate();
		HashMap<String, Object> configMap = getConfig("SYSTEM");
		modelMap.put("sysname", configMap.get("SYSNAME"));
		return "login";
	}
	
	@RequestMapping("/kaptcha")  
	public void initCaptcha(HttpServletRequest request,HttpServletResponse response) throws Exception{
		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("image/jpeg");
		String capText = captchaProducer.createText();
		request.getSession().setAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY, capText);  
		BufferedImage bi = captchaProducer.createImage(capText);

		ServletOutputStream out = response.getOutputStream();
		ImageIO.write(bi, "jpg", out);

		try{
			out.flush();
			}finally{
				out.close();
			}
		}
}

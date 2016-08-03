package net.ussoft.zhxh.web.system;

import java.awt.image.BufferedImage;

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
import net.ussoft.zhxh.service.IAccountService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;
import net.ussoft.zhxh.util.Logger;


@Controller
//@RequestMapping("login")
public class LoginController extends BaseConstroller {
	
	private Logger log = new Logger(LoginController.class);
	
	@Resource
	private IAccountService accountService;
	
	@Autowired
	private Producer captchaProducer = null;
	
	@RequestMapping(value="/login")
	public String login (ModelMap modelMap) throws Exception {
		return "view/system/login";
	}
	
	@RequestMapping(value="/onlogin",method=RequestMethod.POST)
	public ModelAndView onLogin(Sys_account account,String kaptchafield,HttpServletRequest request,ModelMap modelMap) {
		
		log.debug("进入登录。。");
		
		//判断验证码
//		String kaptchaCode = (String)session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		String kaptchaCode = (String) CommonUtils.getSessionAttribute(request, com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		if (kaptchaCode == null || !kaptchaCode.equals(kaptchafield)) {
			modelMap.put("result", "输入的验证码错误，请重新输入。");
			return new ModelAndView("view/system/login",modelMap);
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
			return new ModelAndView("view/system/login",modelMap);
		}
		
		Sys_account res = accountService.login(account);
		
		if (null != res) {
//			//这里要判断帐户的状态，如果为不启用，就拒绝访问
//			if (res.getAccountstate() == 0) {
//				modelMap.put("result", "您的帐户已被禁用，请与管理员联系。");
//				return new ModelAndView("login",modelMap);
//			}
		
			//用户登录成功，将用户实体存入session
			CommonUtils.setSessionAttribute(request, Constants.user_in_session, res);
			
			return new ModelAndView("/view/system/main", modelMap);
		}else {
			modelMap.put("result", "输入的帐户名 或密码错误，请重新输入。");
			return new ModelAndView("view/system/login",modelMap);
		}
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpServletRequest request,ModelMap modelMap) {
		request.getSession().removeAttribute(Constants.user_in_session);
		request.getSession().invalidate();
//		return "login";
		return "redirect:/login.htmls";
//		return "view/system/login";
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

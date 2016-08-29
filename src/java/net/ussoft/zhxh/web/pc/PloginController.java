package net.ussoft.zhxh.web.pc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Public_cat;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicCatService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;
import net.ussoft.zhxh.util.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
//@RequestMapping("m")
public class PloginController extends BaseConstroller {
	
	private Logger log = new Logger(PloginController.class);
	
	@Resource
	private IPublicUserService userService;
	@Resource
	private IPublicCatService catService;
	
	@RequestMapping(value="/login_single")
	public String login_single (ModelMap modelMap) throws Exception {
		return "view/pc/login_single";
	}
	
	@RequestMapping(value="/plogin",method=RequestMethod.POST)
	public void onLogin(String uname,String pwd,HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		log.debug("进入登录。。");
		
		/*//判断验证码
		String kaptchaCode = (String) CommonUtils.getSessionAttribute(request, com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		if (kaptchaCode == null || !kaptchaCode.equals(kaptchafield)) {
			out.print("输入的验证码错误，请重新输入。");
			return;
		}*/
		
		//登录时先判断session里是否有该账户,防止同一台机器有2个session登录
		Public_user userSession = (Public_user) CommonUtils.getSessionAttribute(request, Constants.PC_USER_SESSION);
		if (userSession != null){
			CommonUtils.removeSessionAttribute(request, Constants.PC_USER_SESSION);
//			request.getSession().removeAttribute(Constants.user_in_session);
		}
		
		if(!CommonUtils.isNotNullAndEmpty(uname,pwd)){
			//帐号或密码为""或NULL
			out.print("输入的帐户名 或密码错误，请重新输入。");
			return;
		}
		
		Public_user res = userService.getByPhoneNum(uname);
		
		if (null != res) {
//			//这里要判断帐户的状态，如果为不启用，就拒绝访问
//			if (res.getAccountstate() == 0) {
//				modelMap.put("result", "您的帐户已被禁用，请与管理员联系。");
//				return new ModelAndView("login",modelMap);
//			}
		
			//用户登录成功，将用户实体存入session
			CommonUtils.setSessionAttribute(request, Constants.PC_USER_SESSION, res);
			
		}else {
			out.print("输入的帐户名 或密码错误，请重新输入。");
			return;
		}
		//初始，购物车商品类数量
		List<Public_cat> catList = catService.list(res.getId());
		CommonUtils.setSessionAttribute(request, Constants.CAT_NUM, catList.size());
		out.print("success");
	}
	
	@RequestMapping(value="/plogout")
	public String logout(HttpServletRequest request,ModelMap modelMap) {
		request.getSession().removeAttribute(Constants.PC_USER_SESSION);
		request.getSession().invalidate();
		return "redirect:/";
	}
	
	
	/**
	 * 注册
	 * @param objs
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/reg",method=RequestMethod.POST)
	public void register(Public_user user,HttpServletResponse response) throws Exception {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "error";
		Public_user obj = userService.insert(user);
		if(obj != null)
			result = "success";
		out.print(result);
	}
	
	
	
}

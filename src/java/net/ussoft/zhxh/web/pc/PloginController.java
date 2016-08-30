package net.ussoft.zhxh.web.pc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Public_cat;
import net.ussoft.zhxh.model.Public_phone_code_log;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicCatService;
import net.ussoft.zhxh.service.IPublicPhoneCodeLogService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;
import net.ussoft.zhxh.util.DateUtil;
import net.ussoft.zhxh.util.Logger;
import net.ussoft.zhxh.util.MD5;

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
	@Resource
	private IPublicPhoneCodeLogService codeLogService;
	
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
	@RequestMapping(value="/plogin_reg",method=RequestMethod.POST)
	public void register(Public_user user,String sendcode,HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "error";
		
		//获取验证码session
		HashMap<String,Object> map = (HashMap<String,Object>) CommonUtils.getSessionAttribute(request, Constants.CODE_SESSION);
		
		if (map == null){
//			CommonUtils.removeSessionAttribute(request, Constants.PC_USER_SESSION);
			out.print(result);
			return;
		}
		
		if (!user.getPhonenumber().equals(map.get("phonenumber").toString())) {
			out.print("phoneerror");
			return;
		}
		
		if (!sendcode.equals(map.get("sendCode").toString())) {
			out.print("codeerror");
			return;
		}
		
		Long oldTime = (Long) map.get("codetime");
		
		//当前时间戳
		Long s = (System.currentTimeMillis() - oldTime) / (1000 * 60);
		
		if (s > 2) {
			CommonUtils.removeSessionAttribute(request, Constants.CODE_SESSION);
			out.print("timeout");
			return;
		}
		
		Public_user tmp = new Public_user();
		tmp.setId(UUID.randomUUID().toString());
		tmp.setUsername(user.getUsername());
		tmp.setPhonenumber(user.getPhonenumber());
		
		tmp.setPassword(MD5.encode(user.getPassword()));
		
		
		Public_user obj = userService.insert(tmp);
		
		if(obj != null) {
			result = "success";
		}
		out.print(result);
	}
	
	/**
	 * 产生随机的六位数
	 * @return
	 */
	public static String getSix(){
		Random rad=new Random();
		String result  = rad.nextInt(1000000) +"";
		
		if(result.length()!=6){
			return getSix();
		}
		return result;
	}
	
	@RequestMapping(value="/plogin_getCode",method=RequestMethod.POST)
	public void getCode(String phonenumber,HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		if (null == phonenumber || "".equals(phonenumber)) {
			out.print("empty");
			return;
		}
		
		//判断手机号码是否重复
		boolean isok = userService.checkPhoneNum(phonenumber);
		
		if (isok) {
			out.print("exist");
			return;
		}
		
		String sendCode = getSix();
		
		//TODO 发送短信验证码到手机
		
		
		
		//当前时间戳
		Long oldTime = System.currentTimeMillis();
		
		//s为原时间戳和当前时间戳中间相隔的分钟数
//		Long s = (System.currentTimeMillis() - oldTime) / (1000 * 60);
		CommonUtils.removeSessionAttribute(request, Constants.CODE_SESSION);
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("sendCode", sendCode);
		map.put("phonenumber", phonenumber);
		map.put("codetime", oldTime);
		CommonUtils.setSessionAttribute(request, Constants.CODE_SESSION, map);
		
		//将发送情况写入日志
		Public_phone_code_log codeLog = new Public_phone_code_log();
		codeLog.setId(UUID.randomUUID().toString());
		codeLog.setPhonenumber(phonenumber);
		codeLog.setSendcode(sendCode);
		codeLog.setSendtime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		codeLog.setSendtimestr(oldTime.toString());
		codeLog.setSendtype("PCREG");
		codeLog.setIp(getRemoteIp(request));
		codeLogService.insert(codeLog);
		
		//TODO 返回值先用code代替。等短信连接上了，更改为success
		out.print(sendCode);
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
	
	
	
}

package net.ussoft.zhxh.web.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_dis_config;
import net.ussoft.zhxh.model.Public_phone_code_log;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicDisService;
import net.ussoft.zhxh.service.IPublicPhoneCodeLogService;
import net.ussoft.zhxh.service.IPublicUserLinkService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;
import net.ussoft.zhxh.util.DateUtil;
import net.ussoft.zhxh.util.MD5;


@Controller
@RequestMapping("/orderUser")
public class OrderUserController extends BaseConstroller {
	
	@Resource
	private IPublicUserService userService;
	@Resource
	private IPublicUserLinkService userlinkService;	//个人中心关联关系
	@Resource
	private IPublicPhoneCodeLogService codeLogService;
	@Resource
	private IPublicDisService disService;
	
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(String parentid,String identity,String mapObj,int pageIndex,
			int pageSize,@RequestParam(value="showtype", defaultValue="1") int showtype,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		//分页
		PageBean<Public_user> pageBean = new PageBean<Public_user>();
		pageBean.setPageSize(pageSize);
		pageBean.setPageNo(pageIndex + 1);
		
		Map<String, Object> searchMap = new HashMap<String,Object>();
		
		if (null != mapObj && !"".equals(mapObj)) {
			searchMap = (Map<String, Object>) JSON.parse(mapObj);
		}
		
		userService.list(parentid, identity, searchMap,showtype, pageBean);
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("total", pageBean.getRowCount());
		map.put("data", pageBean.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	@RequestMapping(value="/getParentlist",method=RequestMethod.POST)
	public void getParentlist(String userid,String mapObj,int pageIndex,
			int pageSize,@RequestParam(value="isPage", defaultValue="false") boolean isPage,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		//分页
		PageBean<Public_user> pageBean = new PageBean<Public_user>();
		
		if (isPage) {
			pageBean.setPageSize(pageSize);
			pageBean.setPageNo(pageIndex + 1);
		}
		else {
			pageBean.setIsPage(false);
		}
		
		Map<String, Object> searchMap = new HashMap<String,Object>();
		
		if (null != mapObj && !"".equals(mapObj)) {
			searchMap = (Map<String, Object>) JSON.parse(mapObj);
		}
		
		userService.getParentlist(userid, searchMap, pageBean);
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("total", pageBean.getRowCount());
		map.put("data", pageBean.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	@RequestMapping(value="/disConfig",method=RequestMethod.POST)
	public void disConfig(HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		Public_dis_config dis = disService.getById("1");
		String json = JSON.toJSONString(dis);
		out.print(json);
	}
	
	
	
	/**
	 * 检查手机号是否存在。
	 * @param userid			机构id
	 * @param phoneNum			手机号码
	 * @param checkType			检查类型。 insert 新建。判断是否唯一。update 要判断是否等于原值，等于说明没有更改放过，不等于判断是否已存在
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/checkPhoneNum",method=RequestMethod.GET)
	public void checkPhoneNum(String userid,String phoneNum,String checkType,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		boolean flag = true;
		//判断检查类型
		if (checkType.equals("insert")) {
			flag = userService.checkPhoneNum(phoneNum);
		}
		else {
			Public_user user = userService.getById(userid);
			if (user.getPhonenumber().equals(phoneNum)) {
				flag = false;
			}
			else {
				flag = userService.checkPhoneNum(phoneNum);
			}
		}
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		if (flag) {
			map.put("getdata", "false");
		}
		else {
			map.put("getdata", "true");
		}
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 获取手机验证码
	 * @param phonenumber
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/getCode",method=RequestMethod.POST)
	public void getCode(String userid,String phonenumber,String sendType,HttpServletRequest request,HttpServletResponse response) throws Exception {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		if (null == phonenumber || "".equals(phonenumber)) {
			out.print("empty");
			return;
		}
		
		//判断手机号码是否重复
//		int num = userService.checkPhoneNum(phonenumber);
		boolean flag = true;
		if (null != sendType) {
			if ("insert".equals(sendType)) {
				flag = userService.checkPhoneNum(phonenumber);
				if (flag) {
					out.print("exist");
					return;
				}
			}
			else if ("update".equals(sendType)) {
				Public_user user = userService.getById(userid);
				if (user.getPhonenumber().equals(phonenumber)) {
//					flag = false;
				}
				else {
					flag = userService.checkPhoneNum(phonenumber);
					if (flag) {
						out.print("exist");
						return;
					}
				}
			}
		}
		
		String sendCode = getSix();
		
		String logType = "ORDERREG";
		//发送短信验证码到手机
		String send_content = "您的注册验证码是" + sendCode;
		if (null != sendType) {
			if (sendType.equals("update")) {
				send_content = "您正在修改个人信息，修改信息验证码是"+sendCode+",如非您个人操作，请忽略并与本网站联系。";
				logType = "ORDERUPDATE";
			}
		}
//		SendSMS.sendMessage(phonenumber, send_content);
		savePhoneCodeLog(phonenumber, sendCode, logType, request);
		
		out.print("success");
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
	
	/**
	 * 验证码发送日志
	 * @param phonenumber
	 * @param sendCode
	 * @param sendType
	 * @param request
	 * */
	private void savePhoneCodeLog(String phonenumber,String sendCode,String sendType,HttpServletRequest request){

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
		codeLog.setSendtype(sendType);	//类型
		codeLog.setIp(getRemoteIp(request));
		codeLogService.insert(codeLog);
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
	
	
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public void save(String objs,HttpServletRequest request,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		
		if ("".equals(objs) || objs == null) {
			out.print(result);
			return;
		}
		//
		List<Map<String, String>> rows = (List<Map<String, String>>) JSON.parse(objs);
		
		for(int i=0,l=rows.size(); i<l; i++){
			Map<String,String> row = (Map<String,String>)rows.get(i);
	  		  
			String id = row.get("id") != null ? row.get("id").toString() : "";
	        String state = row.get("_state") != null ? row.get("_state").toString() : "";
	        //新增：id为空，或_state为added
	        if(state.equals("added") || id.equals("")) {
	        	result = insert(row, request);
	        }
	        else if (state.equals("removed") || state.equals("deleted")) {
	        	delete(id);
	        }
	        //更新：_state为空，或modified
	        else if (state.equals("modified") || state.equals(""))	 {
	            update(row,request);
	        }
	    }
		CommonUtils.removeSessionAttribute(request, Constants.CODE_SESSION);
		out.print(result);
	}
	
	/**
	 * 添加
	 * @param row
	 * @return
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	private String insert(Map<String,String> row,HttpServletRequest request) throws IllegalAccessException, InvocationTargetException {
		if (null == row) {
			return "error";
		}
		
		//获取验证码session
		HashMap<String,Object> map = (HashMap<String,Object>) CommonUtils.getSessionAttribute(request, Constants.CODE_SESSION);
		
		if (map == null){
			return "codeerror";
		}
		String sendCode = row.get("sendcode");
		if (null == sendCode || !sendCode.equals(map.get("sendCode").toString())) {
			return "codeerror";
		}
				
		Public_user user = new Public_user(UUID.randomUUID().toString());
		BeanUtils.populate(user, row);
		
		//验证手机号是否已存在
		boolean flag = userService.checkPhoneNum(user.getPhonenumber());
		if(!flag){
//			user.setId(UUID.randomUUID().toString());
			
			if (user.getIdentity().equals("A")) {
				user.setIdentitymemo("代理");
			}
			else if (user.getIdentity().equals("C")) {
				user.setIdentitymemo("门店");
			}
			else if (user.getIdentity().equals("Z")) {
				user.setIdentitymemo("普通会员");
			}
			user.setSetreturn(0);
			user.setIsopen(0);
			
			Public_user pUser = super.getSessionUser();
			if (!user.getIdentity().equals("Z")) {
				if (null != pUser) {
					user.setParentid(pUser.getId());
				}
			}
			else {
				if (null != pUser) {
					user.setBelongcode(pUser.getCompanycode());
				}
			}
			
			//密码md5
			String pass = MD5.encode("123456");
			user.setPassword(pass);
			user.setCreatetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
			
			int num = userService.insert(user);
			
			if (num > 0) {
				return "success";
			}
			else {
				return "error";
			}
		}else{
			return "isPhoneNum";
		}
	}
	
	/**
	 * 更新
	 * @param row
	 * @return
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	private String update(Map<String,String> row,HttpServletRequest request) throws IOException, IllegalAccessException, InvocationTargetException {
		if (null == row) {
			return "error";
		}
		if (row.get("updatePhone").equals("1")) {
			//获取验证码session
			HashMap<String,Object> map = (HashMap<String,Object>) CommonUtils.getSessionAttribute(request, Constants.CODE_SESSION);
			
			if (map == null){
				return "codeerror";
			}
			String sendCode = row.get("sendcode");
			if (null == sendCode || !sendCode.equals(map.get("sendCode").toString())) {
				return "codeerror";
			}
		}
		
		Public_user user = new Public_user();
		BeanUtils.populate(user, row);
		//
		boolean flag = true;
		Public_user pUser = userService.getById(user.getId());
		if(user.getPhonenumber().equals(pUser.getPhonenumber())){
			flag = false;
		}else{
			//验证手机号是否已存在
			flag = userService.checkPhoneNum(user.getPhonenumber());
		}
		
		if(!flag){
			int num = userService.update(user);
			if(num > 0){
				return "success";
			}
			return "error";
		}else{
			return "isPhoneNum";
		}
	}
	
	private void delete(String id) {
		userService.delete(id);
	}
	
	/**
	 * 批量修改机构信息。某个字段
	 * @param updateUserids
	 * @param field
	 * @param fieldValue
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/updateBatch",method=RequestMethod.POST)
	public void updateBatch(String parentid,String updateUserids,String field,String fieldValue,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String flag = "error";
		
		boolean isok = userService.updateBatch(parentid,updateUserids, field, fieldValue);
		
		if (isok) {
			flag = "success";
		}
		
		out.print(flag);
	}
	
	/**
	 * 批量删除机构
	 * @param delUserids
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/delBatch",method=RequestMethod.POST)
	public void delBatch(String delUserids,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String flag = "error";
		
		int isok = userService.delete(delUserids);
		
		if (isok > 0) {
			flag = "success";
		}
		
		out.print(flag);
	}
	
	@RequestMapping(value="/getUser",method=RequestMethod.POST)
	public void getUser(String id,HttpServletResponse response,HttpServletRequest request) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		Public_user user = null;
		
		if (null == id || "".equals(id)) {
			user = getSessionUser();
			id = user.getId();
		}
		
		user = userService.getById(id);
		
		String json = JSON.toJSONString(user);
		
		out.print(json);
		
	}
	
}

package net.ussoft.zhxh.web.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicUserLinkService;
import net.ussoft.zhxh.service.IPublicUserService;


@Controller
@RequestMapping("/orderUser")
public class OrderUserController extends BaseConstroller {
	
	@Resource
	private IPublicUserService userService;
	@Resource
	private IPublicUserLinkService userlinkService;	//个人中心关联关系
	
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(String parentid,String identity,String mapObj,int pageIndex,int pageSize,@RequestParam(value="showtype", defaultValue="1") int showtype,HttpServletResponse response) throws IOException {
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
}

package net.ussoft.zhxh.web.pc;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Brandfirst;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_content;
import net.ussoft.zhxh.model.Public_pic;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IBrandfirstService;
import net.ussoft.zhxh.service.IPublicBrandService;
import net.ussoft.zhxh.service.IPublicContentService;
import net.ussoft.zhxh.service.IPublicPicService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("pcMain")
public class PcMainController extends BaseConstroller {
	
	private Logger log = new Logger(PcMainController.class);
	
	@Resource
	IPublicPicService picService;	//公共图片
	
	@Resource
	IPublicBrandService brandService;	//品牌
	
	@Resource
	IPublicContentService contentService;  //富文本
	
	@Resource
	IPublicUserService userService;	//会员
	
	@Resource
	IBrandfirstService bfService;	//品牌综合
	
	@RequestMapping(value="/pcindex")
	public ModelAndView index (ModelMap modelMap) throws Exception {
		
		//首页轮播图
		List<Public_pic> homePicList = picService.list("home_pic","lbt");
		
		//品牌
		List<Public_brand> brandList = brandService.list();
		
		//专题
		List<Public_content> subjectList = contentService.list("zt", "dzyf");
		
		
		modelMap.put("homePic", homePicList);
		modelMap.put("brandList", brandList);
		modelMap.put("subjectList", subjectList);
		
		return new ModelAndView("/view/pc/index", modelMap);
	}
	
	/**
	 * 专题 打开某个专题
	 * @param id
	 * */
	@RequestMapping(value="/subject")
	public ModelAndView subject (String id,ModelMap modelMap) throws Exception {
		
		//头部
		List<Public_brand> brandList = brandService.list();	//品牌
		List<Public_content> subjectList = contentService.list("zt", "dzyf");	//专题
		
		//专题
		Public_content content = contentService.getById(id);
		
		modelMap.put("brandList", brandList);
		modelMap.put("subjectList", subjectList);
		modelMap.put("content", content);
		modelMap.put("id", id);
		return new ModelAndView("/view/pc/subject", modelMap);
	}
	
	/**
	 * 页脚 - 服务
	 * @param id
	 * */
	@RequestMapping(value="/service")
	public ModelAndView footer (String ptype,ModelMap modelMap) throws Exception {
		List<Public_brand> brandList = brandService.list();	//品牌
		List<Public_content> subjectList = contentService.list("zt", "dzyf");	//专题
		
		ptype = !"".equals(ptype) && ptype != null ?ptype:"faq";
		List<Public_content> serviceList = contentService.list("service", ptype);	//专题
		
		
		
		modelMap.put("brandList", brandList);
		modelMap.put("subjectList", subjectList);
		modelMap.put("serviceList", serviceList);
		modelMap.put("ptype", ptype);
		
		return new ModelAndView("/view/pc/service", modelMap);
	}
	
	/**
	 * 品牌综合页
	 * @param id 品牌ID
	 * @param modelMap
	 * @return ModelAndView
	 * */
	@RequestMapping(value="/zh")
	public ModelAndView zh (String id,ModelMap modelMap) throws Exception {
		
		//头部
		List<Public_brand> brandList = brandService.list();	//品牌
		List<Public_content> subjectList = contentService.list("zt", "dzyf");	//专题
		
		//品牌 轮播图
		List<Public_pic> brandPicList = picService.list(id,"brandfirst_lb_pic");
		
		//品牌综合页内容
		List<Brandfirst> bfList = bfService.list(id);
		
		modelMap.put("brandList", brandList);
		modelMap.put("subjectList", subjectList);
		modelMap.put("brandPicList", brandPicList);
		modelMap.put("bfList", bfList);
		
		
		modelMap.put("id", id);
		
		return new ModelAndView("/view/pc/brand_zh", modelMap);
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
	
	/**
	 * 登录
	 * @param phoneNum
	 * @param password
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public void login(String phoneNum,String password,HttpServletResponse response) throws Exception {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "error";
		Public_user obj = userService.getByPhoneNum(phoneNum);
		if(obj != null){
			if(obj.getPassword().equals(password)){
				//.....
				
				result = "success";
			}else{
				result = "error";
			}
		}
		
		out.print(result);
	}
}

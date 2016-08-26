package net.ussoft.zhxh.web.pc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Public_cat;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicCatService;
import net.ussoft.zhxh.service.IPublicProductSizeService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/porder")
public class PorderController extends BaseConstroller {
	
	@Resource
	private IPublicProductSizeService psizeService;
	
	@Resource
	private IPublicCatService catService;
	
	@RequestMapping(value="/orderconf")
	public ModelAndView orderconf (String id,ModelMap modelMap) throws Exception {
		
		Public_product_size psize = psizeService.getById(id);
		List<Public_product_size> psizeList = new ArrayList<Public_product_size>();
		psizeList.add(psize);
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("psizeList", psizeList);
		
		return new ModelAndView("/view/pc/orderconf", modelMap);
	}
	
	/**
	 * 购物车
	 * */
	@RequestMapping(value="/cat")
	public ModelAndView cat (String userid,ModelMap modelMap) throws Exception {
		//商品
		List<Public_product_size> psizeList = new ArrayList<Public_product_size>();
		//购物车
		List<Public_cat> catList = catService.list(userid);
		for(Public_cat obj:catList){
			Public_product_size psize = psizeService.getById(obj.getProductsizeid());
			psize.setQuantity(obj.getBuycount());
			psizeList.add(psize);
		}
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("psizeList", psizeList);
		
		return new ModelAndView("/view/pc/cat", modelMap);
	}
	
	/**
	 * 购物车-添加
	 * @param productsizeid
	 * @param quantity
	 * */
	@RequestMapping(value="/catAdd",method=RequestMethod.POST)
	public void catAdd(String productsizeid,int quantity,HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		Public_cat cat = new Public_cat();
		HttpSession session = request.getSession();
		Public_user user = (Public_user) CommonUtils.getSessionAttribute(request, Constants.PC_USER_SESSION);
		cat.setId(UUID.randomUUID().toString());
		cat.setUserid(user.getId());
		cat.setProductsizeid(productsizeid);
		cat.setBuycount(quantity);
		
		Public_cat catObj = catService.insert(cat);
		if(catObj != null){
			out.print("success");
			return;
		}
		out.print("error");
		
	}
	
	/**
	 * 购物车 - 修改
	 * @param id
	 * @param quantity 数量
	 * */
	@RequestMapping(value="/catEdit",method=RequestMethod.POST)
	public void catEdit(String id,int quantity,HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		Public_cat cat = catService.getById(id);
		cat.setBuycount(quantity);
		
		int num = catService.update(cat);
		if(num > 0){
			out.print("success");
			return;
		}
		out.print("error");
		
	}
	
	/**
	 * 购物车 - 删除
	 * @param id
	 * */
	@RequestMapping(value="/catDel",method=RequestMethod.POST)
	public void catDel(String id,HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		int num = catService.delete(id);
		if(num > 0){
			out.print("success");
			return;
		}
		out.print("error");
		
	}
	
}

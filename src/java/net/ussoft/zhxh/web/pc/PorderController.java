package net.ussoft.zhxh.web.pc;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Public_cat;
import net.ussoft.zhxh.model.Public_product_size;
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
	
	@RequestMapping(value="/orderbuy")
	public ModelAndView orderbuy (String id,int quantity,ModelMap modelMap) throws Exception {
		
		Public_product_size psize = psizeService.getById(id);
		//如果特价没有，把售价给它-前台统一使用特价
		if(psize.getSaleprice() == 0){
			psize.setSaleprice(psize.getPrice());
		}
		psize.setQuantity(quantity);
		
		//订单确认页公用，统一用集合
		List<Public_product_size> psizeList = new ArrayList<Public_product_size>();
		psizeList.add(psize);
		//合计
		float subtotal = psize.getSaleprice() * quantity;
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("psizeList", psizeList);
		modelMap.put("subtotal", subtotal);
		
		return new ModelAndView("/view/pc/orderconf", modelMap);
	}
	
	@RequestMapping(value="/orderconf")
	public ModelAndView orderconf (String ids,ModelMap modelMap) throws Exception {
		List<String> idlist = new ArrayList<String>();
		String[] idArr = ids.split(",");
		for(String id:idArr){
			idlist.add(id);
		}
		//商品
		List<Public_product_size> psizeList = new ArrayList<Public_product_size>();
		//购物车
		List<Public_cat> catList = catService.getByIds(idlist);
		float subtotal = 0;
		for(Public_cat obj:catList){
			Public_product_size psize = psizeService.getById(obj.getProductsizeid());
			psize.setQuantity(obj.getBuycount());
			psize.setProductcatid(obj.getId());
			//如果特价没有，把售价给它-前台统一使用特价
			if(psize.getSaleprice() == 0){
				psize.setSaleprice(psize.getPrice());
			}
			psizeList.add(psize);
			
			//
			subtotal += psize.getSaleprice() * obj.getBuycount();
		}
				
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("psizeList", psizeList);
		modelMap.put("subtotal", subtotal);
		
		
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
			psize.setProductcatid(obj.getId());
			psizeList.add(psize);
		}
		
		//
		
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("psizeList", psizeList);
		
		return new ModelAndView("/view/pc/cat", modelMap);
	}
	
	/**
	 * 购物车-添加
	 * @param userid
	 * @param productsizeid
	 * @param quantity
	 * */
	@RequestMapping(value="/catAdd",method=RequestMethod.POST)
	public void catAdd(String userid,String productsizeid,int quantity,HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		Public_cat resultcat = catService.getPublicCat(userid, productsizeid);
		//购物车
		int catnum = (int) CommonUtils.getSessionAttribute(request, Constants.CAT_NUM);
		if(resultcat != null){
			int buycount = resultcat.getBuycount() + quantity;
			resultcat.setBuycount(buycount);
			int num = catService.update(resultcat);
			if(num > 0){
				out.print(catnum);
				return;
			}
		}else{
			Public_cat cat = new Public_cat();
			cat.setId(UUID.randomUUID().toString());
			cat.setUserid(userid);
			cat.setProductsizeid(productsizeid);
			cat.setBuycount(quantity);
			
			Public_cat catObj = catService.insert(cat);
			if(catObj != null){
				request.getSession().removeAttribute(Constants.CAT_NUM);
				CommonUtils.setSessionAttribute(request, Constants.CAT_NUM, catnum + 1);
				out.print(catnum + 1);
				return;
			}
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
	public void catDel(String ids,HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		List<String> idlist = new ArrayList<String>();
		String[] idArr = ids.split(",");
		for(String id:idArr){
			idlist.add(id);
		}
		int num = catService.delete(idlist);
		if(num > 0){
			int catnum = (int) CommonUtils.getSessionAttribute(request, Constants.CAT_NUM);
			request.getSession().removeAttribute(Constants.CAT_NUM);
			CommonUtils.setSessionAttribute(request, Constants.CAT_NUM, catnum - idArr.length);
			
			out.print(catnum - idArr.length);
			return;
		}
		out.print("error");
		
	}
	
}

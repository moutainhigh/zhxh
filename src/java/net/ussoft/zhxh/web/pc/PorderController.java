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
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicCatService;
import net.ussoft.zhxh.service.IPublicOrderProductService;
import net.ussoft.zhxh.service.IPublicOrderService;
import net.ussoft.zhxh.service.IPublicProductSizeService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.Constants;
import net.ussoft.zhxh.util.DateUtil;
import net.ussoft.zhxh.util.OrderNO;

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
	
	@Resource
	private IPublicOrderService orderService;
	
	@Resource
	private IPublicOrderProductService orderProServivce;
	
	
	/**
	 * 立即购买
	 * @param id
	 * @param quantity 
	 * */
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
	
	/**
	 * 订单确认
	 * @param ids
	 * */
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
		modelMap.put("pids", ids); //购买的商品返回到订单确认页，用于提交订单
		
		
		return new ModelAndView("/view/pc/orderconf", modelMap);
	}
	
	/**
	 * 提交订单
	 * @param ids
	 * */
	@RequestMapping(value="/suborder")
	public ModelAndView suborder (String ids,ModelMap modelMap) throws Exception {
		List<String> idlist = new ArrayList<String>();
		String[] idArr = ids.split(",");
		for(String id:idArr){
			idlist.add(id);
		}
		
		//添加订单
		Public_order order = addOrder(idlist);
		//添加订单商品
		addOrderProduct(idlist, order.getId());
		//删除购物车-相应的商品
		catService.delete(idlist);
		catinit(true, idlist.size());	//初始化购物车数量
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("subtotal", order.getOrdertotal());	//支付的金额
		modelMap.put("orderno", order.getOrdernumber()); 	//订单号
		
		return new ModelAndView("/view/pc/orderpay", modelMap);
	}
	
	/**
	 * 生产订单
	 * @param idlist 购买的所有商品ID
	 * */
	private Public_order addOrder(List<String> idlist){
		//购物车提交的商品
		List<Public_cat> catList = catService.getByIds(idlist);
		float subtotal = 0;		//合计价格
		for(Public_cat obj:catList){
			Public_product_size psize = psizeService.getById(obj.getProductsizeid());
			//如果特价没有，把售价给它-前台统一使用特价
			if(psize.getSaleprice() == 0){
				psize.setSaleprice(psize.getPrice());
			}
			
			//计算价格
			subtotal += psize.getSaleprice() * obj.getBuycount();
		}
		Public_order order = new Public_order();
		order.setId(UUID.randomUUID().toString());
		//获取session中的账户
		Public_user user = getSessionUser();
		order.setUserid(user.getId());
//		order.setParentid(parentid);			//上级ID
//		order.setIdentity(identity);			//身份
		String ordernumber = "PO"+OrderNO.getOrderNo();		//订单号
		order.setOrdernumber(ordernumber);
		order.setOrdertotal(subtotal);			//总金额
		order.setOrderstatus(0);				//待支付
		order.setOrderstatusmemo("待支付");
		order.setOrdertime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));;
		return orderService.insert(order);
	}
	
	/**
	 * 订单商品
	 * @param idlist 购买的所有商品ID
	 * @param orderId 订单ID
	 * */
	private void addOrderProduct(List<String> idlist,String orderId){
		//购物车提交的商品
		List<Public_cat> catList = catService.getByIds(idlist);
		for(Public_cat obj:catList){
			Public_product_size psize = psizeService.getById(obj.getProductsizeid());
			
			//订单商品 
			Public_order_product orderPro = new Public_order_product();
			orderPro.setId(UUID.randomUUID().toString());
			orderPro.setOrderid(orderId);
			orderPro.setProductid(psize.getId());
			orderPro.setProductname(psize.getProductname());
			orderPro.setProductpic(psize.getProductsize());
			orderPro.setProductnum(psize.getQuantity());	//购买数量
			orderPro.setIsoknum(obj.getBuycount());			//可结算数量（退货时冲减）
			orderPro.setPrice(psize.getSaleprice());		//此处存放的是特价（值已处理-如果特价没有，把售价给它-前台统一使用特价）
			orderPro.setProductmemo(psize.getProductmemo());
			orderPro.setOrdertime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
			orderPro.setStatus(0);	//已购买
			orderProServivce.insert(orderPro);
		}
	}
	
	/**
	 * 购物车
	 * @param userid
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
		if(resultcat != null){
			int buycount = resultcat.getBuycount() + quantity;
			resultcat.setBuycount(buycount);
			int num = catService.update(resultcat);
			if(num > 0){
				out.print(getCatnum());	//返回购物车数量
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
				int catnum = catinit(false, 1);	//初始购物车，加  数量+1
				out.print(catnum);
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
			int catnum = catinit(true, idArr.length);	//出售购物车  -
			out.print(catnum);
			return;
		}
		out.print("error");
		
	}
	
	
	/*===========================================个人中心=============================================*/
	
	/**
	 * 我的订单
	 * @param id
	 * @param quantity 
	 * */
	@RequestMapping(value="/orders")
	public ModelAndView orders (ModelMap modelMap) throws Exception {
		
		/*Public_product_size psize = psizeService.getById(id);
		//如果特价没有，把售价给它-前台统一使用特价
		if(psize.getSaleprice() == 0){
			psize.setSaleprice(psize.getPrice());
		}
		psize.setQuantity(quantity);
		
		//订单确认页公用，统一用集合
		List<Public_product_size> psizeList = new ArrayList<Public_product_size>();
		psizeList.add(psize);
		//合计
		float subtotal = psize.getSaleprice() * quantity;*/
		//初始品牌、专题
		init(modelMap);
		
//		modelMap.put("psizeList", psizeList);
//		modelMap.put("subtotal", subtotal);
		
		return new ModelAndView("/view/pc/account/orders", modelMap);
	}
	
}

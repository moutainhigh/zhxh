package net.ussoft.zhxh.web.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_order;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.impl.PublicOrderService;
import net.ussoft.zhxh.service.impl.PublicUser2Service;
import net.ussoft.zhxh.service.impl.PublicUserService;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;


@Controller
@RequestMapping("/order")
public class OrderController extends BaseConstroller {
	
	@Resource
	private PublicOrderService orderService;
	@Resource
	private PublicUserService userService;
	@Resource
	private PublicUser2Service user2Service;
	
	/**
	 * 跳转到某个页面。
	 * @param page		跳转到参数指定的页面
	 * @return
	 */
	@RequestMapping(value="dispatch",method=RequestMethod.GET)
	public String dispatch(String page,String param ,ModelMap modelMap) {
		
		if (null != param && !"".equals(param)) {
			Map<String,String> paramMap = (Map<String, String>) JSON.parse(param);
//			String[] paramArr = param.split("#");
			for (Map.Entry<String,String> entry : paramMap.entrySet()) {  
				modelMap.put(entry.getKey(), entry.getValue());
			}  
		}
		return page;
	}
	
	/**
	 * 新增订货单
	 * */
	@RequestMapping(value="/newOrder")
	public ModelAndView newOrder (ModelMap modelMap) throws Exception {
		Public_user user = getSessionUser();
		List<Public_user> u_list = userService.listParent(user.getId());
		modelMap.put("u_list", u_list);
		return new ModelAndView("/view/order/order/createorder", modelMap);
	}
	
	/**
	 * 创建订货单
	 * */
	@RequestMapping(value="/createorder",method=RequestMethod.POST)
	public void createorder(String objs,HttpServletResponse response) throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		List<Public_product_size> psizeList = new ArrayList<Public_product_size>();
		//商品
		List<Map<String, String>> rows = (List<Map<String, String>>) JSON.parse(objs);
		for(int i=0,l=rows.size(); i<l; i++){
			Map<String,String> row = (Map<String,String>)rows.get(i);
			Public_product_size product = new Public_product_size();
			BeanUtils.populate(product, row);
			psizeList.add(product);
		}
		Public_user user = getSessionUser();
		Public_order order = orderService.createorder(psizeList, user);
		if(order != null){
			out.print("success");
			return;
		}
		out.print("error");
	}
	
	/**
	 * 订货单
	 * */
	@RequestMapping(value="/myorder")
	public ModelAndView myorder (ModelMap modelMap) throws Exception {
		Public_user user = getSessionUser();
		List<Public_user> u_list = userService.listParent(user.getId());
		modelMap.put("u_list", u_list);
		return new ModelAndView("/view/order/order/myorderlist", modelMap);
	}
	
	/**
	 * 订单列表
	 * */
	@RequestMapping(value="/orderlist",method=RequestMethod.POST)
	public void orderlist(String orderType,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HashMap<String,Object> map = new HashMap<String,Object>();
		PageBean<Public_order> p = new PageBean<Public_order>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("ordertime");
		p.setOrderType("desc");
		
		Map<String, Object> params = new LinkedHashMap<String, Object>();
		Public_user user = getSessionUser();
		if("my".equals(orderType)){
			params.put("userid= ", user.getId());
			p = orderService.list(params, p);
		}else if("sub".equals(orderType)){
			params.put("parentid= ", user.getId());
			p = orderService.list(params, p);
		}
		
		map.put("data", p.getList());
		map.put("pageCount", p.getPageCount());
		map.put("rowCount", p.getRowCount());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 机构经销的品牌
	 * @param parentid
	 * 
	 * */
	@RequestMapping(value="/brandlist",method=RequestMethod.POST)
	public void brandlist(String parentid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HashMap<String,Object> map = new HashMap<String,Object>();
		Public_user user = getSessionUser();
		//获取机构经销的品牌
		List<Public_brand> brandList = user2Service.list_user_brand(parentid, user.getId());
		
		map.put("data", brandList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 商品列表
	 * */
	@RequestMapping(value="/prolist",method=RequestMethod.POST)
	public void productlist(String parentid,String brandid,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HashMap<String,Object> map = new HashMap<String,Object>();
		Public_user user = getSessionUser();
		
		List<Map<String, Object>> list = user2Service.listUserStandardFromBrand(parentid, user.getId(), brandid);
		
		map.put("data",list);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
}

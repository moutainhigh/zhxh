package net.ussoft.zhxh.web.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Brandfirst;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Product_rated;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_pic;
import net.ussoft.zhxh.model.Public_product;
import net.ussoft.zhxh.service.IBrandfirstService;
import net.ussoft.zhxh.service.IProductRatedService;
import net.ussoft.zhxh.service.IPublicBrandService;
import net.ussoft.zhxh.service.IPublicPicService;
import net.ussoft.zhxh.service.IPublicProductService;
import net.ussoft.zhxh.util.FileOperate;

@Controller
@RequestMapping(value="product")
public class ProductController extends BaseConstroller {
	
	@Resource
	private IPublicBrandService brandService;
	@Resource
	private IPublicProductService productService;
	@Resource
	private IProductRatedService ratedService;
	@Resource
	private IPublicPicService picService;
	@Resource
	private IBrandfirstService brandFirstService;
	
	
	//定义常量，用来标识参数
	private final String BRAND = "brand";		//品牌
	private final String PRODUCT = "product";	//对商品表的处理
	private final String RATED = "rated";	//对商品评价表的处理
	private final String BRANDFIRST_LB_PIC = "brandfirst_lb_pic";	//对品牌综合页轮播图片的处理
	private final String BRANDFIRST = "brandfirst";	//对品牌综合页的处理
	
	/**
	 * 获取列表
	 * @param listtype  	为了共用。获取列表的对象类型。 brand：获取品牌列表   product：获取商品列表 rated:商品评价  brandfirst_lb_pic:品牌综合页轮播图片  brandfirst:获取品牌综合页
	 * @param parentid		如果是获取的列表有父节点id。要有id作为参数
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(String listtype,String parentid,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		if (listtype.equals(BRAND)) {
			List<Public_brand> brandList = brandService.list();
			map.put("total", brandList.size());
			map.put("data", brandList);
		}
		else if (listtype.equals(PRODUCT)) {
			PageBean<Public_product> p = new PageBean<Public_product>();
			
			p.setIsPage(false);
			p.setOrderBy("sort");
			List<Public_product> pList = productService.list(p, parentid);
			map.put("total", pList.size());
			map.put("data", pList);
		}
		else if (listtype.equals(RATED)) {
			PageBean<Product_rated> p = new PageBean<Product_rated>();
			p.setPageSize(pageSize);
			p.setPageNo(pageIndex + 1);
			p.setOrderBy("ratedtime");
			p.setOrderType("desc");
			p = ratedService.list(p, parentid);
			map.put("total", p.getPageCount());
			map.put("data", p.getList());
		}
		else if (listtype.equals(BRANDFIRST_LB_PIC)) {
			List<Public_pic> pList = picService.list(parentid,listtype);
			map.put("total", pList.size());
			map.put("data", pList);
		}
		else if (listtype.equals(BRANDFIRST)) {
			List<Brandfirst> pList = brandFirstService.list(parentid);
			map.put("total", pList.size());
			map.put("data", pList);
		}
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
//	/**
//	 * 保存
//	 * @param imageInput
//	 * @param id		 保存id，用来更新
//	 * @param request
//	 * @return
//	 * @throws IOException
//	 */
//	@RequestMapping(value="/update_pic",method=RequestMethod.POST)
//	public ModelAndView update_pic(@RequestParam("imageInput") MultipartFile imageInput,String id,String redirectPath,HttpServletRequest request) throws IOException {
//		
//		HashMap<String,String> fileMap = CommonUtils.toinsert_file(imageInput, "photoAlbum", request);
//		
//		//id为空
//        if (null == id || "".equals(id)) {
//        	
//        }
//        else {
//        	//更新内容
//        	PhotoAlbum tmp = photoAlbumService.getById(id);
//	    	if (null != fileMap && fileMap.size() > 0 && !fileMap.get("newname").isEmpty()) {
//	    		//删除原图片
//	    		if (null != tmp.getPhotopic_path() && !"".equals(tmp.getPhotopic_path())) {
//	    			FileOperate.delFile(request.getSession().getServletContext().getRealPath("") + File.separator + tmp.getPhotopic_path());
//	    		}
//	    		tmp.setPhotopic_path(fileMap.get("filepath") + fileMap.get("newname"));
//	    	}
//	    	
//	    	photoAlbumService.update(tmp);
//        }
//        
//        //获取完整对象，不管是添加还是修改，都返回到修改页面
//        PhotoAlbum photoAlbum = photoAlbumService.getById(id);
//		
//		Map<String,Object> map = new HashMap<String, Object>();
//	    map.put("result", "更新成功.");
//		map.put("photoAlbum", photoAlbum);
//	    return new ModelAndView(redirectPath,map);
//	}
	
	/**
	 * 保存品牌
	 * @param objs			保存的实体json
	 * @param savetype		保存的实体类型。共用 brand:保存的是品牌   product：保存的是商品信息 rated:商品评价
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public void save(String objs,String savetype,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
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
	        	insert(row,savetype);
	        }
	        else if (state.equals("removed") || state.equals("deleted")) {
	        	boolean isok = delete(id,savetype);
	        	if (isok) {
	        		String tmpPath = "";
	        		if (savetype.equals(BRAND)) {
	        			tmpPath = row.get("brandlog");
	        		}
	        		else if (savetype.equals(PRODUCT)) {
	        			tmpPath = row.get("productpic");
	        		}
	        		else if (savetype.equals(BRANDFIRST)) {
	        			tmpPath = row.get("firstpic");
	        		}
	        		
	        		FileOperate.delFile(super.getProjectRealPath() + tmpPath); 
	        	}
	        }
	        //更新：_state为空，或modified
	        else if (state.equals("modified") || state.equals(""))	 {
	            update(row,savetype);
	        }
	    }
		out.print(result);
	}
	
	private boolean insert(Map<String,String> row,String savetype) throws IllegalAccessException, InvocationTargetException {
		if (null == row) {
			return false;
		}
		
		if (savetype.equals(BRAND)) {
			Public_brand brand = new Public_brand();
			BeanUtils.populate(brand, row);
			
			brand.setId(UUID.randomUUID().toString());
			brand = brandService.insert(brand);
		}
		else if (savetype.equals(PRODUCT)) {
			Public_product product = new Public_product();
			BeanUtils.populate(product, row);
			
			product.setId(UUID.randomUUID().toString());
			product = productService.insert(product);
		}
		else if (savetype.equals(RATED)) {
			Product_rated rated = new Product_rated();
			BeanUtils.populate(rated, row);
			
			rated.setId(UUID.randomUUID().toString());
			rated = ratedService.insert(rated);
		}
		else if (savetype.equals(BRANDFIRST)) {
			Brandfirst bFirst = new Brandfirst();
			BeanUtils.populate(bFirst, row);
			
			bFirst.setId(UUID.randomUUID().toString());
			bFirst = brandFirstService.insert(bFirst);
		}
		
		return true;
	}
	
	/**
	 * 删除。
	 * @param id
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private boolean delete(String id,String savetype) throws IOException {
		
		if (id == null || id.equals("") ) {
			return false;
		}
		int num = 0;
		if (savetype.equals(BRAND)) {
			num = brandService.delete(id);
		}
		else if (savetype.equals(PRODUCT)){
			num = productService.delete(id);
		}
		else if (savetype.equals(RATED)) {
			num = ratedService.delete(id);
		}
		else if (savetype.equals(BRANDFIRST)) {
			num = brandFirstService.delete(id);
		}
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	/**
	 * 更新
	 * @param row
	 * @return
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	private boolean update(Map<String,String> row,String savetype) throws IOException, IllegalAccessException, InvocationTargetException {
		
		if (null == row) {
			return false;
		}
		
		int num = 0;
		if (savetype.equals(BRAND)) {
			Public_brand brand = new Public_brand();
			BeanUtils.populate(brand, row);
			num = brandService.update(brand);
		}
		else if (savetype.equals(PRODUCT)){
			Public_product product = new Public_product();
			BeanUtils.populate(product, row);
			num = productService.update(product);
		}
		else if (savetype.equals(RATED)) {
			Product_rated rated = new Product_rated();
			BeanUtils.populate(rated, row);
			num = ratedService.update(rated);
		}
		else if (savetype.equals(BRANDFIRST)) {
			Brandfirst bFirst = new Brandfirst();
			BeanUtils.populate(bFirst, row);
			num = brandFirstService.update(bFirst);
		}
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
	
	
}

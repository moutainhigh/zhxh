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
import net.ussoft.zhxh.model.Labeltype;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_product;
import net.ussoft.zhxh.service.IPublicBrandService;
import net.ussoft.zhxh.service.IPublicProductService;

@Controller
@RequestMapping(value="product")
public class ProductController extends BaseConstroller {
	
	@Resource
	private IPublicBrandService brandService;
	@Resource
	private IPublicProductService productService;
	
	/**
	 * 获取列表
	 * @param listtype  	为了共用。获取列表的对象类型。 brand：获取品牌列表   product：获取商品列表
	 * @param brandid		如果是获取商品列表。要有品牌id作为参数
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(String listtype,String brandid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		if (listtype.equals("brand")) {
			List<Public_brand> brandList = brandService.list();
			map.put("total", brandList.size());
			map.put("data", brandList);
		}
		else if (listtype.equals("product")) {
			PageBean<Public_product> p = new PageBean<Public_product>();
			
			p.setIsPage(false);
			p.setOrderBy("sort");
			List<Public_product> pList = productService.list(p, brandid);
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
	 * @param savetype		保存的实体类型。共用 brand:保存的是品牌   product：保存的是商品信息
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
	        	delete(id,savetype);
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
		
		if (savetype.equals("brand")) {
			Public_brand brand = new Public_brand();
			BeanUtils.populate(brand, row);
			
			brand.setId(UUID.randomUUID().toString());
			brand = brandService.insert(brand);
		}
		else if (savetype.equals("product")) {
			Public_product product = new Public_product();
			BeanUtils.populate(product, row);
			
			product.setId(UUID.randomUUID().toString());
			product = productService.insert(product);
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
		if (savetype.equals("brand")) {
			num = brandService.delete(id);
		}
		else {
			num = productService.delete(id);
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
		if (savetype.equals("brand")) {
			Public_brand brand = new Public_brand();
			BeanUtils.populate(brand, row);
			num = brandService.update(brand);
		}
		else {
			Public_product product = new Public_product();
			BeanUtils.populate(product, row);
			num = productService.update(product);
		}
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
	
	
}
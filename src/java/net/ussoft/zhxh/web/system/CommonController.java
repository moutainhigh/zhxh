package net.ussoft.zhxh.web.system;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.sun.star.io.IOException;

import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_product;
import net.ussoft.zhxh.service.IPublicBrandService;
import net.ussoft.zhxh.service.IPublicProductService;
import net.ussoft.zhxh.util.CommonUtils;
import net.ussoft.zhxh.util.FileOperate;
import net.ussoft.zhxh.util.Logger;

/**
 * 公共控制器
 * @author wangf
 *
 */
@Controller
@RequestMapping(value="common")
public class CommonController {
	
	private Logger log = new Logger(CommonController.class);
	@Resource
	private IPublicBrandService brandService;
	@Resource
	private IPublicProductService productService;
	
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
	 * form提交方式上传保存文件。主要用于单文件上传。
	 * @param imageInput		form提交的文件流
	 * @param id		 		当前上传文件所属记录的id，用来更新记录与文件的关联
	 * @param saveFolder		上传文件的保存路径		 
	 * @param redirectPath		上传完毕返回的路径（如果仅是同一个form提交，就不需要这个）
	 * @param forObj			为了共用，上传文件对应那个实体类.  （1）brandlog:品牌logo上传  （如果是其他的实体类，请在这里添加forObj值的意义）	(2)productpic:商品主图片	
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws java.io.IOException 
	 */
	@RequestMapping(value="/update_common_file",method=RequestMethod.POST)
	public ModelAndView update_common_file(@RequestParam("imageInput") MultipartFile imageInput,String id,String saveFolder, String forObj,String redirectPath,HttpServletRequest request) throws IOException, java.io.IOException {
		
		HashMap<String,String> fileMap = CommonUtils.toinsert_file(imageInput, saveFolder, request);
		String filepath = fileMap.get("filepath") + fileMap.get("newname");
		Map<String,Object> map = new HashMap<String, Object>();
		//id为空
        if (null == id || "".equals(id) || null == forObj || "".equals(forObj)) {
        	//如果没有参数，直接返回
        }
        else {
        	//如果是上传的品牌logo
        	if (forObj.equals("brandlog")) {
        		//更新内容
        		Public_brand tmp = brandService.getById(id);
        		if (null != fileMap && fileMap.size() > 0 && !fileMap.get("newname").isEmpty()) {
    	    		//删除原图片
    	    		if (null != tmp.getBrandlogo() && !"".equals(tmp.getBrandlogo())) {
    	    			FileOperate.delFile(request.getSession().getServletContext().getRealPath("") + File.separator + tmp.getBrandlogo());
    	    		}
    	    		tmp.setBrandlogo(fileMap.get("filepath") + fileMap.get("newname"));
    	    	}
        		else {
        			if (null != tmp.getBrandlogo() && !"".equals(tmp.getBrandlogo())) {
    	    			FileOperate.delFile(request.getSession().getServletContext().getRealPath("") + File.separator + tmp.getBrandlogo());
    	    		}
    	    		tmp.setBrandlogo("");
        		}
    	    	
        		brandService.update(tmp);
        	}
        	else if (forObj.equals("productpic")) {
        		//如果是上传的商品主图片
        		//更新内容
        		Public_product tmp = productService.getById(id);
        		if (null != fileMap && fileMap.size() > 0 && !fileMap.get("newname").isEmpty()) {
        			//删除原图片
        			if (null != tmp.getProductpic() && !"".equals(tmp.getProductpic())) {
        				FileOperate.delFile(request.getSession().getServletContext().getRealPath("") + File.separator + tmp.getProductpic());
        			}
        			tmp.setProductpic(fileMap.get("filepath") + fileMap.get("newname"));
        		}
        		else {
        			if (null != tmp.getProductpic() && !"".equals(tmp.getProductpic())) {
        				FileOperate.delFile(request.getSession().getServletContext().getRealPath("") + File.separator + tmp.getProductpic());
        			}
        			tmp.setProductpic("");
        		}
        		
        		productService.update(tmp);
        	}
        	
        }
        
	    map.put("result", "更新成功.");
		map.put("filepath", filepath);
		map.put("id", id);
		map.put("saveFolder", saveFolder);
		map.put("forObj", forObj);
		map.put("redirectPath", redirectPath);
	    return new ModelAndView(redirectPath,map);
	}
	

}

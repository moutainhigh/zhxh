package net.ussoft.zhxh.web.pc;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Brandfirst;
import net.ussoft.zhxh.model.Brandlist;
import net.ussoft.zhxh.model.Filesdown;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Product_list;
import net.ussoft.zhxh.model.Product_rated;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_content;
import net.ussoft.zhxh.model.Public_pic;
import net.ussoft.zhxh.model.Public_product;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_video;
import net.ussoft.zhxh.model.Sys_public;
import net.ussoft.zhxh.service.IBrandfirstService;
import net.ussoft.zhxh.service.IProductListService;
import net.ussoft.zhxh.service.IProductRatedService;
import net.ussoft.zhxh.service.IPublicBrandService;
import net.ussoft.zhxh.service.IPublicContentService;
import net.ussoft.zhxh.service.IPublicPicService;
import net.ussoft.zhxh.service.IPublicProductService;
import net.ussoft.zhxh.service.IPublicProductSizeService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.service.IPublicVideoService;
import net.ussoft.zhxh.service.IPublicfilesdownService;
import net.ussoft.zhxh.service.impl.SysPublicService;
import net.ussoft.zhxh.util.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;


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
	
	@Resource
	IPublicfilesdownService filesdownService;	//文件下载
	
	@Resource
	private IBrandfirstService brandFirstService;	//品牌综合、系列
	
	@Resource
	private IPublicVideoService videoService;	//视频
	
	@Resource
	private IPublicProductService productService;	//商品
	
	@Resource
	private IProductListService productlistService;	//商品列表
	
	@Resource
	private IProductRatedService ratedService;	//商品评价
	
	@Resource
	private IPublicProductSizeService psizeService;	//商品规格
	
	@Resource
	private SysPublicService publicService;
	
	@RequestMapping(value="/pcindex")
	public ModelAndView index (ModelMap modelMap) throws Exception {
		//首页logo
		Sys_public logo = publicService.getById("1");
		//首页轮播图
		List<Public_pic> homePicList = picService.list("home_pic","lbt",1);
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("logo", logo);
		modelMap.put("homePic", homePicList);
		return new ModelAndView("/view/pc/index", modelMap);
	}
	
	/**
	 * 专题 打开某个专题
	 * @param id
	 * */
	@RequestMapping(value="/subject")
	public ModelAndView subject (String id,ModelMap modelMap) throws Exception {
		//专题
		Public_content content = contentService.getById(id);
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("content", content);
		modelMap.put("id", id);
		modelMap.put("ptype", "0"); //表示专题，用于隐藏品牌故事
		return new ModelAndView("/view/pc/subject", modelMap);
	}
	
	/**
	 * 页脚 - 服务
	 * @param id
	 * */
	@RequestMapping(value="/service")
	public ModelAndView footer (String ptype,ModelMap modelMap) throws Exception {
		ptype = !"".equals(ptype) && ptype != null ?ptype:"faq";
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		map.put("parentid = ", "content");
		map.put("parenttype = ", ptype);
		map.put("isshow = ", 1);			//显示
		List<Public_content> serviceList = contentService.list(map);
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("serviceList", serviceList);
		modelMap.put("ptype", ptype);
		
		return new ModelAndView("/view/pc/service", modelMap);
	}
	
	/**
	 * 品牌故事 内容
	 * @param id
	 * */
	@RequestMapping(value="/story-c")
	public ModelAndView story_c (String id,ModelMap modelMap) throws Exception {
		Public_content content = new Public_content();
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		map.put("parentid = ", id);
		map.put("parenttype = ", "brandstory");
		map.put("isshow = ", 0);  //此处 isshow赋值0 不代表隐藏
		List<Public_content> storys = contentService.list(map);
		
		if (storys.size() == 1) {
			content = storys.get(0);
		}
		//品牌
		Public_brand brand = brandService.getById(id);
				
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("story", content);
		modelMap.put("id", id);
		modelMap.put("brand", brand);
		return new ModelAndView("/view/pc/storycontent", modelMap);
	}
	
	/**
	 * 新闻
	 * @param id
	 * */
	@RequestMapping(value="/news")
	public ModelAndView news (String ptype,@RequestParam(value="page",defaultValue="1")int page,ModelMap modelMap) throws Exception {
		int pageSize = 10;
		
		PageBean<Public_content> p = new PageBean<Public_content>();
		p.setPageSize(pageSize);
		p.setPageNo(page);
		p.setOrderBy("sort asc,createtime desc");
		
		ptype = !"".equals(ptype) && ptype != null ?ptype:"news_hy";
		p = contentService.list(p,"content", ptype,1);
		
		//ptype: news_hy 行业新闻  news_qy 企业新闻  news_sp 商品新闻
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("newsList", p.getList());
		
		modelMap.put("ptype", ptype);
		
		modelMap.put("page", page);
		modelMap.put("pageCount", p.getPageCount());
		modelMap.put("rowCount", p.getRowCount());
		
		return new ModelAndView("/view/pc/news", modelMap);
	}
	
	/**
	 * 新闻 中心内容
	 * @param id
	 * */
	@RequestMapping(value="/news-c")
	public ModelAndView news_c (String id,ModelMap modelMap) throws Exception {
		Public_content content = contentService.getById(id);
		
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("news", content);
		
		return new ModelAndView("/view/pc/newscontent", modelMap);
	}
	
	/**
	 * 美容文章
	 * @param id
	 * */
	@RequestMapping(value="/article")
	public ModelAndView article (String ptype,@RequestParam(value="page",defaultValue="1")int page,ModelMap modelMap) throws Exception {
		int pageSize = 10;
		
		PageBean<Public_content> p = new PageBean<Public_content>();
		p.setPageSize(pageSize);
		p.setPageNo(page);
		p.setOrderBy("sort asc,createtime desc");
		
		ptype = !"".equals(ptype) && ptype != null ?ptype:"mrwz"; //美容文章
		p = contentService.list(p,"content", ptype,1);
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("articleList", p.getList());
		
		modelMap.put("ptype", ptype);
		
		modelMap.put("page", page);
		modelMap.put("pageCount", p.getPageCount());
		modelMap.put("rowCount", p.getRowCount());
		
		return new ModelAndView("/view/pc/article", modelMap);
	}
	
	/**
	 * 美容文章内容
	 * @param id
	 * */
	@RequestMapping(value="/article-c")
	public ModelAndView article_c (String id,ModelMap modelMap) throws Exception {
		Public_content content = contentService.getById(id);
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("article", content);
		
		return new ModelAndView("/view/pc/articlecontent", modelMap);
	}
	
	
	/**
	 * 案例库
	 * @param id
	 * */
	@RequestMapping(value="/cases")
	public ModelAndView cases (String ptype,@RequestParam(value="page",defaultValue="1")int page,ModelMap modelMap) throws Exception {
		int pageSize = 10;
		PageBean<Public_content> p = new PageBean<Public_content>();
		p.setPageSize(pageSize);
		p.setPageNo(page);
		p.setOrderBy("sort");
		p.setOrderType("asc");
		
		ptype = !"".equals(ptype) && ptype != null ?ptype:"case"; //案例库
		p = contentService.list(p,"content", ptype,1);
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("articleList", p.getList());
		
		modelMap.put("ptype", ptype);
		
		modelMap.put("page", page);
		modelMap.put("pageCount", p.getPageCount());
		modelMap.put("rowCount", p.getRowCount());
		
		return new ModelAndView("/view/pc/case", modelMap);
	}
	
	/**
	 * 案例库内容
	 * @param id
	 * */
	@RequestMapping(value="/cases-c")
	public ModelAndView cases_c (String id,ModelMap modelMap) throws Exception {
		Public_content content = contentService.getById(id);
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("article", content);
		
		return new ModelAndView("/view/pc/casecontent", modelMap);
	}
	
	/**
	 * 说明书
	 * @param id
	 * */
	@RequestMapping(value="/spec")
	public ModelAndView spec (String ptype,@RequestParam(value="page",defaultValue="1")int page,ModelMap modelMap) throws Exception {
		int pageSize = 10;
		
		PageBean<Filesdown> p = new PageBean<Filesdown>();
		p.setPageSize(pageSize);
		p.setPageNo(page);
		p.setOrderBy("sort");
		p.setOrderType("asc");
		
		ptype = !"".equals(ptype) && ptype != null ?ptype:"spec";
		p = filesdownService.list(p,"files", ptype);
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("specList", p.getList());
		
		modelMap.put("ptype", ptype);
		
		modelMap.put("page", page);
		modelMap.put("pageCount", p.getPageCount());
		modelMap.put("rowCount", p.getRowCount());
		
		return new ModelAndView("/view/pc/spec", modelMap);
	}
	
	/**
	 * 品牌综合页
	 * @param id 品牌ID
	 * @param modelMap
	 * @return ModelAndView
	 * */
	@RequestMapping(value="/zh")
	public ModelAndView zh (String id,ModelMap modelMap) throws Exception {
		//品牌 轮播图
		List<Public_pic> brandPicList = picService.list(id,"brandfirst_lb_pic",1);
		//品牌综合页内容
		List<Brandfirst> bfList = bfService.list(id);
		//品牌
		Public_brand brand = brandService.getById(id);
		//初始品牌、专题
		init(modelMap);
		modelMap.put("brandPicList", brandPicList);
		modelMap.put("bfList", bfList);
		
		modelMap.put("id", id);
		modelMap.put("ptype", "1"); //表示专题，用于隐藏品牌故事
		modelMap.put("brand", brand);
		return new ModelAndView("/view/pc/brand_zh", modelMap);
	}
	
	/**
	 * 品牌系列页
	 * @param id 品牌ID
	 * @param modelMap
	 * @return ModelAndView
	 * */
	@RequestMapping(value="/series")
	public ModelAndView series (String id,ModelMap modelMap) throws Exception {
		//品牌系列
		Brandlist series = brandFirstService.getBrandlistById(id);
		//品牌系列轮播图
		List<Public_pic> brandlistPic = picService.list(id,"brandlist_lb_pic",1);
		//系列视频
		List<Public_video> videoList = videoService.list(id, "brandlist_video",1);
		//底部图片
		List<Public_pic> brandlist_pic = picService.list(id,"brandlist_pic",1);
		//品牌
		Public_brand brand = brandService.getById(series.getParentid());
		
		//初始品牌、专题
		init(modelMap);
		modelMap.put("series", series);
		modelMap.put("brandlistPic", brandlistPic);
		modelMap.put("videoList", videoList);
		modelMap.put("brandlist_pic", brandlist_pic);
		modelMap.put("brand", brand);
		modelMap.put("id", series.getParentid()); //品牌ID，用于头部菜单选中
		
		return new ModelAndView("/view/pc/brand_series", modelMap);
	}
	
	/**
	 * 商品列表
	 * @param id 商品列表ID
	 * */
	@RequestMapping(value="/product")
	public ModelAndView products (String id,@RequestParam(value="page",defaultValue="1")int page,ModelMap modelMap) throws Exception {
		//商品列表-对象
		Product_list pro_list = productlistService.getById(id);
		int pageSize = 10;
		
		PageBean<Public_product_size> p = new PageBean<Public_product_size>();
		p.setPageSize(pageSize);
		p.setPageNo(page);
		p.setOrderBy("sizesort");
		p = productlistService.listLableProduct(p, id,1);	//列表下的商品
		
		//品牌
		Public_brand brand = brandService.getById(pro_list.getParentid());
				
		//初始品牌、专题
		init(modelMap);
		
		
		modelMap.put("pro_list", pro_list);
		modelMap.put("productList", p.getList());
		modelMap.put("page", page);
		modelMap.put("pageCount", p.getPageCount());
		modelMap.put("rowCount", p.getRowCount());
		modelMap.put("brand", brand);
		modelMap.put("id", pro_list.getParentid());	//品牌ID，用于头部菜单选中
		modelMap.put("plid", id);	//分页用
		return new ModelAndView("/view/pc/products", modelMap);
	}
	
	/**
	 * 新的网站地图
	 * @param id 商品列表ID
	 * */
	@RequestMapping(value="/newMap")
	public ModelAndView newMap(ModelMap modelMap) throws Exception {
		//初始品牌、专题
		init(modelMap);
		return new ModelAndView("/view/pc/newMap", modelMap);
	}
	
	/**
	 * 新的网站地图
	 * @param id 商品列表ID
	 * */
	@RequestMapping(value="/showVideo")
	public ModelAndView showVideo(String id,ModelMap modelMap) throws Exception {
		
		Filesdown filesdown = filesdownService.getById(id);
		modelMap.put("fileurl", filesdown.getFile_path());
		return new ModelAndView("/view/pc/showVideo", modelMap);
	}
	
	/**
	 * 商品详情
	 * @param id 商品ID
	 * */
	@RequestMapping(value="/product_c")
	public ModelAndView products_c (String id,ModelMap modelMap) throws Exception {
		Public_product_size product = psizeService.getById(id);
		//规格
		Map<String, Object> smap = new LinkedHashMap<String, Object>();
		smap.put("productid = ", product.getProductid());
		smap.put("isshow = ", 1);
		List<Public_product_size> psizeList = psizeService.list(smap);
		
		//判断商品详情类型
		Public_content content = null;
		List<Public_pic> proPics = null;
		if(product.getShowtype() == 1){
			//商品详情-富文本
			Map<String, Object> map = new LinkedHashMap<String, Object>();
			map.put("parentid = ", product.getId());
			map.put("parenttype = ", "productrich");
			map.put("isshow = ", 0);  //此处 isshow赋值0 不代表隐藏
			List<Public_content> list = contentService.list(map);
			content = new Public_content();
			if(list.size() >0)
				content = list.get(0);
		}else{
			//仅图片
			proPics = picService.list(product.getId(), "productContentPic", 1);
		}
		//查找商品表
		Public_product pPro = productService.getById(product.getProductid());
		//品牌
		Public_brand brand = brandService.getById(pPro.getBrandid());
		//相关商品
		List<String> idlist = new ArrayList<String>();
		if(!"".equals(product.getLinkids()) && null != product.getLinkids()){
			String[] ids = product.getLinkids().split(",");
			for(String obj:ids){
				idlist.add(obj);
			}
		}
		List<Public_product_size> linkPros = psizeService.getByIds(idlist);
		
		//商品评价
		
		
		//初始品牌、专题
		init(modelMap);
		
		modelMap.put("product", product);
		modelMap.put("pcontent", content);
		modelMap.put("proPics", proPics);
		modelMap.put("psizeList", psizeList);
		
		modelMap.put("linkPros", linkPros);
		modelMap.put("brand", brand);
		modelMap.put("id", brand.getId());
		return new ModelAndView("/view/pc/product_info", modelMap);
	}
	
	/**
	 * 商品评价
	 * */
	@RequestMapping(value="/rated",method=RequestMethod.POST)
	public void rated(String parentid,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		PageBean<Product_rated> p = new PageBean<Product_rated>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("ratedtime");
		p.setOrderType("desc");
		p = ratedService.list(p, parentid,1);
		
		map.put("data", p.getList());
		map.put("pageCount", p.getPageCount());
		map.put("rowCount", p.getRowCount());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 下载
	 * */
	@RequestMapping(value = "/downloadfile", method = RequestMethod.GET)
	public void downloadFile(String id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		Filesdown filesdown = filesdownService.getById(id);
		if(null != filesdown.getFile_path() && !"".equals(filesdown.getFile_path())){
			String fileurl = filesdown.getFile_path();
			String filename = filesdown.getFile_new_name();
			String fileoldname = filesdown.getFile_old_name();
			
			request.setCharacterEncoding("UTF-8");  
			response.setContentType(request.getSession().getServletContext().getRealPath(filename));
			
	        String userAgent = request.getHeader("User-Agent");
	        response.reset();
	        if(userAgent != null && userAgent.indexOf("MSIE") == -1) {
	            // FF
	        	String enableFileName = "=?UTF-8?B?" + (new String(org.apache.commons.codec.binary.Base64.encodeBase64(fileoldname.getBytes("UTF-8")))) + "?=";  
	            response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName); 
	        }else{
	            // IE   
	            String enableFileName = new String(filename.getBytes("GBK"), "ISO-8859-1");   
	            response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName);
	        }
	        
		    String fullFileName = request.getSession().getServletContext().getRealPath(fileurl); 
		    
	        File tmpFile = new File(fullFileName);
	        long fileLength = tmpFile.length();  
	        response.setHeader("Content-Length", String.valueOf(fileLength));
	        
	        BufferedInputStream bis = null;
	        BufferedOutputStream bos = null;
	    	bis = new BufferedInputStream(new FileInputStream(fullFileName));  
	        bos = new BufferedOutputStream(response.getOutputStream());  
	        byte[] buff = new byte[2048];  
	        int bytesRead;  
	        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
	            bos.write(buff, 0, bytesRead);  
	        };
	        bis.close();  
	        bos.close();
		}else{
			
		}
	}
	
}

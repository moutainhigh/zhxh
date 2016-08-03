package net.ussoft.zhxh.web.system;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_pic;
import net.ussoft.zhxh.model.Public_product;
import net.ussoft.zhxh.service.IPublicBrandService;
import net.ussoft.zhxh.service.IPublicPicService;
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
public class CommonController extends BaseConstroller {
	
	private Logger log = new Logger(CommonController.class);
	@Resource
	private IPublicBrandService brandService;
	@Resource
	private IPublicProductService productService;
	@Resource
	private IPublicPicService picService;
	
	private static final int BUFFER_SIZE = 2 * 1024;
	
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
	
	/**
	 * 多文件上传。仅适用与图片公共表
	 * @param request
	 * @param response
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("/upload")
	public void upload(HttpServletRequest request,HttpServletResponse response) throws IllegalStateException, IOException{
		
    	CommonsMultipartResolver multipartResolver  = new CommonsMultipartResolver(request.getSession().getServletContext());
		if(multipartResolver.isMultipart(request)){
			MultipartHttpServletRequest  multiRequest = (MultipartHttpServletRequest)request;
			//获取参数
			String parentid = request.getParameter("parentid");
			String parenttype = request.getParameter("parenttype");
			
			//获取plupload参数
			Integer chunks = Integer.valueOf(request.getParameter("chunks"));
			String name = request.getParameter("name");
			Integer chunk = Integer.valueOf(request.getParameter("chunk"));
			//获取文件列表
			Iterator<String>  iter = multiRequest.getFileNames();
			while(iter.hasNext()){
				//获取文件对象
				MultipartFile file = multiRequest.getFile((String)iter.next());
				//获取临时文件的绝对路径
				String contextPath = getProjectRealPath() + "file" +File.separator + "tmp" + File.separator;
				
				FileOperate.isExist(contextPath);
				
				//生成临时文件
		        String dstPath =  contextPath + name;
		        File dstFile = new File(dstPath);
		        // 文件已存在（上传了同名的文件）
		        if (chunk == 0 && dstFile.exists()) {
		            dstFile.delete();
		            dstFile = new File(dstPath);
		        }
		        //合并文件
		        cat(file, dstFile);
		        // 完成一整个文件;
		        if (chunk == chunks - 1) {
		        	//获取临时文件对象
		        	File newFile =new File(contextPath+name);
		        	
		        	if(newFile != null){
		        		try {
							uploadSaveData(parentid, parenttype,newFile);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
		        }
			}
		}
	}
	
	/**
     * 将原文件，拼接到目标文件dst
     * @param file
     * @param dst
     */
    private void cat(MultipartFile file, File dst) {
        InputStream in = null;
        OutputStream out = null;
        try {
            if (dst.exists()) {
                out = new BufferedOutputStream(new FileOutputStream(dst, true),BUFFER_SIZE);
            } else {
                out = new BufferedOutputStream(new FileOutputStream(dst),BUFFER_SIZE);
            }
            in = new BufferedInputStream(file.getInputStream(), BUFFER_SIZE);

            byte[] buffer = new byte[BUFFER_SIZE];
            int len = 0;
            while ((len = in.read(buffer)) > 0) {
                out.write(buffer, 0, len);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null != in) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (null != out) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * 保存上传电子全文的信息到数据库
     * @param archiveid
     * @param tabletype
     * @param treeid
     * @throws Exception 
     */
	private String uploadSaveData(String parentid,String parenttype,File tmpFile) throws Exception {
    	
        
        //文件的doc的id
        String picId = UUID.randomUUID().toString();
        
        String filename = tmpFile.getName();
        
        String docExt = "";
        //获取扩展名
        if (filename.lastIndexOf(".") >= 0) {
            docExt = filename.substring(filename.lastIndexOf("."));
        }
        //文件的新名字
        String newname = picId + docExt;
        Public_pic pic = new Public_pic();
        pic.setId(picId);
        pic.setParentid(parentid);
        pic.setParenttype(parenttype);
        String contextPath = getProjectRealPath() + "file" +File.separator + "upload" + File.separator;
        pic.setPic_path("file" +File.separator + "upload" + File.separator + newname);
        pic.setPic_memo("");
        pic.setPic_active(0);
        pic.setPic_sort(1);
        pic.setPic_url("");
        
        FileOperate.copyFile(tmpFile.getPath(), contextPath + newname);
        
        //删除临时文件
        deleteFile(tmpFile.getPath());
        
        picService.insert(pic);
        
        return contextPath;
    }
	
	/**
     * 删除单个文件
     * @param   sPath    被删除文件的文件名
     * @return 单个文件删除成功返回true，否则返回false
     */
    public boolean deleteFile(String sPath) {
        boolean flag = false;
        File file = new File(sPath);
        // 路径为文件且不为空则进行删除
        if (file.isFile() && file.exists()) {
            file.delete();
            flag = true;
        }
        return flag;
    }
	

}

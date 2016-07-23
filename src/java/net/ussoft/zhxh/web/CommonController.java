package net.ussoft.zhxh.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;

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

}

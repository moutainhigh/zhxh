package net.ussoft.zhxh.web;

import java.util.UUID;

import javax.annotation.Resource;

import net.ussoft.zhxh.model.Sys_init;
import net.ussoft.zhxh.service.IConfigService;
import net.ussoft.zhxh.service.IEncryService;
import net.ussoft.zhxh.service.IInitService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class PageController {
	
	@Resource
	private IInitService initService;
	@Resource
	private IConfigService configService;
	@Resource
	private IEncryService encryService;
	
	@RequestMapping("/index.jsp")
    public String index(ModelMap modelMap) throws Exception {
		//获取当前系统类型。
		Sys_init tmpInit = new Sys_init();
		tmpInit.setInitkey("systemtype");
		Sys_init init = initService.selectByWhere(tmpInit);
		//如果系统类型为null，赋予基本系统类型
		if (null == init) {
			init = new Sys_init();
			init.setId(UUID.randomUUID().toString());
			init.setInitkey("systemtype");
			init.setInitvalue("842417faf2b3788594959fa091184f113c7d62f4652ff94beab82ed72b9ec7de12048895"
					+ "ab6c2c92eab82ed72b9ec7de45efe7e0b0e6ce49de0789e7a1e3c7f55bdf8cd0205ca7c3d9c10bef8959af1147d63a02441f1a4119a6577ab5d1edddfca2eccfe6f1aebb2c7b28d673b7b015");
			initService.insert(init);
		}
		//如果系统类型为空，更新为基本系统类型
		if ("".equals(init.getInitvalue())) {
			init.setInitvalue("842417faf2b3788594959fa091184f113c7d62f4652ff94beab82ed72b9ec7de12048895"
					+ "ab6c2c92eab82ed72b9ec7de45efe7e0b0e6ce49de0789e7a1e3c7f55bdf8cd0205ca7c3d9c10bef8959af1147d63a02441f1a4119a6577ab5d1edddfca2eccfe6f1aebb2c7b28d673b7b015");
			initService.update(init);
		}
		
		//判断是否包含前端页面
		if (encryService.getInit("ISPAGE")) {
			return "/page/info";
		}
		
//		Sys_config config = new Sys_config();
//		config.setConfigkey("SYSNAME");
//		config = configService.selectByWhere(config);
//		modelMap.put("sysname", config.getConfigvalue());
		
		return "redirect:/login.do"; 
//		return "login";
    }
	@RequestMapping("/page/content")
	public String content() {
		return "/page/content";
	}

}

package net.ussoft.zhxh.web.system;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class PageController {
	
	
	@RequestMapping("/index.jsp")
    public String index(ModelMap modelMap) throws Exception {
		
		return "redirect:/pcMain/pc_index.html";
    }
	@RequestMapping("/page/content")
	public String content() {
		return "/page/content";
	}

}

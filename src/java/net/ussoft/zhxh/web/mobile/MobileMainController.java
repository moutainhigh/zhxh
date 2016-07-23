package net.ussoft.zhxh.web.mobile;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.util.Logger;


@Controller
@RequestMapping("mobileMain")
public class MobileMainController extends BaseConstroller {
	
	private Logger log = new Logger(MobileMainController.class);
	
	@RequestMapping(value="/mobile_index")
	public ModelAndView index (ModelMap modelMap) throws Exception {
		
		return new ModelAndView("/view/mobile/main", modelMap);
		
	}
	
}

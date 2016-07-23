package net.ussoft.zhxh.web.pc;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.util.Logger;


@Controller
@RequestMapping("pcMain")
public class PcMainController extends BaseConstroller {
	
	private Logger log = new Logger(PcMainController.class);
	
	
	@RequestMapping(value="/pc_index")
	public ModelAndView index (ModelMap modelMap) throws Exception {
		
		return new ModelAndView("/view/pc/main", modelMap);
		
	}
	
}

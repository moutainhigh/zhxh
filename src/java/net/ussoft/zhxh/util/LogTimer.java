package net.ussoft.zhxh.util;

import java.util.TimerTask;

import net.ussoft.zhxh.service.ILoginlogService;
import net.ussoft.zhxh.service.IOperlogService;
import net.ussoft.zhxh.service.impl.SpringContextUtils;

public class LogTimer extends TimerTask {
	
	private Logger log = new Logger(LogTimer.class);
	
	public void run() {
		log.info("******删除日志定时任务于["+DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss")+"]启动运行。");
        try {
        	ILoginlogService loginlogService = SpringContextUtils.getBean("loginlogService");
        	IOperlogService operlogService = SpringContextUtils.getBean("operlogService");
        	loginlogService.delete();
        	operlogService.delete();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        log.info("******删除日志任务于["+DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss")+"]运行完毕。");
    }
}

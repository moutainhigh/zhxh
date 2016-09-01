package net.ussoft.zhxh.util;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

//import net.ussoft.zhxh.service.ILoginlogService;
//import net.ussoft.zhxh.service.IOperlogService;
import net.ussoft.zhxh.service.impl.SpringContextUtils;

public class LogTimer2 {
    static int count = 0;
    
    static TimerTask logtask = null;
    
    public static void showTimer() {
    	
    	if (null != logtask) {
    		return;
    	}
//    	final IDocService docService = SpringContextUtils.getBean("docService");
//    	final ILoginlogService loginlogService = SpringContextUtils.getBean("loginlogService");
//    	final IOperlogService operlogService = SpringContextUtils.getBean("operlogService");
    	
    	logtask = new TimerTask() {
            @Override
            public void run() {
                ++count;
                try {
//                	loginlogService.delete();
//                	operlogService.delete();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
                System.out.println("删除日志。时间=" + new Date() + " 执行了" + count + "次"); // 1次
            }
        };

        //设置执行时间
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int day = calendar.get(Calendar.DAY_OF_MONTH);//每天
        //定制每天的21:09:00执行，
        calendar.set(year, month, day, 21, 01, 00);
        Date date = calendar.getTime();
        Timer timer = new Timer();
        System.out.println(date);
        
//        String path = System.getProperty("webapp.root");
//        System.out.println(path);
        
        int period = 2 * 1000;
        //每天的date时刻执行task，每隔2秒重复执行
//        timer.schedule(task, date, period);
        //每天的date时刻执行task, 仅执行一次
        timer.schedule(logtask, date);
    }

    public static void main(String[] args) {
        showTimer();
    }
}

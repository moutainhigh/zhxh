package net.ussoft.zhxh.util;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import net.ussoft.zhxh.service.IDocService;
import net.ussoft.zhxh.service.impl.DocService;
import net.ussoft.zhxh.service.impl.SpringContextUtils;
import net.ussoft.zhxh.util.lucene.Indexer;

public class IndexerTimer2 {
    static int count = 0;
    
    static TimerTask task = null;
    
//    static DocService docService = SpringContextUtils.getBean("docService");
    
//    static WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
//    static IDocService docService = (DocService) context.getBean("docService"); 
    
    
//    UserService us = SpringContextUtils.getBean("userServiceImpl");
    
    public void showTimer() {
    	
//    	if (null != task) {
//    		return;
//    	}
//    	final IDocService docService = SpringContextUtils.getBean("docService");
//    	final IDocService docService = (IDocService) ApplicationContextUtil.getBean("docService");
    	final Logger log = new Logger(DocService.class);
    	
        task = new TimerTask() {
            @Override
            public void run() {
            	log.info("******索引定时任务于["+DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss")+"]启动运行。");
                ++count;
                try {
                	IDocService docService = SpringContextUtils.getBean("docService");
					docService.indexer("");
					//合并索引文件，真正删除标记为删除的
					try {
						Indexer indexer = new Indexer();
						indexer.indexAfterMerge();
					} catch (Exception e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
                log.info("******索引定时任务于["+DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss")+"]运行完毕。");
                System.out.println("时间=" + new Date() + " 执行了" + count + "次"); // 1次
            }
        };

        //设置执行时间
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int day = calendar.get(Calendar.DAY_OF_MONTH);//每天
        //定制每天的21:09:00执行，
        calendar.set(year, month, day, 10, 38, 00);
        Date date = calendar.getTime();
        Timer timer = new Timer();
        System.out.println(date);
        
//        String path = System.getProperty("webapp.root");
//        System.out.println(path);
        
        int period = 2 * 1000;
        //每天的date时刻执行task，每隔2秒重复执行
//        timer.schedule(task, date, period);
        //每天的date时刻执行task, 仅执行一次
        timer.schedule(task, date);
    }

    public static void main(String[] args) {
//        showTimer();
    }
}

package net.ussoft.zhxh.filter;  

import java.util.Calendar;
import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import net.ussoft.zhxh.util.IndexerTimer;
import net.ussoft.zhxh.util.LogTimer;
import net.ussoft.zhxh.util.Logger;  

/** 
 * @author Administrator 定时器 
 */  
public class TimerListener implements ServletContextListener {  
    private Timer timer;
    private Timer timer2;
    private IndexerTimer indexerTimer;
    private LogTimer logTimer;
    private Logger log = new Logger(TimerListener.class);

    public void contextDestroyed(ServletContextEvent arg0) {
        timer.cancel();
        timer2.cancel();
        System.out.println("定时器已销毁");
    }  

    public void contextInitialized(ServletContextEvent event) {
    	//索引计时器
    	Calendar twentyOne = Calendar.getInstance();
        twentyOne.set(Calendar.HOUR_OF_DAY, 12);
        twentyOne.set(Calendar.MINUTE, 19);
        twentyOne.set(Calendar.SECOND, 0);
         
        log.info("索引调度任务启动.");
        
        timer = new java.util.Timer(true);
        indexerTimer = new IndexerTimer();
        
        timer.schedule(indexerTimer, twentyOne.getTime(), 24 * 3600 * 1000);
        
        //日志删除计时器
        Calendar twentyOne2 = Calendar.getInstance();
        twentyOne2.set(Calendar.HOUR_OF_DAY, 21);
        twentyOne2.set(Calendar.MINUTE, 01);
        twentyOne2.set(Calendar.SECOND, 0);
        
        log.info("日志删除调度任务启动.");
        
        timer2 = new java.util.Timer(true);
        logTimer = new LogTimer();
        
        timer2.schedule(logTimer, twentyOne2.getTime(), 24 * 3600 * 1000);
        
        
        
    }  
}  
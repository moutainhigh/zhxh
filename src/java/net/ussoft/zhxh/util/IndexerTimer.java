package net.ussoft.zhxh.util;

import java.util.TimerTask;

//import net.ussoft.zhxh.service.IDocService;
import net.ussoft.zhxh.service.impl.SpringContextUtils;
//import net.ussoft.zhxh.util.lucene.Indexer;  
  
/** 
 * 定时器的任务 
 */  
public class IndexerTimer extends TimerTask {
    private Logger log = new Logger(IndexerTimer.class);
  
    public void run() {  
//    	log.info("******索引定时任务于["+DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss")+"]启动运行。");
//        try {
//        	IDocService docService = SpringContextUtils.getBean("docService");
//			docService.indexer("");
//			//合并索引文件，真正删除标记为删除的
//			try {
//				Indexer indexer = new Indexer();
//				indexer.indexAfterMerge();
//			} catch (Exception e1) {
//				// TODO Auto-generated catch block
//				e1.printStackTrace();
//			}
//			
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//        log.info("******索引定时任务于["+DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss")+"]运行完毕。");
    }  
}  
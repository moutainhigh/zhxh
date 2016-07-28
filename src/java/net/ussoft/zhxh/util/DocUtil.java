package net.ussoft.zhxh.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.DocumentFormat;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;

/**
 * 档案文件在线浏览 工具。主要是将文本类电子全文，转为pdf，供前台预览。
 * 使用了openoffice来转换office文件。
 * @author wangf
 *
 */

public class DocUtil {

	private static final int environment = 1;// 环境 1：windows 2:linux(只涉及pdf2swf路径问题)  
    private static String fileString;
    private static String outputPath;// 输入路径 ，如果不设置就输出在默认的位置  
    private static String fileName;  
    private static File pdfFile;
    private static File docFile;
  
    
  
    /** 
     * 重新设置file 
     *  
     * @param fileString 
     */  
    public static void setFile(String fileString) {
        ini(fileString);
    }  
  
    /** 
     * 初始化 
     *  
     * @param fileString 
     */  
    private static void ini(String fileString) {
        fileName = fileString.substring(0, fileString.lastIndexOf("."));
        docFile = new File(fileString);  
        pdfFile = new File(fileName + ".pdf");
    }  
  
    /** 
     * 转为PDF 
     *  
     * @param file 
     */  
    private static void doc2pdf() throws Exception {  
        if (docFile.exists()) {
        	if(docFile.getName().toLowerCase().indexOf(".pdf")> 0){
        		//copyFile(docFile.toString(),pdfFile.toString());
        		pdfFile = docFile;
        	}
            if (!pdfFile.exists()) {  
//            	DistorySoffice dis = new DistorySoffice();
            	Thread.sleep(7000);
//                OpenOfficeConnection connection1 = new SocketOpenOfficeConnection(8100);
                SocketOpenOfficeConnection connection = new SocketOpenOfficeConnection("127.0.0.1", 8100);
                try {  
                    connection.connect();  
                    DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
//                    DocumentFormat df = new DocumentFormat();
//                    df.
                    converter.convert(docFile, pdfFile);
                    // close the connection  
                    connection.disconnect();  
                    System.out.println("****pdf转换成功，PDF输出：" + pdfFile.getPath()  
                            + "****");  
                } catch (java.net.ConnectException e) {  
                    e.printStackTrace();  
                    System.out.println("****swf转换器异常，openoffice服务未启动！****");  
                    throw e;  
                } catch (com.artofsolving.jodconverter.openoffice.connection.OpenOfficeException e) {  
                    e.printStackTrace();  
                    System.out.println("****swf转换器异常，读取转换文件失败****");  
                    throw e;  
                } catch (Exception e) {  
                    e.printStackTrace();  
                    throw e;  
                }  
            } else {  
                System.out.println("****已经转换为pdf，不需要再进行转化****");  
            }  
        } else {  
            System.out.println("****swf转换器异常，需要转换的文档不存在，无法转换****");  
        }  
    }  
  
    /** 
     * 转换主方法 
     */  
    public static boolean conver() {  
  
    	//pdf文件已存在，直接返回
        if (pdfFile.exists()) {
            return true;  
        }  
  
//        if (environment == 1) {  
//            System.out.println("****swf转换器开始工作，当前设置运行环境windows****");  
//        } else {  
//            System.out.println("****swf转换器开始工作，当前设置运行环境linux****");  
//        }
        try {  
            doc2pdf();  
        } catch (Exception e) {  
            e.printStackTrace();  
            return false;  
        }  
  
        if (pdfFile.exists()) {  
            return true;  
        } else {  
            return false;  
        }  
    }  
  
    /** 
     * 设置输出路径 
     */  
    public static void setOutputPath(String outputPath) {
    	pdfFile = new File(outputPath + ".pdf");
    }  
    
    private static void copyFile(String src,String dest) throws IOException{
        FileInputStream in=new FileInputStream(src);
        File file=new File(dest);
        if(!file.exists())
            file.createNewFile();
        FileOutputStream out=new FileOutputStream(file);
        int c;
        byte buffer[]=new byte[1024];
        while((c=in.read(buffer))!=-1){
            for(int i=0;i<c;i++)
                out.write(buffer[i]);        
        }
        in.close();
        out.close();
    }
    
//    public static void main(String s[]) {  
//        DocConverter d = new DocConverter("F:/Dowln/e4c577be/1B578520/41ea12e7-e9bf-4b9e-b8ee-cdf987d0839f.doc");  
//        d.conver();
//    	CallOpenoffice callOpenoffice = new CallOpenoffice();
//    	DistorySoffice dis = new DistorySoffice();
//    } 

}

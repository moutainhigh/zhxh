package net.ussoft.zhxh.util;   
  
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
  
public class FileOperate {   
    public FileOperate() {   
    }   
    
    private static Logger log = new Logger(FileOperate.class);
  
    /**   
     * 新建目录   
     *    
     * @param folderPath   
     *            String 如 c:/fqf
     * @return boolean   
     */  
    public static boolean newFolder(String folderPath) {
        boolean result =false;
        try {   
            String filePath = folderPath;   
            filePath = filePath.toString();   
            File myFilePath = new File(filePath);   
            if (!myFilePath.exists()) {
                result =  myFilePath.mkdir();
            }   
        } catch (Exception e) {   
            System.out.println("新建目录操作出错 ");
            e.printStackTrace();
            return false;
        }
        return  result;
    }
    
    /**
     * 
     * @param path 文件夹路径
     */
    public static void isExist(String path) {
    	File file = new File(path);
    	//判断文件夹是否存在,如果不存在则创建文件夹
    	if (!file.exists()) {
    		file.mkdirs();
    	}
    }
  
    /**   
     * 新建文件   
     *    
     * @param filePathAndName   
     *            String 文件路径及名称 如c:/fqf.txt   
     * @param fileContent   
     *            String 文件内容   
     * @return boolean   
     */  
    public static boolean newFile(String filePathAndName, String fileContent) {
        boolean result = false;
        try {   
            String filePath = filePathAndName;   
            filePath = filePath.toString();   
            File myFilePath = new File(filePath);   
            if (!myFilePath.exists()) {   
                myFilePath.createNewFile();   
            }   
            FileWriter resultFile = new FileWriter(myFilePath);   
            PrintWriter myFile = new PrintWriter(resultFile);   
            String strContent = fileContent;   
            myFile.println(strContent);   
            resultFile.close();
            result =true;
  
        } catch (Exception e) {   
            System.out.println("新建文件操作出错 ");   
            e.printStackTrace();
            return false;
        }   
         return result;
    }   
  
    public static boolean delFileOrDir(String path){
        File file = new File(path);
        if (file == null || !file.exists()) {
           return  false;
        }
        if (!file.isDirectory()) {
            delFile(path);
        }else{
            delFolder(path);
        }
        return true;
    }
    /**
     * 删除文件   
     *    
     * @param filePathAndName   
     *            String 文件路径及名称 如c:/fqf.txt
     * @return boolean   
     */  
    public static boolean delFile(String filePathAndName) {
        try {   
            String filePath = filePathAndName;   
            filePath = filePath.toString();   
            java.io.File myDelFile = new java.io.File(filePath);   
            return myDelFile.delete();   
  
        } catch (Exception e) {   
            System.out.println("删除文件操作出错 ");   
            e.printStackTrace();   
  
        }
		return false;   
  
    }   
  
    /**   
     * 删除文件夹   
     *    
     *            String
     * @return boolean   
     */  
    public static void delFolder(String folderPath) {
        try {   
            delAllFile(folderPath); // 删除完里面所有内容   
            String filePath = folderPath;   
            filePath = filePath.toString();   
            java.io.File myFilePath = new java.io.File(filePath);   
            myFilePath.delete(); // 删除空文件夹   
  
        } catch (Exception e) {   
            System.out.println("删除文件夹操作出错 ");   
            e.printStackTrace();   
  
        }   
  
    }   
  
    /**   
     * 删除文件夹里面的所有文件   
     *    
     * @param path   
     *            String 文件夹路径 如 c:/fqf   
     */  
    public static void delAllFile(String path) {
        File file = new File(path);   
        if (!file.exists()) {   
            return;   
        }   
        if (!file.isDirectory()) {   
            return;   
        }   
        String[] tempList = file.list();   
        File temp = null;   
        for (int i = 0; i < tempList.length; i++) {   
            if (path.endsWith(File.separator)) {   
                temp = new File(path + tempList[i]);   
            } else {   
                temp = new File(path + File.separator + tempList[i]);   
            }   
            if (temp.isFile()) {   
                temp.delete();   
            }   
            if (temp.isDirectory()) {   
                delAllFile(path + "/ " + tempList[i]);// 先删除文件夹里面的文件   
                delFolder(path + "/ " + tempList[i]);// 再删除空文件夹   
            }   
        }   
    }   
  
    /**   
     * 复制单个文件   
     *    
     * @param oldPath   
     *            String 原文件路径 如：c:/fqf.txt   
     * @param newPath   
     *            String 复制后路径 如：f:/fqf.txt   
     * @return boolean   
     */  
    public static void copyFile(String oldPath, String newPath) {
        try {   
            int bytesum = 0;   
            int byteread = 0;   
            File oldfile = new File(oldPath);   
            if (oldfile.exists()) { // 文件存在时   
                InputStream inStream = new FileInputStream(oldPath); // 读入原文件   
                FileOutputStream fs = new FileOutputStream(newPath);   
                byte[] buffer = new byte[1444];   
                while ((byteread = inStream.read(buffer)) != -1) {   
                    bytesum += byteread; // 字节数 文件大小   
//                    System.out.println(bytesum);   
                    fs.write(buffer, 0, byteread);   
                }   
                inStream.close();   
            }   
        } catch (Exception e) {   
            System.out.println("复制单个文件操作出错 ");   
            e.printStackTrace();   
  
        }   
  
    }   
  
    /**   
     * 复制整个文件夹内容   
     *    
     * @param oldPath   
     *            String 原文件路径 如：c:/fqf   
     * @param newPath   
     *            String 复制后路径 如：f:/fqf/ff   
     * @return boolean   
     */  
    public static void copyFolder(String oldPath, String newPath) {
        try {   
            (new File(newPath)).mkdirs(); // 如果文件夹不存在 则建立新文件夹   
            File a = new File(oldPath);   
            String[] file = a.list();   
            File temp = null;   
            for (int i = 0; i < file.length; i++) {   
                if (oldPath.endsWith(File.separator)) {   
                    temp = new File(oldPath + file[i]);   
                } else {   
                    temp = new File(oldPath + File.separator + file[i]);   
                }   
  
                if (temp.isFile()) {   
                    FileInputStream input = new FileInputStream(temp);   
                    FileOutputStream output = new FileOutputStream(newPath   
                            + "/ " + (temp.getName()).toString());   
                    byte[] b = new byte[1024 * 5];   
                    int len;   
                    while ((len = input.read(b)) != -1) {   
                        output.write(b, 0, len);   
                    }   
                    output.flush();   
                    output.close();   
                    input.close();   
                }   
                if (temp.isDirectory()) {// 如果是子文件夹   
                    copyFolder(oldPath + "/ " + file[i], newPath + "/ "  
                            + file[i]);   
                }   
            }   
        } catch (Exception e) {   
            System.out.println("复制整个文件夹内容操作出错 ");   
            e.printStackTrace();   
  
        }   
  
    }   
  
    /**   
     * 移动文件到指定目录   
     *    
     * @param oldPath   
     *            String 如：c:/fqf.txt   
     * @param newPath   
     *            String 如：d:/fqf.txt   
     */  
    public static void moveFile(String oldPath, String newPath) {
        copyFile(oldPath, newPath);   
        delFile(oldPath);   
  
    }
    public static void moveFile(File oldFile, File newFile) {
        moveFile(oldFile.getPath(),newFile.getPath());
    }

    /**   
     * 移动文件夹到指定目录   
     *    
     * @param oldPath   
     *            String 如：c:/fqf   
     * @param newPath   
     *            String 如：d:/fqf   
     */  
    public static void moveFolder(String oldPath, String newPath) {
        copyFolder(oldPath, newPath);   
        delFolder(oldPath);   
    }

    public static boolean rename(String from, String to) {
        try {
            File fromFile = new File(from);
            fromFile.renameTo(new File(to));
            return true;
        }catch (Exception e){
            return false;
        }
    }
    
    public static String bytesToHexString(byte[] src) {  
        StringBuilder stringBuilder = new StringBuilder();  
        if (src == null || src.length <= 0) {  
            return null;  
        }  
        for (int i = 0; i < src.length; i++) {  
            int v = src[i] & 0xFF;  
            String hv = Integer.toHexString(v);  
            if (hv.length() < 2) {  
                stringBuilder.append(0);  
            }  
            stringBuilder.append(hv);  
        }  
        return stringBuilder.toString();  
    }
    
    private static HashMap<String,String> getFiletypyObj() {
    	
    	HashMap<String,String> type = new HashMap<String,String>();
    	type.put("XML", "3C3F786D6C");
    	return type;
    }
    /**
     * 获取文件的真实类型
     * @param path
     * @return
     * @throws IOException
     */
    public static String getFiletype(String path) throws IOException {
    	File f = new File(path);
		
		if (!f.exists() || f.length() == 0) {
			log.info("*** 文件不存在.");
			return "NOFILE";
		}
		
    	FileInputStream is = new FileInputStream(path);
    	
    	log.info("***  获取的文件流长度：" + is.available());
    	
    	byte[] b = new byte[3];  
        is.read(b, 0, b.length);  
        String hexStr = bytesToHexString(b);
        
        HashMap<String,String> resultMap = getFiletypyObj();
        String doctype = "";
        for (Map.Entry<String, String> entry : resultMap.entrySet()) {
        	if (entry.getValue().indexOf(hexStr.toUpperCase()) >= 0) {
        		doctype = entry.getKey();
        	}
        }
//        3c3f78
        return doctype;
    }
}
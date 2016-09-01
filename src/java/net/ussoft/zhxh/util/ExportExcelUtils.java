package net.ussoft.zhxh.util;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFHeader;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;


public class ExportExcelUtils {
	
	
	private static void setCell(HSSFSheet sheet,HSSFRow row,HSSFCell cell,int column,int width,String cellTxt,HSSFCellStyle style) {
		cell = row.createCell(column);// 创建第0行第k列
		cell.setCellValue(cellTxt);// 设置第0行第k列的值
		if (width > 0) {
			sheet.setColumnWidth(column, width);// 设置列的宽度
		}
//		style.setFont(font);// 设置字体风格
		cell.setCellStyle(style);
	}
	
	//导出档案
//	public static void exportArchive(List<Sys_templetfield> fields,String title,List<Map<String, Object>> rowList,HttpServletResponse response,HttpServletRequest request) throws Exception {
//		HSSFWorkbook workbook = new HSSFWorkbook();
//		
//		Vector<String> tableHeader = new Vector<String>();
//		tableHeader.add("序号");
////		String[] columnArr = new String[];
//		Vector<String> columnArr = new Vector<String>();
//		for (Sys_templetfield field : fields) {
//			if (field.getSort() > 0) {
//				tableHeader.add(field.getChinesename());
//				columnArr.add(field.getEnglishname());
//			}
//		}
//		
//		short cellNumber = (short) tableHeader.size();// 表的列数
//		workbook = new HSSFWorkbook(); // 创建一个excel
//		HSSFCell cell = null; // Excel的列
//		HSSFRow row = null; // Excel的行
//		
//		
//		
//		HSSFFont font = workbook.createFont(); // 设置字体
//		font.setFontName("宋体");
//		font.setFontHeightInPoints((short) 12);// 设置字体
//		
//		HSSFCellStyle style = workbook.createCellStyle(); // 设置表头的类型
//		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直
//		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平
//		style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
//		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
//		style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
//		style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
//		style.setFont(font);// 设置字体风格
//		
//		HSSFSheet sheet = workbook.createSheet("sheet1"); // 创建一个sheet
//		HSSFHeader header = sheet.getHeader();// 设置sheet的头
//		
//		try {
//			header.setCenter(title);
//			row = sheet.createRow(0);
//			row.setHeight((short) 500);
//			
//			//设置序号列
//			setCell(sheet,row,cell,0,2000,tableHeader.get(0),style);
//			
//			for (int k = 1; k < cellNumber; k++) {
//				setCell(sheet,row,cell,k,5000,tableHeader.get(k),style);
//			}
//			
//			int num = 1;
//			for (Map map : rowList) {
//				row = sheet.createRow((short) (num));// 创建第num+1行
//				row.setHeight((short) 500);// 设置行高
//				
//				//插入序号
//				setCell(sheet,row,cell,0,0,String.valueOf(num),style);
//				
//				int c_num = 1;
//				for (String columnName : columnArr) {
//					//插入单元名称
//					if (null != map.get(columnName) && !"".equals(map.get(columnName))) {
//						String columnTxt = map.get(columnName).toString();
//						setCell(sheet,row,cell,c_num,0,columnTxt,style);
//					}
//					else {
//						setCell(sheet,row,cell,c_num,0,"",style);
//					}
//					c_num += 1;
//				}
//				
//				
//				num += 1;
//			}
//			
//			
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
//		
//		OutputStream out = null;// 创建一个输出流对象
//		try {
//			out = response.getOutputStream();
////				String headerStr = "";
//			title += ".xls";
//			response.setContentType("application/vnd.ms-excel;charset=utf-8");
//			
//			String userAgent = request.getHeader("User-Agent");
//			response.reset();
//			if(userAgent != null && userAgent.indexOf("MSIE") == -1) {
//				// FF
//				String enableFileName = "=?UTF-8?B?" + (new String(org.apache.commons.codec.binary.Base64.encodeBase64(title.getBytes("UTF-8")))) + "?=";  
//				response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName); 
//			}else{
//				// IE   
//				String enableFileName = new String(title.getBytes("GBK"), "ISO-8859-1");   
//				response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName);
//			}
//			
//			request.setCharacterEncoding("UTF-8");  
//			
//			workbook.write(out);
//			out.flush();
//		} catch (IOException e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				if (out != null) {
//					out.close();
//				}
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//		}
//	}
	
	
	//============以下没有用到，等待删除
	//导出年报统计表
	public static void exportYearReport(String title,List<Map<String, String>> rowList,HttpServletResponse response,HttpServletRequest request) throws Exception {
		HSSFWorkbook workbook = new HSSFWorkbook();
		
		Vector<String> tableHeader = new Vector<String>();
		
		tableHeader.add("序号");
		tableHeader.add("费用名称");
		tableHeader.add("费用类型");
		
		Vector<String> monthHeader = new Vector<String>();
		monthHeader.add("一月");
		monthHeader.add("二月");
		monthHeader.add("三月");
		monthHeader.add("四月");
		monthHeader.add("五月");
		monthHeader.add("六月");
		monthHeader.add("七月");
		monthHeader.add("八月");
		monthHeader.add("九月");
		monthHeader.add("十月");
		monthHeader.add("十一月");
		monthHeader.add("十二月");
		
		short cellNumber = (short) tableHeader.size();// 表的列数
		workbook = new HSSFWorkbook(); // 创建一个excel
		HSSFCell cell = null; // Excel的列
		HSSFRow row = null; // Excel的行
		
		
		
		HSSFFont font = workbook.createFont(); // 设置字体
		font.setFontName("宋体");
        font.setFontHeightInPoints((short) 12);// 设置字体
        
        HSSFCellStyle style = workbook.createCellStyle(); // 设置表头的类型
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
		style.setFont(font);// 设置字体风格
        
		HSSFSheet sheet = workbook.createSheet("sheet1"); // 创建一个sheet
		HSSFHeader header = sheet.getHeader();// 设置sheet的头
		
		try {
			header.setCenter(title);
			row = sheet.createRow(0);
			row.setHeight((short) 500);
			
			//设置序号列
			setCell(sheet,row,cell,0,2000,tableHeader.get(0),style);
			
			for (int k = 1; k < cellNumber; k++) {
				setCell(sheet,row,cell,k,5000,tableHeader.get(k),style);
			}
			
			//加入第一行表标题
			int num = 0;
			for (int j=0;j<monthHeader.size();j++) {
				num += 3;
				setCell(sheet,row,cell,num,6000,monthHeader.get(j),style);
				sheet.addMergedRegion(new CellRangeAddress(0,0,num,num+2));
			}
			//设置横向合计
			setCell(sheet,row,cell,num + 3,6000,"合计",style);
			sheet.addMergedRegion(new CellRangeAddress(0,0,num+3,num+5));
			
			row = sheet.createRow(1);
			row.setHeight((short) 500);
			
			sheet.addMergedRegion(new CellRangeAddress(0,1,0,0));
			sheet.addMergedRegion(new CellRangeAddress(0,1,1,1));
			sheet.addMergedRegion(new CellRangeAddress(0,1,2,2));
			
			//解决合并单元格 变宽划线问题。================
			row = sheet.getRow(1);
			for(int i=0;i<cellNumber;i++){
				setCell(sheet,row,cell,i,0,"",style);
			}
			
			row = sheet.getRow(0);
			num = 1;
			for(int i=3;i<monthHeader.size()+3;i++){
				setCell(sheet,row,cell,num+3,0,"",style);
			    setCell(sheet,row,cell,num+4,0,"",style);
			    num += 3;
			}
			
			setCell(sheet,row,cell,num+3,0,"",style);
			setCell(sheet,row,cell,num+4,0,"",style);
			//================
			
			row = sheet.getRow(1);
			//加入第二行标题
			num = 3;
			for (int j=0;j<monthHeader.size();j++) {
				setCell(sheet,row,cell,num,3000,"收入",style);
				
				setCell(sheet,row,cell,num+1,3000,"退费",style);
				
				setCell(sheet,row,cell,num+2,3000,"欠费",style);
				num += 3;
			}
			
			//加入横向合计的二行标题====
			setCell(sheet,row,cell,num,3000,"收入",style);
			
			setCell(sheet,row,cell,num+1,3000,"退费",style);
			
			setCell(sheet,row,cell,num+2,3000,"欠费",style);
			//===========
			
			
			//插入数据
			//年度行统计数据
//			Vector<Float> columnSummary = new Vector<Float>();
//			float[] columnSum = {0,0,0,0,0,0,0,0,0,0,0,0};
			float[] columnSum = new float[36];
			for (int i=0;i<36;i++) {
				columnSum[i] = 0;
			}
			
			num = 1;
			
			//总的合计
			float totle_sum_s = 0;
			float totle_sum_t = 0;
			float totle_sum_q = 0;
			
			for (Map map : rowList) {
				row = sheet.createRow((short) (num + 1));// 创建第num+1行
				row.setHeight((short) 500);// 设置行高
				
				//插入序号
				setCell(sheet,row,cell,0,0,String.valueOf(num),style);
				
				//插入费用名称
				if (null != map.get("itemcode") && !"".equals(map.get("itemcode"))) {
					setCell(sheet,row,cell,1,0,map.get("itemcode").toString(),style);
				}
				else {
					setCell(sheet,row,cell,1,0,"",style);
				}
				String itemtype = "支出";
				//插入费用类型
				if (null != map.get("itemtype") && !"".equals(map.get("itemtype"))) {
					
					if (map.get("itemtype").equals("1")) {
						itemtype = "收入";
					}
					setCell(sheet,row,cell,2,0,itemtype,style);
				}
				else {
					setCell(sheet,row,cell,2,0,"",style);
				}
				
				float row_sum_s = 0;
				float row_sum_t = 0;
				float row_sum_q = 0;
				
				int w_num = 3;
				String value = "";
				for (int i=0;i<12;i++) {
					if (null != map.get("m_"+ (i+1) + "_s") && !"".equals(map.get("m_"+ (i+1) + "_s"))) {
						value = map.get("m_"+ (i+1) + "_s").toString();
						if ("支出".equals(itemtype)) {
							columnSum[w_num-3] -= Float.valueOf(value);
							value = "-"+value;
						}
						else {
							columnSum[w_num-3] += Float.valueOf(value);
						}
						setCell(sheet,row,cell,w_num,3000,value,style);
						row_sum_s += Float.valueOf(value);
						
					}
					else {
						setCell(sheet,row,cell,w_num,3000,"",style);
					}
					
					if (null != map.get("m_"+ (i+1) + "_t") && !"".equals(map.get("m_"+ (i+1) + "_t"))) {
						setCell(sheet,row,cell,w_num+1,3000,map.get("m_"+ (i+1) + "_t").toString(),style);
						row_sum_t += Float.valueOf(map.get("m_"+ (i+1) + "_t").toString());
						columnSum[w_num-2] += Float.valueOf(map.get("m_"+ (i+1) + "_t").toString());
					}
					else {
						setCell(sheet,row,cell,w_num+1,3000,"",style);
					}
					
					if (null != map.get("m_"+ (i+1) + "_q") && !"".equals(map.get("m_"+ (i+1) + "_q"))) {
						value = map.get("m_"+ (i+1) + "_q").toString();
						if ("支出".equals(itemtype)) {
							columnSum[w_num-1] -= Float.valueOf(value);
							value = "-"+value;
						}
						else {
							columnSum[w_num-1] += Float.valueOf(value);
						}
						setCell(sheet,row,cell,w_num+2,3000,value,style);
						row_sum_q += Float.valueOf(value);
						
					}
					else {
						setCell(sheet,row,cell,w_num+2,3000,"",style);
					}
//					sum_num += 3;
					w_num += 3;
				}
				//插入行合计
				if (row_sum_s != 0) {
					row_sum_s = ((float)Math.round(row_sum_s*100)/100);
//					row_sum_s = Math.round(row_sum_s*100)/100;
					setCell(sheet,row,cell,w_num,3000,String.valueOf(row_sum_s),style);
//					setCell(sheet,row,cell,w_num,3000,("支出".equals(itemtype))?"-"+String.valueOf(row_sum_s):String.valueOf(row_sum_s),style);
//					totle_sum_s += (Float.valueOf(("支出".equals(itemtype))?"-"+String.valueOf(row_sum_s):String.valueOf(row_sum_s)));
					totle_sum_s += row_sum_s;
				}
				else {
					setCell(sheet,row,cell,w_num,0,"",style);
				}
				if (row_sum_t != 0) {
					row_sum_t = ((float)Math.round(row_sum_t*100)/100);
//					row_sum_t = Math.round(row_sum_t*100)/100;
					setCell(sheet,row,cell,w_num+1,3000,String.valueOf(row_sum_t),style);
					totle_sum_t += (Float.valueOf(String.valueOf(row_sum_t)));
				}
				else {
					setCell(sheet,row,cell,w_num+1,0,"",style);
				}
				
				if (row_sum_q != 0) {
					row_sum_q = ((float)Math.round(row_sum_q*100)/100);
//					row_sum_q = Math.round(row_sum_q*100)/100;
					setCell(sheet,row,cell,w_num+2,3000,String.valueOf(row_sum_q),style);
					totle_sum_q += row_sum_q;
//					setCell(sheet,row,cell,w_num+2,3000,("支出".equals(itemtype))?"-"+String.valueOf(row_sum_q):String.valueOf(row_sum_q),style);
//					totle_sum_q += (Float.valueOf(("支出".equals(itemtype))?"-"+String.valueOf(row_sum_q):String.valueOf(row_sum_q)));
				}
				else {
					setCell(sheet,row,cell,w_num+2,0,"",style);
				}
				num += 1;
			}
			
			//插入纵向合计
			row = sheet.createRow((short) (num + 1));// 创建第num+1行
			row.setHeight((short) 500);// 设置行高
			
			//插入序号 HSSFSheet sheet,HSSFRow row,HSSFCell cell,int column,int width,String cellTxt,HSSFCellStyle style
			setCell(sheet,row,cell,0,2000,"",style);
			//插入合计文字
			setCell(sheet,row,cell,1,5000,"合计",style);
			//插入空白
			setCell(sheet,row,cell,2,5000,"",style);
			
			int w_num = 3;
			for (int i=0;i<36;i++) {
				setCell(sheet,row,cell,w_num,0,String.valueOf(columnSum[i]),style);
				w_num++;
			}
			
			//插入总合计
			setCell(sheet,row,cell,w_num,0,String.valueOf(totle_sum_s),style);
			setCell(sheet,row,cell,w_num+1,0,String.valueOf(totle_sum_t),style);
			setCell(sheet,row,cell,w_num+2,0,String.valueOf(totle_sum_q),style);
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		OutputStream out = null;// 创建一个输出流对象
		try {
			out = response.getOutputStream();
//			String headerStr = "";
			title += ".xls";
			response.setContentType("application/vnd.ms-excel;charset=utf-8");
	        
	        String userAgent = request.getHeader("User-Agent");
	        response.reset();
	        if(userAgent != null && userAgent.indexOf("MSIE") == -1) {
	            // FF
	        	String enableFileName = "=?UTF-8?B?" + (new String(org.apache.commons.codec.binary.Base64.encodeBase64(title.getBytes("UTF-8")))) + "?=";  
	            response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName); 
	        }else{
	            // IE   
	            String enableFileName = new String(title.getBytes("GBK"), "ISO-8859-1");   
	            response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName);
	        }
	        
	        request.setCharacterEncoding("UTF-8");  
	        
			workbook.write(out);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	//导出单元基本信息统计表
	public static void exportUnitInfo(String title,List<Map<String, String>> rowList,HttpServletResponse response,HttpServletRequest request) throws Exception {
		HSSFWorkbook workbook = new HSSFWorkbook();
		
		Vector<String> tableHeader = new Vector<String>();
		
		tableHeader.add("序号");
		tableHeader.add("单元名称");
		tableHeader.add("建筑面积");
		tableHeader.add("套内面积");
		tableHeader.add("单元状态");
		tableHeader.add("单元类型");
		tableHeader.add("是否收费");
		tableHeader.add("排序");
		tableHeader.add("住户");
		tableHeader.add("证件类型");
		tableHeader.add("证件号码");
		tableHeader.add("电话");
		tableHeader.add("手机");
		tableHeader.add("业主");
		tableHeader.add("证件类型");
		tableHeader.add("证件号码");
		tableHeader.add("联系电话");
		
		String[] columnArr = new String[16];
		columnArr[0] = "unitcode";
		columnArr[1] = "building_area";
		columnArr[2] = "using_area";
		columnArr[3] = "unitstate";
		columnArr[4] = "unittype";
		columnArr[5] = "ischarge";
		columnArr[6] = "unitsort";
		columnArr[7] = "leasename";
		columnArr[8] = "leasetype";
		columnArr[9] = "leasenumber";
		columnArr[10] = "phonenumber";
		columnArr[11] = "mobilephone";
		columnArr[12] = "owner";
		columnArr[13] = "ownertype";
		columnArr[14] = "ownernumber";
		columnArr[15] = "ownerphone";
		
		short cellNumber = (short) tableHeader.size();// 表的列数
		workbook = new HSSFWorkbook(); // 创建一个excel
		HSSFCell cell = null; // Excel的列
		HSSFRow row = null; // Excel的行
		
		
		
		HSSFFont font = workbook.createFont(); // 设置字体
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 12);// 设置字体
		
		HSSFCellStyle style = workbook.createCellStyle(); // 设置表头的类型
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//水平
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
		style.setFont(font);// 设置字体风格
		
		HSSFSheet sheet = workbook.createSheet("sheet1"); // 创建一个sheet
		HSSFHeader header = sheet.getHeader();// 设置sheet的头
		
		try {
			header.setCenter(title);
			row = sheet.createRow(0);
			row.setHeight((short) 500);
			
			//设置序号列
			setCell(sheet,row,cell,0,2000,tableHeader.get(0),style);
			
			for (int k = 1; k < cellNumber; k++) {
				setCell(sheet,row,cell,k,5000,tableHeader.get(k),style);
			}
			
			int num = 1;
			for (Map map : rowList) {
				row = sheet.createRow((short) (num));// 创建第num+1行
				row.setHeight((short) 500);// 设置行高
				
				//插入序号
				setCell(sheet,row,cell,0,0,String.valueOf(num),style);
				
				int c_num = 1;
				for (String columnName : columnArr) {
					//插入单元名称
					if (null != map.get(columnName) && !"".equals(map.get(columnName))) {
						String columnTxt = map.get(columnName).toString();
						if (columnName.equals("unitstate")) {
							if (columnTxt.equals("1")) {
								columnTxt = "闲置";
							}
							else if (columnTxt.equals("2")) {
								columnTxt = "已出租";
							}
							else {
								columnTxt = "未知";
							}
						}
						if (columnName.equals("unittype")) {
							if (columnTxt.equals("1")) {
								columnTxt = "住宅";
							}
							else if (columnTxt.equals("2")) {
								columnTxt = "商用";
							}
							else if (columnTxt.equals("3")) {
								columnTxt = "自用";
							}
							else {
								columnTxt = "未知";
							}
						}
						if (columnName.equals("ischarge")) {
							if (columnTxt.equals("1")) {
								columnTxt = "收费";
							}
							else {
								columnTxt = "不收费";
							}
						}
						
						setCell(sheet,row,cell,c_num,0,columnTxt,style);
					}
					else {
						setCell(sheet,row,cell,c_num,0,"",style);
					}
					c_num += 1;
				}
				
				
				num += 1;
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		OutputStream out = null;// 创建一个输出流对象
		try {
			out = response.getOutputStream();
//			String headerStr = "";
			title += ".xls";
			response.setContentType("application/vnd.ms-excel;charset=utf-8");
			
			String userAgent = request.getHeader("User-Agent");
			response.reset();
			if(userAgent != null && userAgent.indexOf("MSIE") == -1) {
				// FF
				String enableFileName = "=?UTF-8?B?" + (new String(org.apache.commons.codec.binary.Base64.encodeBase64(title.getBytes("UTF-8")))) + "?=";  
				response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName); 
			}else{
				// IE   
				String enableFileName = new String(title.getBytes("GBK"), "ISO-8859-1");   
				response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName);
			}
			
			request.setCharacterEncoding("UTF-8");  
			
			workbook.write(out);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (out != null) {
					out.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	
	
}

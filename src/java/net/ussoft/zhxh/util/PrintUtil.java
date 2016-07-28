package net.ussoft.zhxh.util;

import java.util.List;

import net.ussoft.zhxh.model.Sys_print_column_list;
import net.ussoft.zhxh.model.Sys_print_column_out;
import net.ussoft.zhxh.model.Sys_print_table;
import net.ussoft.zhxh.model.Sys_print_title;

public class PrintUtil {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	
	public PrintUtil() {
		
	}
	
	public static String getHtmlTitle(Sys_print_title first,Sys_print_title second) {
		
		StringBuffer sb = new StringBuffer();
		sb.append("<table border='0' cellspacing='0' cellpadding='0' width='100%'>");
		//first 主标题
		if (first.getIsshow() == 1) {
			sb.append("<tr>");
			sb.append("<td align='center' style='font-size:").append(first.getSize()).append("px;padding-bottom: 20px;padding-top: 0px'>").append(first.getTitlename()).append("</td>");
			sb.append("</tr>");
		}
		if (second.getIsshow() == 1) {
			sb.append("<tr>");
			sb.append("<td align='center' style='font-size: ").append(second.getSize()).append("px;padding-bottom: 15px;'>").append(second.getTitlename()).append("</td>");
			sb.append("</tr>");
		}
		
		sb.append("</table>");
		
		return sb.toString();
	}
	
	public static String getHtmlcontent(Sys_print_table printTable,List<Sys_print_column_list> list) {
		
		StringBuffer sb = new StringBuffer();
		if (list.size() > 0) {
			sb.append("<thead>");
			sb.append("<tr style='height:").append(printTable.getTitlerowheight()).append("px;'>");
			for (Sys_print_column_list item : list) {
				sb.append("<th align='").append(item.getColumnalign()).append("' style='border:1px #000 solid;font-size:").append(item.getColumnsize())
				.append("px;width:").append(item.getColumnwidth()).append("px;'>").append(item.getColumnname()).append("</th>");
			}
			sb.append("</tr>");
			sb.append("</thead>");
		}
		
		return sb.toString();
	}
	
	/**
	 * 
	 * @param printTable
	 * @param list
	 * @param columnseat		位置：TOP 顶端  DOWN 底部 
	 * @return
	 */
	public static String getHtmlOut(Sys_print_table printTable,List<Sys_print_column_out> list,String columnseat) {
		StringBuffer sb = new StringBuffer();
		if (list.size() > 0) {
			sb.append("<table border='0' cellspacing='0' cellpadding='0' width='100%'>");
			sb.append("<tr>");
			for (Sys_print_column_out item : list) {
				sb.append("<td align='").append(item.getColumnalign()).append("' style='font-size:").append(item.getColumnsize())
				.append("px;padding-bottom: 10px;padding-top: 0px;width:").append(item.getColumnwidth()).append("px;'>").append(item.getColumnname()).append(":");
				sb.append("<span class='").append(item.getColumnvaluetype()).append("'>");
				if (item.getColumnvaluetype().equals("TEXT")) {
					//如果是固定文字显示，直接写上
					sb.append(item.getColumnvalue());
				}
				else if (item.getColumnvaluetype().equals("AUTO")) {
					sb.append(item.getColumnname());
				}
				sb.append("</span>").append("</td>");
			}
			sb.append("</tr>");
			sb.append("</table>");
		}
		
		return sb.toString();
	}

}

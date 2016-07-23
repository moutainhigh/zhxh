package net.ussoft.zhxh.util;


public class Constants{
	public Constants() {
	}
	/**
	 * 用户session变量
	 */
	public static final String user_in_session = "CURRENT_USER_IN_SESSION";
	
	/**
	 * 物业管理是否有全部操作权。没有仅查看和打印
	 */
	public static final String project_all_auth = "CURRENT_PROJECT_ALL_AUTH";
	/**
	 * 台帐管理是否有全部操作权。
	 */
	public static final String book_auth = "CURRENT_BOOK_AUTH";
	/**
	 * 台帐管理是否有仅待整理操作权。
	 */
	public static final String book_not_in_auth = "CURRENT_BOOK_NOT_IN_AUTH";
	/**
	 * 台帐管理是否有仅打印操作权。
	 */
	public static final String book_print_auth = "CURRENT_BOOK_PRINT_AUTH";
	/**
	 * 台帐管理是否有仅收款的操作权。
	 */
	public static final String book_note_auth = "CURRENT_BOOK_NOTE_AUTH";
	
	/**
	 * 字段copy时，记录copy的字段id
	 */
	public static final String field_copy_session = "CURRENT_FIELD_COPY_SESSION";
	
	/**
	 * 档案数据copy时，记录copy的字段id
	 */
	public static final String data_copy_session = "CURRENT_DATA_COPY_SESSION";
	
	/**
	 * 档案数据copy时，记录copy的字段id所属treeid
	 */
	public static final String data_copy_treeid_session = "CURRENT_DATA_COPY_TREEID_SESSION";
	
	/**
	 * 档案数据copy时，记录copy的字段id所属tabletype
	 */
	public static final String data_copy_tabletype_session = "CURRENT_DATA_COPY_TABLETYPE_SESSION";
	
	/**
	 * 智能检索，存储查询值
	 */
	public static final String intel_search_session = "CURRENT_INTEL_SEARCH_SESSION";
	
	/**
	 * 智能检索，存储查询数量
	 */
	public static final String intel_search_count_session = "CURRENT_INTEL_SEARCH_COUNT_SESSION";
	
	/**
	 * 智能检索，存储选择的树节点
	 */
	public static final String intel_search_treeid_session = "CURRENT_INTEL_SEARCH_TREEID_SESSION";
	
	
	
	/**
	 * 总行数
	 */
	public static final String total_row = "TOTAL_ROW_IN_SESSION";

	/**
	 * 每页显示的行数
	 */
	//public static final int each_page = 10;
	/**
	 * 开始行数
	 */
	public static final int start_row = 1;
	public static final int start_page = 1;
	

}


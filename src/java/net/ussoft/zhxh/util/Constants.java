package net.ussoft.zhxh.util;


public class Constants{
	public Constants() {
	}
	/**
	 * 用户session变量
	 */
	public static final String user_in_session = "CURRENT_USER_IN_SESSION";
	/**
	 * pc账号登陆
	 * */
	public static final String PC_USER_SESSION = "pc_user_sessiion";
	/**
	 * 手机6位验证码
	 * */
	public static final String CODE_SESSION = "code_sessiion";
	
	/**
	 * 购物车 商品类数量
	 * */
	public static final String CAT_NUM = "cat_num";
	
	
	//==========商品管理===========
	/**
	 * 品牌常量。对品牌表的操作。
	 */
	public static final String BRAND = "brand";
	/**
	 * 对商品表的处理
	 */
	public static final String PRODUCT = "product";
	/**
	 * 对商品评价表的处理
	 */
	public static final String RATED = "rated";
	/**
	 * 对品牌综合页轮播图片的处理
	 */
	public static final String BRANDFIRST_LB_PIC = "brandfirst_lb_pic";
	/**
	 * 对品牌综合页的处理
	 */
	public static final String BRANDFIRST = "brandfirst";
	/**
	 * 对品牌系列页的处理
	 */
	public static final String BRANDLIST = "brandlist";
	
	
	//==============公共图片表
	
	/**
	 * 公共图片
	 */
	public static final String PUBLICPIC = "publicpic";
	/**
	 * 公共图片获取list 分页
	 */
	public static final String PUBLICPIC_PAGE = "publicpic_page";
	/**
	 * 富文本操作
	 */
	public static final String PUBLIC_CONTENT = "public_content";
	/**
	 * 富文本圖片
	 */
	public static final String PUBLIC_CONTENT_PIC = "public_content_pic";
	
	/**
	 * 文件
	 */
	public static final String PUBLIC_FILE = "public_file";
	/**
	 * 文件 标题图片
	 */
	public static final String PUBLIC_FILE_PIC = "public_file_pic";
	
	
	
	//==============公共视频表
	
	/**
	 * 公共视频
	 */
	public static final String PUBLICVIDEO = "publicvideo";
	
	
	//================图片上传
	
	/*
	 * 公共资源logo
	 */
	public static final String LOGO = "logo";
	/*
	 * 品牌logo
	 */
	public static final String BRANDLOG = "brandlog";
	
	/**
	 * 商品主图片
	 */
	public static final String PRODUCTPIC = "productpic";
	/**
	 * 品牌综合展示页主图片
	 */
	public static final String FIRSTPIC = "firstpic";
	/**
	 * 公共视频表常量。可能用于视频表的主图片
	 */
	public static final String VIDEO = "video";
	/**
	 * 公共常量。商品规格
	 */
	public static final String PRODUCTSIZE = "productsize";
	/**
	 * 公共常量。商品规格全部获取
	 */
	public static final String PRODUCTSIZEALL = "productsizeall";
	
	/**
	 * 商品列表
	 */
	public static final String PLIST = "plist";
	/**
	 * 商品列表关联的商品
	 */
	public static final String LABEL_PLIST = "label_plist";
	
	/**
	 * 公共资源
	 */
	public static final String SYSPUBLIC = "syspublic";
	/**
	 * 公共利益分配表
	 */
	public static final String DISCONFIG = "disconfig";
	/**
	 * 采购标准表
	 */
	public static final String USERSTANDARD = "userstandard";
	
	/**
	 * 系统消息
	 */
	public static final String ORDER_MESSAGE0_SESSION = "order_message0_session";
	/**
	 * 业务消息
	 */
	public static final String ORDER_MESSAGE1_SESSION = "order_message1_session";
	/**
	 * 站内信
	 */
	public static final String ORDER_MESSAGE2_SESSION = "order_message2_session";
	
	/**
	 * 代理处订单
	 * */
	public static final String ORDER_STATUS_MSG = "order_status_msg";
	
	/**
	 * 代理处订单-确认发货
	 * */
	public static final String ORDER_STATUS_MSG1 = "order_status_msg1";
	
	/**
	 * 代理处订单-确认签收
	 * */
	public static final String ORDER_STATUS_MSG2 = "order_status_msg2";
	
}


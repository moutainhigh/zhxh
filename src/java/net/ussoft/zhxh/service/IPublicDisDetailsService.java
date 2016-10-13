package net.ussoft.zhxh.service;

import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_dis_details;

/**
 * 返利奖励-账单流水记录
 * @author guodh
 * @version v1.0 2016.10.12
 * */
public interface IPublicDisDetailsService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_dis_details
	 * */
	public Public_dis_details getById(String id);
	
	/**
	 * 根据流水单号获取对象
	 * @param billno
	 * @return
	 * */
	public Public_dis_details getByBillno(String billno);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Public_dis_details> list();
	
	/**
	 * 查询所有 分页
	 * @param map
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Public_dis_details> list(Map<String, Object> map,PageBean<Public_dis_details> pageBean);
	
	/**
	 * 查询所有 分页
	 * @param userid
	 * @param parentid
	 * @param detailstype 1:返利；2:奖励
	 * @param pageBean
	 * @return pagebean
	 * */
	public PageBean<Map<String,Object>> list(String userid,String parentid,int detailstype,PageBean<Map<String,Object>> pageBean);
	
	/**
	 * 添加
	 * @param Public_dis_details
	 * @return 
	 * */
	public Public_dis_details insert(Public_dis_details bill);
	
	/**
	 * 修改
	 * @param Public_dis_details
	 * @return 
	 * */
	public int update(Public_dis_details bill);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
}

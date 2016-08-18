package net.ussoft.zhxh.service;

import java.util.List;

import net.ussoft.zhxh.model.Label_list;
import net.ussoft.zhxh.model.PageBean;

/**
 * 标签与列表的关联表
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface ILabelListService {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Label_list
	 * */
	public Label_list getById(String id);
	
	/**
	 * 查询所有
	 * @return list
	 * */
	public List<Label_list> list();
	
	/**
	 * 查询所有 分页
	 * @param pageBean
	 * @return list
	 * */
	public PageBean<Label_list> list(PageBean<Label_list> pageBean,String lableid);
	
	/**
	 * 添加
	 * @param Label_list
	 * @return 
	 * */
	public Label_list insert(Label_list label_list);
	
	/**
	 * 修改
	 * @param Label_list
	 * @return 
	 * */
	public int update(Label_list label_list);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
	
	/**
	 * 插入标签与对象的关联。
	 * @param objids		对象id字符串。逗号分隔
	 * @param lableid		标签id。对于商品与商品列表来说，列表id充当标签id。
	 * @return
	 */
	public boolean saveLableList(String objids,String labelid,String tablename);
	
	/**
	 * 移除对应关系。
	 * @param objids		对象的id字符串。逗号分隔
	 * @param lableid		标签id，对于商品与商品列表来说，列表的id充当标签id
	 * @return
	 */
	public int deleteLableList(String objids,String labelid);
	
}

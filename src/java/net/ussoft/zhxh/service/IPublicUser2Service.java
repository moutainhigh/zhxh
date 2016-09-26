package net.ussoft.zhxh.service;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_brand;
import net.ussoft.zhxh.model.Public_product_size;
import net.ussoft.zhxh.model.Public_set_user_standard;
import net.ussoft.zhxh.model.Public_user;

/**
 * 用户管理
 * @author guodh
 * @version v1.0 2016.07.27
 * */
public interface IPublicUser2Service {

	/**
	 * 根据ID获取对象
	 * @param id
	 * @return Public_user
	 * */
	public Public_user getById(String id);
	
	/**
	 * 个人中心关联关系查询
	 * @param parentid
	 * @return
	 * */
	public List<Public_user> list(String parentid,String identity);
	
	/**
	 * 添加
	 * @param Public_user
	 * @return 
	 * */
	public boolean insert(Public_user user);
	
	/**
	 * 修改
	 * @param Public_user
	 * @return 
	 * */
	public int update(Public_user user);
	
	/**
	 * 删除
	 * @param id
	 * @return
	 * */
	public int delete(String id);
	
	
	
	//============机构与品牌begin
	/**
	 * 获取机构能操作的品牌
	 * @param parentid
	 * @param userid
	 * @param brandname		检索条件。模糊检索品牌名称	可选
	 * @param PageBean		分页检索。可选。null为不分页，获取全部	
	 * @return
	 * */
	public PageBean<Public_brand> list_user_brand(String parentid,String userid,String brandname,PageBean<Public_brand> p);
	
	/**
	 * 删除机构对应的品牌
	 * @param parentid
	 * @param userid
	 * @param brandid
	 */
	public void delUserBrand(String parentid,String userid,String brandid);
	/**
	 * 为机构选择品牌
	 * @param parentid
	 *  * @param userid
	 * @return
	 * */
	public List<Public_brand> list_select_brand(String parentid,String userid);
	
	
	/**
	 * 保存机构与品牌对应
	 * @param brandids
	 * @param parentid
	 * @param userid
	 * @return
	 */
	public boolean saveUserBrand(String brandids,String parentid,String userid);
	
	/**
	 * 为机构选择规格
	 * @param parentid
	 * @param userid
	 * @param productid
	 * @return
	 * */
	public List<Public_product_size> list_select_size(String parentid,String userid,String productid);
	
	/**
	 * 获取机构采购利益表数据。采购利益表为主表。个人中心表为从表。还有品牌表，商品表。采用sql联合查询太复杂。本方法为获取数据后，独立查找各种信息，再补全。
	 * @param parentid			设置者	
	 * @param userid			被设置者
	 * @param brandid			品牌id。可选 null或空字符将不参与条件
	 * @param productid			商品id，可选
	 * @param state				状态，可选
	 * @param productname		商品名称。可选。检索条件，是规格表的商品名称，（注意：这个名称可能与商品表一致，也可能不一致。）模糊检索。
	 * @param p					分页pageBean
	 * @return
	 */
	public PageBean<Map<String,Object>> listUserStandard(String parentid,String userid,String brandid,
			String productid,String state,String productname,PageBean<Map<String,Object>> p);
	
	
	/**
	 * 获取被设置机构的采购利益详细
	 * @param parentid
	 * @param userid
	 * @return
	 */
	public List<Map<String,Object>> listUserStandard(String parentid,String userid,String productid,String brandid,String state);
	
	/**
	 * 获取被设置机构的采购利益详细。根据品牌id，获取全部商品下的全部规格
	 * @param parentid
	 * @param userid
	 * @param brandid
	 * @return
	 */
	public List<Map<String,Object>> listUserStandardFromBrand(String parentid,String userid,String brandid);
	
	/**
	 * 获取被设置机构的采购利益详细。根据品牌id，获取全部商品下的全部规格
	 * @param parentid
	 * @param userid
	 * @param brandid
	 * @param productname 商品名称检索
	 * @return
	 */
	public List<Map<String,Object>> listUserStandardFromBrand(String parentid,String userid,String brandid,String productname);
	
	/**
	 * 添加机构的规格采购标准
	 * @param brandid
	 * @param productid
	 * @param sizeids
	 * @param parentid
	 * @param userid
	 * @return
	 */
	public boolean saveUserSizeStandard(String brandid,String productid,String sizeids,String parentid,String userid);
	
	/**
	 * 按设置者与被设置者，批量修改采购标准
	 * @param parentid
	 * @param userid
	 * @param updatekey
	 * @param updatevalue
	 * @return
	 */
	public boolean updateUserSizeStandard(String parentid,String userid,String updatekey,String updatevalue);
	
	/**
	 * 保存机构的规格设置标准
	 * @param objs
	 * @return
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 */
	public boolean saveStandard(List<Map<String, String>> rows) throws IllegalAccessException, InvocationTargetException;
	
	/**
	 * 获取机构的奖励转货款系数
	 * @param parentid
	 * @param userid
	 * @return
	 */
	public List<Map<String,Object>> listUserRatio(String parentid);
	
	/**
	 * 获取要添加机构到奖励转货款的机构列表
	 * @param parentid
	 * @return
	 */
	public List<Public_user> listSelectUserC(String parentid);
	
	/**
	 * 为奖励转货款系数表插入新的对应
	 * @param ids
	 * @param parentid
	 */
	public void UserRatioSel(String ids,String parentid);
	
	/**
	 * 保存机构奖励转货款系数
	 * @param objs
	 * @return
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 */
	public boolean saveRatio(List<Map<String, String>> rows) throws IllegalAccessException, InvocationTargetException;
	
	
	
	//================end
	
}

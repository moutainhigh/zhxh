package net.ussoft.zhxh.web.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_set_bonuses_ratio;
import net.ussoft.zhxh.model.Public_trade_bill;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.service.IPublicTradeBillService;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.util.Constants;
import net.ussoft.zhxh.util.DateUtil;
import net.ussoft.zhxh.util.OrderNO;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;

/**
 * 机构利益处理active
 * @author wangf
 *
 */

@Controller
@RequestMapping("/orderUserBank")
public class OrderUserBankController extends BaseConstroller {
	
	@Resource
	private IPublicUserBankService userBankService;
	@Resource
	private IPublicTradeBillService billService;
	@Resource
	private IPublicUserService userService;
	
	/**
	 * 获取机构的资金帐户
	 * @param parentid
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/listUserBank",method=RequestMethod.POST)
	public void listUserBrand(String parentid,String userid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		List<Map<String,Object>> resultList = userBankService.getUserBankList(parentid,userid);
		Public_user user = getSessionUser();
		map.put("total", resultList.size());
		map.put("data", resultList);
		if(user.getId().equals("1")){
			map.put("identity", "1");	//查看我的账户的时候用于身份判断
		}else{
			map.put("identity", user.getIdentity());	//查看我的账户的时候用于身份判断
		}
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 充值
	 * @param parentid
	 * @param amount
	 * @param trantype 交易类型
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/recharge",method=RequestMethod.POST)
	public void recharge(String parentid,float amount,int trantype,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(parentid == null || "".equals(parentid) || amount <=0){
			out.print("error");
			return;
		}
		Public_user user = getSessionUser();
		Public_trade_bill bill = new Public_trade_bill();
		bill.setId(UUID.randomUUID().toString());
		bill.setBillid(OrderNO.getOrderNo());
		bill.setParentid(parentid);
		Public_user p_user = userService.getById(parentid);
		bill.setP_useranme(p_user.getUsername());
		bill.setUserid(user.getId());
		bill.setUsername(user.getUsername());
		bill.setAmount(amount);
		bill.setCreatetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
//		bill.setPaytype(paytype); //支付类型
		bill.setTrantype(trantype);//交易类型	trantype:交易类型, 0:普通购买,1:充值-货款充值,2:充值-现金充值,3:提现-现金账户,4:提现-奖励账户,5:提现-平台售额
		bill.setTrantypetxt(Constants.TRANTYPE_TXT[trantype]);
		bill.setStatus(0);	//状态：0失败，1成功
		
		bill = billService.insert(bill);
		if(bill != null){
			int num = userBankService.recharge(bill, user.getIdentity());
			if(num > 0){
				out.print("success");
				return;
			}
		}
		out.print("error");
	}
	
	/**
	 * 提现
	 * @param parentid
	 * @param amount
	 * @param trantype 交易类型
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/withdrawal",method=RequestMethod.POST)
	public void withdrawal(String parentid,float amount,int trantype,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(parentid == null || "".equals(parentid) || amount <=0){
			out.print("error");
			return;
		}
		Public_user user = getSessionUser();
		Public_trade_bill bill = new Public_trade_bill();
		bill.setId(UUID.randomUUID().toString());
		bill.setBillid(OrderNO.getOrderNo());
		bill.setParentid(parentid);
		Public_user p_user = userService.getById(parentid);
		bill.setP_useranme(p_user.getUsername());
		bill.setUserid(user.getId());
		bill.setUsername(user.getUsername());
		bill.setAmount(amount);
		bill.setCreatetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
//		bill.setPaytype(paytype); //支付类型
		bill.setTrantype(trantype);//交易类型	trantype:交易类型, 0:普通购买,1:充值-货款充值,2:充值-现金充值,3:提现-现金账户,4:提现-奖励账户,5:提现-平台售额
		bill.setTrantypetxt(Constants.TRANTYPE_TXT[trantype]);
		bill.setStatus(0);	//状态：0失败，1成功
		bill = billService.insert(bill);
		if(bill != null){
			int num = userBankService.withdrawal(bill, user.getIdentity());
			if(num > 0){
				out.print("success");
				return;
			}
		}
		out.print("error");
	}
	
	/**
	 * 设置配额
	 * @param userid
	 * @param amount
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/setQuota",method=RequestMethod.POST)
	public void setQuota(String userid,float amount,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(userid == null || "".equals(userid) || amount <=0){
			out.print("error");
			return;
		}
		Public_user user = getSessionUser();
		int num = userBankService.setQuota(userid, user.getId(), amount);
		if(num > 0){
			out.print("success");
			return;
		}
		out.print("error");
	}
	
	/**
	 * 获取转货款系数
	 * @param parentid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/getTransfCoef",method=RequestMethod.POST)
	public void getTransfCoef(String parentid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(parentid == null || "".equals(parentid)){
			out.print("error");
			return;
		}
		Public_user user = getSessionUser();
		Public_set_bonuses_ratio ratio = userBankService.getBonusersRatio(user.getId(), parentid);
		if(ratio != null){
			out.print(ratio.getBonuses_ratio()+"");
			return;
		}
		out.print("error");
	}
	
	/**
	 * 奖励账户金额转货款
	 * @param parentid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/transfBuyBank",method=RequestMethod.POST)
	public void transfBuyBank(String parentid,float amount,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(parentid == null || "".equals(parentid) || amount <= 0){
			out.print("error");
			return;
		}
		Public_user user = getSessionUser();
		int num = userBankService.transfBuyBank(user.getId(), parentid, amount);
		if(num > 0){
			out.print("success");
			return;
		}
		out.print("error");
	}
	
	/**
	 * 获取资金帐户明细
	 * @param parentid
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/accountDetail",method=RequestMethod.POST)
	public void accountDetail(String parentid,String userid,String trantype,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Map<String,Object>> p = new PageBean<Map<String,Object>>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("createtime");
		p.setOrderType("desc");
		List<String> trantypes = new ArrayList<String>();
		if(null != trantype && !"".equals(trantype)){
			String[] arr = trantype.split(",");
			Collections.addAll(trantypes, arr);
		}
		p = billService.list(userid, parentid, trantypes, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	
	
}

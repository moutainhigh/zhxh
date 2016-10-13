package net.ussoft.zhxh.web.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Income_bill;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_set_bonuses_ratio;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Public_user_bank;
import net.ussoft.zhxh.model.Spending_bill;
import net.ussoft.zhxh.service.IIncomeBillService;
import net.ussoft.zhxh.service.IPublicDisDetailsService;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.service.IQuotaBillService;
import net.ussoft.zhxh.service.ISpendingBillService;
import net.ussoft.zhxh.util.BillNO;
import net.ussoft.zhxh.util.DateUtil;

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
	private IIncomeBillService incomeBillService;
	@Resource
	private IQuotaBillService quotaBillService;
	@Resource
	private ISpendingBillService spendingBillService;
	@Resource
	private IPublicDisDetailsService disDetailsService;
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
	 * 设置资金账户的状态-开启、冻结
	 * @param userid
	 * @param parentid
	 * @param state
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/setAccountState",method=RequestMethod.POST)
	public void setAccountState(String userid,String parentid,int state,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(userid == null || "".equals(userid) || parentid == null || "".equals(parentid)){
			out.print("error");
			return;
		}
		String result = "";
		Public_user_bank userbank = userBankService.getUserBank(userid, parentid);
		if(state == 0){
			userbank.setBankstate(1);
			userbank.setBankstatetxt("正常");
			result = "开启";
		}else{
			userbank.setBankstate(0);
			userbank.setBankstatetxt("冻结");
			result = "冻结";
		}
		int num = userBankService.update(userbank);
		if(num > 0){
			out.print(result);
			return;
		}
		out.print("error");
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
		
		//充值交易流水
		Income_bill bill = new Income_bill();
		bill.setId(UUID.randomUUID().toString());
		bill.setBillno(BillNO.getBillNo());	//流水号
//		bill.setOrderid(orderid);
		Public_user p_user = userService.getById(parentid);
		bill.setParentid(parentid);
		bill.setP_username(p_user.getUsername());
		bill.setP_company(p_user.getCompanyname());
		Public_user user = getSessionUser();
		bill.setUserid(user.getId());
		bill.setU_username(user.getUsername());
		bill.setU_company(user.getCompanyname());
		bill.setAccount_receivable(amount);		//应收款
		bill.setAccount_real(amount);			//实收款
		bill.setCreatetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
//		bill.setPaytype(paytype);
		bill.setTrantype(trantype);	//交易类型——1：现金充值，2：货款充值，3：售额（全），4：售额（分期）
		String[] TRANTYPE_TXT = {"","现金充值","货款充值","售额（全款）","售额（分期）"};
		bill.setTrantypetxt(TRANTYPE_TXT[trantype]);
		bill.setStatus(0);	//状态：0失败，1成功
		
		
		bill = incomeBillService.insert(bill);
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
		//支出-账单流水
		Spending_bill bill = new Spending_bill();
		bill.setId(UUID.randomUUID().toString());
		bill.setBillno(BillNO.getBillNo());
		Public_user user = getSessionUser();
		bill.setUserid(user.getId());
		bill.setU_username(user.getUsername());
		bill.setU_company(user.getCompanyname());
		Public_user p_user = userService.getById(parentid);
		bill.setParentid(parentid);
		bill.setP_username(p_user.getUsername());
		bill.setP_company(p_user.getCompanyname());
		bill.setAmount(amount);
		bill.setCreatetime(DateUtil.getNowTime("yyyy-MM-dd HH:mm:ss"));
		bill.setTrantype(trantype); //1：平台可提现账户提现，2：代理可提现账户提现，3：店平台售额提现，4：店奖励可提现账户提现
		String[] TRANTYPE_TXT = {"","平台可提现账户提现","代理可提现账户提现","店平台售额提现","店奖励可提现账户提现"};
		bill.setTrantypetxt(TRANTYPE_TXT[trantype]);
		bill.setStatus(0);	//-1:失败，0：提交申请，1：成功
		bill = spendingBillService.insert(bill);
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
	public void setQuota(String userid,int amount,HttpServletResponse response) throws IOException {
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
	 * 收入总计-账单流水
	 * @param parentid
	 * @param userid
	 * @param trantype
	 * @param identity
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/incomeBillDetail",method=RequestMethod.POST)
	public void incomeBillDetail(String parentid,String userid,String trantype,String identity,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
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
		p = incomeBillService.list(userid, parentid, trantypes, identity, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 支出总计-账单流水
	 * @param parentid
	 * @param userid
	 * @param trantype
	 * @param identity
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/spendingBillDetail",method=RequestMethod.POST)
	public void spendingBillDetail(String parentid,String userid,String trantype,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
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
		p = spendingBillService.list(userid, parentid, trantypes, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 配额-账单流水
	 * @param parentid
	 * @param userid
	 * @param trantype
	 * @param identity
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/quotaBillDetail",method=RequestMethod.POST)
	public void quotaBillDetail(String parentid,String userid,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Map<String,Object>> p = new PageBean<Map<String,Object>>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("createtime");
		p.setOrderType("desc");
		p = quotaBillService.list(userid, parentid, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 返利、奖励-账单流水
	 * @param parentid
	 * @param userid
	 * @param detailstype 1:返利,2:奖励
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/rebateRewardBill",method=RequestMethod.POST)
	public void rebateRewardBill(String parentid,String userid,int detailstype,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Map<String,Object>> p = new PageBean<Map<String,Object>>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("createtime");
		p.setOrderType("desc");

		p = disDetailsService.list(userid, parentid, detailstype, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
}

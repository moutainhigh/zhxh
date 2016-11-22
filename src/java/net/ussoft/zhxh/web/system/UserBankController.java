package net.ussoft.zhxh.web.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Disposable_bill;
import net.ussoft.zhxh.model.PageBean;
import net.ussoft.zhxh.model.Public_dis_details;
import net.ussoft.zhxh.model.Public_order_product;
import net.ussoft.zhxh.model.Public_user;
import net.ussoft.zhxh.model.Public_user_bank;
import net.ussoft.zhxh.model.Rebate_reward_bill;
import net.ussoft.zhxh.model.Share_bill;
import net.ussoft.zhxh.model.Transf_buy_bank_bill;
import net.ussoft.zhxh.service.IDisposableBillService;
import net.ussoft.zhxh.service.IIncomeBillService;
import net.ussoft.zhxh.service.IPublicDisDetailsService;
import net.ussoft.zhxh.service.IPublicPhoneCodeLogService;
import net.ussoft.zhxh.service.IPublicUserBankService;
import net.ussoft.zhxh.service.IPublicUserService;
import net.ussoft.zhxh.service.IQuotaBillService;
import net.ussoft.zhxh.service.IRebateRewardBillService;
import net.ussoft.zhxh.service.IShareBillService;
import net.ussoft.zhxh.service.ISpendingBillService;
import net.ussoft.zhxh.service.ITransfBuyBankBillService;

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
@RequestMapping("/userBank")
public class UserBankController extends BaseConstroller {
	
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
	@Resource
	private IPublicPhoneCodeLogService codeLogService;
	@Resource
	private IShareBillService shareBillService;
	@Resource
	private ITransfBuyBankBillService transfService;
	@Resource
	private IRebateRewardBillService rebateRewardBillService;
	@Resource
	private IDisposableBillService disposableBillService;
	
	/**
	 * 获取机构的资金帐户
	 * @param parentid
	 * @param userid
	 * @param searchKey
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/listUserBank",method=RequestMethod.POST)
	public void listUserBank(String parentid,String userid,String searchKey,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		List<Map<String,Object>> resultList = userBankService.getUserBankList(parentid,userid,searchKey);
		map.put("total", resultList.size());
		map.put("data", resultList);
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
	@RequestMapping(value="/multiple_update",method=RequestMethod.POST)
	public void multiple_update(String ids,String field,String value,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		if(ids == null || "".equals(ids) ){
			out.print("error");
			return;
		}
		String result = "success";
		int num = userBankService.multiple_update(ids, field, value);
		if(num > 0){
			out.print(result);
			return;
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
		int num = userBankService.setQuota(userid, "1", amount);
		if(num > 0){
			out.print("success");
			return;
		}
		out.print("error");
	}
	
	public HashMap<String,Object> setMap(String bankname,Float bankpay,String bankid,String banktype) {
		HashMap<String,Object> tmpMap = new HashMap<>();
		tmpMap.put("bankname",bankname);
		tmpMap.put("bankpay", bankpay);
		tmpMap.put("bankid",bankid);
		tmpMap.put("banktype",banktype);
		
		return tmpMap;
	}
	
	/**
	 * 获取机构的资金帐户
	 * @param bankid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/showUserBank",method=RequestMethod.POST)
	public void showUserBank(String bankid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		Public_user_bank bank = userBankService.getById(bankid);
		
		Public_user user = userService.getById(bank.getUserid());
		
		List<HashMap<String,Object>> resultList = new ArrayList<HashMap<String,Object>>();
		//如果是平台自己的资金帐户
		if ("1".equals(user.getId())) {
			resultList.add(setMap("收入总计",bank.getIncomebank(),bank.getId(),"incomebank"));
			resultList.add(setMap("支出总计",bank.getCostbank(),bank.getId(),"costbank"));
			resultList.add(setMap("可提现帐户",bank.getTakenbank(),bank.getId(),"takenbank"));
			resultList.add(setMap("平台销售额总计",bank.getSellbank(),bank.getId(),"sellbank"));
		}
		else if ("A".equals(user.getIdentity())) {
			//如果是代理
			resultList.add(setMap("收入总计",bank.getIncomebank(),bank.getId(),"incomebank"));
			resultList.add(setMap("支出总计",bank.getCostbank(),bank.getId(),"costbank"));
			resultList.add(setMap("可提现帐户",bank.getTakenbank(),bank.getId(),"takenbank"));
			resultList.add(setMap("可支配帐户",bank.getHavebank(),bank.getId(),"havebank"));
			resultList.add(setMap("平台销售额总计",bank.getSellbank(),bank.getId(),"sellbank"));
			resultList.add(setMap("配额总计",bank.getQuotabank(),bank.getId(),"quotabank"));
			resultList.add(setMap("充值总计",bank.getDepositbank(),bank.getId(),"depositbank"));
		}
		else if ("C".equals(user.getIdentity())) {
			//如果是门店
        	resultList.add(setMap("充值总计",bank.getDepositbank(),bank.getId(),"depositbank"));
        	resultList.add(setMap("配额总计",bank.getQuotabank(),bank.getId(),"quotabank"));
        	resultList.add(setMap("平台销售额总计",bank.getSellbank(),bank.getId(),"sellbank"));
        	resultList.add(setMap("平台销售额可提现",bank.getSelltakenbank(),bank.getId(),"selltakenbank"));
        	resultList.add(setMap("可支配帐户",bank.getHavebank(),bank.getId(),"havebank"));
        	resultList.add(setMap("返利（累计）",bank.getRebatesbank(),bank.getId(),"rebatesbank"));
        	resultList.add(setMap("奖励（累计）",bank.getBonusesbank(),bank.getId(),"bonusesbank"));
        	resultList.add(setMap("奖励可提现帐户",bank.getBonusestakenbank(),bank.getId(),"bonusestakenbank"));
		}
		
		map.put("total", resultList.size());
		map.put("data", resultList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/*------------------综合平台 资金帐户 交易流水--------------*/
	

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
		
		PageBean<Rebate_reward_bill> p = new PageBean<Rebate_reward_bill>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("createtime");
		p.setOrderType("desc");

		Map<String, Object> values = new LinkedHashMap<String, Object>();
		values.put("parentid= ", parentid);
		values.put("userid= ", userid);
		values.put("type= ", detailstype);
		p = rebateRewardBillService.list(values, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 返利、奖励-账单流水-明细
	 * @param parentid
	 * @param userid
	 * @param detailstype 1:返利,2:奖励
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/rebateRewardBillDetails",method=RequestMethod.POST)
	public void rebateRewardBillDetails(String billid,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Public_dis_details> p = new PageBean<Public_dis_details>();
		p.setIsPage(false);
		p.setOrderBy("createtime");
		p.setOrderType("desc");
		
		Map<String, Object> values = new LinkedHashMap<String, Object>();
		values.put("billid= ", billid);
		p = disDetailsService.list(values, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 平台售额分润-账单流水
	 * @param userid
	 * @param status
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/shareBill",method=RequestMethod.POST)
	public void shareBill(String userid,String status,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Share_bill> p = new PageBean<Share_bill>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("sharetime");
		p.setOrderType("desc");

		Map<String, Object> values = new LinkedHashMap<String, Object>();
		values.put("userid= ", userid);
		if(null != status && !"".equals(status)){
			values.put("sharestate= ", status);
		}
		
		p = shareBillService.list(values, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 平台售额分润-账单流水-明细
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/shareBillDetails",method=RequestMethod.POST)
	public void shareBillDetails(String userid,String orderproductids,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		List<Public_order_product> list = shareBillService.orderProlist(orderproductids);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userid", userid);
		map.put("data", list);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 奖励转货款-账单流水
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/transfBill",method=RequestMethod.POST)
	public void transfBill(String userid, int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Transf_buy_bank_bill> p = new PageBean<Transf_buy_bank_bill>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("createtime");
		p.setOrderType("desc");
		Map<String, Object> values = new LinkedHashMap<String, Object>();
		values.put("userid= ", userid);
		p = transfService.list(values, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 可支配账户变更-账单流水
	 * @param userid
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/disposableBill",method=RequestMethod.POST)
	public void disposableBill(String userid, String parentid,int pageIndex,int pageSize,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		PageBean<Disposable_bill> p = new PageBean<Disposable_bill>();
		p.setPageSize(pageSize);
		p.setPageNo(pageIndex);
		p.setOrderBy("createtime");
		p.setOrderType("desc");
		Map<String, Object> values = new LinkedHashMap<String, Object>();
		values.put("userid= ", userid);
		values.put("parentid= ", parentid);
		p = disposableBillService.list(values, p);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("total", p.getRowCount());
		map.put("data", p.getList());
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
}

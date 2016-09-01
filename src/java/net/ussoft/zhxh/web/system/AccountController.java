package net.ussoft.zhxh.web.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;

import net.ussoft.zhxh.base.BaseConstroller;
import net.ussoft.zhxh.model.Sys_account;
import net.ussoft.zhxh.service.IAccountService;
import net.ussoft.zhxh.util.MD5;

@Controller
@RequestMapping(value="account")
public class AccountController extends BaseConstroller {
	
	@Resource
	private IAccountService accountService;
	
	/**
	 * 获取帐户列表
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public void list(HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		List<Sys_account> accountList = accountService.list();
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("total", accountList.size());
		map.put("data", accountList);
		
		String json = JSON.toJSONString(map);
		out.print(json);
	}
	
	/**
	 * 保存
	 * @param objs
	 * @param response
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public void save(String objs,HttpServletResponse response) throws IOException, IllegalAccessException, InvocationTargetException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "success";
		
		if ("".equals(objs) || objs == null) {
			out.print(result);
			return;
		}
		
		//
		List<Map<String, String>> rows = (List<Map<String, String>>) JSON.parse(objs);
		
		for(int i=0,l=rows.size(); i<l; i++){
			Map<String,String> row = (Map<String,String>)rows.get(i);
	  		  
			String id = row.get("id") != null ? row.get("id").toString() : "";
	        String state = row.get("_state") != null ? row.get("_state").toString() : "";
	        //新增：id为空，或_state为added
	        if(state.equals("added") || id.equals("")) {
	        	insert(row);
	        }
	        else if (state.equals("removed") || state.equals("deleted")) {
	        	delete(id);
	        }
	        //更新：_state为空，或modified
	        else if (state.equals("modified") || state.equals(""))	 {
	            update(row);
	        }
	    }
		out.print(result);
	}
	
	private boolean insert(Map<String,String> row) throws IllegalAccessException, InvocationTargetException {
		if (null == row) {
			return false;
		}
		Sys_account account = new Sys_account();
		BeanUtils.populate(account, row);
		
		account.setId(UUID.randomUUID().toString());
		//生成默认密码md5
		String pass = MD5.encode("123456");
		account.setPassword(pass);
		account = accountService.insert(account);
		return true;
	}
	
	/**
	 * 删除。
	 * @param id
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	private boolean delete(String id) throws IOException {
		
		if (id == null || id.equals("") ) {
			return false;
		}
		if (id.equals("1")) {
			return true;
		}
		int num = accountService.delete(id);
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	/**
	 * 更新
	 * @param row
	 * @return
	 * @throws IOException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	private boolean update(Map<String,String> row) throws IOException, IllegalAccessException, InvocationTargetException {
		
		if (null == row) {
			return false;
		}
		Sys_account account = new Sys_account();
		BeanUtils.populate(account, row);
		
		int num = accountService.update(account);
		
		if (num <= 0 ) {
			return false;
		}
		return true;
	}
	
	/**
	 * 执行更新帐户密码
	 * @param id
	 * @param password
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value="/toupdatepass",method=RequestMethod.POST)
	public void toupdatepass(String id,String password,HttpServletResponse response) throws IOException {
		
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		
		Sys_account account = accountService.getById(id);
		
		if (account == null || password.equals("")) {
			out.print(result);
			return;
		}
		
		account.setPassword(MD5.encode(password).toString());
		
		int num = accountService.update(account);
		if (num > 0 ) {
			result = "success";
		}
		out.print(result);
	}
	
	/**
	 * 初始化帐户密码
	 * @param ids
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/initUpdatePass",method=RequestMethod.POST)
	public void initUpdatePass(String ids,HttpServletResponse response) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String result = "failure";
		
		int num = accountService.initUpdatePass(ids);
		
		if (num >0) {
			result = "success";
		}
		
		out.print(result);
	}
	
	
}

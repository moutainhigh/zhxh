package net.ussoft.zhxh.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ussoft.zhxh.dao.SysAccountDao;
import net.ussoft.zhxh.model.Sys_account;
import net.ussoft.zhxh.service.IAccountService;
import net.ussoft.zhxh.util.MD5;

@Service
public class AccountService implements IAccountService {
	
	@Resource
	private SysAccountDao accountDao;
	

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IAccountService#getById(java.lang.String)
	 */
	@Override
	public Sys_account getById(String id) {
		return accountDao.get(id);
	}
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.archive.service.IAccountService#list()
	 */
	@Override
	public List<Sys_account> list() {
		return accountDao.getAll();
	}

	@Transactional("txManager")
	@Override
	public Sys_account insert(Sys_account account) {
		accountDao.save(account);
		return account;
	}

	@Transactional("txManager")
	@Override
	public int update(Sys_account account) {
		Sys_account tmp = accountDao.update(account);
		if (null != tmp) {
			return 1;
		}
		return 0;
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IAccountService#delete(java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public int delete(String id) {
		return accountDao.del(id);
	}

	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IAccountService#login(net.ussoft.zhxh.model.Sys_account)
	 */
	@Override
	public Sys_account login(Sys_account account) {
		Sys_account tmp = new Sys_account();
		tmp.setAccountcode(account.getAccountcode());
		Sys_account result = accountDao.searchOne(tmp);
		if (result == null ) {
			return null;
		}
		// 将输入的密码与Pojo里的密码MD5后对比，如果不匹配，说明密码不对
		if (!MD5.encode(account.getPassword()).equals(
				result.getPassword())) {
			return null;
		}
		return result;
	}
	/*
	 * (non-Javadoc)
	 * @see net.ussoft.zhxh.service.IAccountService#initUpdatePass(java.lang.String)
	 */
	@Transactional("txManager")
	@Override
	public int initUpdatePass(String ids) {
		String[] idArr = ids.split(",");
		
		Sys_account tmp = new Sys_account();
		tmp.setPassword(MD5.encode("123456").toString());
		
		int num = 0;
		
		for (String id : idArr) {
			tmp.setId(id);
			accountDao.update(tmp);
			num++;
		}
		
		return num;
	}

	
}

package net.ussoft.zhxh.service;


public interface IEncryService {
	
	/**
	 * 将字符串加密
	 * @param str
	 * @return
	 * @throws Exception 
	 */
	public String encryption(String str) throws Exception;
	
	/**
	 * 解密字符串
	 * @param str
	 * @return
	 * @throws Exception 
	 */
	public String Decryption(String str) throws Exception;
	
//	public Boolean getInit(int num) throws Exception;
	public Boolean getInit(String str) throws Exception;
	

}

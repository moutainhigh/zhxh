package net.ussoft.zhxh.model;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Table(name="public_user")
public class Public_user {

	private String id;
	private String usercode;		//	账户名称
	private String username;		//	真实姓名
	private String phonenumber;		//	手机
	private String identity;		//	身份
	private String identitymemo;	//	身份中文
	private String dianid;			//	店id
	private String shidaiid;		//	市代id
	private String shengdaiid;		//	省代id
	private String tuijianid;		//	推荐人id
	private String tuijianman;		//	推荐人
	private String tuijiansort;		//	推荐顺序
	private Integer setreturn;		//	是否接收分成
	private Integer isopen;			//	开关
	private String password;		//	密码
	private String uid;				//	微信唯一标识id
	private int sex;
	private String birthday;
	private String companyname;		//存储机构（代理或店）的名称
	private String companypath; 	//存储机构（代理或店）的地址
	
	private String belongcode; 		//存储普通会员的所属店代码
	private String companycode; 	//存储机构的代码
	private String wechar; 			//微信号码
	private String rank; 			//代理商或店的级别,存文本，仅仅显示，没有实际意义。
	
	private int sort;
	
	//临时字段
	private String parentid; 		//存储机构（代理或店）的直属上级id
	private String createtime;		//创建时间
	private String addressid;		//收货地址
	
	public Public_user() {
		super();
	}
	
	public Public_user(String id) {
		this.id = id;
		this.usercode = "";
		this.username = "";
		this.phonenumber = "";
		this.identity = "";
		this.identitymemo = "";
		this.dianid = "";
		this.shidaiid = "";
		this.shengdaiid = "";
		this.tuijianid = "";
		this.tuijianman = "";
		this.tuijiansort = "";
		this.setreturn = 0;
		this.isopen = 0;
		this.password = "";
		this.uid = "";
		this.sex = 0;
		this.birthday = "";
		this.companyname = "";
		this.companypath = "";
		this.belongcode = "";
		this.companycode = "";
		this.wechar = "";
		this.rank = "";
		this.sort = 1;
		this.parentid = "";
		this.createtime = "";
	}
//	public Public_user {
//		this.setUsercode("");
//		this.setUsername("");
//		this.setPhonenumber("");
//		this.setIdentity("");
//		this.setIdentitymemo("");
//		this.set
//	}
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsercode() {
		return usercode;
	}
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getDianid() {
		return dianid;
	}
	public void setDianid(String dianid) {
		this.dianid = dianid;
	}
	public String getShidaiid() {
		return shidaiid;
	}
	public void setShidaiid(String shidaiid) {
		this.shidaiid = shidaiid;
	}
	public String getShengdaiid() {
		return shengdaiid;
	}
	public void setShengdaiid(String shengdaiid) {
		this.shengdaiid = shengdaiid;
	}
	public String getTuijianid() {
		return tuijianid;
	}
	public void setTuijianid(String tuijianid) {
		this.tuijianid = tuijianid;
	}
	public String getTuijiansort() {
		return tuijiansort;
	}
	public void setTuijiansort(String tuijiansort) {
		this.tuijiansort = tuijiansort;
	}
	public Integer getSetreturn() {
		return setreturn;
	}
	public void setSetreturn(Integer setreturn) {
		this.setreturn = setreturn;
	}
	public Integer getIsopen() {
		return isopen;
	}
	public void setIsopen(Integer isopen) {
		this.isopen = isopen;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getTuijianman() {
		return tuijianman;
	}
	public void setTuijianman(String tuijianman) {
		this.tuijianman = tuijianman;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getIdentity() {
		return identity;
	}
	public void setIdentity(String identity) {
		this.identity = identity;
	}
	public String getIdentitymemo() {
		return identitymemo;
	}
	public void setIdentitymemo(String identitymemo) {
		this.identitymemo = identitymemo;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getCompanypath() {
		return companypath;
	}
	public void setCompanypath(String companypath) {
		this.companypath = companypath;
	}
	public String getBelongcode() {
		return belongcode;
	}
	public void setBelongcode(String belongcode) {
		this.belongcode = belongcode;
	}
	public String getCompanycode() {
		return companycode;
	}
	public void setCompanycode(String companycode) {
		this.companycode = companycode;
	}
	public String getWechar() {
		return wechar;
	}
	public void setWechar(String wechar) {
		this.wechar = wechar;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	@Transient
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	@Transient
	public String getAddressid() {
		return addressid;
	}
	public void setAddressid(String addressid) {
		this.addressid = addressid;
	}
	
}

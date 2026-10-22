package com.fuao.fajxc.vo;


public class CdnUser implements java.io.Serializable {

	private int id;	
	private String loginUserName;		//登录用户名
	private String password;			//登录密码
	private String apiPassword;			//api密码
	private String userCompany;			//用户公司名称
	private String userName;			//用户姓名
	private String userPost;			//用户所在公司的职务
	private int phone;					//用户电话
	private String email;				//用户邮箱
	private String fax;					//用户传真
	private int QQ;						//用户QQ
	private String mark; 				//备注
	

	public CdnUser() {
		super();
	}


	public CdnUser(String loginUserName,String password,String apiPassword,String userCompany,String userName,
			String userPost,int phone,String email,String fax,int QQ,String mark)
	{
		this.loginUserName=loginUserName;
		this.password=password;
		this.apiPassword=apiPassword;
		this.userCompany=userCompany;
		this.userName=userName;
		this.userPost=userPost;
		this.phone=phone;
		this.email=email;
		this.fax=fax;
		this.QQ=QQ;
		this.mark=mark;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getLoginUserName() {
		return loginUserName;
	}


	public void setLoginUserName(String loginUserName) {
		this.loginUserName = loginUserName;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getApiPassword() {
		return apiPassword;
	}


	public void setApiPassword(String apiPassword) {
		this.apiPassword = apiPassword;
	}


	public String getUserCompany() {
		return userCompany;
	}


	public void setUserCompany(String userCompany) {
		this.userCompany = userCompany;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getUserPost() {
		return userPost;
	}


	public void setUserPost(String userPost) {
		this.userPost = userPost;
	}


	public int getPhone() {
		return phone;
	}


	public void setPhone(int phone) {
		this.phone = phone;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getFax() {
		return fax;
	}


	public void setFax(String fax) {
		this.fax = fax;
	}


	public int getQQ() {
		return QQ;
	}


	public void setQQ(int qQ) {
		QQ = qQ;
	}


	public String getMark() {
		return mark;
	}


	public void setMark(String mark) {
		this.mark = mark;
	}

	
	
	
}
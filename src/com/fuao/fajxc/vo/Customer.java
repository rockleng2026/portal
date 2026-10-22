package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;



/**
 * Customer entity. @author MyEclipse Persistence Tools
 */

public class Customer implements java.io.Serializable {

	// Fields

	private Integer customerId;
	private Employee employee;
	private String customerName;
	private String customerPassword;
	private String customerType;
	private String customerType2;
	private String cardid;
	private String customerCompany;
	private String customerAddress;
	private String bankAccount;
	private String customerOrigin;
	private String realName;
	private String phone;
	private String mobilePhone;
	private String email;
	private String zipCode;
	private String date;
	private String qq;
	private String facsimile;
	private String admin;
	private String del;
	private Integer isLoginAccount;
	private String userFrom;
	private String userFrom2;
	private String userNotes;
	private String customerCompanyYw;
	private String realNamePinyin;
	private String customerCountry;
	private String customerProvince;
	private String customerCity;
	private String addressYw;
	private String businesslinkpersion;
	private String dobusinesscode;
	private String questionid;
	private String answervalue;
	private String issetmibao;
	private String authorization;
	private String localip;
	private String historytime;
	private String cardPhoto;// 上传身份证
	private String license;// 上传营业执照  
	private String cusClass;
	private String companyadress;// 公司地址
	private String customerexplain;// 客户需求说明
	private String companyScale;// 公司规模说明
	private String companyphone;// 公司电话
	private String customerfj;// 上传客户附件
	private int phoneIsOk;//是否设置我登录手机
	private String cuSFZTime;//身份证有效期
	private String customerTX;//用户头像
	private Set refundmentlogs = new HashSet(0);
	private Set customercommodities = new HashSet(0);
	private Set conkouts = new HashSet(0);
	private Set customermoves = new HashSet(0);
	private Set customerauditings = new HashSet(0);
	private Set customertryouts = new HashSet(0);
	private Set saleorders = new HashSet(0);
	private Set intentfollowUps = new HashSet(0);
	private Set cusid = new HashSet(0);
	private Set paymentlog = new HashSet(0);
	private Set sgOrder = new HashSet(0);

	


	public String getCustomerTX() {
		return customerTX;
	}

	public void setCustomerTX(String customerTX) {
		this.customerTX = customerTX;
	}

	public String getCompanyadress() {
		return companyadress;
	}

	public void setCompanyadress(String companyadress) {
		this.companyadress = companyadress;
	}

	public String getCustomerexplain() {
		return customerexplain;
	}

	public void setCustomerexplain(String customerexplain) {
		this.customerexplain = customerexplain;
	}

	public String getCompanyScale() {
		return companyScale;
	}

	public void setCompanyScale(String companyScale) {
		this.companyScale = companyScale;
	}

	public String getCompanyphone() {
		return companyphone;
	}

	public void setCompanyphone(String companyphone) {
		this.companyphone = companyphone;
	}

	public String getCustomerfj() {
		return customerfj;
	}

	public void setCustomerfj(String customerfj) {
		this.customerfj = customerfj;
	}

	public Set getCusid() {
		return cusid;
	}

	public String getCusClass() {
		return cusClass;
	}

	public void setCusClass(String cusClass) {
		this.cusClass = cusClass;
	}

	public void setCusid(Set cusid) {
		this.cusid = cusid;
	}

	/** default constructor */
	public Customer() {
	}

	/** full constructor */
	public Customer(Employee employee, String companyadress,
			String customerexplain, String companyScale, String companyphone,
			String customerfj, String customerName, String cardPhoto,
			String license, String customerPassword, String customerType,
			String customerType2, String cardid, String customerCompany,
			String customerAddress, String bankAccount, String customerOrigin,
			String realName, String phone, String mobilePhone, String email,
			String zipCode, String date, String qq, String facsimile,
			String admin, String del, Integer isLoginAccount, String userFrom,
			String userFrom2, String userNotes, String customerCompanyYw,
			String realNamePinyin, String customerCountry,
			String customerProvince, String customerCity, String addressYw,
			String businesslinkpersion, String dobusinesscode,
			String questionid, String answervalue, String issetmibao,
			Set refundmentlogs, Set customercommodities, Set conkouts,
			Set customermoves, Set customerauditings, Set customertryouts,
			Set saleorders, Set cusid, Set intentfollowUps,
			String authorization, String localip, String historytime,int phoneIsOk,String cuSFZTime,String customerTX) {
		this.employee = employee;
		this.customerName = customerName;
		this.customerPassword = customerPassword;
		this.customerType = customerType;
		this.customerType2 = customerType2;
		this.cardid = cardid;
		this.customerCompany = customerCompany;
		this.customerAddress = customerAddress;
		this.bankAccount = bankAccount;
		this.customerOrigin = customerOrigin;
		this.realName = realName;
		this.phone = phone;
		this.mobilePhone = mobilePhone;
		this.email = email;
		this.zipCode = zipCode;
		this.date = date;
		this.qq = qq;
		this.facsimile = facsimile;
		this.admin = admin;
		this.del = del;
		this.isLoginAccount = isLoginAccount;
		this.userFrom = userFrom;
		this.userFrom2 = userFrom2;
		this.userNotes = userNotes;
		this.customerCompanyYw = customerCompanyYw;
		this.realNamePinyin = realNamePinyin;
		this.customerCountry = customerCountry;
		this.customerProvince = customerProvince;
		this.customerCity = customerCity;
		this.addressYw = addressYw;
		this.businesslinkpersion = businesslinkpersion;
		this.dobusinesscode = dobusinesscode;
		this.questionid = questionid;
		this.answervalue = answervalue;
		this.issetmibao = issetmibao;
		this.refundmentlogs = refundmentlogs;
		this.customercommodities = customercommodities;
		this.conkouts = conkouts;
		this.customermoves = customermoves;
		this.customerauditings = customerauditings;
		this.customertryouts = customertryouts;
		this.saleorders = saleorders;
		this.intentfollowUps = intentfollowUps;
		this.authorization = authorization;
		this.localip = localip;
		this.historytime = historytime;
		this.cusid = cusid;
		this.license = license;
		this.cardPhoto = cardPhoto;
		this.companyadress = companyadress;
		this.companyphone = companyphone;
		this.companyScale = companyScale;
		this.customerexplain = customerexplain;
		this.customerfj = customerfj;
		this.phoneIsOk=phoneIsOk;
		this.cuSFZTime=cuSFZTime;
		this.customerTX=customerTX;
	}

	// Property accessors

	
	public Integer getCustomerId() {
		return this.customerId;
	}

	public String getCuSFZTime() {
		return cuSFZTime;
	}

	public void setCuSFZTime(String cuSFZTime) {
		this.cuSFZTime = cuSFZTime;
	}

	public String getCardPhoto() {
		return cardPhoto;
	}

	public void setCardPhoto(String cardPhoto) {
		this.cardPhoto = cardPhoto;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public String getAuthorization() {
		return authorization;
	}

	public void setAuthorization(String authorization) {
		this.authorization = authorization;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getCustomerName() {
		return this.customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerPassword() {
		return this.customerPassword;
	}

	public void setCustomerPassword(String customerPassword) {
		this.customerPassword = customerPassword;
	}

	public String getCustomerType() {
		return this.customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public String getCustomerType2() {
		return this.customerType2;
	}

	public void setCustomerType2(String customerType2) {
		this.customerType2 = customerType2;
	}

	public String getCardid() {
		return this.cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public String getCustomerCompany() {
		return this.customerCompany;
	}

	public void setCustomerCompany(String customerCompany) {
		this.customerCompany = customerCompany;
	}

	public String getCustomerAddress() {
		return this.customerAddress;
	}

	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}

	public String getBankAccount() {
		return this.bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	public String getCustomerOrigin() {
		return this.customerOrigin;
	}

	public void setCustomerOrigin(String customerOrigin) {
		this.customerOrigin = customerOrigin;
	}

	public String getRealName() {
		return this.realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMobilePhone() {
		return this.mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getZipCode() {
		return this.zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getDate() {
		return this.date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getQq() {
		return this.qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getFacsimile() {
		return this.facsimile;
	}

	public void setFacsimile(String facsimile) {
		this.facsimile = facsimile;
	}

	public String getAdmin() {
		return this.admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public String getDel() {
		return this.del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public Integer getIsLoginAccount() {
		return this.isLoginAccount;
	}

	public void setIsLoginAccount(Integer isLoginAccount) {
		this.isLoginAccount = isLoginAccount;
	}

	public String getUserFrom() {
		return this.userFrom;
	}

	public void setUserFrom(String userFrom) {
		this.userFrom = userFrom;
	}

	public String getUserFrom2() {
		return this.userFrom2;
	}

	public void setUserFrom2(String userFrom2) {
		this.userFrom2 = userFrom2;
	}

	public String getUserNotes() {
		return this.userNotes;
	}

	public void setUserNotes(String userNotes) {
		this.userNotes = userNotes;
	}

	public String getCustomerCompanyYw() {
		return this.customerCompanyYw;
	}

	public void setCustomerCompanyYw(String customerCompanyYw) {
		this.customerCompanyYw = customerCompanyYw;
	}

	public String getRealNamePinyin() {
		return this.realNamePinyin;
	}

	public void setRealNamePinyin(String realNamePinyin) {
		this.realNamePinyin = realNamePinyin;
	}

	public String getCustomerCountry() {
		return this.customerCountry;
	}

	public void setCustomerCountry(String customerCountry) {
		this.customerCountry = customerCountry;
	}

	public String getCustomerProvince() {
		return this.customerProvince;
	}

	public void setCustomerProvince(String customerProvince) {
		this.customerProvince = customerProvince;
	}

	public String getCustomerCity() {
		return this.customerCity;
	}

	public void setCustomerCity(String customerCity) {
		this.customerCity = customerCity;
	}

	public String getAddressYw() {
		return this.addressYw;
	}

	public void setAddressYw(String addressYw) {
		this.addressYw = addressYw;
	}

	public String getBusinesslinkpersion() {
		return this.businesslinkpersion;
	}

	public void setBusinesslinkpersion(String businesslinkpersion) {
		this.businesslinkpersion = businesslinkpersion;
	}

	public String getDobusinesscode() {
		return this.dobusinesscode;
	}

	public void setDobusinesscode(String dobusinesscode) {
		this.dobusinesscode = dobusinesscode;
	}

	public String getQuestionid() {
		return this.questionid;
	}

	public void setQuestionid(String questionid) {
		this.questionid = questionid;
	}

	public String getAnswervalue() {
		return this.answervalue;
	}

	public void setAnswervalue(String answervalue) {
		this.answervalue = answervalue;
	}

	public String getIssetmibao() {
		return this.issetmibao;
	}

	public void setIssetmibao(String issetmibao) {
		this.issetmibao = issetmibao;
	}

	public Set getRefundmentlogs() {
		return this.refundmentlogs;
	}

	public void setRefundmentlogs(Set refundmentlogs) {
		this.refundmentlogs = refundmentlogs;
	}

	public Set getCustomercommodities() {
		return this.customercommodities;
	}

	public void setCustomercommodities(Set customercommodities) {
		this.customercommodities = customercommodities;
	}

	public Set getConkouts() {
		return this.conkouts;
	}

	public void setConkouts(Set conkouts) {
		this.conkouts = conkouts;
	}

	public Set getCustomermoves() {
		return this.customermoves;
	}

	public void setCustomermoves(Set customermoves) {
		this.customermoves = customermoves;
	}

	public Set getCustomerauditings() {
		return this.customerauditings;
	}

	public void setCustomerauditings(Set customerauditings) {
		this.customerauditings = customerauditings;
	}

	public Set getCustomertryouts() {
		return this.customertryouts;
	}

	public void setCustomertryouts(Set customertryouts) {
		this.customertryouts = customertryouts;
	}

	public Set getSaleorders() {
		return this.saleorders;
	}

	public void setSaleorders(Set saleorders) {
		this.saleorders = saleorders;
	}

	public Set getIntentfollowUps() {
		return this.intentfollowUps;
	}

	public void setIntentfollowUps(Set intentfollowUps) {
		this.intentfollowUps = intentfollowUps;
	}

	public void setLocalip(String localip) {
		this.localip = localip;
	}

	public String getLocalip() {
		return localip;
	}

	public String getHistorytime() {
		return historytime;
	}

	public void setHistorytime(String historytime) {
		this.historytime = historytime;
	}

	public Set getPaymentlog() {
		return paymentlog;
	}

	public void setPaymentlog(Set paymentlog) {
		this.paymentlog = paymentlog;
	}

	public Set getSgOrder() {
		return sgOrder;
	}

	public void setSgOrder(Set sgOrder) {
		this.sgOrder = sgOrder;
	}
	public int getPhoneIsOk() {
		return phoneIsOk;
	}

	public void setPhoneIsOk(int phoneIsOk) {
		this.phoneIsOk = phoneIsOk;
	}
	
}
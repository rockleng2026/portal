package com.fuao.fajxc.vo;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import java.util.HashSet;
import java.util.Set;

/**
 * Conkout entity. @author MyEclipse Persistence Tools
 */

public class ConkOut implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Employee employee;
	private Product product;
	private Customer customer;
	private String conkOutNo;
	private Questioncategory issueType;
	private String descs;
	private String state;
	private Timestamp faultTime;
	private Timestamp endTim;
	private String remark;
	private String delflag;
	private String solveDepict;
	private String customerphone;                 //客户电话
    private String wdnr;                          //网站域名
    private Questioncategory proudcotType;                 //产品类型
    private String email;                         //客户email
    private String appraise;
    private String ip ;
    private String leavess;
    private String receiveTime;
    private Integer upserverid;
    private Employee emp;   // 处理人
    private Integer status;
    private Integer grades; //满意度
    private Integer bzf;  //标识符(避免重复接收用)
    private Employee handleemp;
    private String temp;
    
    private Integer ispay;  //是否产生费用
    private Integer isdeclare;  //责任声明
    private Integer sure;  //确认勾选
    private Operationgroup group;  //关联运维组
    private Set conkoutAsks = new HashSet(0);
	// Constructors

	/** default constructor */
	public ConkOut() {
	}

	/** full constructor */
	public ConkOut(Employee employee, Product product, Customer customer,
			String conkOutNo, Questioncategory issueType, String descs, String state,
			Timestamp faultTime,Timestamp endTim, String remark, String delflag,
			String solveDepict,String customerphone,String wdnr,Questioncategory proudcotType,
			String email,String appraise,Set conkoutAsks,String receiveTime,Integer upserverid,Integer ispay,Integer isdeclare,Integer sure,Operationgroup group,Employee emp,Integer status,Integer grades,Integer bzf,Employee handleemp,String temp) {
		
		
		this.employee=employee;
		this.product = product;
		this.customer = customer;
		this.conkOutNo = conkOutNo;
		this.issueType = issueType;
		this.descs = descs;
		this.state = state;
		this.faultTime = faultTime;
		this.endTim = endTim;
		this.remark = remark;
		this.delflag = delflag;
		this.solveDepict = solveDepict;
		this.customerphone = customerphone;
		this.proudcotType = proudcotType;
		this.wdnr = wdnr;
		this.email = email;
		this.appraise = appraise;
		this.conkoutAsks = conkoutAsks;
		this.receiveTime = receiveTime;
		this.upserverid = upserverid;
		this.ispay = ispay;
		this.isdeclare = isdeclare;
		this.sure = sure;
		this.group = group;
		this.emp = emp;
		this.status = status;
		this.grades = grades;
		this.bzf = bzf;
		this.handleemp = handleemp;
		this.temp = temp;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Customer getCustomer() {
		return this.customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getConkOutNo() {
		return this.conkOutNo;
	}

	public void setConkOutNo(String conkOutNo) {
		this.conkOutNo = conkOutNo;
	}
	public Questioncategory getIssueType() {
		return issueType;
	}

	public void setIssueType(Questioncategory issueType) {
		this.issueType = issueType;
	}

	public String getDescs() {
		return this.descs;
	}

	public void setDescs(String descs) {
		this.descs = descs;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}
	public Timestamp getFaultTime() {
		return faultTime;
	}

	public void setFaultTime(Timestamp faultTime) {
		this.faultTime = faultTime;
	}

	public Timestamp getEndTim() {
		return endTim;
	}

	public void setEndTim(Timestamp endTim) {
		this.endTim = endTim;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public String getSolveDepict() {
		return this.solveDepict;
	}

	public void setSolveDepict(String solveDepict) {
		this.solveDepict = solveDepict;
	}

	public String getCustomerphone() {
		return customerphone;
	}

	public void setCustomerphone(String customerphone) {
		this.customerphone = customerphone;
	}

	public String getWdnr() {
		return wdnr;
	}

	public void setWdnr(String wdnr) {
		this.wdnr = wdnr;
	}

	public Questioncategory getProudcotType() {
		return proudcotType;
	}

	public void setProudcotType(Questioncategory proudcotType) {
		this.proudcotType = proudcotType;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAppraise() {
		return appraise;
	}

	public void setAppraise(String appraise) {
		this.appraise = appraise;
	}

	public Set getConkoutAsks() {
		return conkoutAsks;
	}

	public void setConkoutAsks(Set conkoutAsks) {
		this.conkoutAsks = conkoutAsks;
	}
	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getLeavess() {
		return leavess;
	}

	public void setLeavess(String leavess) {
		this.leavess = leavess;
	}

	public String getReceiveTime() {
		return receiveTime;
	}

	public void setReceiveTime(String receiveTime) {
		this.receiveTime = receiveTime;
	}

	public Integer getUpserverid() {
		return upserverid;
	}

	public void setUpserverid(Integer upserverid) {
		this.upserverid = upserverid;
	}

	public Integer getIspay() {
		return ispay;
	}

	public void setIspay(Integer ispay) {
		this.ispay = ispay;
	}

	public Integer getIsdeclare() {
		return isdeclare;
	}

	public void setIsdeclare(Integer isdeclare) {
		this.isdeclare = isdeclare;
	}

	public Integer getSure() {
		return sure;
	}

	public void setSure(Integer sure) {
		this.sure = sure;
	}

	public Operationgroup getGroup() {
		return group;
	}

	public void setGroup(Operationgroup group) {
		this.group = group;
	}

	public Employee getEmp() {
		return emp;
	}

	public void setEmp(Employee emp) {
		this.emp = emp;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getGrades() {
		return grades;
	}

	public void setGrades(Integer grades) {
		this.grades = grades;
	}

	public Integer getBzf() {
		return bzf;
	}

	public void setBzf(Integer bzf) {
		this.bzf = bzf;
	}

	public Employee getHandleemp() {
		return handleemp;
	}

	public void setHandleemp(Employee handleemp) {
		this.handleemp = handleemp;
	}

	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}

}
package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * SaleOrder entity. @author MyEclipse Persistence Tools
 */

public class SaleOrder implements java.io.Serializable {

	// Fields  销售订单

	private Integer id; //销售订单id
	private String uuid;
	private Property property;
	private AllType allTypeByPayStyle; //付费类型
	private Questioncategory allTypeByOrdertype;  //分类
	private Employee employee; //销售人员Id(员工表)
	private Customer customer;  //客户
	private AllType allTypeByPayStatus;  //付费状态
	private String saleOrderNo;  //订单号
	private Double price;   //价格
	private String beginTime;  //开始时间
	private String endTime;   //end时间
	private String spaceSize; //机位大小
	private Integer productNum;//产品数量
	private String bw;    ///带宽总数
	private Integer ipNum;  //ip数量
	private Integer usedSize; //已经使用的机位大小
	private String auditingState;  
	private String finance;  //财务审核（1.通过 0未通过）
	private String orderStartTime;  //订单续费开始时间
	private String description;  //订单描述
	private String delflag;   ///删除标记
	private String inputAdmin;
	private String inputTime;
	private	Integer	isgetorder;//是否收货
	private String serverConfiguration;   ///服务器配置
	private Set refundmentLogs = new HashSet(0);
	private Set charges = new HashSet(0);
	private Set addServers = new HashSet(0);
	private Set renewLogs = new HashSet(0);
	private Set upServers = new HashSet(0);
	private long day;

    
	// Constructors

	public long getDay() {
		return day;
	}
	public void setDay(long day) {
		this.day = day;
	}

	/** default constructor */
	public SaleOrder() {
	}

	/** minimal constructor */
	public SaleOrder(Questioncategory allTypeByOrdertype, Employee employee,
			Double price, String beginTime) {
		this.allTypeByOrdertype = allTypeByOrdertype;
		this.employee = employee;
		this.price = price;
		this.beginTime = beginTime;
	}

	/** full constructor */
	public SaleOrder(String uuid,Property property, AllType allTypeByPayStyle,
			Questioncategory allTypeByOrdertype, Employee employee, Customer customer,
			AllType allTypeByPayStatus, String saleOrderNo, Double price,
			String beginTime, String endTime, String spaceSize,
			Integer productNum, String bw, Integer ipNum, Integer usedSize,
			String mainAuditing, String finance, String orderStartTime,
			String description, String delflag, String inputAdmin,
			String inputTime, String serverConfiguration, Set refundmentLogs,
			Set charges, Set addServers, Set renewLogs, Set upServers) {
		this.uuid=uuid;
		this.property = property;
		this.allTypeByPayStyle = allTypeByPayStyle;
		this.allTypeByOrdertype = allTypeByOrdertype;
		this.employee = employee;
		this.customer = customer;
		this.allTypeByPayStatus = allTypeByPayStatus;
		this.saleOrderNo = saleOrderNo;
		this.price = price;
		this.beginTime = beginTime;
		this.endTime = endTime;
		this.spaceSize = spaceSize;
		this.productNum = productNum;
		this.bw = bw;
		this.ipNum = ipNum;
		this.usedSize = usedSize;
		this.auditingState = mainAuditing;
		this.finance = finance;
		this.orderStartTime = orderStartTime;
		this.description = description;
		this.delflag = delflag;
		this.inputAdmin = inputAdmin;
		this.inputTime = inputTime;
		this.serverConfiguration = serverConfiguration;
		this.refundmentLogs = refundmentLogs;
		this.charges = charges;
		this.addServers = addServers;
		this.renewLogs = renewLogs;
		this.upServers = upServers;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Property getProperty() {
		return this.property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	public AllType getAllTypeByPayStyle() {
		return this.allTypeByPayStyle;
	}

	public void setAllTypeByPayStyle(AllType allTypeByPayStyle) {
		this.allTypeByPayStyle = allTypeByPayStyle;
	}

	public Questioncategory getAllTypeByOrdertype() {
		return allTypeByOrdertype;
	}

	public void setAllTypeByOrdertype(Questioncategory allTypeByOrdertype) {
		this.allTypeByOrdertype = allTypeByOrdertype;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Customer getCustomer() {
		return this.customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public AllType getAllTypeByPayStatus() {
		return this.allTypeByPayStatus;
	}

	public void setAllTypeByPayStatus(AllType allTypeByPayStatus) {
		this.allTypeByPayStatus = allTypeByPayStatus;
	}

	public String getSaleOrderNo() {
		return this.saleOrderNo;
	}

	public void setSaleOrderNo(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getBeginTime() {
		return this.beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getSpaceSize() {
		return this.spaceSize;
	}

	public void setSpaceSize(String spaceSize) {
		this.spaceSize = spaceSize;
	}

	public Integer getProductNum() {
		return this.productNum;
	}

	public void setProductNum(Integer productNum) {
		this.productNum = productNum;
	}

	public String getBw() {
		return this.bw;
	}

	public void setBw(String bw) {
		this.bw = bw;
	}

	public Integer getIpNum() {
		return this.ipNum;
	}

	public void setIpNum(Integer ipNum) {
		this.ipNum = ipNum;
	}

	public Integer getUsedSize() {
		return this.usedSize;
	}

	public void setUsedSize(Integer usedSize) {
		this.usedSize = usedSize;
	}

	

	public String getAuditingState() {
		return auditingState;
	}

	public void setAuditingState(String auditingState) {
		this.auditingState = auditingState;
	}

	public String getFinance() {
		return this.finance;
	}

	public void setFinance(String finance) {
		this.finance = finance;
	}

	public String getOrderStartTime() {
		return this.orderStartTime;
	}

	public void setOrderStartTime(String orderStartTime) {
		this.orderStartTime = orderStartTime;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public String getInputAdmin() {
		return this.inputAdmin;
	}

	public void setInputAdmin(String inputAdmin) {
		this.inputAdmin = inputAdmin;
	}

	public String getInputTime() {
		return this.inputTime;
	}

	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}

	public String getServerConfiguration() {
		return this.serverConfiguration;
	}

	public void setServerConfiguration(String serverConfiguration) {
		this.serverConfiguration = serverConfiguration;
	}

	public Set getRefundmentLogs() {
		return this.refundmentLogs;
	}

	public void setRefundmentLogs(Set refundmentLogs) {
		this.refundmentLogs = refundmentLogs;
	}

	public Set getCharges() {
		return this.charges;
	}

	public void setCharges(Set charges) {
		this.charges = charges;
	}

	public Set getAddServers() {
		return this.addServers;
	}

	public void setAddServers(Set addServers) {
		this.addServers = addServers;
	}

	public Set getRenewLogs() {
		return this.renewLogs;
	}

	public void setRenewLogs(Set renewLogs) {
		this.renewLogs = renewLogs;
	}

	public Set getUpServers() {
		return this.upServers;
	}

	public void setUpServers(Set upServers) {
		this.upServers = upServers;
	}
	public void setIsgetorder(Integer isgetorder) {
		this.isgetorder = isgetorder;
	}
	public Integer getIsgetorder() {
		return isgetorder;
	}

}
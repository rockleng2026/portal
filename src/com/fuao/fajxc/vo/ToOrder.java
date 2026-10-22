package com.fuao.fajxc.vo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * ToOrder entity. @author MyEclipse Persistence Tools
 */

public class ToOrder implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private Department department;
	private PurOrder purOrder;
	private String piciNo;
	private String totime;
	private String buytype;
	private String deliverytType;
	private Timestamp deliveryTime;
	private String deliveryer;
	private String deliveryaddress;
	private String phone;
	private String supplieraddress;
	private String payappoint;
	private String isBilling;
	private String billingType;
	private String payType;
	private String payAppointType;
	private String paytraffic;
	private String trafficOrdernum;
	private String orderGross;
	private String trafficcompany;
	private String trafficLinkman;
	private String trafficphone;
	private Double grossmoney;
	private String remark;
	private String delflag;
	private String toOrderNum;
	private Integer toOrderVerify;
	private Integer storageState;
	private Set toOrderprinfos = new HashSet(0);
	private Set storageInfos = new HashSet(0);
	private Set batchexps = new HashSet(0);
	private Set returnOrders = new HashSet(0);

	// Constructors

	/** default constructor */
	public ToOrder() {
	}

	/** full constructor */
	public ToOrder(Employee employee, Department department, PurOrder purOrder,
			String piciNo, String totime, String buytype, String deliverytType,
			Timestamp deliveryTime, String deliveryer, String deliveryaddress,
			String phone, String supplieraddress, String payappoint,
			String isBilling, String billingType, String payType,
			String payAppointType, String paytraffic, String trafficOrdernum,
			String orderGross, String trafficcompany, String trafficLinkman,
			String trafficphone, Double grossmoney, String remark,
			String delflag, String toOrderNum, Integer toOrderVerify,
			Integer storageState, Set toOrderprinfos, Set storageInfos,
			Set batchexps, Set returnOrders) {
		this.employee = employee;
		this.department = department;
		this.purOrder = purOrder;
		this.piciNo = piciNo;
		this.totime = totime;
		this.buytype = buytype;
		this.deliverytType = deliverytType;
		this.deliveryTime = deliveryTime;
		this.deliveryer = deliveryer;
		this.deliveryaddress = deliveryaddress;
		this.phone = phone;
		this.supplieraddress = supplieraddress;
		this.payappoint = payappoint;
		this.isBilling = isBilling;
		this.billingType = billingType;
		this.payType = payType;
		this.payAppointType = payAppointType;
		this.paytraffic = paytraffic;
		this.trafficOrdernum = trafficOrdernum;
		this.orderGross = orderGross;
		this.trafficcompany = trafficcompany;
		this.trafficLinkman = trafficLinkman;
		this.trafficphone = trafficphone;
		this.grossmoney = grossmoney;
		this.remark = remark;
		this.delflag = delflag;
		this.toOrderNum = toOrderNum;
		this.toOrderVerify = toOrderVerify;
		this.storageState = storageState;
		this.toOrderprinfos = toOrderprinfos;
		this.storageInfos = storageInfos;
		this.batchexps = batchexps;
		this.returnOrders = returnOrders;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Department getDepartment() {
		return this.department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public PurOrder getPurOrder() {
		return this.purOrder;
	}

	public void setPurOrder(PurOrder purOrder) {
		this.purOrder = purOrder;
	}

	public String getPiciNo() {
		return this.piciNo;
	}

	public void setPiciNo(String piciNo) {
		this.piciNo = piciNo;
	}

	public String getTotime() {
		return this.totime;
	}

	public void setTotime(String totime) {
		this.totime = totime;
	}

	public String getBuytype() {
		return this.buytype;
	}

	public void setBuytype(String buytype) {
		this.buytype = buytype;
	}

	public String getDeliverytType() {
		return this.deliverytType;
	}

	public void setDeliverytType(String deliverytType) {
		this.deliverytType = deliverytType;
	}

	public Timestamp getDeliveryTime() {
		return this.deliveryTime;
	}

	public void setDeliveryTime(Timestamp deliveryTime) {
		this.deliveryTime = deliveryTime;
	}

	public String getDeliveryer() {
		return this.deliveryer;
	}

	public void setDeliveryer(String deliveryer) {
		this.deliveryer = deliveryer;
	}

	public String getDeliveryaddress() {
		return this.deliveryaddress;
	}

	public void setDeliveryaddress(String deliveryaddress) {
		this.deliveryaddress = deliveryaddress;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSupplieraddress() {
		return this.supplieraddress;
	}

	public void setSupplieraddress(String supplieraddress) {
		this.supplieraddress = supplieraddress;
	}

	public String getPayappoint() {
		return this.payappoint;
	}

	public void setPayappoint(String payappoint) {
		this.payappoint = payappoint;
	}

	public String getIsBilling() {
		return this.isBilling;
	}

	public void setIsBilling(String isBilling) {
		this.isBilling = isBilling;
	}

	public String getBillingType() {
		return this.billingType;
	}

	public void setBillingType(String billingType) {
		this.billingType = billingType;
	}

	public String getPayType() {
		return this.payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getPayAppointType() {
		return this.payAppointType;
	}

	public void setPayAppointType(String payAppointType) {
		this.payAppointType = payAppointType;
	}

	public String getPaytraffic() {
		return this.paytraffic;
	}

	public void setPaytraffic(String paytraffic) {
		this.paytraffic = paytraffic;
	}

	public String getTrafficOrdernum() {
		return this.trafficOrdernum;
	}

	public void setTrafficOrdernum(String trafficOrdernum) {
		this.trafficOrdernum = trafficOrdernum;
	}

	public String getOrderGross() {
		return this.orderGross;
	}

	public void setOrderGross(String orderGross) {
		this.orderGross = orderGross;
	}

	public String getTrafficcompany() {
		return this.trafficcompany;
	}

	public void setTrafficcompany(String trafficcompany) {
		this.trafficcompany = trafficcompany;
	}

	public String getTrafficLinkman() {
		return this.trafficLinkman;
	}

	public void setTrafficLinkman(String trafficLinkman) {
		this.trafficLinkman = trafficLinkman;
	}

	public String getTrafficphone() {
		return this.trafficphone;
	}

	public void setTrafficphone(String trafficphone) {
		this.trafficphone = trafficphone;
	}

	public Double getGrossmoney() {
		return this.grossmoney;
	}

	public void setGrossmoney(Double grossmoney) {
		this.grossmoney = grossmoney;
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

	public String getToOrderNum() {
		return this.toOrderNum;
	}

	public void setToOrderNum(String toOrderNum) {
		this.toOrderNum = toOrderNum;
	}

	public Integer getToOrderVerify() {
		return this.toOrderVerify;
	}

	public void setToOrderVerify(Integer toOrderVerify) {
		this.toOrderVerify = toOrderVerify;
	}

	public Integer getStorageState() {
		return this.storageState;
	}

	public void setStorageState(Integer storageState) {
		this.storageState = storageState;
	}

	public Set getToOrderprinfos() {
		return this.toOrderprinfos;
	}

	public void setToOrderprinfos(Set toOrderprinfos) {
		this.toOrderprinfos = toOrderprinfos;
	}

	public Set getStorageInfos() {
		return this.storageInfos;
	}

	public void setStorageInfos(Set storageInfos) {
		this.storageInfos = storageInfos;
	}

	public Set getBatchexps() {
		return this.batchexps;
	}

	public void setBatchexps(Set batchexps) {
		this.batchexps = batchexps;
	}

	public Set getReturnOrders() {
		return this.returnOrders;
	}

	public void setReturnOrders(Set returnOrders) {
		this.returnOrders = returnOrders;
	}

}
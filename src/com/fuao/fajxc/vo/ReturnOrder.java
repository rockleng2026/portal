package com.fuao.fajxc.vo;

/**
 * ReturnOrder entity. @author MyEclipse Persistence Tools
 */

public class ReturnOrder implements java.io.Serializable {

	// Fields

	private Integer id;
	private ToOrder toOrder;
	private Employee employee;
	private Department department;
	private PurOrder purOrder;
	private Supplier supplier;
	private String purReturnNo;
	private String returnTime;
	private String returnStyle;
	private String returnReason;
	private String returnDescription;
	private String returnTimeLimit;
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
	private String grossmoney;
	private String remark;
	private String delflag;
	private String buytype;
	private Integer returnOrderVerify;
	private Integer isReturn;

	// Constructors

	/** default constructor */
	public ReturnOrder() {
	}

	/** minimal constructor */
	public ReturnOrder(ToOrder toOrder, PurOrder purOrder, Supplier supplier,
			String purReturnNo, String returnTime) {
		this.toOrder = toOrder;
		this.purOrder = purOrder;
		this.supplier = supplier;
		this.purReturnNo = purReturnNo;
		this.returnTime = returnTime;
	}

	/** full constructor */
	public ReturnOrder(ToOrder toOrder, Employee employee,
			Department department, PurOrder purOrder, Supplier supplier,
			String purReturnNo, String returnTime, String returnStyle,
			String returnReason, String returnDescription,
			String returnTimeLimit, String payappoint, String isBilling,
			String billingType, String payType, String payAppointType,
			String paytraffic, String trafficOrdernum, String orderGross,
			String trafficcompany, String trafficLinkman, String trafficphone,
			String grossmoney, String remark, String delflag, String buytype,
			Integer returnOrderVerify, Integer isReturn) {
		this.toOrder = toOrder;
		this.employee = employee;
		this.department = department;
		this.purOrder = purOrder;
		this.supplier = supplier;
		this.purReturnNo = purReturnNo;
		this.returnTime = returnTime;
		this.returnStyle = returnStyle;
		this.returnReason = returnReason;
		this.returnDescription = returnDescription;
		this.returnTimeLimit = returnTimeLimit;
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
		this.buytype = buytype;
		this.returnOrderVerify = returnOrderVerify;
		this.isReturn = isReturn;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public ToOrder getToOrder() {
		return this.toOrder;
	}

	public void setToOrder(ToOrder toOrder) {
		this.toOrder = toOrder;
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

	public Supplier getSupplier() {
		return this.supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public String getPurReturnNo() {
		return this.purReturnNo;
	}

	public void setPurReturnNo(String purReturnNo) {
		this.purReturnNo = purReturnNo;
	}

	public String getReturnTime() {
		return this.returnTime;
	}

	public void setReturnTime(String returnTime) {
		this.returnTime = returnTime;
	}

	public String getReturnStyle() {
		return this.returnStyle;
	}

	public void setReturnStyle(String returnStyle) {
		this.returnStyle = returnStyle;
	}

	public String getReturnReason() {
		return this.returnReason;
	}

	public void setReturnReason(String returnReason) {
		this.returnReason = returnReason;
	}

	public String getReturnDescription() {
		return this.returnDescription;
	}

	public void setReturnDescription(String returnDescription) {
		this.returnDescription = returnDescription;
	}

	public String getReturnTimeLimit() {
		return this.returnTimeLimit;
	}

	public void setReturnTimeLimit(String returnTimeLimit) {
		this.returnTimeLimit = returnTimeLimit;
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

	public String getGrossmoney() {
		return this.grossmoney;
	}

	public void setGrossmoney(String grossmoney) {
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

	public String getBuytype() {
		return this.buytype;
	}

	public void setBuytype(String buytype) {
		this.buytype = buytype;
	}

	public Integer getReturnOrderVerify() {
		return this.returnOrderVerify;
	}

	public void setReturnOrderVerify(Integer returnOrderVerify) {
		this.returnOrderVerify = returnOrderVerify;
	}

	public Integer getIsReturn() {
		return this.isReturn;
	}

	public void setIsReturn(Integer isReturn) {
		this.isReturn = isReturn;
	}

}
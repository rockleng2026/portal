package com.fuao.fajxc.vo;

import java.sql.Timestamp;
import java.util.Date;

import com.sun.corba.se.impl.orbutil.closure.Constant;

/**
 * DownServer entity. @author MyEclipse Persistence Tools
 */

public class DownServer implements java.io.Serializable {

	// Fields

	private Integer id;
	private AllType allType;     //
	private Product product;      //商品、服务器
	private Employee employee;   //员工
	private Timestamp dtime;     //下架时间表
	private Integer downFlag;     //是否已经下架
	private Integer auditingFlag;  //审核状态
	private String downNo;     //下架单号
	private String remark;      //备注
	private Integer delflag;    //是否删除   0为没有删除， 1为已经删除
	private String serverIp;     //服务器IP地址
	private Customer customer;  //客户
	private String businesstype;  //业务类型
	private String system;   //系统显示
	private String configurationinfo;//配置详情信息
	private String bandwidthflow;//带宽流量
	private String downcause;//下架原因
	private Float returnAmout;// 退返金额
	private String settlementAccount;//结算账号
	private Integer costFlag;//是否费用结清  0为已    1为否
	private String serverLocation;//服务器存放的机房位置，防止服务器换了机房后，下架上的机房位置也会变
	private String upNo ;//下架时记录上架单号
	private String dowTimedt;
	// Constructors

   
	public String getUpNo() {
		return upNo;
	}



	public String getDowTimedt() {
		return dowTimedt;
	}



	public void setDowTimedt(String dowTimedt) {
		this.dowTimedt = dowTimedt;
	}



	public void setUpNo(String upNo) {
		this.upNo = upNo;
	}

	/** default constructor */
	public DownServer() {
	}

	/** full constructor */
	public DownServer(AllType allType, Product product, Employee employee,
			Timestamp dtime, Integer downFlag, Integer auditingFlag,
			String downNo, String remark, Integer delflag,String serverIp,
			Customer customer,String businesstype,String system,String configurationinfo,
			String bandwidthflow,String downcause,Float returnAmout,
			String settlementAccount,Integer costFlag, String serverLocation) {
		this.allType = allType;
		this.product = product;
		this.employee = employee;
		this.dtime = dtime;
		this.downFlag = downFlag;
		this.auditingFlag = auditingFlag;
		this.downNo = downNo;
		this.remark = remark;
		this.delflag = delflag;
		this.serverIp=serverIp;
		this.customer=customer;
		this.businesstype=businesstype;
		this.system=system;
		this.configurationinfo=configurationinfo;
		this.bandwidthflow=bandwidthflow;
		this.downcause=downcause;
		this.returnAmout=returnAmout;
		this.settlementAccount=settlementAccount;
		this.costFlag=costFlag;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public AllType getAllType() {
		return this.allType;
	}

	public void setAllType(AllType allType) {
		this.allType = allType;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Timestamp getDtime() {
		return this.dtime;
	}

	public void setDtime(Timestamp dtime) {
		this.dtime = dtime;
	}

	public Integer getDownFlag() {
		return this.downFlag;
	}

	public void setDownFlag(Integer downFlag) {
		this.downFlag = downFlag;
	}

	public Integer getAuditingFlag() {
		return this.auditingFlag;
	}

	public void setAuditingFlag(Integer auditingFlag) {
		this.auditingFlag = auditingFlag;
	}

	public String getDownNo() {
		return this.downNo;
	}

	public void setDownNo(String downNo) {
		this.downNo = downNo;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public String getServerIp() {
		return serverIp;
	}

	public void setServerIp(String serverIp) {
		this.serverIp = serverIp;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getBusinesstype() {
		return businesstype;
	}

	public void setBusinesstype(String businesstype) {
		this.businesstype = businesstype;
	}

	public String getSystem() {
		return system;
	}

	public void setSystem(String system) {
		this.system = system;
	}

	public String getConfigurationinfo() {
		return configurationinfo;
	}

	public void setConfigurationinfo(String configurationinfo) {
		this.configurationinfo = configurationinfo;
	}

	public String getBandwidthflow() {
		return bandwidthflow;
	}

	public void setBandwidthflow(String bandwidthflow) {
		this.bandwidthflow = bandwidthflow;
	}

	public String getDowncause() {
		return downcause;
	}

	public void setDowncause(String downcause) {
		this.downcause = downcause;
	}

	public Float getReturnAmout() {
		return returnAmout;
	}

	public void setReturnAmout(Float returnAmout) {
		this.returnAmout = returnAmout;
	}

	public String getSettlementAccount() {
		return settlementAccount;
	}

	public void setSettlementAccount(String settlementAccount) {
		this.settlementAccount = settlementAccount;
	}

	public int getCostFlag() {
		return costFlag;
	}

	public void setCostFlag(Integer costFlag) {
		this.costFlag = costFlag;
	}

	public String getServerLocation() {
		return serverLocation;
	}

	public void setServerLocation(String serverLocation) {
		this.serverLocation = serverLocation;
	}
	
	
}
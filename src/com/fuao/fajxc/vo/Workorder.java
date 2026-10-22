package com.fuao.fajxc.vo;

import java.io.Serializable;
/**
 * 工单(在填写完上架单并审批完成之后,自动生成工单,转给客服人员)
 * @author Administrator  袁天龙 2013-1-15
 *
 */
public class Workorder implements Serializable{
	private Integer id;  //PK
	private String workorderNo;
	private SaleOrder saleorder; //销售订单
	private UpServer upserver; //上架单
	private String problemType; //问题类型
	private String problemInfo; //问题描述
	private Integer status;  //处理状态
	private String temp;  //备注
	
	private Sale_orders saleOrders;  //新的销售订单
	
	public Workorder(){}
	public Workorder(Integer id,String workorderNo, SaleOrder saleorder, UpServer upserver,
			String problemType, String problemInfo,
			Integer status, String temp,Sale_orders saleOrders) {
		this.id = id;
		this.workorderNo = workorderNo;
		this.saleorder = saleorder;
		this.upserver = upserver;
		this.problemType = problemType;
		this.problemInfo = problemInfo;
		this.status = status;
		this.temp = temp;
		this.saleOrders = saleOrders;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public SaleOrder getSaleorder() {
		return saleorder;
	}
	public void setSaleorder(SaleOrder saleorder) {
		this.saleorder = saleorder;
	}
	public UpServer getUpserver() {
		return upserver;
	}
	public void setUpserver(UpServer upserver) {
		this.upserver = upserver;
	}
	public String getProblemType() {
		return problemType;
	}
	public void setProblemType(String problemType) {
		this.problemType = problemType;
	}
	public String getProblemInfo() {
		return problemInfo;
	}
	public void setProblemInfo(String problemInfo) {
		this.problemInfo = problemInfo;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getWorkorderNo() {
		return workorderNo;
	}
	public void setWorkorderNo(String workorderNo) {
		this.workorderNo = workorderNo;
	}
	public Sale_orders getSaleOrders() {
		return saleOrders;
	}
	public void setSaleOrders(Sale_orders saleOrders) {
		this.saleOrders = saleOrders;
	}
	
}

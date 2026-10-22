package com.fuao.fajxc.vo;

import java.io.Serializable;
import java.util.Date;

public class Operate implements Serializable{
	private Integer id; //运维 
	private String operateNo; //运维编号(自动生成唯一编号)
	private SaleOrder saleorder; //订单号，来自销售订单对象
	private UpServer upserver; //上架单号,来自上架单对象
	private Employee employee;  //上架人员
	private Depot depot;  //仓库
	private Cabinet cabinet;  //机柜
	private Product product; //商品名称,服务器名称
	private String markNum;  //柜号
	private String housesAndRooms;  //机房和房间字符串
	private String jhj; //交换机
	private String port; // 端口
	private String ipAddress;  //IP地址
	private String jgh;  //机柜号
	private Date uptime; //上架时间
	private Date downtime; //下架时间
	private String temp; //备注
	private Sale_orders saleOrders;  //新的销售订单
	
	public Operate(){}
	public Operate(Integer id, String operateNo, SaleOrder saleorder,
			UpServer upserver, Employee employee, Depot depot,
			Cabinet cabinet, Product product,
			String markNum, String jhj, String port, String ipAddress,
			Date uptime, Date downtime, String temp,String housesAndRooms,String jgh,Sale_orders saleOrders) {
		this.id = id;
		this.operateNo = operateNo;
		this.saleorder = saleorder;
		this.upserver = upserver;
		this.employee = employee;
		this.depot = depot;
		this.cabinet = cabinet;
		this.product = product;
		this.markNum = markNum;
		this.jhj = jhj;
		this.port = port;
		this.ipAddress = ipAddress;
		this.uptime = uptime;
		this.downtime = downtime;
		this.temp = temp;
		this.housesAndRooms = housesAndRooms;
		this.jgh = jgh;
		this.saleOrders = saleOrders;
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getOperateNo() {
		return operateNo;
	}
	public void setOperateNo(String operateNo) {
		this.operateNo = operateNo;
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
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public Depot getDepot() {
		return depot;
	}
	public void setDepot(Depot depot) {
		this.depot = depot;
	}
	public Cabinet getCabinet() {
		return cabinet;
	}
	public void setCabinet(Cabinet cabinet) {
		this.cabinet = cabinet;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public String getMarkNum() {
		return markNum;
	}
	public void setMarkNum(String markNum) {
		this.markNum = markNum;
	}
	public String getJhj() {
		return jhj;
	}
	public void setJhj(String jhj) {
		this.jhj = jhj;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public Date getUptime() {
		return uptime;
	}
	public void setUptime(Date uptime) {
		this.uptime = uptime;
	}
	public Date getDowntime() {
		return downtime;
	}
	public void setDowntime(Date downtime) {
		this.downtime = downtime;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getHousesAndRooms() {
		return housesAndRooms;
	}
	public void setHousesAndRooms(String housesAndRooms) {
		this.housesAndRooms = housesAndRooms;
	}
	public String getJgh() {
		return jgh;
	}
	public void setJgh(String jgh) {
		this.jgh = jgh;
	}
	public Sale_orders getSaleOrders() {
		return saleOrders;
	}
	public void setSaleOrders(Sale_orders saleOrders) {
		this.saleOrders = saleOrders;
	}
	
}

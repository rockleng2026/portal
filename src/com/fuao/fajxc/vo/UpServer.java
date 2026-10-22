package com.fuao.fajxc.vo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * UpServer entity. @author MyEclipse Persistence Tools
 */

public class UpServer implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer parentId;   //父id
	private SaleOrder saleOrder;//销售订单
	private Integer saleId;
	private Product product;	//c产品  服务器
	private Employee employee;   //上架员工
	private Timestamp uptime;   //上架时间
	private Timestamp downtime;   //下架时间 
	private String maintenancePass;  //维护口令
	private Integer bandwidthAmount;   //带宽数量的
	private Integer bandwidthThrottling; //带宽限制   bandwidthThrottling
	private Integer audtitingFlag; // 审核状态
	private Integer upFlag;      //是否上架     下架为0  ，上架后为1，再为2故障
	private String upNo;       //上架单号
	private Integer delflag;   //是否已经删除
	private String serverIp;   //要上架的IP地址  商品的id号
	private Integer ipnum;    //要上架的IP数量
	private Customer customer;  //客户
	private String serverLocation;//服务器存放的机房位置，防止服务器换了机房后，下架上的机房位置也会变
	private String temp;//备注
	private Cabinet Tupcabs;
	private String  marknum; //刻度
	private String startpossition;
	private String endpossition;
	
	//服务器ID
	private int seridse;
	//保存员工ID
	private int empIds;
	//ytl8.8日新增3个字段 varchar型 
	private String jhjname; //交换机名称
	private String port; //端口号
	private String jgh; //机柜号
	private String uptimeString;
	private String downtimeString;
	//销售的
	private String salespaceString;
	private String salenameString;
	private String salenodeString;
	//机房和房间
	private String housesAndRoomsID;//字符串
	private String housesAndRooms;
	
	private Set operates = new HashSet(0);
//	private Integer remarks;
	//新的订单表
	private Sale_orders soOrders;
	//工单
	private ConkOut conkout;
	// Constructors
   
	public String getUptimeString() {
		return uptimeString;
	}

	public String getHousesAndRoomsID() {
		return housesAndRoomsID;
	}

	public void setHousesAndRoomsID(String housesAndRoomsID) {
		this.housesAndRoomsID = housesAndRoomsID;
	}

	public String getHousesAndRooms() {
		return housesAndRooms;
	}



	public void setHousesAndRooms(String housesAndRooms) {
		this.housesAndRooms = housesAndRooms;
	}



	public int getEmpIds() {
		return empIds;
	}



	public void setEmpIds(int empIds) {
		this.empIds = empIds;
	}



	public int getSeridse() {
		return seridse;
	}



	public void setSeridse(int seridse) {
		this.seridse = seridse;
	}



	public String getSalespaceString() {
		return salespaceString;
	}



	public void setSalespaceString(String salespaceString) {
		this.salespaceString = salespaceString;
	}



	public String getSalenameString() {
		return salenameString;
	}



	public void setSalenameString(String salenameString) {
		this.salenameString = salenameString;
	}



	public String getSalenodeString() {
		return salenodeString;
	}



	public void setSalenodeString(String salenodeString) {
		this.salenodeString = salenodeString;
	}



	public String getStartpossition() {
		return startpossition;
	}



	public void setStartpossition(String startpossition) {
		this.startpossition = startpossition;
	}



	public String getEndpossition() {
		return endpossition;
	}



	public void setEndpossition(String endpossition) {
		this.endpossition = endpossition;
	}



	public void setUptimeString(String uptimeString) {
		this.uptimeString = uptimeString;
	}



	public String getDowntimeString() {
		return downtimeString;
	}



	public void setDowntimeString(String downtimeString) {
		this.downtimeString = downtimeString;
	}



	/** default constructor */
	public UpServer() {
	}
    
    

	public String getMarknum() {
		return marknum;
	}



	public void setMarknum(String marknum) {
		this.marknum = marknum;
	}



	public Cabinet getTupcabs() {
		return Tupcabs;
	}

	public void setTupcabs(Cabinet tupcabs) {
		Tupcabs = tupcabs;
	}

	/** full constructor */
	public UpServer(Integer parentId,SaleOrder saleOrder,Integer saleId, Product product, Employee employee,
			Timestamp uptime, Timestamp downtime, String maintenancePass,
			Integer bandwidthAmount, Integer bandwidthThrottling,
			Integer audtitingFlag, Integer upFlag, String upNo,
			Integer delflag,String serverIp,Integer ipnum,Customer customer,String serverLocation,String temp,String jhjname,String port,String jgh,Sale_orders soOrders) {
		this.parentId=parentId;
		this.saleOrder = saleOrder;
		this.product = product;
		this.employee = employee;
		this.uptime = uptime;
		this.downtime = downtime;
		this.maintenancePass = maintenancePass;
		this.bandwidthAmount = bandwidthAmount;
		this.bandwidthThrottling = bandwidthThrottling;
		this.audtitingFlag = audtitingFlag;
		this.upFlag = upFlag;
		this.upNo = upNo;
		this.delflag = delflag;
		this.serverIp=serverIp;
		this.ipnum=ipnum;
		this.customer=customer;
		this.serverLocation=serverLocation;
		this.temp=temp;
		this.jhjname=jhjname;
		this.port=port;
		this.jgh=jgh;
		this.saleId=saleId;
		this.soOrders = soOrders;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	
	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public SaleOrder getSaleOrder() {
		return this.saleOrder;
	}

	public void setSaleOrder(SaleOrder saleOrder) {
		this.saleOrder = saleOrder;
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

	public Timestamp getUptime() {
		return this.uptime;
	}

	public void setUptime(Timestamp uptime) {
		this.uptime = uptime;
	}

	public Timestamp getDowntime() {
		return this.downtime;
	}

	public void setDowntime(Timestamp downtime) {
		this.downtime = downtime;
	}

	public String getMaintenancePass() {
		return this.maintenancePass;
	}

	public void setMaintenancePass(String maintenancePass) {
		this.maintenancePass = maintenancePass;
	}

	public Integer getBandwidthAmount() {
		return this.bandwidthAmount;
	}

	public void setBandwidthAmount(Integer bandwidthAmount) {
		this.bandwidthAmount = bandwidthAmount;
	}

	public Integer getBandwidthThrottling() {
		return this.bandwidthThrottling;
	}

	public void setBandwidthThrottling(Integer bandwidthThrottling) {
		this.bandwidthThrottling = bandwidthThrottling;
	}

	public Integer getAudtitingFlag() {
		return this.audtitingFlag;
	}

	public void setAudtitingFlag(Integer audtitingFlag) {
		this.audtitingFlag = audtitingFlag;
	}

	public Integer getUpFlag() {
		return this.upFlag;
	}

	public void setUpFlag(Integer upFlag) {
		this.upFlag = upFlag;
	}

	public String getUpNo() {
		return this.upNo;
	}

	public void setUpNo(String upNo) {
		this.upNo = upNo;
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

	public Integer getIpnum() {
		return ipnum;
	}

	public void setIpnum(Integer ipnum) {
		this.ipnum = ipnum;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getServerLocation() {
		return serverLocation;
	}

	public void setServerLocation(String serverLocation) {
		this.serverLocation = serverLocation;
	}

	public String getJhjname() {
		return jhjname;
	}

	public void setJhjname(String jhjname) {
		this.jhjname = jhjname;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getJgh() {
		return jgh;
	}

	public void setJgh(String jgh) {
		this.jgh = jgh;
	}
	
	public Integer getSaleId() {
		return saleId;
	}

	public void setSaleId(Integer saleId) {
		this.saleId = saleId;
	}

	public String toString(){
		return "id"+","+upFlag+","+serverIp;
	}

	public Sale_orders getSoOrders() {
		return soOrders;
	}

	public void setSoOrders(Sale_orders soOrders) {
		this.soOrders = soOrders;
	}

//	public Integer getRemarks() {
//		return remarks;
//	}
//
//	public void setRemarks(Integer remarks) {
//		this.remarks = remarks;
//	}

	public ConkOut getConkout() {
		return conkout;
	}

	public void setConkout(ConkOut conkout) {
		this.conkout = conkout;
	}

	public Set getOperates() {
		return operates;
	}

	public void setOperates(Set operates) {
		this.operates = operates;
	}
	
}
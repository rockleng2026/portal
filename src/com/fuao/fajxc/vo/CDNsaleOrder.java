package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

public class CDNsaleOrder  implements java.io.Serializable{
	private Integer id;
	private String uuid;
	private String saleOrderNo;  //订单CDN编号
	private Customer  customer; //客户
	private Employee employee;  //员工
	private SetMeal setmeal;    //套餐
	private String time;       //申请时间
	private String starttime;  //开始运行时间
	private String endtime;   //结束运行时间
	private float price;     //实际价格
	private String delFlag;  //删除标记     0没有删除文件                    1为已经删除
	private String recordsNO; //备案号
	private String IPinterval;//IP区间数
	private String PVinterval;//PV区间数
	private String accessoryfile; //附件文件平均大小
	private String mostfile;	//多数文件平均大小
	private Integer writeflag; //写入文件标记  0没有写入，1已经写入
	private String cuRealmName;    //客户申请域名
	private String syRealmName;   //系统域名
	private String serverFlag;   //服务状态     2为关闭的       1为开启
	private String auditingState;  //审核状态
	private Set caches = new HashSet(0);
	private Set districts = new HashSet(0);
	private Set cdnips = new HashSet(0);
	
	
	public CDNsaleOrder(){
		
	}
	public CDNsaleOrder(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
	}
	
	public CDNsaleOrder(String uuid,String saleOrderNo,Customer customer,Employee employee,SetMeal setmeal,
			String time,String starttime,String endtime,float price,String delFlag,
			String recordsNO, String IPinterval, String PVinterval, String accessoryfile  ,String mostfile,
			Integer writeflag , String cuRealmName,String syRealmName,String serverFlag,
			String auditingState,Set caches, Set districts, Set cdnips){
		this.uuid=uuid;
		this.saleOrderNo=saleOrderNo;
		this.customer=customer;
		this.employee=employee;
		this.setmeal=setmeal;
		this.time=time;
		this.starttime=starttime;
		this.endtime=endtime;
		this.price=price;
		this.delFlag=delFlag;
		this.recordsNO=recordsNO;
		this.IPinterval=IPinterval;
		this.PVinterval=PVinterval;
		this.accessoryfile=accessoryfile;
		this.mostfile=mostfile;
		this.writeflag=writeflag;
		this.cuRealmName=cuRealmName;
		this.syRealmName=syRealmName;
		this.serverFlag=serverFlag;
		this.auditingState=auditingState;
		this.caches = caches;
		this.districts = districts;
		this.cdnips = cdnips;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getSaleOrderNo() {
		return saleOrderNo;
	}
	public void setSaleOrderNo(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public SetMeal getSetmeal() {
		return setmeal;
	}
	public void setSetmeal(SetMeal setmeal) {
		this.setmeal = setmeal;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	public String getRecordsNO() {
		return recordsNO;
	}
	public void setRecordsNO(String recordsNO) {
		this.recordsNO = recordsNO;
	}
	public String getIPinterval() {
		return IPinterval;
	}
	public void setIPinterval(String iPinterval) {
		this.IPinterval = iPinterval;
	}
	public String getPVinterval() {
		return PVinterval;
	}
	public void setPVinterval(String pVinterval) {
		this.PVinterval = pVinterval;
	}
	public String getAccessoryfile() {
		return accessoryfile;
	}
	public void setAccessoryfile(String accessoryfile) {
		this.accessoryfile = accessoryfile;
	}
	public String getMostfile() {
		return mostfile;
	}
	public void setMostfile(String mostfile) {
		this.mostfile = mostfile;
	}
	public Integer getWriteflag() {
		return writeflag;
	}
	public void setWriteflag(Integer writeflag) {
		this.writeflag = writeflag;
	}
	public String getCuRealmName() {
		return cuRealmName;
	}
	public void setCuRealmName(String cuRealmName) {
		this.cuRealmName = cuRealmName;
	}
	public String getSyRealmName() {
		return syRealmName;
	}
	public void setSyRealmName(String syRealmName) {
		this.syRealmName = syRealmName;
	}
	public String getServerFlag() {
		return serverFlag;
	}
	public void setServerFlag(String serverFlag) {
		this.serverFlag = serverFlag;
	}
	public String getAuditingState() {
		return auditingState;
	}
	public void setAuditingState(String auditingState) {
		this.auditingState = auditingState;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public Set getCaches() {
		return this.caches;
	}

	public void setCaches(Set caches) {
		this.caches = caches;
	}

	public Set getDistricts() {
		return this.districts;
	}

	public void setDistricts(Set districts) {
		this.districts = districts;
	}
	public Set getCdnips() {
		return this.cdnips;
	}

	public void setCdnips(Set cdnips) {
		this.cdnips = cdnips;
	}
	
	public Set getCDNsaleOrder() {
		return this.cdnips;
	}


}

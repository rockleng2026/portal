package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import com.ibm.icu.util.Currency;

/**
 * Sale_orders entity. @author MyEclipse Persistence Tools
 */

public class Sale_orders implements java.io.Serializable {

	// Fields 新订单

	private Integer soId;
	private String soNums; // 订单编号
	private Integer soStat;
	private Integer soCheckStat;
	private String soOrderTime;
	private Customer customer; // 客户
	private Questioncategory allTypeByOrdertype; // 类型
	private double sgPrice;// 价格
	private String sgDelivtype;// 送货方式
	private String sgAddress;// 送货地址
	private String sgLeave;// 客户留言
	private Integer count;//商品数量
	private Integer ipnum; // IP数量
	private String spaceSize; // 机位大小
	private Employee employee;// 代客操作人
	private double devilvprice;// 邮寄费用
	private Integer statchang;// 提交并审核或者直接提交标识
	private String divsg;//商品详情
	private double prices;//商品价格
	private Integer isDelivery; // 是否需要发货 0 1

	private Set saleGoods_midses = new HashSet(0);
	private Set upserver = new HashSet(0);
	private Set charge = new HashSet(0);
	private double meetPrice;// 应付
	private String spec;
	// Constructors

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	/** default constructor */
	public Sale_orders() {
	}

	/** full constructor */
	public Sale_orders(String soNums, Integer soStat, Integer soCheckStat,
			String soOrderTime, Set saleGoods_midses, Customer customer,
			double sgPrice, String sg_delivtype, String sg_address,
			String sgLeave, Integer ipnum, String spaceSize, double meetPrice,
			Employee employee, Questioncategory allTypeByOrdertype,
			double devilvprice,Integer statchang,String divsg,double prices) {
		this.soNums = soNums;
		this.soStat = soStat;
		this.soCheckStat = soCheckStat;
		this.soOrderTime = soOrderTime;
		this.saleGoods_midses = saleGoods_midses;
		this.customer = customer;
		this.sgPrice = sgPrice;
		this.sgDelivtype = sg_delivtype;
		this.sgAddress = sg_address;
		this.sgLeave = sgLeave;
		this.ipnum = ipnum;
		this.spaceSize = spaceSize;
		this.meetPrice = meetPrice;
		this.employee = employee;
		this.allTypeByOrdertype = allTypeByOrdertype;
		this.devilvprice = devilvprice;
		this.statchang = statchang;
		this.divsg = divsg;
		this.prices = prices;
	}

	// Property accessors

	public Integer getSoId() {
		return this.soId;
	}

	public void setSoId(Integer soId) {
		this.soId = soId;
	}

	public String getSoNums() {
		return this.soNums;
	}

	public void setSoNums(String soNums) {
		this.soNums = soNums;
	}

	public Integer getSoStat() {
		return this.soStat;
	}

	public void setSoStat(Integer soStat) {
		this.soStat = soStat;
	}

	public Integer getSoCheckStat() {
		return this.soCheckStat;
	}

	public void setSoCheckStat(Integer soCheckStat) {
		this.soCheckStat = soCheckStat;
	}

	public String getSoOrderTime() {
		return this.soOrderTime;
	}

	public void setSoOrderTime(String soOrderTime) {
		this.soOrderTime = soOrderTime;
	}

	public Set getSaleGoods_midses() {
		return this.saleGoods_midses;
	}

	public void setSaleGoods_midses(Set saleGoods_midses) {
		this.saleGoods_midses = saleGoods_midses;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public double getSgPrice() {
		return sgPrice;
	}

	public void setSgPrice(double sgPrice) {
		this.sgPrice = sgPrice;
	}

	public String getSgDelivtype() {
		return sgDelivtype;
	}

	public void setSgDelivtype(String sgDelivtype) {
		this.sgDelivtype = sgDelivtype;
	}

	public String getSgAddress() {
		return sgAddress;
	}

	public void setSgAddress(String sgAddress) {
		this.sgAddress = sgAddress;
	}

	public String getSgLeave() {
		return sgLeave;
	}

	public void setSgLeave(String sgLeave) {
		this.sgLeave = sgLeave;
	}

	public Set getUpserver() {
		return upserver;
	}

	public void setUpserver(Set upserver) {
		this.upserver = upserver;
	}

	public Integer getIpnum() {
		return ipnum;
	}

	public void setIpnum(Integer ipnum) {
		this.ipnum = ipnum;
	}

	public String getSpaceSize() {
		return spaceSize;
	}

	public void setSpaceSize(String spaceSize) {
		this.spaceSize = spaceSize;
	}

	public Set getCharge() {
		return charge;
	}

	public void setCharge(Set charge) {
		this.charge = charge;
	}

	public double getMeetPrice() {
		return meetPrice;
	}

	public void setMeetPrice(double meetPrice) {
		this.meetPrice = meetPrice;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Questioncategory getAllTypeByOrdertype() {
		return allTypeByOrdertype;
	}

	public void setAllTypeByOrdertype(Questioncategory allTypeByOrdertype) {
		this.allTypeByOrdertype = allTypeByOrdertype;
	}

	public double getDevilvprice() {
		return devilvprice;
	}

	public void setDevilvprice(double devilvprice) {
		this.devilvprice = devilvprice;
	}

	public Integer getStatchang() {
		return statchang;
	}

	public void setStatchang(Integer statchang) {
		this.statchang = statchang;
	}

	public String getDivsg() {
		return divsg;
	}

	public void setDivsg(String divsg) {
		this.divsg = divsg;
	}

	public double getPrices() {
		return prices;
	}

	public void setPrices(double prices) {
		this.prices = prices;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Integer getIsDelivery() {
		return isDelivery;
	}

	public void setIsDelivery(Integer isDelivery) {
		this.isDelivery = isDelivery;
	}
	
}
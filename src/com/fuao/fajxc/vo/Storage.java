package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Storage entity. @author MyEclipse Persistence Tools
 */

public class Storage implements java.io.Serializable {

	// Fields

	private Integer storageId;                           //入库ID
	private Depot depot;                                 //仓库
	private AllType allType;                             //入库类型
	private Employee employee;                           //入库员工
	private Customer customer;
	private String storageNo;                            //入库单号
	private Integer storageVerify;                       //入库审核
	private String storageDate;                          //入库时间
	private Double productPriceSum;                      //入库总价   
	private String delflag;                              //删除标记
	private String storageRemark;                        //备注
	private String identitys;                            //唯一的标识
	private Set<StorageInfo> storageInfos = new HashSet<StorageInfo>(0);

	// Constructors

	/** default constructor */
	public Storage() {
	}

	/** minimal constructor */
	public Storage(Depot depot, AllType allType, Employee employee,
			String storageNo, Integer storageVerify, String storageDate,Customer customer,String identitys) {
		this.depot = depot;
		this.allType = allType;
		this.employee = employee;
		this.storageNo = storageNo;
		this.storageVerify = storageVerify;
		this.storageDate = storageDate;
		this.customer=customer;
		this.identitys = identitys;
	}

	/** full constructor */
	public Storage(Depot depot, AllType allType, Employee employee,
			String storageNo, Integer storageVerify, String storageDate,
			Double productPriceSum, String delflag, String storageRemark,
			Set storageInfos,Customer customer) {
		this.depot = depot;
		this.allType = allType;
		this.employee = employee;
		this.storageNo = storageNo;
		this.storageVerify = storageVerify;
		this.storageDate = storageDate;
		this.productPriceSum = productPriceSum;
		this.delflag = delflag;
		this.storageRemark = storageRemark;
		this.storageInfos = storageInfos;
		this.customer=customer;
	}

	// Property accessors

	public Integer getStorageId() {
		return this.storageId;
	}

	public void setStorageId(Integer storageId) {
		this.storageId = storageId;
	}

	public Depot getDepot() {
		return this.depot;
	}

	public void setDepot(Depot depot) {
		this.depot = depot;
	}

	public AllType getAllType() {
		return this.allType;
	}

	public void setAllType(AllType allType) {
		this.allType = allType;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getStorageNo() {
		return this.storageNo;
	}

	public void setStorageNo(String storageNo) {
		this.storageNo = storageNo;
	}

	public Integer getStorageVerify() {
		return this.storageVerify;
	}

	public void setStorageVerify(Integer storageVerify) {
		this.storageVerify = storageVerify;
	}

	public String getStorageDate() {
		return this.storageDate;
	}

	public void setStorageDate(String storageDate) {
		this.storageDate = storageDate;
	}

	public Double getProductPriceSum() {
		return this.productPriceSum;
	}

	public void setProductPriceSum(Double productPriceSum) {
		this.productPriceSum = productPriceSum;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	public String getStorageRemark() {
		return this.storageRemark;
	}

	public void setStorageRemark(String storageRemark) {
		this.storageRemark = storageRemark;
	}

	public Set<StorageInfo> getStorageInfos() {
		return this.storageInfos;
	}

	public void setStorageInfos(Set<StorageInfo> storageInfos) {
		this.storageInfos = storageInfos;
	}

	public String getIdentitys() {
		return identitys;
	}

	public void setIdentitys(String identitys) {
		this.identitys = identitys;
	}
	
}
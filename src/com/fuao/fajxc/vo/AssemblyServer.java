package com.fuao.fajxc.vo;

import java.sql.Timestamp;

/**
 * AssemblyServer entity. @author MyEclipse Persistence Tools
 */

public class AssemblyServer implements java.io.Serializable {

	// Fields

	private Integer id;
	private Product productByNetworkCardId;
	private Product productByMainBoardId;
	private Depot depot;
	private Product productByPowerId;
	private Model model;
	private Product productByServerId;
	private Employee employee;
	private Product productByCpuId;
	private Product productByCrateId;
	private Product productByHdId;
	private Product productByMemoryId;
	private String remark;
	private Integer delflag;
	private String assemblyNo;
	private Timestamp atime;

	// Constructors

	/** default constructor */
	public AssemblyServer() {
	}

	/** full constructor */
	public AssemblyServer(Product productByNetworkCardId,
			Product productByMainBoardId, Depot depot,
			Product productByPowerId, Model model, Product productByServerId,
			Employee employee, Product productByCpuId,
			Product productByCrateId, Product productByHdId,
			Product productByMemoryId, String remark, Integer delflag,
			String assemblyNo, Timestamp atime) {
		this.productByNetworkCardId = productByNetworkCardId;
		this.productByMainBoardId = productByMainBoardId;
		this.depot = depot;
		this.productByPowerId = productByPowerId;
		this.model = model;
		this.productByServerId = productByServerId;
		this.employee = employee;
		this.productByCpuId = productByCpuId;
		this.productByCrateId = productByCrateId;
		this.productByHdId = productByHdId;
		this.productByMemoryId = productByMemoryId;
		this.remark = remark;
		this.delflag = delflag;
		this.assemblyNo = assemblyNo;
		this.atime = atime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Product getProductByNetworkCardId() {
		return this.productByNetworkCardId;
	}

	public void setProductByNetworkCardId(Product productByNetworkCardId) {
		this.productByNetworkCardId = productByNetworkCardId;
	}

	public Product getProductByMainBoardId() {
		return this.productByMainBoardId;
	}

	public void setProductByMainBoardId(Product productByMainBoardId) {
		this.productByMainBoardId = productByMainBoardId;
	}

	public Depot getDepot() {
		return this.depot;
	}

	public void setDepot(Depot depot) {
		this.depot = depot;
	}

	public Product getProductByPowerId() {
		return this.productByPowerId;
	}

	public void setProductByPowerId(Product productByPowerId) {
		this.productByPowerId = productByPowerId;
	}

	public Model getModel() {
		return this.model;
	}

	public void setModel(Model model) {
		this.model = model;
	}

	public Product getProductByServerId() {
		return this.productByServerId;
	}

	public void setProductByServerId(Product productByServerId) {
		this.productByServerId = productByServerId;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Product getProductByCpuId() {
		return this.productByCpuId;
	}

	public void setProductByCpuId(Product productByCpuId) {
		this.productByCpuId = productByCpuId;
	}

	public Product getProductByCrateId() {
		return this.productByCrateId;
	}

	public void setProductByCrateId(Product productByCrateId) {
		this.productByCrateId = productByCrateId;
	}

	public Product getProductByHdId() {
		return this.productByHdId;
	}

	public void setProductByHdId(Product productByHdId) {
		this.productByHdId = productByHdId;
	}

	public Product getProductByMemoryId() {
		return this.productByMemoryId;
	}

	public void setProductByMemoryId(Product productByMemoryId) {
		this.productByMemoryId = productByMemoryId;
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

	public String getAssemblyNo() {
		return this.assemblyNo;
	}

	public void setAssemblyNo(String assemblyNo) {
		this.assemblyNo = assemblyNo;
	}

	public Timestamp getAtime() {
		return this.atime;
	}

	public void setAtime(Timestamp atime) {
		this.atime = atime;
	}

}
package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Product entity. @author MyEclipse Persistence Tools
 */

public class Product implements java.io.Serializable {

	// Fields 产品表

	private Integer id;  //产品id
	private Depot depot;  ///仓库
	private StorageInfo storageInfo; // 入库详细
	private Property property;                            //属性Id(属性表)
	private String barcode;   //条形码
	private Integer useSum;   //使用次数
	private Integer usestate;  //使用状态（1.使用2.未使用3.已实际出库4.上架）
	private Integer parentId;  
	private String delflag;  //删除标记
	private Customer tmp;
	private String tmp1;
	private String tmp2;
	private String tmp3;
	private Integer isfreeze;
	private Set assemblyServersForMemoryId = new HashSet(0);
	private Set upServers = new HashSet(0);
	private Set ruinInfos = new HashSet(0);
	private Set assemblyServersForHdId = new HashSet(0);
	private Set assemblyServersForCpuId = new HashSet(0);
	private Set assemblyServersForPowerId = new HashSet(0);
	private Set assemblyServersForCrateId = new HashSet(0);
	private Set assemblyServersForNetworkCardId = new HashSet(0);
	private Set downServers = new HashSet(0);
	private Set assemblyServersForMainBoardId = new HashSet(0);
	private Set assemblyServersForServerId = new HashSet(0);
	private Set outboundInfos = new HashSet(0);
	private Set serverMonitors = new HashSet(0);
	private Set conkouts = new HashSet(0);
	private Set tresourceCheck = new HashSet(0);

	// Constructors

	/** default constructor */
	public Product() {
	}

	/** minimal constructor */
	public Product(Property property, String barcode) {
		this.property = property;
		this.barcode = barcode;
	}

	/** full constructor */
	public Product(Depot depot, StorageInfo storageInfo, Property property,
			String barcode, Integer useSum, Integer usestate, Integer parentId,
			String delflag, Customer tmp, String tmp1, String tmp2, String tmp3,
			Integer isfreeze,Set assemblyServersForMemoryId, Set upServers, Set ruinInfos,
			Set assemblyServersForHdId, Set assemblyServersForCpuId,
			Set assemblyServersForPowerId, Set assemblyServersForCrateId,
			Set assemblyServersForNetworkCardId, Set downServers,
			Set assemblyServersForMainBoardId, Set assemblyServersForServerId,
			Set outboundInfos, Set serverMonitors,Set conkouts) {
		this.depot = depot;
		this.storageInfo = storageInfo;
		this.property = property;
		this.barcode = barcode;
		this.useSum = useSum;
		this.usestate = usestate;
		this.parentId = parentId;
		this.delflag = delflag;
		this.tmp = tmp;
		this.tmp1 = tmp1;
		this.tmp2 = tmp2;
		this.tmp3 = tmp3;
		this.isfreeze = isfreeze;
		this.assemblyServersForMemoryId = assemblyServersForMemoryId;
		this.upServers = upServers;
		this.ruinInfos = ruinInfos;
		this.assemblyServersForHdId = assemblyServersForHdId;
		this.assemblyServersForCpuId = assemblyServersForCpuId;
		this.assemblyServersForPowerId = assemblyServersForPowerId;
		this.assemblyServersForCrateId = assemblyServersForCrateId;
		this.assemblyServersForNetworkCardId = assemblyServersForNetworkCardId;
		this.downServers = downServers;
		this.assemblyServersForMainBoardId = assemblyServersForMainBoardId;
		this.assemblyServersForServerId = assemblyServersForServerId;
		this.outboundInfos = outboundInfos;
		this.serverMonitors = serverMonitors;
		this.conkouts=conkouts;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Depot getDepot() {
		return this.depot;
	}

	public void setDepot(Depot depot) {
		this.depot = depot;
	}

	public StorageInfo getStorageInfo() {
		return this.storageInfo;
	}

	public void setStorageInfo(StorageInfo storageInfo) {
		this.storageInfo = storageInfo;
	}

	public Property getProperty() {
		return this.property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	public String getBarcode() {
		return this.barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}

	public Integer getUseSum() {
		return this.useSum;
	}

	public void setUseSum(Integer useSum) {
		this.useSum = useSum;
	}

	public Integer getUsestate() {
		return this.usestate;
	}

	public void setUsestate(Integer usestate) {
		this.usestate = usestate;
	}

	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getDelflag() {
		return this.delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}


	public Customer getTmp() {
		return tmp;
	}

	public void setTmp(Customer tmp) {
		this.tmp = tmp;
	}

	public String getTmp1() {
		return tmp1;
	}

	public void setTmp1(String tmp1) {
		this.tmp1 = tmp1;
	}

	public String getTmp2() {
		return this.tmp2;
	}

	public void setTmp2(String tmp2) {
		this.tmp2 = tmp2;
	}

	public String getTmp3() {
		return this.tmp3;
	}

	public void setTmp3(String tmp3) {
		this.tmp3 = tmp3;
	}

	public Set getAssemblyServersForMemoryId() {
		return this.assemblyServersForMemoryId;
	}

	public void setAssemblyServersForMemoryId(Set assemblyServersForMemoryId) {
		this.assemblyServersForMemoryId = assemblyServersForMemoryId;
	}

	public Set getUpServers() {
		return this.upServers;
	}

	public void setUpServers(Set upServers) {
		this.upServers = upServers;
	}

	public Set getRuinInfos() {
		return this.ruinInfos;
	}

	public void setRuinInfos(Set ruinInfos) {
		this.ruinInfos = ruinInfos;
	}

	public Set getAssemblyServersForHdId() {
		return this.assemblyServersForHdId;
	}

	public void setAssemblyServersForHdId(Set assemblyServersForHdId) {
		this.assemblyServersForHdId = assemblyServersForHdId;
	}

	public Set getAssemblyServersForCpuId() {
		return this.assemblyServersForCpuId;
	}

	public void setAssemblyServersForCpuId(Set assemblyServersForCpuId) {
		this.assemblyServersForCpuId = assemblyServersForCpuId;
	}

	public Set getAssemblyServersForPowerId() {
		return this.assemblyServersForPowerId;
	}

	public void setAssemblyServersForPowerId(Set assemblyServersForPowerId) {
		this.assemblyServersForPowerId = assemblyServersForPowerId;
	}

	public Set getAssemblyServersForCrateId() {
		return this.assemblyServersForCrateId;
	}

	public void setAssemblyServersForCrateId(Set assemblyServersForCrateId) {
		this.assemblyServersForCrateId = assemblyServersForCrateId;
	}

	public Set getAssemblyServersForNetworkCardId() {
		return this.assemblyServersForNetworkCardId;
	}

	public void setAssemblyServersForNetworkCardId(
			Set assemblyServersForNetworkCardId) {
		this.assemblyServersForNetworkCardId = assemblyServersForNetworkCardId;
	}

	public Set getDownServers() {
		return this.downServers;
	}

	public void setDownServers(Set downServers) {
		this.downServers = downServers;
	}

	public Set getAssemblyServersForMainBoardId() {
		return this.assemblyServersForMainBoardId;
	}

	public void setAssemblyServersForMainBoardId(
			Set assemblyServersForMainBoardId) {
		this.assemblyServersForMainBoardId = assemblyServersForMainBoardId;
	}

	public Set getAssemblyServersForServerId() {
		return this.assemblyServersForServerId;
	}

	public void setAssemblyServersForServerId(Set assemblyServersForServerId) {
		this.assemblyServersForServerId = assemblyServersForServerId;
	}

	public Set getOutboundInfos() {
		return this.outboundInfos;
	}

	public void setOutboundInfos(Set outboundInfos) {
		this.outboundInfos = outboundInfos;
	}

	public Set getServerMonitors() {
		return this.serverMonitors;
	}

	public void setServerMonitors(Set serverMonitors) {
		this.serverMonitors = serverMonitors;
	}

	public Set getConkouts() {
		return conkouts;
	}

	public void setConkouts(Set conkouts) {
		this.conkouts = conkouts;
	}

	public Set getTresourceCheck() {
		return tresourceCheck;
	}

	public void setTresourceCheck(Set tresourceCheck) {
		this.tresourceCheck = tresourceCheck;
	}

	public Integer getIsfreeze() {
		return isfreeze;
	}

	public void setIsfreeze(Integer isfreeze) {
		this.isfreeze = isfreeze;
	}
	

}
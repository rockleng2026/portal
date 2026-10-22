package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Employee entity. @author MyEclipse Persistence Tools
 */

public class Employee implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 6887785842836256251L;
	private Integer id;
	private String uuid;
	private Department department;
	private String name;
	private Integer age;
	private Integer sex;
	private String cardid;
	private String time;
	private String education;
	private String tel;
	private String birth;
	private Integer delflag;
	private String empNo;
	private Integer isLoginAccount;
	private String nation;
	private String health;
	private String stature;
	private String heft;
	private String married;
	private String censusreg;
	private String engleve;
	private String place;
	private String nowplace;
	private String urgenttel;
	private String specialty;
	private String computeleve;
	private String email;
	private String msqk;
	private String jtcy;
	private String isqj;
	private Groups groups;
	private Workposition workposition;
	private Integer isLeave;
	private String leaveReason;
	private String entryTime;
	private String leaveTime;
	private String photo;
	private Double approvemoney; // 审批最大金额
	
	private EmployeeGrade empgrade;
	
	private Set assemblyServers = new HashSet(0);
	private Set customerCommodities = new HashSet(0);
	private Set conkOuts = new HashSet(0);
	private Set outbounds = new HashSet(0);
	private Set depots = new HashSet(0);
	private Set returnOrders = new HashSet(0);
	private Set purOrders = new HashSet(0);
	private Set refundmentLogsForEmpId = new HashSet(0);
	private Set priceregulations = new HashSet(0);
	private Set toOrders = new HashSet(0);
	private Set downServers = new HashSet(0);
	private Set customerMovesForOldPrincipal = new HashSet(0);
	private Set auditingOrderTabs = new HashSet(0);
	private Set paymentLogs = new HashSet(0);
	private Set refundmentLogsForApprovePresonId = new HashSet(0);
	private Set applyBuiesForApproveEmp = new HashSet(0);
	private Set storages = new HashSet(0);
	private Set serverMonitors = new HashSet(0);
	private Set departments = new HashSet(0);
	private Set customerMovesForNewPrincipal = new HashSet(0);
	private Set customers = new HashSet(0);
	private Set stats = new HashSet(0);
	private Set incomes = new HashSet(0);
	private Set ruins = new HashSet(0);
	private Set commodityTpyes = new HashSet(0);
	private Set saleOrders = new HashSet(0);
	private Set renewLogs = new HashSet(0);
	private Set customerAuditings = new HashSet(0);
	private Set chargesForEmployeeId = new HashSet(0);
	private Set upServers = new HashSet(0);
	private Set refundmentLogsForFinancingId = new HashSet(0);
	private Set applyBuiesForEmployeeId = new HashSet(0);
	private Set chargesForEmpId = new HashSet(0);
	private Set intentFollowUps = new HashSet(0);
	private Set conkoutsForEmpTakeId = new HashSet(0);
	private Set conkoutsForEmpId = new HashSet(0);
	private Set missionEmps = new HashSet(0);
	private Set missions = new HashSet(0);
	private Set employeeFjfbs = new HashSet(0);
	private Set projectemp = new HashSet(0);
	private Set newparticipator = new HashSet(0);
	private Set newproblem = new HashSet(0);
	 private Set examscores = new HashSet(0);
	 private Set examtabscores = new HashSet(0);
	 private Set exampapers = new HashSet(0);
	 private Set task=new HashSet(); // newtask
	 private Set newqusetion = new HashSet(0);
	 private Set scheduleplan = new HashSet(0);
	 

	 private Set functionrecord1=new HashSet();
	 private Set functionrecord2=new HashSet();
	 
	 private Set newprjtresource1 = new HashSet();
	 private Set newprjtresource = new HashSet();
	 
	 private Set tresourceCheck = new HashSet(0);
	 private Set tresourceCheck1 = new HashSet(0);
	 private Set paymentlogs = new HashSet(0);
	 
	 private Set sg = new HashSet(0);//新订单表sale_orders
	// Constructors

	public Set getExamscores() {
		return examscores;
	}

	public void setExamscores(Set examscores) {
		this.examscores = examscores;
	}

	public Set getExamtabscores() {
		return examtabscores;
	}

	public void setExamtabscores(Set examtabscores) {
		this.examtabscores = examtabscores;
	}

	public Set getExampapers() {
		return exampapers;
	}

	public void setExampapers(Set exampapers) {
		this.exampapers = exampapers;
	}

	public Set getMissions() {
		return missions;
	}

	public Set getProjectemp() {
		return projectemp;
	}

	public void setProjectemp(Set projectemp) {
		this.projectemp = projectemp;
	}

	public void setMissions(Set missions) {
		this.missions = missions;
	}

	/** default constructor */
	public Employee() {
	}

	public Employee(Integer id) {
		super();
		this.id = id;
	}

	/** full constructor */
	public Employee(String uuid, Department department, String name, Integer age,
			Integer sex, String cardid, String time, String education,
			String tel, String birth, Integer delflag, String empNo,
			Integer isLoginAccount, String nation, String health,
			String stature, String heft, String married, String censusreg,
			String engleve, String place, String nowplace, String urgenttel,
			String specialty, String computeleve, String msqk, String jtcy, Integer isLeave, 
			String leaveReason, String entryTime, String leaveTime, Groups groups, Set assemblyServers,
			Set customerCommodities, Set conkOuts, Set outbounds, Set depots,
			Set returnOrders, Set purOrders, Set refundmentLogsForEmpId,
			Set priceregulations, Set toOrders, Set downServers,
			Set customerMovesForOldPrincipal, Set auditingOrderTabs,
			Set paymentLogs, Set refundmentLogsForApprovePresonId,
			Set applyBuiesForApproveEmp, Set storages, Set serverMonitors,
			Set departments, Set customerMovesForNewPrincipal, Set customers,
			Set stats, Set incomes, Set ruins, Set commodityTpyes,
			Set saleOrders, Set renewLogs, Set customerAuditings,
			Set chargesForEmployeeId, Set upServers,
			Set refundmentLogsForFinancingId, Set applyBuiesForEmployeeId,
			Set chargesForEmpId, Set intentFollowUps,Set conkoutsForEmpTakeId,
			Set conkoutsForEmpId, Set employeeFjfbs,Set newparticipator,Set newproblem) {
		this.uuid = uuid;
		this.department = department;
		this.name = name;
		this.age = age;
		this.sex = sex;
		this.cardid = cardid;
		this.time = time;
		this.education = education;
		this.tel = tel;
		this.birth = birth;
		this.delflag = delflag;
		this.empNo = empNo;
		this.isLoginAccount = isLoginAccount;
		this.nation = nation;
		this.health = health;
		this.stature = stature;
		this.heft = heft;
		this.married = married;
		this.censusreg = censusreg;
		this.engleve = engleve;
		this.place = place;
		this.nowplace = nowplace;
		this.urgenttel = urgenttel;
		this.specialty = specialty;
		this.computeleve = computeleve;
		this.jtcy = jtcy;
		this.msqk = msqk;
		this.groups = groups;
		this.isLeave = isLeave;
		this.leaveReason = leaveReason;
		this.entryTime = entryTime;
		this.leaveTime = leaveTime;
		this.assemblyServers = assemblyServers;
		this.customerCommodities = customerCommodities;
		this.conkOuts = conkOuts;
		this.outbounds = outbounds;
		this.depots = depots;
		this.returnOrders = returnOrders;
		this.purOrders = purOrders;
		this.refundmentLogsForEmpId = refundmentLogsForEmpId;
		this.priceregulations = priceregulations;
		this.toOrders = toOrders;
		this.downServers = downServers;
		this.customerMovesForOldPrincipal = customerMovesForOldPrincipal;
		this.auditingOrderTabs = auditingOrderTabs;
		this.paymentLogs = paymentLogs;
		this.refundmentLogsForApprovePresonId = refundmentLogsForApprovePresonId;
		this.applyBuiesForApproveEmp = applyBuiesForApproveEmp;
		this.storages = storages;
		this.serverMonitors = serverMonitors;
		this.departments = departments;
		this.customerMovesForNewPrincipal = customerMovesForNewPrincipal;
		this.customers = customers;
		this.stats = stats;
		this.incomes = incomes;
		this.ruins = ruins;
		this.commodityTpyes = commodityTpyes;
		this.saleOrders = saleOrders;
		this.renewLogs = renewLogs;
		this.customerAuditings = customerAuditings;
		this.chargesForEmployeeId = chargesForEmployeeId;
		this.upServers = upServers;
		this.refundmentLogsForFinancingId = refundmentLogsForFinancingId;
		this.applyBuiesForEmployeeId = applyBuiesForEmployeeId;
		this.chargesForEmpId = chargesForEmpId;
		this.intentFollowUps = intentFollowUps;
		this.conkoutsForEmpId=conkoutsForEmpId;
		this.conkoutsForEmpTakeId=conkoutsForEmpTakeId;
		this.employeeFjfbs = employeeFjfbs;
		this.newparticipator = newparticipator;
		this.newproblem =  newproblem;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Department getDepartment() {
		return this.department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getAge() {
		return this.age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public Integer getSex() {
		return this.sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getCardid() {
		return this.cardid;
	}

	public void setCardid(String cardid) {
		this.cardid = cardid;
	}

	public String getIsqj() {
		return isqj;
	}

	public void setIsqj(String isqj) {
		this.isqj = isqj;
	}

	public String getTime() {
		return this.time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getEducation() {
		return this.education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getTel() {
		return this.tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getBirth() {
		return this.birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public String getEmpNo() {
		return this.empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public Integer getIsLoginAccount() {
		return this.isLoginAccount;
	}

	public void setIsLoginAccount(Integer isLoginAccount) {
		this.isLoginAccount = isLoginAccount;
	}

	public String getNation() {
		return this.nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getHealth() {
		return this.health;
	}

	public void setHealth(String health) {
		this.health = health;
	}

	public String getStature() {
		return this.stature;
	}

	public void setStature(String stature) {
		this.stature = stature;
	}

	public String getHeft() {
		return this.heft;
	}

	public void setHeft(String heft) {
		this.heft = heft;
	}

	public String getMarried() {
		return this.married;
	}

	public void setMarried(String married) {
		this.married = married;
	}

	public String getCensusreg() {
		return this.censusreg;
	}

	public void setCensusreg(String censusreg) {
		this.censusreg = censusreg;
	}

	public String getEngleve() {
		return this.engleve;
	}

	public void setEngleve(String engleve) {
		this.engleve = engleve;
	}

	public String getPlace() {
		return this.place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getNowplace() {
		return this.nowplace;
	}

	public void setNowplace(String nowplace) {
		this.nowplace = nowplace;
	}

	public String getUrgenttel() {
		return this.urgenttel;
	}

	public void setUrgenttel(String urgenttel) {
		this.urgenttel = urgenttel;
	}

	public String getSpecialty() {
		return this.specialty;
	}

	public void setSpecialty(String specialty) {
		this.specialty = specialty;
	}

	public String getComputeleve() {
		return this.computeleve;
	}

	public void setComputeleve(String computeleve) {
		this.computeleve = computeleve;
	}

	public Set getAssemblyServers() {
		return this.assemblyServers;
	}

	public void setAssemblyServers(Set assemblyServers) {
		this.assemblyServers = assemblyServers;
	}

	public Set getCustomerCommodities() {
		return this.customerCommodities;
	}

	public void setCustomerCommodities(Set customerCommodities) {
		this.customerCommodities = customerCommodities;
	}

	public Set getConkOuts() {
		return this.conkOuts;
	}

	public void setConkOuts(Set conkOuts) {
		this.conkOuts = conkOuts;
	}

	public Set getOutbounds() {
		return this.outbounds;
	}

	public void setOutbounds(Set outbounds) {
		this.outbounds = outbounds;
	}

	public Set getDepots() {
		return this.depots;
	}

	public void setDepots(Set depots) {
		this.depots = depots;
	}

	public Set getReturnOrders() {
		return this.returnOrders;
	}

	public void setReturnOrders(Set returnOrders) {
		this.returnOrders = returnOrders;
	}

	public Set getPurOrders() {
		return this.purOrders;
	}

	public void setPurOrders(Set purOrders) {
		this.purOrders = purOrders;
	}

	public Set getRefundmentLogsForEmpId() {
		return this.refundmentLogsForEmpId;
	}

	public void setRefundmentLogsForEmpId(Set refundmentLogsForEmpId) {
		this.refundmentLogsForEmpId = refundmentLogsForEmpId;
	}

	public Set getPriceregulations() {
		return this.priceregulations;
	}

	public void setPriceregulations(Set priceregulations) {
		this.priceregulations = priceregulations;
	}

	public Set getToOrders() {
		return this.toOrders;
	}

	public void setToOrders(Set toOrders) {
		this.toOrders = toOrders;
	}

	public Set getDownServers() {
		return this.downServers;
	}

	public void setDownServers(Set downServers) {
		this.downServers = downServers;
	}

	public Set getCustomerMovesForOldPrincipal() {
		return this.customerMovesForOldPrincipal;
	}

	public void setCustomerMovesForOldPrincipal(Set customerMovesForOldPrincipal) {
		this.customerMovesForOldPrincipal = customerMovesForOldPrincipal;
	}

	public Set getAuditingOrderTabs() {
		return this.auditingOrderTabs;
	}

	public void setAuditingOrderTabs(Set auditingOrderTabs) {
		this.auditingOrderTabs = auditingOrderTabs;
	}

	public Set getPaymentLogs() {
		return this.paymentLogs;
	}

	public void setPaymentLogs(Set paymentLogs) {
		this.paymentLogs = paymentLogs;
	}

	public Set getRefundmentLogsForApprovePresonId() {
		return this.refundmentLogsForApprovePresonId;
	}

	public void setRefundmentLogsForApprovePresonId(
			Set refundmentLogsForApprovePresonId) {
		this.refundmentLogsForApprovePresonId = refundmentLogsForApprovePresonId;
	}

	public Set getApplyBuiesForApproveEmp() {
		return this.applyBuiesForApproveEmp;
	}

	public void setApplyBuiesForApproveEmp(Set applyBuiesForApproveEmp) {
		this.applyBuiesForApproveEmp = applyBuiesForApproveEmp;
	}

	public Set getStorages() {
		return this.storages;
	}

	public void setStorages(Set storages) {
		this.storages = storages;
	}

	public Set getServerMonitors() {
		return this.serverMonitors;
	}

	public void setServerMonitors(Set serverMonitors) {
		this.serverMonitors = serverMonitors;
	}

	public Set getDepartments() {
		return this.departments;
	}

	public void setDepartments(Set departments) {
		this.departments = departments;
	}

	public Set getCustomerMovesForNewPrincipal() {
		return this.customerMovesForNewPrincipal;
	}

	public void setCustomerMovesForNewPrincipal(Set customerMovesForNewPrincipal) {
		this.customerMovesForNewPrincipal = customerMovesForNewPrincipal;
	}

	public Set getCustomers() {
		return this.customers;
	}

	public void setCustomers(Set customers) {
		this.customers = customers;
	}

	public Set getStats() {
		return this.stats;
	}

	public void setStats(Set stats) {
		this.stats = stats;
	}

	public Set getIncomes() {
		return this.incomes;
	}

	public void setIncomes(Set incomes) {
		this.incomes = incomes;
	}

	public Set getRuins() {
		return this.ruins;
	}

	public void setRuins(Set ruins) {
		this.ruins = ruins;
	}

	public Set getCommodityTpyes() {
		return this.commodityTpyes;
	}

	public void setCommodityTpyes(Set commodityTpyes) {
		this.commodityTpyes = commodityTpyes;
	}

	public Set getSaleOrders() {
		return this.saleOrders;
	}

	public void setSaleOrders(Set saleOrders) {
		this.saleOrders = saleOrders;
	}

	public Set getRenewLogs() {
		return this.renewLogs;
	}

	public void setRenewLogs(Set renewLogs) {
		this.renewLogs = renewLogs;
	}

	public Set getCustomerAuditings() {
		return this.customerAuditings;
	}

	public void setCustomerAuditings(Set customerAuditings) {
		this.customerAuditings = customerAuditings;
	}

	public Set getChargesForEmployeeId() {
		return this.chargesForEmployeeId;
	}

	public void setChargesForEmployeeId(Set chargesForEmployeeId) {
		this.chargesForEmployeeId = chargesForEmployeeId;
	}

	public Set getUpServers() {
		return this.upServers;
	}

	public void setUpServers(Set upServers) {
		this.upServers = upServers;
	}

	public Set getRefundmentLogsForFinancingId() {
		return this.refundmentLogsForFinancingId;
	}

	public void setRefundmentLogsForFinancingId(Set refundmentLogsForFinancingId) {
		this.refundmentLogsForFinancingId = refundmentLogsForFinancingId;
	}

	public Set getApplyBuiesForEmployeeId() {
		return this.applyBuiesForEmployeeId;
	}

	public void setApplyBuiesForEmployeeId(Set applyBuiesForEmployeeId) {
		this.applyBuiesForEmployeeId = applyBuiesForEmployeeId;
	}

	public Set getChargesForEmpId() {
		return this.chargesForEmpId;
	}

	public void setChargesForEmpId(Set chargesForEmpId) {
		this.chargesForEmpId = chargesForEmpId;
	}

	public Set getIntentFollowUps() {
		return this.intentFollowUps;
	}

	public void setIntentFollowUps(Set intentFollowUps) {
		this.intentFollowUps = intentFollowUps;
	}

	public Set getConkoutsForEmpTakeId() {
		return conkoutsForEmpTakeId;
	}

	public void setConkoutsForEmpTakeId(Set conkoutsForEmpTakeId) {
		this.conkoutsForEmpTakeId = conkoutsForEmpTakeId;
	}

	public Set getConkoutsForEmpId() {
		return conkoutsForEmpId;
	}

	public void setConkoutsForEmpId(Set conkoutsForEmpId) {
		this.conkoutsForEmpId = conkoutsForEmpId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMsqk() {
		return msqk;
	}

	public void setMsqk(String msqk) {
		this.msqk = msqk;
	}

	public String getJtcy() {
		return jtcy;
	}

	public void setJtcy(String jtcy) {
		this.jtcy = jtcy;
	}
	


	public Groups getGroups() {
		return groups;
	}

	public void setGroups(Groups groups) {
		this.groups = groups;
	}

	public Set getMissionEmps() {
		return missionEmps;
	}

	public void setMissionEmps(Set missionEmps) {
		this.missionEmps = missionEmps;
	}

	public Set getEmployeeFjfbs() {
		return employeeFjfbs;
	}

	public void setEmployeeFjfbs(Set employeeFjfbs) {
		this.employeeFjfbs = employeeFjfbs;
	}

	public Integer getIsLeave() {
		return isLeave;
	}

	public void setIsLeave(Integer isLeave) {
		this.isLeave = isLeave;
	}

	public String getLeaveReason() {
		return leaveReason;
	}

	public void setLeaveReason(String leaveReason) {
		this.leaveReason = leaveReason;
	}

	public String getEntryTime() {
		return entryTime;
	}

	public void setEntryTime(String entryTime) {
		this.entryTime = entryTime;
	}

	public String getLeaveTime() {
		return leaveTime;
	}

	public void setLeaveTime(String leaveTime) {
		this.leaveTime = leaveTime;
	}

	public Workposition getWorkposition() {
		return workposition;
	}

	public void setWorkposition(Workposition workposition) {
		this.workposition = workposition;
	}

	public Set getNewparticipator() {
		return newparticipator;
	}

	public void setNewparticipator(Set newparticipator) {
		this.newparticipator = newparticipator;
	}

	public Set getNewproblem() {
		return newproblem;
	}

	public void setNewproblem(Set newproblem) {
		this.newproblem = newproblem;
	}

	public Set getTask() {
		return task;
	}

	public void setTask(Set task) {
		this.task = task;
	}

	public Set getNewqusetion() {
		return newqusetion;
	}

	public void setNewqusetion(Set newqusetion) {
		this.newqusetion = newqusetion;
	}

	public Set getScheduleplan() {
		return scheduleplan;
	}

	public void setScheduleplan(Set scheduleplan) {
		this.scheduleplan = scheduleplan;
	}
	public Set getFunctionrecord1() {
		return functionrecord1;
	}

	public void setFunctionrecord1(Set functionrecord1) {
		this.functionrecord1 = functionrecord1;
	}

	public Set getFunctionrecord2() {
		return functionrecord2;
	}

	public void setFunctionrecord2(Set functionrecord2) {
		this.functionrecord2 = functionrecord2;
	}

	public Double getApprovemoney() {
		return approvemoney;
	}

	public void setApprovemoney(Double approvemoney) {
		this.approvemoney = approvemoney;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Set getNewprjtresource1() {
		return newprjtresource1;
	}

	public void setNewprjtresource1(Set newprjtresource1) {
		this.newprjtresource1 = newprjtresource1;
	}

	public Set getNewprjtresource() {
		return newprjtresource;
	}

	public void setNewprjtresource(Set newprjtresource) {
		this.newprjtresource = newprjtresource;
	}
	public EmployeeGrade getEmpgrade() {
		return empgrade;
	}

	public void setEmpgrade(EmployeeGrade empgrade) {
		this.empgrade = empgrade;
	}

	public Set getTresourceCheck() {
		return tresourceCheck;
	}

	public void setTresourceCheck(Set tresourceCheck) {
		this.tresourceCheck = tresourceCheck;
	}

	public Set getTresourceCheck1() {
		return tresourceCheck1;
	}

	public void setTresourceCheck1(Set tresourceCheck1) {
		this.tresourceCheck1 = tresourceCheck1;
	}

	public Set getPaymentlogs() {
		return paymentlogs;
	}

	public void setPaymentlogs(Set paymentlogs) {
		this.paymentlogs = paymentlogs;
	}

	public Set getSg() {
		return sg;
	}

	public void setSg(Set sg) {
		this.sg = sg;
	}
}
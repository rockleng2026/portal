package com.fuao.fajxc.vo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class NewProject implements java.io.Serializable{
	/**
	 *    项目表
	 */
	private Integer id; 
	private String projectname; //项目名称
	private Integer schedule; //进度
	private String launcher; //发起人
	private Date begintime; //开始时间
	private Date endtime; //结束时间
	private String projectinfo; //项目描述
	private Integer approver; //审批人
	private Integer projectstatus;//状态
	private Double money; // 项目金额
	private Set newfunction = new HashSet();//项目功能
	private Missiontype missiontype;//项目类型
	private int isdel; // 判断是否删除，1已删除默认为0
	private Employee employee; //审批员工
	private Set approveprj = new HashSet(0);// 审批项目
	private Set newparticipator = new HashSet(0);//参与人
	//private NewPrjdept prjdept; // 参与部门对象
	//项目对参与部门  一对多
	private Set<NewPrjdept> depts = new HashSet<NewPrjdept>();
	//项目对参与人员表 一对多
	private Set<NewParticipator> cyr = new HashSet<NewParticipator>();
	//项目对查看者  一对多
	private Set<NewWatch> watch = new HashSet<NewWatch>();
	//项目对文档 一对多
	private Set<NewDocument> documents = new HashSet<NewDocument>();
	// 项目功能一对多
	private Set function=new HashSet();
	private String temp1;
	private String temp2;
	private String temp3;
	private String temp4;
	
	public NewProject(){}
	public NewProject(Integer id, String projectname, Integer schedule,
			 String launcher, Date begintime,Integer projecttype1, Date begintime1,
			Date endtime, String projectinfo, Integer approver,
			Integer projectstatus,Set newfunction,Missiontype missiontype,Set newparticipator,String temp1,String temp2,String temp3,String temp4) {
		this.id = id;
		this.projectname = projectname;
		this.schedule = schedule;
		this.launcher = launcher;
		this.begintime = begintime1;
		this.endtime = endtime;
		this.projectinfo = projectinfo;
		this.approver = approver;
		this.projectstatus = projectstatus;
		this.newfunction = newfunction;
		this.missiontype = missiontype;
		this.newparticipator = newparticipator;
		this.temp1 = temp1;
		this.temp2 = temp2;
		this.temp3 = temp3;
		this.temp4 = temp4;
	}
	public Set getApproveprj() {
		return approveprj;
	}
	public void setApproveprj(Set approveprj) {
		this.approveprj = approveprj;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getProjectname() {
		return projectname;
	}
	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}
	public Integer getSchedule() {
		return schedule;
	}
	public void setSchedule(Integer schedule) {
		this.schedule = schedule;
	}

	public Date getBegintime() {
		return begintime;
	}
	public void setBegintime(Date begintime) {
		this.begintime = begintime;
	}
	public Date getEndtime() {
		return endtime;
	}
	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	public String getProjectinfo() {
		return projectinfo;
	}
	public void setProjectinfo(String projectinfo) {
		this.projectinfo = projectinfo;
	}
	public Integer getApprover() {
		return approver;
	}
	public void setApprover(Integer approver) {
		this.approver = approver;
	}
	public Integer getProjectstatus() {
		return projectstatus;
	}
	public void setProjectstatus(Integer projectstatus) {
		this.projectstatus = projectstatus;
	}
	public Set getNewfunction() {
		return newfunction;
	}
	public void setNewfunction(Set newfunction) {
		this.newfunction = newfunction;
	}
	public Missiontype getMissiontype() {
		return missiontype;
	}
	public void setMissiontype(Missiontype missiontype) {
		this.missiontype = missiontype;
	}
	public Set<NewParticipator> getCyr() {
		return cyr;
	}
	public void setCyr(Set<NewParticipator> cyr) {
		this.cyr = cyr;
	}
	public Set<NewWatch> getWatch() {
		return watch;
	}
	public void setWatch(Set<NewWatch> watch) {
		this.watch = watch;
	}
	public String getLauncher() {
		return launcher;
	}
	public void setLauncher(String launcher) {
		this.launcher = launcher;
	}
	public Set<NewDocument> getDocuments() {
		return documents;
	}
	public void setDocuments(Set<NewDocument> documents) {
		this.documents = documents;
	}
	public Set<NewPrjdept> getDepts() {
		return depts;
	}
	public void setDepts(Set<NewPrjdept> depts) {
		this.depts = depts;
	}
	public Set getFunction() {
		return function;
	}
	public void setFunction(Set function) {
		this.function = function;
	}
	public Set getNewparticipator() {
		return newparticipator;
	}
	public void setNewparticipator(Set newparticipator) {
		this.newparticipator = newparticipator;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public int getIsdel() {
		return isdel;
	}
	public void setIsdel(int isdel) {
		this.isdel = isdel;
	}
	public String getTemp1() {
		return temp1;
	}
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	public String getTemp2() {
		return temp2;
	}
	public void setTemp2(String temp2) {
		this.temp2 = temp2;
	}
	public String getTemp3() {
		return temp3;
	}
	public void setTemp3(String temp3) {
		this.temp3 = temp3;
	}
	public String getTemp4() {
		return temp4;
	}
	public void setTemp4(String temp4) {
		this.temp4 = temp4;
	}
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	
}

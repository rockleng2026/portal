package com.fuao.fajxc.vo;

import java.util.HashSet;
import java.util.Set;

/**
 * Scheduleplan entity. @author MyEclipse Persistence Tools
 */

public class Scheduleplan implements java.io.Serializable {

	// Fields

	private Integer id;
	private Employee employee;
	private Integer plantype;
	private String todayWorkPlan;
	private String tomorrowWorkPlan;
	private String workcontent;
	private String workremind;
	private String begintime;
	private String endtime;
	private String remindtime;
	private String finishtime;
	private Integer sendStyle;
	private Integer remainSet;
	private Integer state;
	private Integer importantLevel;
	private String durationTime;
	private String subjecttitle;
	private String organizer;
	private String subjectstyle;
	private String participator;
	private Integer isplan;
	private Integer effective;
	private String tmp;
	private String tmp1;
	private String tmp2;
	private String tmp3;// 附件字段
	private NewFunction function;// 功能任务表，外键。胡宝林添加
	private Set newproblem = new HashSet(0); //问题表外键 王雄加

	// Constructors

	/** default constructor */
	public Scheduleplan() {
	}

	/** full constructor */
	public Scheduleplan(Employee employee, Integer plantype,
			String todayWorkPlan, String tomorrowWorkPlan,
			String begintime, String endtime, String finishtime,
			Integer sendStyle, Integer remainSet, Integer state,
			Integer importantLevel, String tmp, String tmp1, 
			String durationTime, String tmp2,Set newproblem) {
		this.employee = employee;
		this.plantype = plantype;
		this.todayWorkPlan = todayWorkPlan;
		this.tomorrowWorkPlan = tomorrowWorkPlan;
		this.begintime = begintime;
		this.endtime = endtime;
		this.finishtime = finishtime;
		this.sendStyle = sendStyle;
		this.remainSet = remainSet;
		this.state = state;
		this.importantLevel = importantLevel;
		this.tmp = tmp;
		this.tmp1 = tmp1;
		this.durationTime = durationTime;
		this.tmp2 = tmp2;
		this.newproblem = newproblem;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Integer getPlantype() {
		return this.plantype;
	}

	public void setPlantype(Integer plantype) {
		this.plantype = plantype;
	}

	public String getTodayWorkPlan() {
		return this.todayWorkPlan;
	}

	public void setTodayWorkPlan(String todayWorkPlan) {
		this.todayWorkPlan = todayWorkPlan;
	}

	public String getTomorrowWorkPlan() {
		return this.tomorrowWorkPlan;
	}

	public void setTomorrowWorkPlan(String tomorrowWorkPlan) {
		this.tomorrowWorkPlan = tomorrowWorkPlan;
	}

	public String getBegintime() {
		return this.begintime;
	}

	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}

	public String getEndtime() {
		return this.endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public String getFinishtime() {
		return this.finishtime;
	}

	public void setFinishtime(String finishtime) {
		this.finishtime = finishtime;
	}

	public Integer getSendStyle() {
		return this.sendStyle;
	}

	public void setSendStyle(Integer sendStyle) {
		this.sendStyle = sendStyle;
	}

	public Integer getRemainSet() {
		return this.remainSet;
	}

	public void setRemainSet(Integer remainSet) {
		this.remainSet = remainSet;
	}

	public Integer getState() {
		return this.state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getImportantLevel() {
		return this.importantLevel;
	}

	public void setImportantLevel(Integer importantLevel) {
		this.importantLevel = importantLevel;
	}

	public String getTmp() {
		return this.tmp;
	}

	public void setTmp(String tmp) {
		this.tmp = tmp;
	}

	public String getTmp1() {
		return this.tmp1;
	}

	public void setTmp1(String tmp1) {
		this.tmp1 = tmp1;
	}

	public String getDurationTime() {
		return durationTime;
	}

	public void setDurationTime(String durationTime) {
		this.durationTime = durationTime;
	}
	
	public String getTmp2() {
		return this.tmp2;
	}

	public void setTmp2(String tmp2) {
		this.tmp2 = tmp2;
	}
	public String getOrganizer() {
		return organizer;
	}

	public void setOrganizer(String organizer) {
		this.organizer = organizer;
	}

	public String getParticipator() {
		return participator;
	}

	public void setParticipator(String participator) {
		this.participator = participator;
	}

	public Integer getIsplan() {
		return isplan;
	}

	public void setIsplan(Integer isplan) {
		this.isplan = isplan;
	}

	public Integer getEffective() {
		return effective;
	}

	public void setEffective(Integer effective) {
		this.effective = effective;
	}

	public String getWorkcontent() {
		return workcontent;
	}

	public void setWorkcontent(String workcontent) {
		this.workcontent = workcontent;
	}

	public String getWorkremind() {
		return workremind;
	}

	public void setWorkremind(String workremind) {
		this.workremind = workremind;
	}

	public String getRemindtime() {
		return remindtime;
	}

	public void setRemindtime(String remindtime) {
		this.remindtime = remindtime;
	}

	public String getSubjecttitle() {
		return subjecttitle;
	}

	public void setSubjecttitle(String subjecttitle) {
		this.subjecttitle = subjecttitle;
	}

	public String getSubjectstyle() {
		return subjectstyle;
	}

	public void setSubjectstyle(String subjectstyle) {
		this.subjectstyle = subjectstyle;
	}

	public NewFunction getFunction() {
		return function;
	}

	public void setFunction(NewFunction function) {
		this.function = function;
	}

	public Set getNewproblem() {
		return newproblem;
	}

	public void setNewproblem(Set newproblem) {
		this.newproblem = newproblem;
	}

	public String getTmp3() {
		return tmp3;
	}

	public void setTmp3(String tmp3) {
		this.tmp3 = tmp3;
	}
	
}
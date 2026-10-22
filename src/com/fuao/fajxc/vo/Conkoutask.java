package com.fuao.fajxc.vo;

/**
 * Conkoutask entity. @author MyEclipse Persistence Tools
 */

public class Conkoutask implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private ConkOut conkout;
	private Employee employeeByEmpTakeId;
	private Employee employeeByEmpId;
	private Department department;
	private String descs;
	private String faultTime;
	private String endTim;
	private String inceptTime;
	private String propellingTime;
	private String resolveTime;
	private String solveDepict;
	private String appraise;
	private String isMain;
	private String yawp;
	private String corrincomTime;
	private int parentId;
	private int state;
    private Integer missiontypeid;//´æ·ÅÔËÎ¬×éid
	// Constructors

	/** default constructor */
	public Conkoutask() {
	}

	/** full constructor */
	public Conkoutask(ConkOut conkout, Employee employeeByEmpTakeId,
			Employee employeeByEmpId, Department department, String descs,
			String faultTime, String endTim, String inceptTime,
			String propellingTime, String resolveTime, String solveDepict,
			String appraise,String isMain,String yawp,Integer missiontypeid) {
		this.conkout = conkout;
		this.employeeByEmpTakeId = employeeByEmpTakeId;
		this.employeeByEmpId = employeeByEmpId;
		this.department = department;
		this.descs = descs;
		this.faultTime = faultTime;
		this.endTim = endTim;
		this.inceptTime = inceptTime;
		this.propellingTime = propellingTime;
		this.resolveTime = resolveTime;
		this.solveDepict = solveDepict;
		this.appraise = appraise;
		this.isMain = isMain;
		this.yawp = yawp;
		this.missiontypeid=missiontypeid;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public Integer getMissiontypeid() {
		return missiontypeid;
	}

	public void setMissiontypeid(Integer missiontypeid) {
		this.missiontypeid = missiontypeid;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public ConkOut getConkout() {
		return conkout;
	}

	public void setConkout(ConkOut conkout) {
		this.conkout = conkout;
	}

	public Employee getEmployeeByEmpTakeId() {
		return this.employeeByEmpTakeId;
	}

	public void setEmployeeByEmpTakeId(Employee employeeByEmpTakeId) {
		this.employeeByEmpTakeId = employeeByEmpTakeId;
	}

	public Employee getEmployeeByEmpId() {
		return this.employeeByEmpId;
	}

	public void setEmployeeByEmpId(Employee employeeByEmpId) {
		this.employeeByEmpId = employeeByEmpId;
	}

	public Department getDepartment() {
		return this.department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public String getDescs() {
		return this.descs;
	}

	public void setDescs(String descs) {
		this.descs = descs;
	}

	public String getFaultTime() {
		return this.faultTime;
	}

	public void setFaultTime(String faultTime) {
		this.faultTime = faultTime;
	}

	public String getEndTim() {
		return this.endTim;
	}

	public void setEndTim(String endTim) {
		this.endTim = endTim;
	}

	public String getInceptTime() {
		return this.inceptTime;
	}

	public void setInceptTime(String inceptTime) {
		this.inceptTime = inceptTime;
	}

	public String getPropellingTime() {
		return this.propellingTime;
	}

	public void setPropellingTime(String propellingTime) {
		this.propellingTime = propellingTime;
	}

	public String getResolveTime() {
		return this.resolveTime;
	}

	public void setResolveTime(String resolveTime) {
		this.resolveTime = resolveTime;
	}

	public String getSolveDepict() {
		return this.solveDepict;
	}

	public void setSolveDepict(String solveDepict) {
		this.solveDepict = solveDepict;
	}

	public String getAppraise() {
		return this.appraise;
	}

	public void setAppraise(String appraise) {
		this.appraise = appraise;
	}
	
	public String getIsMain() {
		return isMain;
	}

	public void setIsMain(String isMain) {
		this.isMain = isMain;
	}

	public String getYawp() {
		return yawp;
	}

	public void setYawp(String yawp) {
		this.yawp = yawp;
	}

	public String getCorrincomTime() {
		return corrincomTime;
	}

	public void setCorrincomTime(String corrincomTime) {
		this.corrincomTime = corrincomTime;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	

}
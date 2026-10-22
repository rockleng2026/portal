package com.fuao.fajxc.vo;

public class Tresourcecheck {

	/*
	 * author 王雄 	
	 * email:wangxiong@fuao.com 资源核实单
	 */
	private Integer id;// 主键
	private Employee empid;// 申请人
	private City city;// 地区id
	private Depot depot;// 机房
	private String rvid;// 核实单编号
	private Sale_goods saleGoods;// 产品
	private String starttime;// 时间
	private String isstate;// 状态
	private Employee employee;// 回复人
	private String conent; // 回复内容
	private String temp1;// 备份1
	private String temp2;// 备份2
	private String temp3;// 备份3
	private Integer audtitingFlag;//审批标识

	public Tresourcecheck() {

	}

	public Tresourcecheck(Integer id, Employee empid,  City city,
			Depot depot, String rvid, Sale_goods saleGoods,
			String starttime, String isstate, Employee employee, String conent,
			String temp1, String temp2, String temp3,Integer audtitingFlag) {
		this.id = id;
		this.empid = empid;
		this.city = city;
		this.depot = depot;
		this.rvid =rvid;
		this.saleGoods = saleGoods;
		this.starttime = starttime;
		this.isstate = isstate;
		this.employee = employee;
		this.conent = conent;
		this.temp1 = temp1;
		this.temp2 = temp2;
		this.temp3 = temp3;
		this.audtitingFlag = audtitingFlag;

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmpid() {
		return empid;
	}

	public void setEmpid(Employee empid) {
		this.empid = empid;
	}

	public City getCity() {
		return city;
	}

	public void setCity(City city) {
		this.city = city;
	}



	public String getRvid() {
		return rvid;
	}

	public void setRvid(String rvid) {
		this.rvid = rvid;
	}

	

	public Depot getDepot() {
		return depot;
	}

	public void setDepot(Depot depot) {
		this.depot = depot;
	}

	public Sale_goods getSaleGoods() {
		return saleGoods;
	}

	public void setSaleGoods(Sale_goods saleGoods) {
		this.saleGoods = saleGoods;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getIsstate() {
		return isstate;
	}

	public void setIsstate(String isstate) {
		this.isstate = isstate;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getConent() {
		return conent;
	}

	public void setConent(String conent) {
		this.conent = conent;
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

	public Integer getAudtitingFlag() {
		return audtitingFlag;
	}

	public void setAudtitingFlag(Integer audtitingFlag) {
		this.audtitingFlag = audtitingFlag;
	}
	
	

}

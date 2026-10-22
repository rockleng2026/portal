package com.fuao.fajxc.vo;


public class FormTemp  implements java.io.Serializable{
	/**
	 * 表单模板
	 * 
	 * **/
	private Integer id;   
	private String mark;	//标识符
	private String typeName;   //单据模板表名
	private String time;    //创建模板时间
	private Employee employee; //创建模板人
	private String code;       //html页面代码
	private Integer delflag;   //删除标识符   0未删除   1为已删除
	private String temp;
	
	public FormTemp(){
	}
	
	public FormTemp(String mark,String typeName, String time,Employee employee,String code,Integer delflag,
			String temp ){
		this.mark=mark;
		this.typeName = typeName;
		this.time = time;
		this.employee = employee;
		this.code = code;
		this.delflag = delflag;
		this.temp = temp;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Integer getDelflag() {
		return delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}
}

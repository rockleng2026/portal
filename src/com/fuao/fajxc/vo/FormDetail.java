package com.fuao.fajxc.vo;


public class FormDetail  implements java.io.Serializable{
	/**
	 * 表单详细
	 * 
	 * **/
	private Integer id;
	private FormTemp formtemp;   //表单模板
	private Employee employee;   //填表人
	private String orderNo;		//单据编号
	private Integer delflag;	 //删除标识符   0未删除   1为已删除
	private Integer audtitingFlag;  //审核标识
	private String time;      //创建/添加表单时间
	private String temp;

	
	public FormDetail()
	{
	}
	
	public FormDetail(FormTemp formtemp, Employee employee, String orderNo,String time,Integer delflag,Integer audtitingFlag,
			String temp)
	{
		this.formtemp = formtemp;
		this.employee=employee;
		this.orderNo=orderNo;
		this.time=time;
		this.delflag = delflag;
		this.audtitingFlag=audtitingFlag;
		this.temp = temp;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public FormTemp getFormtemp() {
		return formtemp;
	}
	
	public void setFormtemp(FormTemp formtemp) {
		this.formtemp = formtemp;
	}
	
	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public Integer getDelflag() {
		return delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public Integer getAudtitingFlag() {
		return audtitingFlag;
	}

	public void setAudtitingFlag(Integer audtitingFlag) {
		this.audtitingFlag = audtitingFlag;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}
}

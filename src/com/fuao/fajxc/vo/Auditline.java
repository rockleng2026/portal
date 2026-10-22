package com.fuao.fajxc.vo;

public class Auditline {
    private int id;
    private int foreignId;//部门或者员工id
    private double Januarymoney;//一月
    private double Februarymoney;//二月
    private double marchmoney;//三月
    private double Aprilmoney;//四月
    private double Maymoney;//五月
    private double Junemoney;//六月
    private double Julymoney;//七月
    private double Augustmoney;//八月
    private double Septembermoney;//九月
    private double Octobermoney;//十月
    private double Novembermoney;//十一月
    private double Decembermoney;//十二月
    private double Firstquarter;//一季度
    private double Twoquarter;//二季度
    private double Threequarter;//三季度
    private double Fourquarter;//四季度
    private double Halfyear1;//上半年
    private double Halfyear2;//下半年
    private double Yearmoney;//全年
    private String creatTime;//时间
    private int temp;//标识符  是否是部门还是员工业务1为部门  2为员工
    private int isflag;//标识符 是否是部门转过来的业务  1为部门转过来的业务 0为非部门转过来的
	public Auditline(int id, int foreignId, double januarymoney,
			double februarymoney, double marchmoney, double aprilmoney,
			double maymoney, double junemoney, double julymoney,
			double augustmoney, double septembermoney, double octobermoney,
			double novembermoney, double decembermoney, double firstquarter,
			double twoquarter, double threequarter, double fourquarter,
			double halfyear1, double halfyear2, double yearmoney, String creatTime, int temp,
			int isflag) {
		super();
		this.id = id;
		this.foreignId = foreignId;
		Januarymoney = januarymoney;
		Februarymoney = februarymoney;
		this.marchmoney = marchmoney;
		Aprilmoney = aprilmoney;
		Maymoney = maymoney;
		Junemoney = junemoney;
		Julymoney = julymoney;
		Augustmoney = augustmoney;
		Septembermoney = septembermoney;
		Octobermoney = octobermoney;
		Novembermoney = novembermoney;
		Decembermoney = decembermoney;
		Firstquarter = firstquarter;
		Twoquarter = twoquarter;
		Threequarter = threequarter;
		Fourquarter = fourquarter;
		Halfyear1 = halfyear1;
		Halfyear2 = halfyear2;
		Yearmoney = yearmoney;
		creatTime=this.creatTime;
		this.temp = temp;
		this.isflag = isflag;
	}
	
	public Auditline(){
		
	}

	
	public String getCreatTime() {
		return creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getForeignId() {
		return foreignId;
	}

	public void setForeignId(int foreignId) {
		this.foreignId = foreignId;
	}

	public double getJanuarymoney() {
		return Januarymoney;
	}

	public void setJanuarymoney(double januarymoney) {
		Januarymoney = januarymoney;
	}

	public double getFebruarymoney() {
		return Februarymoney;
	}

	public void setFebruarymoney(double februarymoney) {
		Februarymoney = februarymoney;
	}

	public double getMarchmoney() {
		return marchmoney;
	}

	public void setMarchmoney(double marchmoney) {
		this.marchmoney = marchmoney;
	}

	public double getAprilmoney() {
		return Aprilmoney;
	}

	public void setAprilmoney(double aprilmoney) {
		Aprilmoney = aprilmoney;
	}

	public double getMaymoney() {
		return Maymoney;
	}

	public void setMaymoney(double maymoney) {
		Maymoney = maymoney;
	}

	public double getJunemoney() {
		return Junemoney;
	}

	public void setJunemoney(double junemoney) {
		Junemoney = junemoney;
	}

	public double getJulymoney() {
		return Julymoney;
	}

	public void setJulymoney(double julymoney) {
		Julymoney = julymoney;
	}

	public double getAugustmoney() {
		return Augustmoney;
	}

	public void setAugustmoney(double augustmoney) {
		Augustmoney = augustmoney;
	}

	public double getSeptembermoney() {
		return Septembermoney;
	}

	public void setSeptembermoney(double septembermoney) {
		Septembermoney = septembermoney;
	}

	public double getOctobermoney() {
		return Octobermoney;
	}

	public void setOctobermoney(double octobermoney) {
		Octobermoney = octobermoney;
	}

	public double getNovembermoney() {
		return Novembermoney;
	}

	public void setNovembermoney(double novembermoney) {
		Novembermoney = novembermoney;
	}

	public double getDecembermoney() {
		return Decembermoney;
	}

	public void setDecembermoney(double decembermoney) {
		Decembermoney = decembermoney;
	}

	public double getFirstquarter() {
		return Firstquarter;
	}

	public void setFirstquarter(double firstquarter) {
		Firstquarter = firstquarter;
	}

	public double getTwoquarter() {
		return Twoquarter;
	}

	public void setTwoquarter(double twoquarter) {
		Twoquarter = twoquarter;
	}

	public double getThreequarter() {
		return Threequarter;
	}

	public void setThreequarter(double threequarter) {
		Threequarter = threequarter;
	}

	public double getFourquarter() {
		return Fourquarter;
	}

	public void setFourquarter(double fourquarter) {
		Fourquarter = fourquarter;
	}

	public double getHalfyear1() {
		return Halfyear1;
	}

	public void setHalfyear1(double halfyear1) {
		Halfyear1 = halfyear1;
	}

	public double getHalfyear2() {
		return Halfyear2;
	}

	public void setHalfyear2(double halfyear2) {
		Halfyear2 = halfyear2;
	}

	public double getYearmoney() {
		return Yearmoney;
	}

	public void setYearmoney(double yearmoney) {
		Yearmoney = yearmoney;
	}

	public int getTemp() {
		return temp;
	}

	public void setTemp(int temp) {
		this.temp = temp;
	}

	public int getIsflag() {
		return isflag;
	}

	public void setIsflag(int isflag) {
		this.isflag = isflag;
	}
	
	
    
    
}

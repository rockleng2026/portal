package com.fuao.fajxc.vo;
//到期提醒临时使用实体
public class Reminders {
	//即将到期工单名称；
	String name;       
	
	//数量
	String number;
	
	//id集合
	String ids;
	
	//实体名
	String enitName;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getEnitName() {
		return enitName;
	}

	public void setEnitName(String enitName) {
		this.enitName = enitName;
	}

}

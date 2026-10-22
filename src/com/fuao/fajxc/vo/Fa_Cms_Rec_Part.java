package com.fuao.fajxc.vo;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

/**
 * 
 * @author 推荐配置
 *
 */
public class Fa_Cms_Rec_Part {
	private Integer pid; //PK
	private String part_name; //位置名字
	private Integer part_num; //位置显示的数量
	private String part_desc; //位置描述
	private String temp; //备注
	private Integer typeid; //对应类别ID
	private Integer mid; //参数位置
	private String eng_name; //英文名
	//part对classes  多对一
	private Fa_Cms_Classes classes;//所属栏目
	
	public Fa_Cms_Rec_Part(){}
	public Fa_Cms_Rec_Part(Integer pid, String partName, Integer partNum,
			String partDesc, String temp, Integer typeid, Integer mid,
			String engName) {
		this.pid = pid;
		part_name = partName;
		part_num = partNum;
		part_desc = partDesc;
		this.temp = temp;
		this.typeid = typeid;
		this.mid = mid;
		eng_name = engName;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public String getPart_name() {
		return part_name;
	}

	public void setPart_name(String partName) {
		part_name = partName;
	}

	public Integer getPart_num() {
		return part_num;
	}

	public void setPart_num(Integer partNum) {
		part_num = partNum;
	}

	public String getPart_desc() {
		return part_desc;
	}

	public void setPart_desc(String partDesc) {
		part_desc = partDesc;
	}

	public String getTemp() {
		return temp;
	}

	public void setTemp(String temp) {
		this.temp = temp;
	}
	public Integer getTypeid() {
		return typeid;
	}

	public void setTypeid(Integer typeid) {
		this.typeid = typeid;
	}

	public Integer getMid() {
		return mid;
	}

	public void setMid(Integer mid) {
		this.mid = mid;
	}

	public String getEng_name() {
		return eng_name;
	}

	public void setEng_name(String engName) {
		eng_name = engName;
	}

	public Fa_Cms_Classes getClasses() {
		return classes;
	}

	public void setClasses(Fa_Cms_Classes classes) {
		this.classes = classes;
	}
	
}

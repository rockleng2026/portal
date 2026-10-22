package com.fuao.fajxc.vo;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class City implements Serializable{
	private Integer id;
	private String name;
	private String code; //邮编
	private Integer superid; //父ID
	private String pinyin;
	private String temp;
	// 城市对机房  一对多
	private Set<ElectHouse> electhouses = new HashSet<ElectHouse>();
	private Set tresourceCheck = new HashSet();

	public City(){
		
	}

	public City(Integer id, String name, String code, Integer superid,
			String pinyin, String temp) {
		this.id = id;
		this.name = name;
		this.code = code;
		this.superid = superid;
		this.temp = temp;
		this.electhouses = electhouses;
		this.pinyin=pinyin;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Integer getSuperid() {
		return superid;
	}
	public void setSuperid(Integer superid) {
		this.superid = superid;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public Set<ElectHouse> getElecthouses() {
		return electhouses;
	}
	public void setElecthouses(Set<ElectHouse> electhouses) {
		this.electhouses = electhouses;
	}
	public String getPinyin() {
		return pinyin;
	}
	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}

	public Set getTresourceCheck() {
		return tresourceCheck;
	}

	public void setTresourceCheck(Set tresourceCheck) {
		this.tresourceCheck = tresourceCheck;
	}
	
}

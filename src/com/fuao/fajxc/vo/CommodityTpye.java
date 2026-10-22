package com.fuao.fajxc.vo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * CommodityTpye entity. @author MyEclipse Persistence Tools
 */

public class CommodityTpye implements java.io.Serializable {

	// Fields

	private Integer id;
	private CommodityTpye superid;
	private Employee employee;
	private Field field;
	private String typeName;
	private String time;
	private String del;
	private String ischeckbox;
	private String ico;
	private Set batchexps = new HashSet(0);
	private Set applyBuyinfos = new HashSet(0);
	private Set models = new HashSet(0);
	private int superidd ;
	private List<CommodityTpye> child = new ArrayList<CommodityTpye>();
	
	// Constructors

	/** default constructor */
	public CommodityTpye() {
	}

	/** minimal constructor */
	public CommodityTpye(String typeName) {
		this.typeName = typeName;
	}

	/** full constructor */
	public CommodityTpye(Employee employee, Field field, String typeName,
			String time, String del, Set batchexps, Set applyBuyinfos,
			Set models) {
		this.employee = employee;
		this.field = field;
		this.typeName = typeName;
		this.time = time;
		this.del = del;
		this.batchexps = batchexps;
		this.applyBuyinfos = applyBuyinfos;
		this.models = models;
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

	public Field getField() {
		return this.field;
	}

	public void setField(Field field) {
		this.field = field;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getTime() {
		return this.time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getDel() {
		return this.del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public Set getBatchexps() {
		return this.batchexps;
	}

	public void setBatchexps(Set batchexps) {
		this.batchexps = batchexps;
	}

	public Set getApplyBuyinfos() {
		return this.applyBuyinfos;
	}

	public void setApplyBuyinfos(Set applyBuyinfos) {
		this.applyBuyinfos = applyBuyinfos;
	}

	public Set getModels() {
		return this.models;
	}

	public void setModels(Set models) {
		this.models = models;
	}


	public List<CommodityTpye> getChild() {
		return child;
	}

	public void setChild(List<CommodityTpye> child) {
		this.child = child;
	}

	public CommodityTpye getSuperid() {
		return superid;
	}

	public void setSuperid(CommodityTpye superid) {
		this.superid = superid;
	}

	public String getIscheckbox() {
		return ischeckbox;
	}

	public void setIscheckbox(String ischeckbox) {
		this.ischeckbox = ischeckbox;
	}

	public String getIco() {
		return ico;
	}

	public void setIco(String ico) {
		this.ico = ico;
	}

	public int getSuperidd() {
		return superidd;
	}

	public void setSuperidd(int superidd) {
		this.superidd = superidd;
	}

}
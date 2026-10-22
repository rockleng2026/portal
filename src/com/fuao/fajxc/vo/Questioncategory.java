package com.fuao.fajxc.vo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Questioncategory entity. @author MyEclipse Persistence Tools
 */

public class Questioncategory implements java.io.Serializable {

	// Fields

	private Integer id;
	private Questioncategory questioncategory;
	private String questionName;
	private String remark;
	private String isAssess;
	private String tmp1;
	private String tmp2;
	private String tmp3;
	private Set empassesses = new HashSet(0);
	private Set questioncategories = new HashSet(0);
	private List<Questioncategory> child = new ArrayList<Questioncategory>();
	private Set saleOrdersForOrdertype = new HashSet(0);
	private int superid ;
	// Constructors

	/** default constructor */
	public Questioncategory() {
	}

	/** full constructor */
	public Questioncategory(Questioncategory questioncategory,
			String questionName, String remark, String tmp, String tmp1,
			String tmp2, String tmp3, Set empassesses, Set questioncategories) {
		this.questioncategory = questioncategory;
		this.questionName = questionName;
		this.remark = remark;
		this.isAssess = tmp;
		this.tmp1 = tmp1;
		this.tmp2 = tmp2;
		this.tmp3 = tmp3;
		this.empassesses = empassesses;
		this.questioncategories = questioncategories;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Questioncategory getQuestioncategory() {
		return this.questioncategory;
	}

	public void setQuestioncategory(Questioncategory questioncategory) {
		this.questioncategory = questioncategory;
	}

	public String getQuestionName() {
		return this.questionName;
	}

	public void setQuestionName(String questionName) {
		this.questionName = questionName;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}


	public String getIsAssess() {
		return isAssess;
	}

	public void setIsAssess(String isAssess) {
		this.isAssess = isAssess;
	}

	public String getTmp1() {
		return this.tmp1;
	}

	public void setTmp1(String tmp1) {
		this.tmp1 = tmp1;
	}

	public String getTmp2() {
		return this.tmp2;
	}

	public void setTmp2(String tmp2) {
		this.tmp2 = tmp2;
	}

	public String getTmp3() {
		return this.tmp3;
	}

	public void setTmp3(String tmp3) {
		this.tmp3 = tmp3;
	}

	public Set getEmpassesses() {
		return this.empassesses;
	}

	public void setEmpassesses(Set empassesses) {
		this.empassesses = empassesses;
	}

	public Set getQuestioncategories() {
		return this.questioncategories;
	}

	public void setQuestioncategories(Set questioncategories) {
		this.questioncategories = questioncategories;
	}

	public List<Questioncategory> getChild() {
		return child;
	}

	public void setChild(List<Questioncategory> child) {
		this.child = child;
	}

	public int getSuperid() {
		return superid;
	}

	public void setSuperid(int superid) {
		this.superid = superid;
	}

	public Set getSaleOrdersForOrdertype() {
		return saleOrdersForOrdertype;
	}

	public void setSaleOrdersForOrdertype(Set saleOrdersForOrdertype) {
		this.saleOrdersForOrdertype = saleOrdersForOrdertype;
	}

}
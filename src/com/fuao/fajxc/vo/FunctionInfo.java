package com.fuao.fajxc.vo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * FunctionInfo entity. @author MyEclipse Persistence Tools
 */

public class FunctionInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -3893692565438691008L;
	private Integer functionId;
	private String linkFunctionName;
	private Integer superId;
	private String linkFunctionPage;
	private String description;
	private String imagepath;
	private Integer delflag;
	private Set pagefunction=new HashSet(0);
	private Integer versionFlag;
	private List<FunctionInfo> child = new ArrayList<FunctionInfo>();
	// Constructors

	/** default constructor */
	public FunctionInfo() {
	}

	/** minimal constructor */
	public FunctionInfo(String linkFunctionName, Integer superId) {
		this.linkFunctionName = linkFunctionName;
		this.superId = superId;
	}

	public Integer getVersionFlag() {
		return versionFlag;
	}

	public void setVersionFlag(Integer versionFlag) {
		this.versionFlag = versionFlag;
	}

	/** full constructor */
	public FunctionInfo(String linkFunctionName, Integer superId,
			String linkFunctionPage, String description, String imagepath,
			Integer delflag) {
		this.linkFunctionName = linkFunctionName;
		this.superId = superId;
		this.linkFunctionPage = linkFunctionPage;
		this.description = description;
		this.imagepath = imagepath;
		this.delflag = delflag;
	}

	// Property accessors

	public Integer getFunctionId() {
		return this.functionId;
	}

	public void setFunctionId(Integer functionId) {
		this.functionId = functionId;
	}

	public String getLinkFunctionName() {
		return this.linkFunctionName;
	}

	public void setLinkFunctionName(String linkFunctionName) {
		this.linkFunctionName = linkFunctionName;
	}

	public Integer getSuperId() {
		return this.superId;
	}

	public void setSuperId(Integer superId) {
		this.superId = superId;
	}

	public String getLinkFunctionPage() {
		return this.linkFunctionPage;
	}

	public void setLinkFunctionPage(String linkFunctionPage) {
		this.linkFunctionPage = linkFunctionPage;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImagepath() {
		return this.imagepath;
	}

	public void setImagepath(String imagepath) {
		this.imagepath = imagepath;
	}

	public Integer getDelflag() {
		return this.delflag;
	}

	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}

	public List<FunctionInfo> getChild() {
		return child;
	}

	public void setChild(List<FunctionInfo> child) {
		this.child = child;
	}

	public Set getPagefunction() {
		return pagefunction;
	}

	public void setPagefunction(Set pagefunction) {
		this.pagefunction = pagefunction;
	}


}
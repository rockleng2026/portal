package com.fuao.fajxc.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * 页面功能实体
 */

public class pagefunction implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Fields
	private Integer id;//主键
	private String name;//页面功能名称
	private String linkFunctionPage;//链接功能页面
	private String description;//描述
	private Integer delflag;//删除标识
	private FunctionInfo function; // 菜单外键表
	private Integer onlyflag;
	
	
	public pagefunction() {
		super();
	}
	public pagefunction(Integer id, String name, String linkFunctionPage,
			String description, Integer delflag, FunctionInfo function) {
		super();
		this.id = id;
		this.name = name;
		this.linkFunctionPage = linkFunctionPage;
		this.description = description;
		this.delflag = delflag;
		this.function = function;
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
	public String getLinkFunctionPage() {
		return linkFunctionPage;
	}
	public void setLinkFunctionPage(String linkFunctionPage) {
		this.linkFunctionPage = linkFunctionPage;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getDelflag() {
		return delflag;
	}
	public void setDelflag(Integer delflag) {
		this.delflag = delflag;
	}
	public FunctionInfo getFunction() {
		return function;
	}
	public void setFunction(FunctionInfo function) {
		this.function = function;
	}
	public Integer getOnlyflag() {
		return onlyflag;
	}
	public void setOnlyflag(Integer onlyflag) {
		this.onlyflag = onlyflag;
	}
	


}
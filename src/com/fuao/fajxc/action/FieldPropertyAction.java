package com.fuao.fajxc.action;

import java.io.IOException;

import com.fuao.fajxc.bussiness.FieldPropertyBussiness;
import com.fuao.fajxc.bussiness.FieldRemarkBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.FieldProperty;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

public class FieldPropertyAction implements ServletRequestAware,ModelDriven,ServletResponseAware {

	private static Logger logger = Logger.getLogger(FieldPropertyAction.class);
	private Employee emp;
	private EmployeeBussiness empBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private FieldPropertyBussiness fieldPropertyBussiness;
	private FieldRemarkBussiness fieldRemarkBussiness;
	private List<FieldProperty> listFieldProperty;
	private FieldProperty fieldProperty;
	public Object getModel() {
		return fieldProperty = new FieldProperty();
	}
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}
	public Employee getEmp() {
		return emp;
	}
	public void setEmp(Employee emp) {
		this.emp = emp;
	}
	public EmployeeBussiness getEmpBussiness() {
		return empBussiness;
	}
	public void setEmpBussiness(EmployeeBussiness empBussiness) {
		this.empBussiness = empBussiness;
	}
	public HttpServletRequest getRequest() {
		return request;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public HttpServletResponse getResponse() {
		return response;
	}
	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	public FieldPropertyBussiness getFieldPropertyBussiness() {
		return fieldPropertyBussiness;
	}
	public void setFieldPropertyBussiness(
			FieldPropertyBussiness fieldPropertyBussiness) {
		this.fieldPropertyBussiness = fieldPropertyBussiness;
	}
	public FieldRemarkBussiness getFieldRemarkBussiness() {
		return fieldRemarkBussiness;
	}
	public void setFieldRemarkBussiness(FieldRemarkBussiness fieldRemarkBussiness) {
		this.fieldRemarkBussiness = fieldRemarkBussiness;
	}
	public List<FieldProperty> getListFieldProperty() {
		return listFieldProperty;
	}
	public void setListFieldProperty(List<FieldProperty> listFieldProperty) {
		this.listFieldProperty = listFieldProperty;
	}
	public FieldProperty getFieldProperty() {
		return fieldProperty;
	}
	public void setFieldProperty(FieldProperty fieldProperty) {
		this.fieldProperty = fieldProperty;
	}
	
	
}

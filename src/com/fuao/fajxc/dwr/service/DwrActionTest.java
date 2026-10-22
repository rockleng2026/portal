package com.fuao.fajxc.dwr.service;

import java.util.List;

import com.fuao.fajxc.vo.Department;
import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class DwrActionTest extends ActionSupport {

	private List<Department> department;

	public List<Department> getDepartment() {
		return department;
	}

	public void setDepartment(List<Department> department) {
		this.department = department;
	}

	private DwrGetDeptDAO dwrgetdept;

	public void setDwrgetdept(DwrGetDeptDAO dwrgetdept) {
		this.dwrgetdept = dwrgetdept;
	}

	// 得到所有的部门信息
	public String getListDept() {
		this.department = dwrgetdept.getAllDept();
		return "success";
	}

}

package com.fuao.fajxc.dwr.service;

import java.util.List;
import com.fuao.fajxc.dao.basic.EmployeeDao;
import com.fuao.fajxc.dao.impl.basic.EmployeeDaoImpl;
import com.fuao.fajxc.vo.Employee;

public class DwrGetEmp {

	private EmployeeDao empdao;

	public EmployeeDao getEmpdao() {
		return empdao;
	}

	public void setEmpdao(EmployeeDao empdao) {
		this.empdao = empdao;
	}

	// 根据部门编号得到对应的员工信息
	public String getEmpByDeptid(String deptid) {
		List<Employee> emplist =getEmp(deptid);
		
		String str = "<select>";
		if(emplist.size()>0){
			for (int i = 0; i < emplist.size(); i++) {
				Employee emp = emplist.get(i);
				str += "<option id='" + emp.getId() + "'>" + emp.getName()
						+ "</option>";
			}
		}else{
			str+="<option value='-1'>--所有--</option>";
		}
		str += "</select>";
		return str;
	}

	// 得到员工集合信息
	public List<Employee> getEmp(String deptid) {
		System.out.println(deptid);
		String hql = "from Employee where department=" + deptid;
		List<Employee> emplist = empdao.exHql(hql);
		System.out.println(emplist.size());
		return emplist;
	}

}

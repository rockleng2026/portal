package com.fuao.fajxc.dwr.service;

import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.vo.Department;

public class DwrGetDeptDAO extends HibernateDaoSupport {
	
	@SuppressWarnings("unchecked")
	public List<Department> getAllDept(){
		String sql = "from Department where delflag=0";
		List<Department> list2 = this.getHibernateTemplate().find(sql);
		return list2;
	}

}

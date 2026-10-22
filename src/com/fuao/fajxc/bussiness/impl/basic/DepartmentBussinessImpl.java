package com.fuao.fajxc.bussiness.impl.basic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.fuao.fajxc.bussiness.basic.DepartmentBussiness;
import com.fuao.fajxc.dao.basic.DepartmentDao;
import com.fuao.fajxc.util.PageBean;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.WorkpositionEmployee;

public class DepartmentBussinessImpl implements DepartmentBussiness {
	
	private DepartmentDao departDao;

	/**
	 * @return the departDao
	 */
	public DepartmentDao getDepartDao() {
		return departDao;
	}


	/**
	 * @param departDao the departDao to set
	 */
	public void setDepartDao(DepartmentDao departDao) {
		this.departDao = departDao;
	}


	public PageBean selDepart(int pagesize, int page, String addhql) {
		int allRow = departDao.DepartCount(addhql);    //总记录数    
        System.out.println(allRow);
        int totalPage = PageBean.countTotalPage(pagesize, allRow);	//总页数    
        final int offset = PageBean.countOffset(pagesize, page);	  //当前页开始记录    
        final int length = pagesize;	    //每页记录数    
        final int currentPage = PageBean.countCurrentPage(page);    
        List list = departDao.selDepart(offset, length,addhql);	   //"一页"的记录    
			
		//把分页信息保存到Bean中
		PageBean pageBean = new PageBean();
		pageBean.setPageSize(pagesize);
		pageBean.setCurrentPage(currentPage);
		pageBean.setAllRow(allRow);
		pageBean.setTotalPage(totalPage);
		pageBean.setList(list);
		pageBean.init();
		return pageBean;
	}


	public List selEmp() {
		return departDao.selEmp();
	}


	public boolean addOrUpdateDepartment(int mark, Department dep) {
		// TODO Auto-generated method stub
		return departDao.addOrUpdateDepartment(mark, dep);
	}

	/**
     * 添加部门信息
     * @author 阙超强 14015
     * @param dep
     * @return Department
     */
	public Department addDepartment(Department dep){
		Department department = null;
		try {
			department = (Department) departDao.addReturnObject(dep);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return department;
	}

	public Department onedep(String addhql) {
		// TODO Auto-generated method stub
		return departDao.onedep(addhql);
	}


	public boolean delEmp(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<ids.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return departDao.delDepart(obj);
	}

	/*
	 * 获取所有的部门信息
	 * @see 
	 */
	public List<Department> getalldept(String addhql){
		List<Department> alldept=null;
		String hql="from Department as tb where 1=1 and filialemark!='FA' and name!='集团董事局' and tb.delflag!=1"+addhql;
		System.out.println("hql:"+hql);
		alldept=departDao.execHQL(hql);
		System.out.println("alldept:"+alldept);
		return alldept;
	}
	
	/*
	 * 获取所有的部门信息包含集团董事局
	 * @see 
	 */
	public List<Department> getalldept2(String addhql){
		List<Department> alldept=null;
		String hql="from Department as tb where 1=1  and tb.delflag!=1"+addhql;
		System.out.println("hql:"+hql);
		alldept=departDao.execHQL(hql);
		System.out.println("alldept:"+alldept);
		return alldept;
	}

	/*
	 * 获取单个部门的信息
	 * @see 
	 */
	public Department getDepartment(String id) {
		
		try {
			return (Department)departDao.select(Department.class,Integer.parseInt(id));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}





	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		return departDao.exHqlPages(hql, pageNo, pageSize, values);
	}
	
	/*
	 * modify by lzy 2012-11-18
	 */
	/**
	 * 获得部门所有子部门，包括本部门
	 * @param dept 实例化部门对象
	 * @return 部门及子部门id组成的用逗号分隔的字符串 eg1,2,3, 无则返回""
	 */
	public String getSonDepartment(Department dept){
		
		String returnValue = "";
		List  list = departDao.execSQL("select getChildDeptLst("+dept.getId()+")");
		if(list != null && list.size()>0){
      	  
      	  returnValue= list.get(0).toString();
      	  
      	  returnValue = returnValue.substring(1);
        }
		return returnValue;
	}


	public Employee getDeptManager(Department dept) {
		
//		通过员工-岗位表 查找到担任到部门主管岗位的员工
		WorkpositionEmployee wp = new WorkpositionEmployee();
//		wp.setDepartment(dept);
		Employee emp = new Employee();
		String hql = "From Workposition  wp where wp.workposition.department.id  ="+dept.getId() +" and wp.positiontype = 4";
		List list = departDao.execHQL(hql);
		if(list != null && list.size()>0){
			
			emp = ((WorkpositionEmployee)list.get(0)).getEmployee();
			
		}
		
		return emp;
	}


	public Employee getDeptManagerRecursive(Department dept) {
		// TODO Auto-generated method stub
		return null;
	}


	public Employee getDeptManagerRecursive(Employee emp) {
		// TODO Auto-generated method stub
		return null;
	}
	
}

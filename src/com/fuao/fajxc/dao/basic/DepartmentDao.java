package com.fuao.fajxc.dao.basic;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;

public interface DepartmentDao extends BaseDao {

	/**
	 * 查找部门信息分页
	 * @param first
	 * @param max
	 * @param addhql
	 * @return
	 */
	public List selDepart(int first,int max,String addhql);
	/**
	 *查找部门总数 
	 *@return
	 */
	public int DepartCount(String addhql);
	
    /**
     * 添加或更新部门信息
     * @param mark 1:添加 2：更新
     * @param dep
     * @return
     */
	public boolean addOrUpdateDepartment(int mark,Department dep);
	
   /**
    * 查找所有员工
    * @return
    */
	public List selEmp();
	
	/**
	 * 根据条件查找部门
	 * @return
	 */
	public Department onedep(String addhql);
	 
	
	/**
	 * 删除部门
	 * @param id
	 * @return
	 */
	public boolean delDepart(Object[] ids);
	
	/**
	 * 分页查找部门
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	
	
}

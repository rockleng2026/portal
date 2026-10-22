package com.fuao.fajxc.dao.impl.basic;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.action.LoginAction;
import com.fuao.fajxc.dao.basic.DepartmentDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;

public class DepartmentDaoImpl extends BaseDaoImpl implements DepartmentDao {

	private static Logger logger = Logger.getLogger(LoginAction.class);
	
	public int DepartCount(String addhql) {
		// TODO Auto-generated method stub
		String hql="from Department where delflag=0"+addhql;
		return super.getHibernateTemplate().find
		(hql).size();
	}

	public boolean delDepart(Object[] ids) {
		// TODO Auto-generated method stub
		String hql="update Department set delflag=1 where id in(:ids)";
		Query query=this.getSession().createQuery(hql);
		query.setParameterList("ids",ids);
		int i=query.executeUpdate();
		if(i>0)
			return true;
		return false;
	}

	public List selDepart(int first, int max, String addhql) {
		// TODO Auto-generated method stub
		String hql="from Department where delflag=0"+addhql+" order by id desc";
		Query query=this.getSession().createQuery(hql);
		query.setFirstResult(first);
		query.setMaxResults(max);
		return query.list();
	}

	public boolean addOrUpdateDepartment(int mark,Department dep) {
		// TODO Auto-generated method stub
		boolean flag=true;
		try
		{
			if(mark==1){
				this.getHibernateTemplate().save(dep);
			}
			else{
				this.getHibernateTemplate().update(dep);
			}
		}
		catch(Exception ex)
		{
			flag=false;
			logger.error("添加或更新出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public List selEmp() {
		String hql="from Employee where delflag=0";
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	public Department onedep(String addhql) {
		String hql="from Department where 1=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		Department dep=null;
		if(query.list()!=null){
			dep=(Department)query.list().get(0);
		}
		return dep;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		Pages pages=null;
		try
		{
			pages=super.paginationQuery(hql, pageNo, pageSize, values);
			System.out.println(pages);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("下架单分页时出错Dao",ex);
		}
		return pages;
	}

}

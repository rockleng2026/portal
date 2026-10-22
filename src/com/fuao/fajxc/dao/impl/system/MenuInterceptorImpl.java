/**
 * 
 */
package com.fuao.fajxc.dao.impl.system;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.dao.system.MenuInterceptorDao;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.WorkpositionEmployee;

/**
 * @author 蔡亚俊
 *
 * 2011-7-20
 */
public class MenuInterceptorImpl extends HibernateDaoSupport implements MenuInterceptorDao {

	/**
	 * 根据用户名和密码，获得该用户对象
	 * @param loginname
	 * @param password
	 * @return
	 */
	public Users getUsersByLoginName(String loginname,String password)
	{
		Users user = new Users();
		
		user.setLoginName(loginname);
		
		user.setPassword(password);
		String hql="from Users where loginName=? and password=? and delflag=0";
		Query query=this.getSession().createQuery(hql);
		query.setParameter(0, user.getLoginName());
		query.setParameter(1, user.getPassword());
		Users users = new Users();
		
		if(query.list().size()>0)
		{
			users = (Users)query.list().get(0);
		}
		else {
			users.setUserId(0);
		}
		return users;
	}
	
	/**
	 * 根据用户id查询该用户是否存在访问权限
	 * @param userid
	 * @return
	 */
	public RoleFunctionInfo isExistsPermissionByUserId(int userid)
	{
		System.out.println("execute isExistsPermissionByUserId........");
		String hql = "from RoleFunctionInfo rff where rff.users.userId=?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, userid);
		List list = query.list();
		System.out.println(list.size());
		
		if(list.size()>0)
		{
			RoleFunctionInfo rff=(RoleFunctionInfo)list.get(0);
			if(rff.getRoleFunctionId()>0)
			{
				return rff;
			}
		}
		RoleFunctionInfo rff = new RoleFunctionInfo();
		rff.setRoleFunctionId(0);
		
		return rff;
	}
	
	/**
	 * 获取对象列表
	 * @param tableName
	 * @param andhql
	 * @return
	 */
	public List getObject(String tableName,String andhql)
	{
		String hql = " from "+tableName+" where 1=1 "+andhql;
		System.out.println("hql : "+hql);
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
	
	/************
	 * 根据部门编号找到岗位
	 */
	public List<Workposition> positionList(int deptid){
		List<Workposition> wpolist=new ArrayList<Workposition>();
		// 注20241030 String hql="from WorkpositionEmployee where employee.id="+deptid+" and positiontype=1";
		String hql="from WorkpositionEmployee where employee.id="+deptid;
		List<WorkpositionEmployee> wpelist=this.getHibernateTemplate().find(hql);
		for(int i=0;i<wpelist.size();i++){
			WorkpositionEmployee wpe=wpelist.get(i);
			Workposition wpo=wpe.getWorkposition();
			wpolist.add(wpo);
		}
		//String hql="from Workposition where department.id="+deptid;
		return wpolist;
		
	}
	
	/*********
	 * 得到当前登录人
	 */
	public Employee getObj(String loginname){
		String hql="from Employee where empNo='"+loginname+"'";
		List list=this.getHibernateTemplate().find(hql);
		Employee emp=new Employee();
		if(list!=null && list.size()>0){
			emp=(Employee)list.get(0);
		}
		return emp;
	}
}

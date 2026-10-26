/**
 * 
 */
package com.fuao.fajxc.dao.impl.system;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.dao.system.RoleSystemDao;
import com.fuao.fajxc.utilinterface.PublicMissionType;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.UserGroupInfo;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.Workgrade;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.WorkpositionEmployee;

/**
 * @author 蔡亚俊
 *
 * 2011-7-13
 */
public class RoleSystemDaoImpl extends HibernateDaoSupport implements RoleSystemDao {

	/**
	 * 获得所有角色列表
	 * @return
	 */
	public List<Roles> getRolesList()
	{
		String hql = "from Roles";
		Query query = this.getSession().createQuery(hql);
		List<Roles> rolelist = query.list();
		if(rolelist.size()>0)
		{
			return rolelist;
		}
		return null;
	}
	
	/**
	 * 新增或修改角色信息
	 * @param role
	 * @return
	 */
	public int saveOrUpdateRole(Roles role)
	{
		int  result = 0;
		this.getSession().saveOrUpdate(role);
		if(this.isExistsRole(role.getRoleName()))
		{
			result = 1;
		}
		return result;
	}
	
	/**
	 * 查询是否存在该角色
	 * @param roleid
	 * @return
	 */
	public boolean isExistsRole(String rolename)
	{
		System.out.println("isExistsRole......... ");
		System.out.println(" rolename : "+rolename);
		boolean flag = false;
		Roles roles = this.getObject(rolename);
		if(roles.getRoleName()!=null)
		{
			System.out.println(roles.getRoleName());
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 查询角色信息
	 * @param rolename
	 * @return
	 */
	public Roles getObject(String rolename)
	{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa     "+ rolename);
		String hql = "from Roles r where r.roleName= ?";
		Query query = this.getSession().createQuery(hql);
		query.setString(0, rolename);
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		Roles roles = new Roles();
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		if(query.list().size()>0)
		{System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbb");
			roles = (Roles)query.list().get(0);;
			return roles;
		}
		return roles;
	}
	
	/**
	 * 查询角色信息
	 * @param rolename
	 * @return
	 */
	public Roles getObject(int roleId)
	{
		String hql = "from Roles r where r.roleId= ?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, roleId);
		Roles roles = new Roles();
		if(query.list().size()>0)
		{
			roles = (Roles)query.list().get(0);;
			return roles;
		}
		return roles;
	}
	
	/**
	 * 根据id删除角色
	 * @param roles
	 * @return
	 */
	public int delRole(Roles roles)
	{
		System.out.println("delRole .........................");
		int result = 0;
		Roles role1 = this.getObject(roles.getRoleId());
		this.getSession().delete(roles);
		Roles role = this.getObject(roles.getRoleId());
		System.out.println("abcd  : "+role.getRoleId());
		if(role.getRoleId()==null)
		{
			result = 1;
		}
		return  result;
	}
	
	/**
	 * 根据用户名和密码，获得该用户对象
	 * @param loginname
	 * @param password
	 * @return
	 */
	public Users getUsersByLoginName(String loginname,String password)
	{
		String hql="from Users where loginName=? and password=? and isAI=0";
		Query query = this.getSession().createQuery(hql);
		query.setString(0, loginname);
		query.setString(1, password);
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
	 * 删除role_Function_info
	 * @param groups
	 * @return
	 */
	public boolean deleteRoleFunctionInfo(RoleFunctionInfo info)
	{
		boolean flag=true;
		try
		{
			this.getHibernateTemplate().delete(info);
		}
		catch(Exception ex)
		{
			logger.error("删除角色错误",ex);
			flag=false;
			ex.printStackTrace();
		}
		return flag;
	}
	/************
	 * 根据部门编号找到岗位
	 */
	public List<Workposition> positionList(int empid){
		List<Workposition> wpolist=new ArrayList<Workposition>();
		// 得到员工对象
		Employee emp=(Employee) this.getObject(Employee.class,empid);
		if(emp.getName().equals("admin")){ // 如果是系统管理员就有设置岗位权限的功能。
			// 根据当前登录人得到这个人员主岗
			String hql="from WorkpositionEmployee where employee.id="+empid+" and positiontype=1";//１先查主岗
			List<WorkpositionEmployee> wpelist=this.getHibernateTemplate().find(hql);
			if(wpelist.size()<=0){
				Workposition wokp=new Workposition();
				wokp.setName("系统管理员");
				wokp.setDepartment(emp.getDepartment());
				wokp.setShortname("XTGLY");
				wokp.setFunctionIDs(PublicMissionType.functions);
				wokp.setPermissions(PublicMissionType.option);
				Workgrade grade=(Workgrade)this.getObject(Workgrade.class, 1);
				wokp.setWorkgrade(grade);
				wokp.setWorkcontent("");
				wokp.setIspersonman(1);
				wpolist.add(wokp);
				 this.getHibernateTemplate().save(wokp);
				// 添加审核员工对象
				WorkpositionEmployee workemp=new WorkpositionEmployee();
				workemp.setWorkposition(wokp);
				workemp.setEmployee(emp);
				workemp.setPositiontype(1);
				this.getHibernateTemplate().save(workemp);
			}else{
				for(int i=0;i<wpelist.size();i++){
					WorkpositionEmployee wpe=wpelist.get(i);
					Workposition wpo=wpe.getWorkposition();
					wpolist.add(wpo);
				}
			}
		}else{
			// 根据当前登录人得到这个人员主岗
			String hql="from WorkpositionEmployee where employee.id="+empid+" and positiontype=1";
			List<WorkpositionEmployee> wpelist=this.getHibernateTemplate().find(hql);
			for(int i=0;i<wpelist.size();i++){
				WorkpositionEmployee wpe=wpelist.get(i);
				Workposition wpo=wpe.getWorkposition();
				wpolist.add(wpo);
			}
		}
		return wpolist;		
	}
	
	/******
	 * 根据编号找到对象
	 */
	public Object getObject(Class clazz, Integer id){
		return  super.getHibernateTemplate().get(clazz, id);
	} 
	/*********
	 * 根据hql语句找到集合
	 */
	public List getlist(String hql){
		return this.getHibernateTemplate().find(hql);
	}
}

package com.fuao.fajxc.dao.position;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.pagefunction;

public class PositionDaoImpl extends BaseDaoImpl implements PositionDao {

	public List getAllPositionList() {
		String hql="from Workposition";
		return this.getHibernateTemplate().find(hql);
	}
	
	/**
	 * 获取所有功能菜单
	 * @return
	 */
	public List<FunctionInfo> getAllFunctions()
	{
		String hql = "from FunctionInfo";
		Query query = this.getSession().createQuery(hql);
		List<FunctionInfo> functionlist = query.list();
		if(functionlist.size()>0)
		{
			return functionlist;
		}
		return null;
	}
	
	/**
	 * 获取superID下功能菜单
	 * @param superId
	 * @return
	 */
	public List<FunctionInfo> getFunctionsBySuperId(int superId)
	{
		String hql = "from FunctionInfo info where info.superId="+superId+" order by delflag";
		System.out.println("sql : "+hql);
		Query query = this.getSession().createQuery(hql);
		List<FunctionInfo> superfunctionlist = query.list();
		return superfunctionlist;
	}
	
	/**
	 * 查询岗位信息
	 * @param rolename
	 * @return
	 */
	public Workposition getObject(int positionid)
	{
		String hql = "from Workposition r where r.id= ?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, positionid);
		Workposition position=new Workposition();
		if(query.list().size()>0)
		{
			position = (Workposition)query.list().get(0);;
			return position;
		}
		return position;
	}
	
	/**
	 * 新增岗位信息
	 * @param role
	 * @return
	 */
	public int addPosition(Workposition position)
	{
		int  result = 0;
		String hql="INSERT INTO workposition(name,shortname,deptid,workcontent,edittime,functionIDs,permissions) VALUES('"+position.getName()+"','"+position.getShortname()+"',"+position.getDepartment().getId()+",'"+position.getWorkcontent()+"','"+position.getEdittime()+"','"+position.getFunctionIDs()+"','"+position.getPermissions()+"')";
		Session session= this.getSession();
		Query query= session.createSQLQuery(hql);
		int i= query.executeUpdate();
		System.out.println(i);
		//this.getSession().saveOrUpdate(position);
		if(this.isExistsRole(position.getName()))
		{
			result = 1;
		}
		return result;
	}
	
	/**
	 * 修改岗位信息
	 * @param role
	 * @return
	 */
	public int updatePosition(Workposition position)
	{
		int  result = 0;
		String hql="UPDATE Workposition SET functionIDs='"+position.getFunctionIDs()+"',permissions='"+position.getPermissions()+"' WHERE id="+position.getId()+"";
		Session session= this.getSession();
		Query query= session.createQuery(hql);
		int i= query.executeUpdate();
		System.out.println(i);
		//this.getSession().saveOrUpdate(position);
		if(this.isExistsRole(position.getName()))
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
	public boolean isExistsRole(String positionname)
	{
		System.out.println("isExistsRole......... ");
		System.out.println(" positionname : "+positionname);
		boolean flag = false;
		Workposition position = this.getObject(positionname);
		if(position.getName()!=null)
		{
			System.out.println(position.getName());
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 查询角色信息
	 * @param rolename
	 * @return
	 */
	public Workposition getObject(String positionname)
	{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa     "+ positionname);
		String hql = "from Workposition p where p.name= ?";
		Query query = this.getSession().createQuery(hql);
		query.setString(0, positionname);
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		Workposition position=new Workposition();
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		if(query.list().size()>0)
		{
			System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbb");
			position = (Workposition)query.list().get(0);;
			return position;
		}
		return position;
	}
	
	/*********
	 * 根据菜单页面编号得到其对应的页面功能集合
	 */
	public List<pagefunction> pagefunctionlist(int functionid){
		String hql="from pagefunction where function.id="+functionid;
		return this.getHibernateTemplate().find(hql);
	}

	/*********
	 * 修改岗位信息
	 */
	public void update(Workposition position){
		String hql="UPDATE Workposition SET name='"+position.getName()+"',shortname='"+position.getShortname()+"',edittime='"+position.getEdittime()+"',department.id="+position.getDepartment().getId()+",workcontent='"+position.getWorkcontent()+"',functionIDs='"+position.getFunctionIDs()+"',permissions='"+position.getPermissions()+"' WHERE id="+position.getId()+"";
		Session session= this.getSession();
		Query query= session.createQuery(hql);
		int i= query.executeUpdate();
	}
}

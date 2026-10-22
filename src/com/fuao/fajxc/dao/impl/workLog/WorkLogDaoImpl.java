package com.fuao.fajxc.dao.impl.workLog;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.workLog.WorkLogDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.fuao.fajxc.vo.Scheduleplan;
import com.fuao.fajxc.vo.WorkLog;

public class WorkLogDaoImpl extends BaseDaoImpl implements WorkLogDao{

	/**
	 * 执行sql语句
	 * @author 阙超强 14015
	 * @date 2011-12-23 10:52:52
	 */
	public String executeSql(String sql) {
		Query query = this.getSession().createSQLQuery(sql);
		String returnValue = "";
		List list =query.list();
          if(list != null && list.size()>0){
        	  returnValue= list.get(0).toString();
        	  returnValue = returnValue.substring(1);
          }
          
		return returnValue;
	}
	/****
	 * 根据存sql语句查找到集合
	 */
	public List exeWorksql(String now,String date,int deptid,int empid){
		String writesql="SELECT id FROM employee WHERE id IN (SELECT empId FROM  workLog WHERE TYPE=0 AND recordTime>='"+now+"' AND recordTime<'"+date+"') AND delflag=0";
		if(deptid!=-1){
			writesql+=" AND department="+deptid;
		}
		if(empid!=-1){
			writesql+=" AND id="+empid;
		}
		Query query = this.getSession().createSQLQuery(writesql);
		return query.list();
	}
	/******
	 * 根据员工编号得到员工集合
	 */
	public Object getEmp(Class clazz, Integer id){
		return this.getHibernateTemplate().get(clazz, id);
	}
	/**
	 * 执行sql语句
	 */
	public String exeDeptSql(String sql) {
		Query query = this.getSession().createSQLQuery(sql);
		String returnValue = "";
		List list =query.list();
          if(list != null && list.size()>0){
        	  returnValue= list.get(0).toString();
          }
          
		return returnValue;
	}
	
	  /**
	   * 文章列表分页
	   */
//	public List splitPages(int current,int row,String sql) {
//	    System.out.println(current);
//	    System.out.println(row);
//		Session session = (Session)super.getSessionFactory().getCurrentSession();
////		Query query = session.createQuery("from Fa_Cms_News order by cid desc");
////		query.setFirstResult(current);
////		query.setMaxResults(row);	
////		List<Fa_Cms_News> list=(List<Fa_Cms_News>)query.list();
////		System.out.println(list.size());
//		return printList(list);
//	}
	
	//组装数据
	@SuppressWarnings("unchecked")
	public List printList(List<Object[]> liss){
	
			Session session = (Session)super.getSessionFactory().getCurrentSession();
			Query query = session.createQuery("from Employee where delflag=0");
			query.setFirstResult(1);
			query.setMaxResults(15);	
		System.out.println(""+liss.size());
		List list=new ArrayList();
		int count=1;
		for(int i=0;i<liss.size();i++){
			   Object[] obj=liss.get(i);	
				Map m=new HashMap();
				m.put("id", obj[0]);
				m.put("dept",obj[3]);
				m.put("zw",obj[2]);
				m.put("empname",obj[1]);
				m.put("log", obj[4]);
				m.put("pOper","aa");
				list.add(m);
		}
			    return list;
	}
	
	
	//执行SQL语句
	public List exeSQLQuery(String sql){
		Session session = this.getSession();
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}

	/******
	 * 根据员工ID得到这个员工今天有没有请假
	 */
	public List getLeavesimpleByEmpid(int empid,String time){
		// 请假的开始时间
		String hql="from Leavesimple where empid="+empid;
		if(time.trim().length()>0){
			hql+=" and begintime<='"+time+"' and endtime>='"+time+"'";
		}
		List list=this.getHibernateTemplate().find(hql);
		System.out.println(list.size());
		return list;
	}
	
	/******
	 * 根据员工ID得到这个员工这个月的未写日志天数。
	 */
	public List yueQjDate(int empid,int mon){
		// 请假的开始时间
		//MONTH(begintime)>=4<MONTH(endtime)
		String hql="from Leavesimple where empid="+empid+" and MONTH(begintime)<="+mon+" and MONTH(endtime)>="+mon;
		List list=this.getHibernateTemplate().find(hql);
		System.out.println(list.size());
		return list;
	}
	
	public boolean updateWorkLog(String replyContent,int empNo,String date,List workLogID)
	{
		boolean result = false;
		Session session = this.getSession();
		Transaction t = null;
		
		
		try
		{
			//
			t = session.beginTransaction();
			String hql = "update WorkLog as wl set wl.replyContent =:replyContent,wl.isView = 1,wl.replyTime=:replyTime,wl.employeeByReplier.id =:empNo where wl.id in (:ids) ";
			String hql1 = " from WorkLog wl where wl.id in (:ids)";
			String hql2 = "update AuditingOrderTab aot set aot.handlestate = 2, aot.auditingFlag =1 ,aot.tmp =:tmp where aot.orderNo =:logNo";
			
			Query query = session.createQuery(hql);
			query.setString("replyContent", replyContent);
			query.setString("replyTime", date);
			query.setInteger("empNo", empNo);
			query.setParameterList("ids", workLogID);
			query.executeUpdate();
			
			Query query1 = session.createQuery(hql1);
			query1.setParameterList("ids",workLogID);
			List workLogs = query1.list();
			
			for(int i = 0 ; i < workLogs.size();i++)
			{
				WorkLog workLog = (WorkLog) workLogs.get(i);
				Query query2 = session.createQuery(hql2);
				query2.setString("tmp",replyContent);
				query2.setString("logNo", workLog.getLogNo());
				query2.executeUpdate();
			}
			t.commit();
			result = true;
		}
		catch(Exception e)
		{
			result = false;
			t.rollback();
			e.printStackTrace();
		}
		return result;
	}

	public WorkLog getLogById(int ID)
	{
		WorkLog workLog = null;
		
		try
		{
			workLog = (WorkLog) super.getHibernateTemplate().get(WorkLog.class, ID);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return workLog;
	}

	public List getByIds(Object[] ids) 
	{
		List list = new ArrayList();
		
		try
		{
			Object[] obj=new Object[ids.length];
			
			for(int i=0;i<obj.length;i++)
			{
				obj[i]=Integer.parseInt(ids[i].toString().trim());
			}
			String hql = "from WorkLog wl where wl.id in (:ids)";
			Session session = super.getHibernateTemplate().getSessionFactory().getCurrentSession();
			Query query = session.createQuery(hql);
			query.setParameterList("ids",obj);
			list = query.list();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return list;
	}
	public List getDepartment() 
	{
		
		List list = null;
		
		try
		{
			list = this.getHibernateTemplate().find("from Department");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	public List getEmployee(int id) 
	{
		List list = null;
		
		try
		{
			list = this.getHibernateTemplate().find("from Employee where department.id = "+id);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 根据部门得到子类部门
	 */
	public List getGroup(int parentID) 
	{
		List list = null;
		
		try
		{
			list = 	this.getHibernateTemplate().find("from Department where parentId="+parentID);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values)
	{
		Pages pages = null;
		
		try {
			pages = super.paginationQuery(hql, pageNo,pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("分页时出错",e);
		}
		
		return pages;
	}
	/***
	 * 添加日程记事
	 */
	public void addSch(Object sch){
		this.getHibernateTemplate().save(sch);
	}
	
	/******
	 * 添加访问记录
	 */
	public void addRecord(Executerecord record){
		this.getHibernateTemplate().save(record);
	}
	
	/********
	 * 修改对象
	 */
	public void updateObj(Object obj){
		 this.getHibernateTemplate().update(obj);
		 
	}
	
}

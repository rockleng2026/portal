package com.fuao.fajxc.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.bussiness.LoginBussiness;
import com.fuao.fajxc.bussiness.impl.LoginBussinessImpl;
import com.fuao.fajxc.dao.LoginDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Users;
import com.fuao.fajxc.vo.VerifyOrder;

public class LoginDaoImpl extends HibernateDaoSupport implements LoginDao {

	/*
	 * 用户登录(non-Javadoc)
	 * @see com.fuao.fajxc.dao.LoginDao#UserLogin(java.lang.String, java.lang.String)
	 */
	public boolean UserLogin(Users users) {
		boolean flag=true;
		String hql="from Users where loginName=? and password=? and delflag=0";
		Query query=this.getSession().createQuery(hql);
		query.setParameter(0, users.getLoginName());
		query.setParameter(1, users.getPassword());
		//System.out.println(query.list().size());
		if(query.list().size()<1)
			flag=false;
		return flag;
	}
	
	
	
	public static void main(String[] args)
	{
		ApplicationContext ac=new FileSystemXmlApplicationContext
		("/src/applicationContext*.xml");
		LoginBussiness ldi=(LoginBussinessImpl) ac.getBean("Loginbussiness");
//		Users users=new Users();
//		users.setLoginName("蔡志鹏");
//		users.setPassword("admin");
//		boolean flag=ldi.UserLogin(users);
//		Logger logger = Logger.getLogger(LoginDaoImpl.class);
//		logger.info("登录名为"+users.getLoginName());
//		System.out.println(flag);
		Employee emp=(Employee) ldi.selEmpOrCus("employee", 3);
		System.out.println(emp.getName());
}



	public Object selEmpOrCus(String mark,int id) {
		System.out.println("mark:"+mark);
		if(mark.equals("employee"))
		{
			String hql="from Employee where id="+id;
			Query query=this.getSession().createQuery(hql);
			System.out.println(((Employee)query.list().get(0)).getName());
			return (Employee)query.list().get(0);
		}
		else
		{
			String hql="from Customer where id="+id;
			Query query=this.getSession().createQuery(hql);
			return (Customer)query.list().get(0);
		}
	}

	/**
	 * 待办事项提醒，根据审核流程表得到对象
	 * @param hql
	 * @return
	 */
	public List<AuditingOrderTab> getAuditingOrder(String hql )
	{
		List<AuditingOrderTab> list = new ArrayList<AuditingOrderTab>();
		System.out.println(hql);
		Query query = this.getSession().createQuery(hql);
		Iterator it = query.list().iterator();
		while(it.hasNext())
		{
			Object[] obj = (Object[]) it.next();
			AuditingOrderTab tab = new AuditingOrderTab();
			tab.setTmp(obj[0].toString());
			String vhql = "from VerifyOrder where id = "+obj[1].toString();
			System.out.println("vhql : "+vhql);
			List<VerifyOrder> orderlist = this.getObjectList(vhql);
			if(orderlist.size()>0)
			{
				tab.setVerifyOrder(orderlist.get(0));
			}
			list.add(tab);
		}
		return list;
	}
	
	public List getObjectList(String hql)
	{
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}

	public List executionSql(String sql)
	{
		return this.getHibernateTemplate().find(sql);
	}

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

}

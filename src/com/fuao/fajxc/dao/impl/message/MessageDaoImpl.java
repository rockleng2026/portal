package com.fuao.fajxc.dao.impl.message;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.message.MessageDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Message;
import com.fuao.fajxc.vo.Messagereceiver;

public class MessageDaoImpl extends BaseDaoImpl implements MessageDao{

	public boolean addData(Message data) throws Exception {
		super.add(data);
		return true;
	}
	/**
	 * 据HQL语句查询所有
	 * 
	 */
	public List<Message> exHql(String hql) {
		List<Message> datas=null;
		try {
		datas=super.execHQL(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return datas;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
			Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
			
			 System.out.println(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	public Message getMessagedata(String id) {
		try {
			return (Message) super.select(Message.class,Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateData(Message data)throws Exception  {
			super.update(data);
			return true;
	}
	/**
	 * 
	 */
	public List getObjectList(String hql )
	{
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
	/**
	 * 查询对象
	 * @author 阙超强 
	 * 2011-11-22 14:02:28
	 */
	public Object getObject(String hql){
		Object o = this.getSession().createQuery(hql).uniqueResult();
		return o;
	}
	/**
	 * 删除信息
	 * @return
	 */
	public boolean delmessage(Object[] ids) {
		System.out.println("int[].length:");
		boolean flag=false;
		String hql="update Messagereceiver set delfalg=1 where receiverid in(:ids)";
		Query query=this.getSession().createQuery(hql);
		query.setParameterList("ids", ids);
		int i=query.executeUpdate();
		if(i>0)
			flag=true;
		return flag;
	}
	
	/**
	 * 读取信息
	 * @return
	 */
	public boolean duqumessage(Object[] duqu) {
		//获得当前时间
		//获取系统当前时间并格式成为字符串
		Date d = new Date(); 

		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat( "yyyy-MM-dd HH:mm:ss ");  
	    String str3 = dateFormat.format(d);
	    
		
		System.out.println("int[].length:");
		boolean flag=false;
		for(int i=0;i<duqu.length;i++)
		{
			String hql="update Messagereceiver set readfalg=1,receivetime='"+str3+"' where message='"+duqu[i]+"'";
			System.out.println(hql);
			Query query=this.getSession().createQuery(hql);
			int a=query.executeUpdate();
			if(a>0)
			{
				flag=true;
			}
			else
			{
				return false;
			}
		}
		
		return flag;
	}
	/**
	 * 读取信息
	 * @return
	 */
	public boolean duqu1message(Object[] duqu) {
		//获得当前时间
		//获取系统当前时间并格式成为字符串
		Date d = new Date(); 

		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat( "yyyy-MM-dd HH:mm:ss ");  
	    String str3 = dateFormat.format(d);
	    
		
		System.out.println("int[].length:");
		boolean flag=false;
		for(int i=0;i<duqu.length;i++)
		{
			String hql="update Message set tmp1=1,releasetime='"+str3+"' where messageid='"+duqu[i]+"'";
			System.out.println(hql);
			Query query=this.getSession().createQuery(hql);
			int a=query.executeUpdate();
			if(a>0)
			{
				flag=true;
			}
			else
			{
				return false;
			}
		}
		
		return flag;
	}
	/**
	 * 读取的时候修改状态
	 */
	public boolean dumessage(int id){
		//当前时间
		Date d = new Date(); 

		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat( "yyyy-MM-dd HH:mm:ss ");  
	    String str3 = dateFormat.format(d);
	    
	    boolean flag=false;
		String hql="update Messagereceiver set readfalg=1,receivetime='"+str3+"' where message ='"+id+"'";
	    Query query=this.getSession().createQuery(hql);
	    int i=query.executeUpdate();
	    if(i>0)
	    {
	    	flag=true;
	    }
		return flag;
	}
	/**
	 * 删除信息Message
	 * @return
	 */
	public boolean delsendmes(Object[] ids) {
		System.out.println("int[].length:");
		boolean flag=false;
		String hql="update Message set delfalg=1 where messageid in(:ids)";
		Query query=this.getSession().createQuery(hql);
		query.setParameterList("ids", ids);
		int i=query.executeUpdate();
		if(i>0)
			flag=true;
		return flag;
	}
	public boolean delMessage(int id){
		boolean flag=false;
		
		String hql1="update Messagereceiver set delfalg=1 where receiverid="+id+"";
		Query query=getSession().createQuery(hql1);
		int i=query.executeUpdate();
		if(i>0)
		{
			flag=true;
		}
		return flag;
	}
	
	/**
	 * 删除信息类型Message
	 * @return
	 */
	public boolean delmesstype(Object[] ids) {
		System.out.println("int[].length:");
		boolean flag=false;
		String hql="update Messagetype set delflag=1 where messagetypeid in(:ids)";
		Query query=this.getSession().createQuery(hql);
		query.setParameterList("ids", ids);
		int i=query.executeUpdate();
		if(i>0)
			flag=true;
		return flag;
	}
	
	/**
	 * 得到所有项目名称
	 */
	public List getAllProject(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	
	/******
	 * 根据员工编号得到员工集合
	 */
	public Object getEmp(Class clazz, Integer id){
		return this.getHibernateTemplate().get(clazz, id);
	}
	/*****
	 * 保存对象
	 */
	public void addReceiver(Object obj){
		this.getHibernateTemplate().update(obj);
	}
	
	/********
	 * 添加保存对象
	 */
	public void addObject(Object obj){
		this.getHibernateTemplate().save(obj);
	}
	/******
	 * 修改对象　
	 */
	public void updateObj(Object obj){
		this.getHibernateTemplate().update(obj);
	}
	/******
	 * 删除对象　
	 */
	public void delObj(Object obj){
		this.getHibernateTemplate().delete(obj);
	}
}

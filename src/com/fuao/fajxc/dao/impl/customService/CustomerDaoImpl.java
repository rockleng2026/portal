package com.fuao.fajxc.dao.impl.customService;


import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.dao.customService.CustomServiceDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.MD5;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.DeliveryAddress;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.UpServer;
import com.fuao.fajxc.vo.Users;
import com.jspsmart.upload.Request;
import com.sun.org.apache.bcel.internal.generic.DALOAD;

public class CustomerDaoImpl extends BaseDaoImpl implements CustomServiceDao {

	/**
	 * 客户登录验证
	 */
	public Customer customerLogin(String loginId,String password) {
		Customer c = new Customer();
		c.setCustomerPassword(password);
		c.setCustomerName(loginId);
		System.out.println(password);
		String hql = "from Customer where customerName = ? and customerPassword = ?";
		Query query = this.getSession().createQuery(hql);
		query.setParameter(0, c.getCustomerName());
		query.setParameter(1, c.getCustomerPassword());
		List users = query.list();
		if(null != users && users.size()>0)
		{
			return (Customer)users.get(0);
		}else
			
		return null;
	}

	public Users custrmerRegister(Customer custom) {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean updateUserLoginInfo(Users user) {
		try {
			super.update(user);
		} catch (Exception e) {
			
			e.printStackTrace();
			
			return false;
		}
		return true;
	}

	/**
	 * 查询客户信息
	 */
	public Customer getcustomer(int id) {
		try {
			Customer customer = (Customer)super.select(Customer.class, id);
			return customer;
		} catch (Exception e) {
			
			e.printStackTrace();
			return null;
		}
		
	}

	public List getorder(String orderType,int customerId) {
		//String hql = "from SaleOrder s where s.customer.customerId="+customerId+" and s.allTypeByOrdertype.id="+Integer.parseInt(orderType)+"";
		//将s.allTypeByOrdertype.id 关联改为s.Questioncategory.id  将前端提交工单选择的产品类型结合起来
		//modify by lzy 2012-7-16
		String hql = "from SaleOrder s where s.customer.customerId="+customerId+" and s.allTypeByOrdertype.id="+Integer.parseInt(orderType)+"";
		Query query = this.getSession().createQuery(hql);
		List list = query.list();
		if(null != list)
		{
			return list;
		}
		return null;
	}

	public boolean addconkOut(ConkOut co) {
		try {
			this.add(co);
			
			return true;
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			return false;
		}
	}

	/**
	 * 添加客户
	 * @param customer
	 * @return
	 */
	public Customer addCustomer(Customer customer)
	{
		boolean flag = false ; 
		try
		{
			this.getHibernateTemplate().save(customer);
			System.out.println(" c:  "+customer.getCustomerId()+"  "+customer.getCustomerName());
//			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("添加客户出错",ex);
		}
		return customer ;
	}
	/**
	 * 修改客户
	 * @param customer
	 * @return
	 */
	public boolean updateCustomer(Customer customer)
	{
		boolean flag = false ; 
		try
		{
			this.getHibernateTemplate().merge(customer);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("添加客户出错",ex);
		}
		return flag ;
	}
	
	public List getList(String hql)
	{
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
  /**
   * 插入客户登录的ip和时间。以及查询最近交易费用 14032
   */
	public List selcust(String loginid,String ip) {
		
		List<String> list1 = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date time = null;
		sdf.format(new Date());
		//插入时间和ip
		String SQLT = sdf.format(new Date());
		System.out.println(SQLT);
		String hql = "UPDATE Customer SET localip='" + ip + "' , historytime='"
				+ SQLT + "' WHERE  customerName='" + loginid + "'";
		System.out.println(hql);
		Query query = this.getSession().createQuery(hql);
		query.executeUpdate();
		//查询最近消费金额
		String sel1="select customer_id from customer where customer_name='"+loginid+"'";
		Query query1 = this.getSession().createSQLQuery(sel1);
		List<Integer> list=query1.list();
		Integer oInteger = 0; //客户id
		for (int i = 0; i < list.size(); i++) {
		 oInteger=list.get(0);
		}
		
		if(oInteger!=0){
		String sel2="select rechargemonery from rechargeLog where customerId="+oInteger;
		Query query2 = this.getSession().createSQLQuery(sel2);
		 list1=query2.list();
		}
		return list1;
	}

public String iscustomer(String loginid) {
	String sel1="select customer_type2 from customer where customer_name='"+loginid+"'";
	Query query1 = this.getSession().createSQLQuery(sel1);
	List<String> list=query1.list();
	String oInteger = "0"; //客户id
	for (int i = 0; i < list.size(); i++) {
		if(list.get(0)!=null){
	 oInteger=list.get(0);
		}
	}
	int x=Integer.parseInt(oInteger);
	if(x==3){
		return "3";
	}else{
	return "0";
	}
}

//修改密码
public boolean updatePassword(String newpass1 ,String logininame) {
	Customer c = new Customer();
	c.setCustomerPassword(newpass1);
	c.setCustomerName(logininame);
	boolean  f=false;
	String sql="update Customer c set c.customerPassword=?   where  customerName=?";
	try {
		Query query = this.getSession().createQuery(sql);
		query.setParameter(0, c.getCustomerPassword());
		query.setParameter(1, c.getCustomerName());
		query.executeUpdate();
		f=true;
	} catch (Exception e) {
	}
	return f;
}


public List selaudState(String paratid) {
	String sql="from SaleOrder where id="+paratid;
	Query query=this.getSession().createQuery(sql);
	List list=query.list();
	
	
	return list;

}


public boolean saveAddress(DeliveryAddress deliveryAddress) {
	System.out.println(deliveryAddress.getCustomer().getCustomerId());
	System.out.println(deliveryAddress.getPhones());
	boolean falg=false;
	try {
		super.getHibernateTemplate().save(deliveryAddress);
		falg=true;
		
	} catch (Exception e) {
		falg=false;
	}  
	
	return falg;
}



public Customer getCustomid(String loginname) {
	Customer c=null;
	String sql="from Customer  where customer_name='"+loginname+"'";
	Query query=this.getSession().createQuery(sql);
	List<Customer> list=query.list();
	System.out.println(list.size());
	for (int i = 0; i < list.size(); i++) {
		Object obj=list.get(0);
		System.out.println(obj);
		
		 c=(Customer)obj;
	}
	
	
	 System.out.println(c.getCustomerId());
   
	 return c;
  }
  



public List selupserver() {
	String sqlString=" from UpServer WHERE delflag=0 ";
	Query query=(Query) this.getSession().createQuery(sqlString);
	
	
	return query.list();
	
}

public void qdorder(String idString) {
	
	String hqlString="update SaleOrder set auditingState=0 where id="+idString;
	
	Query query=(Query) this.getSession().createQuery(hqlString);
	query.executeUpdate();
}

public void qrorder(String idString) {
String hqlString="update SaleOrder set isgetorder=1 where id="+idString;
	
	Query query=(Query) this.getSession().createQuery(hqlString);
	query.executeUpdate();
}

public List<DeliveryAddress> getAddress(Customer customer){
//	String sql3="select count(*) from  delivery_address  where cusid="+customer.getCustomerId()+"";
//	Query query1=this.getSession().createSQLQuery(sql3);
//	List<Integer> l1=query1.list();
//	Integer x=0;
//	for (int i = 0; i < l1.size(); i++) {  
//		   x=l1.get(0);
//	}
//	 int x1=x-5;
	String sql="from DeliveryAddress  where customer='"+customer.getCustomerId()+"' order by addressId desc";
	Query query=this.getSession().createQuery(sql);
	query.setFirstResult(0);
	query.setMaxResults(5);
	List<DeliveryAddress> list=query.list();
	return list;
 }

public DeliveryAddress getDaliver(String id) {
	DeliveryAddress d=null;
 	String  sql="from DeliveryAddress  where addressId='"+id+"'";
 	Query query=this.getSession().createQuery(sql);
 	
 	List<DeliveryAddress> d1=  query.list();
	for (int i = 0; i <d1.size(); i++) {
		d=d1.get(0);
	}
	return d;
}

public void delAddress(String id) {
	String hql="delete  from  delivery_address  where address_id ="+id+"";
	Query query=this.getSession().createSQLQuery(hql);
	query.executeUpdate();
}

public boolean updateAddress(DeliveryAddress deli) {
	boolean b=false;
	try {
		super.update(deli);
		b=true;
	} catch (Exception e) {
		e.printStackTrace();
		b=false;
	}
	return b;
}

public void addsql(String sql0) {
	Query query=this.getSession().createSQLQuery(sql0);
	query.executeUpdate();
	
}

public List getSgByCode(String sgcode){
	String hql = "from Sale_goods where sgcode="+sgcode+" order by sgId desc";
	List list = this.getHibernateTemplate().find(hql);
	return list;
}

}
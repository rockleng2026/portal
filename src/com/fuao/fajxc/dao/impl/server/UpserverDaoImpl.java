package com.fuao.fajxc.dao.impl.server;

import java.util.List;


import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.hql.ast.HqlASTFactory;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.impl.purchase.PurOrderDaoImpl;
import com.fuao.fajxc.dao.server.UpserverDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.UpServer;

public class UpserverDaoImpl extends BaseDaoImpl implements UpserverDao {

	private static Logger logger = Logger.getLogger(UpserverDaoImpl.class);
	
	public boolean addupServer(UpServer us) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().saveOrUpdate(us);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("添加上架单时出错",ex);
		}
		return flag;
	}

	public boolean delupServer(Object[] ids) {
		boolean flag=false;
		try
		{
			String hql="update UpServer set delflag=1 where id in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids",ids);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("上架单删除时出错Dao",ex);
		}
		return flag;
	}

	public boolean editupServer(UpServer us) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(us);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("修改上架单时出错Dao",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages pages=null;
		try
		{
			pages=super.paginationQuery(hql, pageNo, pageSize, values);
			System.out.println(pages);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("上架单分页时出错Dao",ex);
		}
		return pages;
	}

	public List someupServer(String addhql) {
		String hql="from UpServer where delflag=0 "+addhql;
		System.out.println("upserverDaoimpl"+hql);
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	public boolean executeHql(String hql) {
		boolean flag=false;
		try
		{
			Query query=this.getSession().createQuery(hql);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	public List findByIPs(String hql) {
		 Query query = this.getSession().createQuery(hql);
	     return query.list();
	}

	public void updIPs(IPConfiguration ipc) {
		this.getHibernateTemplate().merge(ipc);
		
	}
	
	//根据仓库id查询服务器信息
	public List getServersByDepotid(int depotid) {
		String hql = "from Product where depot.id="+depotid;
		return this.getHibernateTemplate().find(hql);
	}
	//根据机房id查询机柜信息
	public List getCabinetByElecthouse(int cabinetid) {
		String hql = "from Cabinet where Telecthouse.electId="+cabinetid;
		return this.getHibernateTemplate().find(hql);
	}

	public List getCustomers() {
		try {
			String hql = "from Customer";
			Session session = this.getSessionFactory().getCurrentSession();
			Query query = session.createSQLQuery(hql);
		//	Session session = this.getSessionFactory().getCurrentSession();
		//	Query query = session.createSQLQuery(hql);
			List list = query.list();
		//	List list = this.getHibernateTemplate().find(hql);
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}

	public List getElectHouse() {
		String hql = "from ElectHouse where 1 = 1";
		List list = this.getHibernateTemplate().find(hql);
		return list;
	}
	
	public List getSaleorderBySaleorderId(int saleorderId){
		String hql = "from SaleOrder where id="+saleorderId;
		List list = this.getHibernateTemplate().find(hql);
		return list;
	}
	
	public Object getCustomerByPK(Class clazz,int customerid){
		String hql = "from Customer where customerId="+customerid;
		return this.getHibernateTemplate().get(Customer.class, customerid);
	}
	
	public void addUpserver(Object obj){
		this.getHibernateTemplate().save(obj);
	}
	
	public List getAll(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	
	public Object getObjectById(Class clazz,Integer id){
		return this.getHibernateTemplate().get(clazz, id);
	}
	
	public List getUpserverByServerId(int serverid){
		String hql = "from UpServer where product.id="+serverid;
		return this.getHibernateTemplate().find(hql);
	}
	
	/**
     * 根据上架单号查询其对象
     */
	public List getUpserverByUpNo(String upNo){
		String hql = "from UpServer where upNo='"+upNo+"'";
		return this.getHibernateTemplate().find(hql);
	}
	
	public void updateObj(Object obj){
		this.getHibernateTemplate().update(obj);
	}
	
	public boolean updObject(Object obj){
		this.getHibernateTemplate().update(obj);
		return true;
	}

}

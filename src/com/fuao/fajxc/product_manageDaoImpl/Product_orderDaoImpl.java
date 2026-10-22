package com.fuao.fajxc.product_manageDaoImpl;

import java.util.List;

import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.product_manageDao.prodect_OrderDao;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.DeliveryAddress;
import com.fuao.fajxc.vo.SaleGoods_mids;
import com.fuao.fajxc.vo.Sale_goods;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.UpServer;
import com.fuao.fajxc.vo.VerifyOrderEmployee;
import com.fuao.fajxc.util.Pages;

public class Product_orderDaoImpl extends BaseDaoImpl implements prodect_OrderDao {

	
	public boolean Delete(Object obj) {
		// TODO Auto-generated method stub
		return true;
	}

	public Object save(Object obj) {
		this.getHibernateTemplate().save(obj);
		return null;
	}

	public Object selectById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public List selectByall(String hql) {
		// TODO Auto-generated method stub
		return super.execHQL(hql);
	}

	public List selectall() {
		// TODO Auto-generated method stub
		return null;
	}

	public Object Update(Object obj) {
		
		//this.getHibernateTemplate().update(obj);a
	
		try {
			return this.update(obj);  
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
  public Pages  paginationQuery(final String hql, final int pageNo,final int pageSize, final Object... values){
	  
	return super.paginationQuery( hql, pageNo, pageSize, values);
  }

	public Object saleDoodsById(int id) {
		String hql="from Sale_goods where sgId="+id;
		List list=this.getHibernateTemplate().find(hql);
		Sale_goods goos=new Sale_goods();
		if(list.size()>0){
			for (int i = 0; i < list.size(); i++) {
				goos=(Sale_goods) list.get(0);
			}
		}
		return goos;
	}

	public int updateUpdate(String str,int id) {
		String sql="update  sale_goods  set sg_stat =2,sg_puttime='"+str+"' where sg_id="+id+"";
		int val=this.getSession().createSQLQuery(sql).executeUpdate();
		return val;
	}

	public int undercarriage(int id) {
		String sql="update  sale_goods  set sg_stat =0 where sg_id="+id+"";
		int val=this.getSession().createSQLQuery(sql).executeUpdate();
		return val;
	}
//////////////////////
	public String undercarriageup(int id) {
        int m=0;
		Session session=this.getSessionFactory().getCurrentSession();
		String sql="update  sale_goods  set sg_stat =2 where sg_id="+id+"";
		int val=session.createSQLQuery(sql).executeUpdate();
	 	Sale_goods sgds=(Sale_goods) this.getHibernateTemplate().get(Sale_goods.class, id);
    	List<AuditingOrderTab> sList=this.getHibernateTemplate().find("from AuditingOrderTab where orderNo='"+sgds.getSgcode()+"'");
    	for (AuditingOrderTab auditingOrderTab : sList) {
    			auditingOrderTab.setAuditingFlag(10);
    			auditingOrderTab.setDeldate(1);
    		try{
    		session.beginTransaction();
    		session.update(auditingOrderTab);
    		session.getTransaction().commit();
    		}catch (Exception e) {
    			session.getTransaction().rollback();
			}
    		
		}
		return val+","+sgds.getSgcode();
	}

	/*
	 * 删除商品a
	 */
	public int delsg(Object[] ids) {
		String sql = "update  sale_goods  set sg_stat =0 where sg_id in (:ids)";
		Query query = this.getSession().createSQLQuery(sql);
		query.setParameterList("ids", ids);
		
		int count = query.executeUpdate();
		return count;
	}
	
	/*
	 * 删除资源核实单
	 */
	public int delRC(Object[] ids) {
		String sql = "delete from t_resourceCheck  where id in (:ids)";
		Query query = this.getSession().createSQLQuery(sql);
		query.setParameterList("ids", ids);
		int count = query.executeUpdate();
		return count;
	}
	
	public int addAuditingOrder2(String otype, String oNo, String entityName,
			String filialemark) {
		
		//定义查询出该种单据的审核流程列表hql
		String hql = "  from VerifyOrderEmployee v where v.verifyOrder.ordertype.mark='"+otype+"'";
		//执行hql返回审核流程中的审核员工
		List<VerifyOrderEmployee> list = null;
		try{
			list = execHQL(hql);
		}catch(Exception e){
			e.printStackTrace();
		}
		//如果list为null表示该种类型的单据无需审核
		if(null == list || list.size()<=0){
			return 0;
			//如果审核流程不为null则向审核表中插入数据
		}else{
			String aa="0";
			for(int i=0; i<list.size(); i++){
				
				//创建审核表对象
				AuditingOrderTab aot = new AuditingOrderTab();
				
				aot.setAuditingFlag(0);
				aot.setDeldate(0);
				aot.setAuditingOrder(Integer.parseInt(list.get(i).getOrderVerify()));
				
				System.out.println(Integer.parseInt(list.get(i).getOrderVerify()));
				aot.setDepartment(list.get(i).getDepartment());
				
				System.out.println(list.get(i).getDepartment());
				aot.setOrderNo(oNo);
				
				System.out.println(oNo);
				aot.setMark(list.get(i).getVerifyState());
				aot.setEmpOrdept(list.get(i).getVerifyOrder().getEmpOrdept());
				System.out.println(list.get(i).getVerifyOrder().getEmpOrdept());
				System.out.println(list.get(i).getVerifyState());
				aot.setEmployees(list.get(i).getEmployees());
				System.out.println(list.get(i).getEmployees()+"***********");
				if(i==0 ||list.get(i).getOrderVerify().equals(aa))
				{
					aot.setHandlestate(1);
					aa=list.get(i).getOrderVerify();
				}
				else
				{
					aot.setHandlestate(0);
				}
				addAuditingOrder(aot);
			}
			
			return 2;
			}				
	}
	public boolean addAuditingOrder(AuditingOrderTab aot) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(aot);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	public Object get(Class clazz, Integer id) {
		Object obj = this.getHibernateTemplate().get(clazz, id);
		return obj;
	}

	public List selSomeGoods_dict(String addhql) {
	
		Query query=this.getSession().createQuery("from Sale_goods where 1=1 "+addhql);
		System.out.println(query.list().size()+"===============");
		return query.list();
	}



	public Sale_orders add(Sale_orders orders) {
		try {
			this.getHibernateTemplate().save(orders);
			return orders;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	



	public List someauditingOrder(String addhql) {
		String hql="from AuditingOrderTab where 1=1 "+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	public boolean checkemp(String orderNo,String empid){
		boolean flag=false;
		List<AuditingOrderTab> alist=someauditingOrder(" and orderNo='"+orderNo+"' and handlestate=1 and (incepttime='' or incepttime=null )");
		if(alist!=null && alist.size()>0)
		{

			for(int i=0;i<alist.size();i++)
			{
				if(alist.get(i).getEmployees().equals(empid))
				{
					flag=true;
				}
			}
		}
		return flag;
	}

	public boolean checkemp1(String orderNo,String empid){
		boolean flag=false;
		List alist=someauditingOrder(" and orderNo='"+orderNo+"'");
		if(alist!=null && alist.size()>0){
			for(int j=0;j<alist.size();j++)
			{
				if(((AuditingOrderTab)alist.get(j)).getEmployees().equals(empid))
				{
					return flag=true;
				}
			}
		}
		return flag;
	}


	public void updatsql(String sql) {
	Session session=this.getSessionFactory().getCurrentSession();
	Query query=session.createQuery(sql);
	query.executeUpdate();
		
	}


	public void addsm(SaleGoods_mids goodsMids) {
		boolean falg = false;
		try {
			this.getHibernateTemplate().save(goodsMids);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean updateRC(String sql) {
		boolean falg = false;
		Query query = this.getSession().createSQLQuery(sql);
		int count = query.executeUpdate();
		if(count>0)
		{
			falg = true;
		}
		return falg;
	}

	public String exeSql(String sql) {
			Query query = this.getSession().createSQLQuery(sql);
			String returnValue = "";
			List list =query.list();
	          if(list != null && list.size()>0){
	        	  returnValue= list.get(0).toString();
	        	  returnValue = returnValue.substring(1);
	          }
	          
			return returnValue;
	}

	public DeliveryAddress add(DeliveryAddress address) {
		try {
			this.getHibernateTemplate().save(address);
			return address;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean update(String cusid, String addressid) {
		
		boolean falg = false;
		
		String upsql = "update delivery_address set def='1' where address_id ="+new Integer(addressid);
		Query query = this.getSession().createSQLQuery(upsql);
		int count = query.executeUpdate();
		
		String upsqls = "update delivery_address set def='0' where address_id not in("+addressid+") and cusid ="+new Integer(cusid);
		Query query1 = this.getSession().createSQLQuery(upsqls);
		int num = query1.executeUpdate();
		if(count>0)
		{
			falg = true;
		}
		return falg;
	}

	public UpServer add(UpServer server) {
		try {
			this.getHibernateTemplate().save(server);
			return server;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}

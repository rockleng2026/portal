package com.fuao.fajxc.serser.dao;

import java.util.List;

import javax.transaction.SystemException;

import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.hql.ast.tree.FromClause;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.vo.Cabinet;
import com.fuao.fajxc.vo.DownServer;
import com.fuao.fajxc.vo.ElectHouse;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.Users;

import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.LogTab;

import com.fuao.fajxc.vo.Product;

import com.fuao.fajxc.vo.SaleOrder;



import com.fuao.fajxc.vo.UpServer;

public class SerajaxDaoImpl extends HibernateDaoSupport implements SerajaxDao{

	public boolean deleteDate(Object obj) {
		ElectHouse et = (ElectHouse) obj;
		this.getHibernateTemplate().delete(et);
		return true;
	}

	public Object getObjDate(int id) {
		try{
			Thread.sleep(100);
		}catch (Exception e) {
		}
		return this.getHibernateTemplate().get(Cabinet.class,id);
	}

	public List getdateList(Object obj) {
		int m =(Integer) obj;
		return this.getHibernateTemplate().find("from ElectHouse where electId <>"+m);
	}

	public boolean saveDate(Object obj) {
       	return false;
	   
	}

	public boolean updateDate(Object obj) {
	    Cabinet cabinet =(Cabinet) obj;
	    this.getHibernateTemplate().merge(cabinet);
		return true;
	  
	}

	public List selList() {
		System.out.println("I dao");
		return this.getHibernateTemplate().find("from ElectHouse");
	}

	public void Add(Cabinet cabinet) {
		 this.getHibernateTemplate().save(cabinet);
	}
	//机房，机柜
	public Object getConmensById(Class clazz, Integer id) {
		return this.getHibernateTemplate().get(clazz, id);
	}

	public List get(Integer id) {
		String hql = "from Cabinet where electId ="+id;
		Query query = this.getSession().createQuery(hql);
		List list = query.list();
		return list;
	}

	public void delEle(ElectHouse electHouse) {
		String hql = "delete from ElectHouse e where e.electId = "+electHouse.getElectId();
		Query query = this.getSession().createQuery(hql);
		int num = query.executeUpdate();
		if(num>0)
		{
//			System.out.println("执行了.");
		}
	}

	public void delCabin(Cabinet cabinet) {
          this.getHibernateTemplate().delete(cabinet);
	}

	public List findEle(String electName) {
		String hql = "from ElectHouse where electName=?";
		Query query  = this.getSession().createQuery(hql);
		query.setString(0, electName);
		List list = query.list();
		return list;
	}

	public void saveEle(ElectHouse electHouse) {
		this.getHibernateTemplate().save(electHouse);
	}


	public List selbyUps(int p, int s) {
		System.out.println("p="+p+"s="+s);
		return this.getHibernateTemplate().find("from UpServer u where u.Tupcabs.caid="+p+" "+"and (u.upFlag=1 OR u.upFlag=2)");
	}

	public void updateCab(Cabinet cabinet){
		String hql = "update Cabinet c set ";
		if(cabinet.getCaname().trim() != "" && cabinet.getCaname() !=null )
		{
			hql+="c.caname='"+cabinet.getCaname()+"'";
		}
		if(cabinet.getCasz() != null)
		{
			hql+= ",c.casz="+cabinet.getCasz();
		}
		if(cabinet.getBwmax() != null)
		{
			hql+=",c.bwmax="+cabinet.getBwmax();
		}
		if(cabinet.getPmax() != null)
		{
			hql += ",c.pmax="+cabinet.getPmax();
		}
		if(cabinet.getUseSize() !=null){
			hql += ",c.useSize="+cabinet.getUseSize();
		}
		if(cabinet.getTelecthouse() !=null){
			hql += ",c.Telecthouse.electId="+cabinet.getTelecthouse().getElectId();
		}
		hql += "  where c.caid="+cabinet.getCaid();
		Query query = this.getSession().createQuery(hql);
		int num = query.executeUpdate();
		if(num >0)
		{
			System.out.println("修改成功!");
		}
	}
	
	public Cabinet delC(Integer caid)
	{
		String hql = "delete from Cabinet where caid="+caid;
		Query query = this.getSession().createQuery(hql);
		Cabinet cabinet = (Cabinet)query.list().get(0);
		return cabinet;
	}
	public UpServer selByserID(int m) {
		return (UpServer) this.getHibernateTemplate().get(UpServer.class,m);
	}


	public boolean updUpserv(UpServer up) {
		this.getHibernateTemplate().merge(up);
	    return true;
	}

	public List find(Integer caid) {
		System.out.println("caidnnnn="+caid);
        Query query = this.getSession().createQuery("from Cabinet c where c.caid <>"+caid+"  and c.Telecthouse.superid<>0");
		return query.list();
	}



	public int selAllLoggers(int m) {
		Query query = this.getSession().createQuery("select count(*) from LogTab t where t.Tupve.id="+m);
		int pm = Integer.parseInt(query.uniqueResult().toString());
		return pm;
	}

	@SuppressWarnings("unchecked")
	public List spliPages(int current, int size, int m) {
	    Query query = this.getSession().createQuery("from LogTab t where t.Tupve.id="+m);
	    query.setFirstResult(current);
	    query.setMaxResults(size);
		return query.list();
	}

	public boolean addDownSer(DownServer dow) {
             return false;
	}

	@SuppressWarnings("unchecked")
	public List getOnceObject(Class oneClass, String names,String values) {
		System.out.println("class="+oneClass.getName()+","+oneClass.getComponentType());
		return this.getHibernateTemplate().find("from "+oneClass.getName()+" "+"c where  c."+names + "='"+values+"'");
	}



	public Product findPr(Integer pid) {
		String hql = "from Product as p where p.id"+pid;
		return null;
	}

	public List findUp(Integer serverid) {
		String hql = "from UpServer as u where u.Tupcabs.caid=?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, serverid);
		return query.list();
	}

	public List<ElectHouse> findEle() {
		String hql = "from ElectHouse e where substring(e.electCode,3,2)='00'";
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}

	public void updateinC(Integer electid,Integer caid) {
		String hql = "update Cabinet as c set c.Telecthouse.electId=? where c.caid=?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, electid);
		query.setInteger(1,caid);
		int num = query.executeUpdate();
		if(num >0 )
		{
//			System.out.println("修改!");
		}
	}

	public List findByC(Integer electid) {
		String hql = "from Cabinet as c where c.Telecthouse.electId=?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, electid);
		return query.list();
	}

	public List<Cabinet> findAll() {
		String hql = "from Cabinet";
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}

	public void updateU(Integer caid, Integer id) {
		String hql = "update UpServer as u set u.Tupcabs.caid = ? where u.id=?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, caid);
		query.setInteger(1, id);
		int num = query.executeUpdate();
		if(num > 0 )
		{
//			System.out.println("修改!");
		}
	}

	public List<SaleOrder> findAllSale(String mt) {
		String hql = "from SaleOrder where saleOrderNo='"+mt+"'";
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}

	public List<Product> findAllPro() {
		String hql = "from Product";
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}

	public List<UpServer> findCabUper(int caid) {
		Query query =this.getSession().createQuery("from UpServer u where u.marknum is not null and u.Tupcabs.caid="+caid);
		List list = query.list();
		System.out.println("list size="+list.size());
		return list;
	}

	public int saveupser(UpServer ups) {
//		 try{
//	    this.getSession().beginTransaction();
//	    this.getSession().save(ups);
//	    this.getSession().getTransaction().commit();
//	    }catch (Exception e) {
//	      e.printStackTrace();
//	      this.getSession().beginTransaction().rollback();
//		}
		this.getHibernateTemplate().save(ups);
		return ups.getId();
	}
	public List getsaleNode(String node) {
		return this.getHibernateTemplate().find("from SaleOrder where saleOrderNo='"+node+"'");
	}

	public List getProductList(int m) {
		return this.getHibernateTemplate().find("from Product p where p.property.id="+m);
	}

	public List getStorage() {
		return this.getHibernateTemplate().find("from Depot");
	}
    //入仓库表
	public List getstorageId(int mp) {
		return this.getHibernateTemplate().find("from Product p where p.depot.id="+mp);
	}

	public boolean updateAllupsers(UpServer us) {
//		  this.getSession().beginTransaction();
//			try{
//			    this.getSession().merge(us);
//			    this.getSession().getTransaction().commit();
//			}catch (Exception e) {
//			   this.getSession().getTransaction().rollback();
//			   e.printStackTrace();
//			}
		this.getHibernateTemplate().merge(us);
	         if(us.getUpFlag()==2){
		       return true;
	         }else{
	        	 return false;
	         }
	     
	}

	public List getUsersAll(String logname) {
		return this.getHibernateTemplate().find("from Users where loginName='"+logname+"'");
	}
    //修改状态
	public void updaUperStat(UpServer us) {
//		try{
//		this.getSession().beginTransaction();
//		this.getSession().merge(us);
//		this.getSession().getTransaction().commit();
//		}catch (Exception e) {
//			this.getSession().getTransaction().rollback();
//		}
		this.getHibernateTemplate().merge(us);
	}

	public int saveDownSers(DownServer ds) {
		this.getHibernateTemplate().save(ds);
		return ds.getId();
	}

	public void upsaveStats(UpServer ups) {
		try{
		this.getSession().beginTransaction();
		this.getSession().merge(ups);
		this.getSession().getTransaction().commit();
		}catch (Exception e) {
			this.getSession().getTransaction().rollback();
		}
		
	}
    //获取最高房间编码
	public List getRoomCode(String hsql) {
	    Query query = this.getSession().createQuery(hsql);
		return query.list();
	}
    public ElectHouse getElehouseObj(int id){
    	return (ElectHouse) this.getHibernateTemplate().get(ElectHouse.class, id);
    }
    //Ip操作
	public List IPManage(String hsql) {
		 Query query = this.getSession().createQuery(hsql);
	     return query.list();
	}

	public void updatIPs(IPConfiguration ipc) {
		
		this.getHibernateTemplate().merge(ipc);
		
	}

	public void updateHouses(ElectHouse ehse) {
		
		this.getHibernateTemplate().merge(ehse);
		
	}
}

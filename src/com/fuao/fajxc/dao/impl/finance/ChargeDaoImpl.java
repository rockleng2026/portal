package com.fuao.fajxc.dao.impl.finance;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.bussiness.finance.ChargeBussiness;
import com.fuao.fajxc.bussiness.impl.finance.ChargeBussinessImpl;
import com.fuao.fajxc.dao.finance.ChargeDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.impl.basic.SupplierDaoImpl;
import com.fuao.fajxc.util.paging.Page;
import com.fuao.fajxc.vo.Charge;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Sale_orders;
public class ChargeDaoImpl extends BaseDaoImpl  implements ChargeDao{
	

	private static Logger logger = Logger.getLogger(SupplierDaoImpl.class);
	public List<Charge> getCharge() {
		
		String hql="from Charge where del=0 Order By id desc ";
		Query query=this.getSession().createQuery(hql);
        return query.list();

	}

	/**
	 * 添加收款单
	 * @param Charge 收款单实体
	 * @return boolean true添加成功：false 添加失败；
	 */
	public boolean addCharge(Charge charge) {
		try{
			
			charge.setDel("0");                              //新添加 收款单信息设置删除标记为0
		this.getHibernateTemplate().saveOrUpdate(charge);
		}catch (Exception e) {
			logger.error(e);
			return false;
		}
		return true;
	}

	/**
	 * 用ID查询收款单信息
	 */
	public Charge getCharge(String id) {
		logger.debug("getting Charge instance with id: " + id);
		try {
			Charge Charge=null;
			    String hql="from Charge e where e.id=?";
			    Query query=this.getSession().createQuery(hql);
			    query.setParameter(0, Integer.parseInt(id));
			    if(query.list()!=null){
			    	Charge=(Charge) query.list().get(0);
			    }
			    return Charge;
		} catch (RuntimeException re) {
			logger.error("get Charge", re);
			throw re;
		}
	}

	/**
	 * 根据ID删除收款单信息
	 * 先根据传人的id查询出实体  
	 * 在更新实体的del标记为1
	 */
	public boolean delCharge(String id) {
		try{
			Charge Charge = getCharge(id);
			Charge.setDel("1");
			getHibernateTemplate().update(Charge);
			}catch (Exception e) {
				logger.error(e);
				return false;
			}
			return true;
		}

	/**
	 * 修改收款单信息
	 */
	public boolean updaCharge(Charge charge) {
		try{
		getHibernateTemplate().update(charge);
		}catch (Exception e) {
			logger.error(e);
			return false;
		}
		return true;
	}

	/**
	 * 获取收款单信息的总条数
	 */
	public int getProductCount() {
		String hql="from Charge where del=0 ";
		Query query=this.getSession().createQuery(hql);
        return query.list().size();
		}

	/**
	 * 分页查询收款单信息
	 */
	public List getProductByPage(final Page page ,final String hql) {
		return this.getHibernateTemplate().executeFind(new HibernateCallback(){
		public Object doInHibernate(Session session) throws HibernateException, SQLException {
		Query query=session.createQuery("from Charge where 1=1 and del=0 "+hql +"Order By id desc");
		query.setFirstResult(page.getBeginIndex()); //hibernate分页的精髓 呵呵
		System.out.println(page.getEveryPage());
		query.setMaxResults(page.getEveryPage());
		return query.list();
		}
		});
		}

	/**
	 * 查询员工信息
	 */
	public List getEmp() {
		String hql="from Employee where delflag=0  ";
		Query query=this.getSession().createQuery(hql);
        return query.list();
	}

	/**
	 * 查询订单信息
	 */
	public List getSaleOrder() {
		String hql="from SaleOrder ";
		Query query=this.getSession().createQuery(hql);
        return query.list();
	}

	public SaleOrder getSaleOrderOne(int id) {
		String hql="from SaleOrder where id=?";
		Query query=this.getSession().createQuery(hql);
		query.setParameter(0, id);
        return (SaleOrder)query.list().get(0);
	}
	public Sale_orders getSaleOrderOnes(int id) {
		String hql="from Sale_orders where soId=?";
		Query query=this.getSession().createQuery(hql);
		query.setParameter(0, id);
        return (Sale_orders)query.list().get(0);
	}

	
	
	public static void main(String[] args) {
		ApplicationContext ctx = new ClassPathXmlApplicationContext("application*.xml");
		ChargeDao c =(ChargeDaoImpl) ctx.getBean("chargeDao");
		List<Charge> l = c.getCharge();
		System.out.println(l.size());
	}

	public boolean updateSg(String hql) {
		boolean falg = false;
		Query query = this.getSession().createSQLQuery(hql);
		int count = query.executeUpdate();
		if(count >0)
		{
			falg = true;
		}
		return falg;
	}

	public List find(String hql) {
		return this.getHibernateTemplate().find(hql);
	}



}

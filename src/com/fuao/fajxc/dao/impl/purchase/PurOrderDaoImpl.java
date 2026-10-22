package com.fuao.fajxc.dao.impl.purchase;

import java.io.Serializable;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.fuao.fajxc.action.LoginAction;
import com.fuao.fajxc.bussiness.purchase.PurOrderBussiness;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.purchase.PurOrderDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.PurOrder;
import com.fuao.fajxc.vo.PurOrderInfo;


public class PurOrderDaoImpl extends BaseDaoImpl implements PurOrderDao {

	private static Logger logger = Logger.getLogger(PurOrderDaoImpl.class);
	/**
	 *
	 * 添加采购单
	 *
	 */
	public boolean addPurOrder(PurOrder purO) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(purO);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("采购订单添加出错",ex);
		}
		return flag;
	}
	
	/**
	 * 添加采购单 返回对象
	 * @author 阙超强 14015
	 * @param purO
	 * @return PurOrder
	 */
	public PurOrder addPurOrderReturn(PurOrder purO){
		try {
			super.getHibernateTemplate().saveOrUpdate(purO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return purO;
	}

	public boolean delPurOrder(Object[] ids) {
		boolean flag=false;
		try
		{
			String hql="update PurOrder set delflag=1 where id in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids",ids);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("采购订单删除时出错",ex);
		}
		return flag;
	}

	public boolean editPurOrder(PurOrder purO) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(purO);
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("采购订单修改时出错",ex);
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
			logger.error("分页时出错",ex);
		}
		return pages;
	}
	
	public static void main(String[] args)
	{
		ApplicationContext ac=new FileSystemXmlApplicationContext
		("/src/applicationContext*.xml");
		PurOrderBussiness pb=(PurOrderBussiness)ac.getBean("purOrderBussiness");
//		Pages pages=pb.exHqlPages("from PurOrder where delflag=0 order by id desc", 1, 10, null);
//		System.out.println(pages.getPageList().size());
//		PurOrder purO=new PurOrder();
//		purO.setPrice(34.3);
//		System.out.println(pb.addPurOrder(purO));
		//根据条件查找list
		//System.out.println(pb.selSomePurOrder(" and id=25"));
		//删除info
		List list=pb.selsomePurOrderinfo(2, 11);
		System.out.println(list.size());
	}

	public List selSomePurOrder(String addhql) {
		// TODO Auto-generated method stub
		Query query=this.getSession().createQuery("from PurOrder where delflag=0"+addhql);
		return query.list();
	}

	public boolean addPurOrderInfo(PurOrderInfo poi) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().save(poi);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("添加采购订单时出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean delPurOrderInfo(String addhql) {
		boolean flag=false;
		try
		{
			String hql="delete from PurOrderInfo where 1=1"+addhql;
			Query query=this.getSession().createQuery(hql);
			int tes=query.executeUpdate();
			if(tes>0)
				flag=true;
		}
		catch(Exception ex)
		{
			logger.error("删除时出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}

	public boolean updatePurOrderInfo(PurOrderInfo poinfo) {
		boolean flag=false;
		try
		{
			this.getHibernateTemplate().update(poinfo);
			flag=true;
		}
		catch(Exception ex)
		{
			logger.error("更新时出错",ex);
		}
		return flag;
	}

	public boolean delPurOrderInfo(Object[] ids) {
		boolean flag=false;
		try
		{
			String hql="update PurOrderInfo set priceDelflag=1 where id in (:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids",ids);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("删除时出错",ex);
		}
		return flag;
	}

	/**
	 * 根据purid获取purOrderInfo表中列表
	 * @return
	 */
	public List getPurOrderInfoById(String addhql)
	{
		String hql = "from PurOrderInfo where priceDelflag=0 "+addhql;
		System.out.println("hql : "+hql);
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	public List selsomePurOrderinfo(int num,int modelId) {
		String hql="from PurOrderInfo where modelId="+modelId+" order by id desc";
		Query query=this.getSession().createQuery(hql);
		query.setMaxResults(num);
		return query.list();
	}

	
}

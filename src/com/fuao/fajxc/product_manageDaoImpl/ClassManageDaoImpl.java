package com.fuao.fajxc.product_manageDaoImpl;

import java.io.Serializable;
import java.util.List;

import javax.jms.Session;

import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.product_manageDao.ClassManageDao;
import com.fuao.fajxc.util.Page;
import com.fuao.fajxc.util.Pager;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.GoodsClass_expand;
import com.fuao.fajxc.vo.Goods_dict;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.RechargeLog;
import com.fuao.fajxc.vo.SaledFlow;
import com.fuao.fajxc.vo.UpServer;

public class ClassManageDaoImpl extends HibernateDaoSupport implements ClassManageDao{

	public Object save(Object obj)throws Exception{
		if(obj instanceof Goods_dict){
			Goods_dict gct=(Goods_dict) obj;
			this.getHibernateTemplate().save(gct);
			return gct;
		}else{
			GoodsClass_expand gex=(GoodsClass_expand) obj;
			this.getHibernateTemplate().save(gex);
			return gex;
		}
	}

	public Object selectById(int id) {
		Goods_dict gDict=(Goods_dict) this.getHibernateTemplate().get(Goods_dict.class, id);
		return gDict;
	}

	@SuppressWarnings("unchecked")
	public List selectByall(String hql) {
		return this.getHibernateTemplate().find(hql);
	}

	public List selectall() {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean Delete(Object obj) {
		// TODO Auto-generated method stub
		return false;
	}

	public Object Update(Object obj) {
		if(obj instanceof Goods_dict){
			Goods_dict gDict=(Goods_dict) obj;
			try{
		    this.getSession().beginTransaction();
		    this.getSession().merge(gDict);
		    this.getSession().getTransaction().commit();
			}catch (Exception e) {
				this.getSession().getTransaction().rollback();
			}
	        return gDict;
		}else{
			GoodsClass_expand exp=(GoodsClass_expand) obj;
			try{
		    this.getSession().beginTransaction();
		    this.getSession().merge(exp);
		    this.getSession().getTransaction().commit();
			}catch (Exception e) {
				this.getSession().getTransaction().rollback();
			}
	        return exp;
		}
	}

	public Object saleDoodsById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public int undercarriage(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int updateUpdate(String str, int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	public void add(Object data) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public Object addReturnObject(Object data) {
		// TODO Auto-generated method stub
		return null;
	}

	public int countSql(String sql) {
		// TODO Auto-generated method stub
		return 0;
	}

	public void del(Class cs, String primaryKey) {
		// TODO Auto-generated method stub
		
	}

	public List execHQL(String hql) {
		// TODO Auto-generated method stub
		return null;
	}

	public List execSQL(String sql) {
		// TODO Auto-generated method stub
		return null;
	}

	public List execSQLByPage(String sql, int offset, int pagesize) {
		// TODO Auto-generated method stub
		return null;
	}

	public int execSQLUpdate(String sql) {
		// TODO Auto-generated method stub
		return 0;
	}

	public Integer findByDetachedCriteria(DetachedCriteria detachedCriteria) {
		// TODO Auto-generated method stub
		return null;
	}

	public List findByDetachedCriteriaPage(DetachedCriteria detachedCriteria,
			int offset, int length) {
		// TODO Auto-generated method stub
		return null;
	}

	public Object getObj(String loginName) {
		// TODO Auto-generated method stub
		return null;
	}

	public List getUpserver(String hql) {
		// TODO Auto-generated method stub
		return null;
	}

	public Pages paginationQuery(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		return null;
	}

	public Pages paginationQuery(int pageNo, int pageSize,
			Class persistentClass, Criterion... criterion) {
		// TODO Auto-generated method stub
		return null;
	}

	public Pages paginationQuery(int pageNo, int pageSize, Criteria fc,
			Class persistentClass) {
		// TODO Auto-generated method stub
		return null;
	}

	public void saveFlowInfo(SaledFlow sfd) {
		// TODO Auto-generated method stub
		
	}

	public boolean saveRecharge(RechargeLog rech) {
		// TODO Auto-generated method stub
		return false;
	}

	public List selAllKinddatas(String sql) {
		// TODO Auto-generated method stub
		return null;
	}

	public Object select(Class cls, Serializable primaryKey) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public List selectOrder(String hql) {
		// TODO Auto-generated method stub
		return null;
	}

	public void updateIPs(IPConfiguration ipc) {
		// TODO Auto-generated method stub
		
	}

	public void updateSaleorder(String slaeOrderNo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void updtFlowInfo(SaledFlow sfd) {
		// TODO Auto-generated method stub
		
	}

	public void updtRecharge(RechargeLog rech) {
		// TODO Auto-generated method stub
		
	}

	public UpServer upmerger(UpServer upser) {
		// TODO Auto-generated method stub
		return null;
	}

	public void delete(Object data) throws Exception {
		this.getSession().beginTransaction();
		this.getSession().delete(data);
		this.getSession().getTransaction().commit();
	}

	public boolean update(Object data) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}
	public int selectsplits(String hql){
		Query query = this.getSession().createQuery(hql);
		return Integer.parseInt(query.uniqueResult().toString());
	}
	public Page doSplit(int pageNo, int pagesize) {
		Page page = new Page();
		int num = selectsplits("select count(*) from Goods_dict");
		Query query = this.getSession().createQuery("from Goods_dict order by gdId desc");
		query.setMaxResults(pagesize);
		query.setFirstResult(pageNo);
		page.setTotalNum(num);
		page.setCurrentPage(pageNo/pagesize+1);
		if(num%pagesize==0){
			page.setTotallyPage(num/pagesize);
		}else{
			page.setTotallyPage((num/pagesize+1));
		}
		System.out.println("query.list()="+query.list().size());
		page.setPageList(query.list());
		return page;
	}

	public Page doSplit(int pageNo, int pagesize, String name) {
		Page page = new Page();
		int num = selectsplits("select count(*) from Goods_dict where gdnames like '%"+name+"%'");
		Query query = this.getSession().createQuery("from Goods_dict where gdnames like '%"+name+"%'");
		query.setMaxResults(pagesize);
		query.setFirstResult(pageNo);
		page.setTotalNum(num);
		page.setCurrentPage(pageNo/pagesize+1);
		if(num%pagesize==0){
			page.setTotallyPage(num/pagesize);
		}else{
			page.setTotallyPage((num/pagesize+1));
		}
		System.out.println("query.list()="+query.list().size());
		page.setPageList(query.list());
		return page;
	}


	public int addAuditingOrder2(String otype, String oNo, String entityName,
			String filialemark) {
		// TODO Auto-generated method stub
		return 0;
	}
	public List selSomeGoods_dict(String addhql) {
		// TODO Auto-generated method stub
		return null;
	}

	public List someauditingOrder(String addhql) {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean checkemp(String orderNo, String empid) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean checkemp1(String orderNo, String empid) {
		// TODO Auto-generated method stub
		return false;
	}

	public String undercarriageup(int id) {
		// TODO Auto-generated method stub
		return null;
	}



}

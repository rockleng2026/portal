package com.fuao.fajxc.product_manageDao;

import java.util.List;

import org.jboss.cache.aop.ObjectGraphHandler;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;

public interface product_CommentDao extends BaseDao{
    
	public Object save(Object obj) throws Exception;
	public Object Update(Object obj);
	public boolean Delete(Object obj);
	public List selectall();
	public List selectByall(String hql);
	public Object selectById(int id);
	public Object saleDoodsById(int id);
	public int updateUpdate(String str,int id);
	public int undercarriage(int id);
	public String undercarriageup(int id);
	Pages paginationQuery(String hql, int pageNo, int pageSize, Object[] values);
	public int addAuditingOrder2(String otype,String oNo,String entityName,String filialemark);
	public List selSomeGoods_dict(String addhql);
	public List someauditingOrder(String addhql);
	public boolean checkemp(String orderNo, String empid);
	public boolean checkemp1(String orderNo,String empid);
	/*
	 * a
	 */
}

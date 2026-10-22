package com.fuao.fajxc.product_manageService;

import java.util.List;

import org.jboss.cache.aop.ObjectGraphHandler;

public interface product_CommentService {
    
	public Object save(Object obj)throws Exception;;
	public Object update(Object obj);
	public boolean delete(Object obj);
	public List selectall();
	public List selectByall(String hql);
	public Object selectById(int id);
	public Object saleDoodsById(int id);
	public int updateUpdate(String str,int id);
	public int undercarriage(int id,String ms1,String ms2,String ms3);
	public int undercarriageup(int id);
	public List selSomeGoods_dict(String addhql);
	public List someauditingOrder(String addhql);
	public int addAuditingOrder2(String otype,String oNo,String entityName,String filialemark);
	public boolean checkemp(String orderNo,String empid);
	public boolean checkemp1(String orderNo,String empid);
	/*
	 * a
	 */
	
}

package com.fuao.fajxc.product_manageServiceImpl;

import java.util.List;

import com.fuao.fajxc.product_manageDao.prodect_OrderDao;
import com.fuao.fajxc.product_manageDao.product_CommentDao;
import com.fuao.fajxc.product_manageDaoImpl.Product_orderDaoImpl;
import com.fuao.fajxc.product_manageService.Product_orderService;
import com.fuao.fajxc.product_manageService.product_CommentService;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Sale_goods;

public class Product_orderServiceImpl implements Product_orderService {
	
	private prodect_OrderDao prodect_OrderDao;

	public void setProdect_OrderDao(prodect_OrderDao prodect_OrderDao) {
		this.prodect_OrderDao = prodect_OrderDao;
	}

	public prodect_OrderDao getProdect_OrderDao() {
		return prodect_OrderDao;
	}

	public boolean delete(Object obj) {
		// TODO Auto-generated method stuba
		return prodect_OrderDao.Delete(obj);
	}

	public Object save(Object obj) {
		
		try {
			return prodect_OrderDao.save(obj);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public Object selectById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public List selectByall(String hql) {
		// TODO Auto-generated method stub
		return prodect_OrderDao.selectByall(hql);
	}

	public List selectall() {
		// TODO Auto-generated method stub
		return prodect_OrderDao.selectall();
	}

	public Object update(Object obj) {
		// TODO Auto-generated method stub
		return  prodect_OrderDao.Update(obj);
	}

	public Object saleDoodsById(int id) {
		// TODO Auto-generated method stub
		return prodect_OrderDao.saleDoodsById(id);
	}

	public Pages paginationQuery(String hql, int pageNo, int pageSize,
			final Object... values) {
		// TODO Auto-generated method stub
		return prodect_OrderDao.paginationQuery( hql, pageNo,  pageSize,
				values);
	}

	public int updateUpdate(String str,int id) {
		
		return prodect_OrderDao.updateUpdate(str,id);
	}

	public int undercarriage(int id,String ms1,String ms2,String ms3) {
		String mps[]=prodect_OrderDao.undercarriageup(id).split(",");
		System.out.println("yang.......="+ms1+","+mps[1]+","+ms2+","+ms3);
		addAuditingOrder2(ms1,mps[1],ms2,ms3);
		return Integer.parseInt(mps[0]);
		
	}

	public int undercarriageup(int id) {
		return prodect_OrderDao.undercarriage(id);
	}

	public int addAuditingOrder2(String otype, String oNo, String entityName,
			String filialemark) {
		return prodect_OrderDao.addAuditingOrder2( otype,oNo,entityName, filialemark);
	}

	public List selSomeGoods_dict(String addhql) {
		
		return prodect_OrderDao.selSomeGoods_dict(addhql);
	}
	
	public List someauditingOrder(String addhql) {
		// TODO Auto-generated method stub
		return prodect_OrderDao.someauditingOrder(addhql);
	}

	public boolean checkemp(String orderNo, String empid) {
		// TODO Auto-generated method stub
		return  prodect_OrderDao.checkemp(orderNo,empid);
	}

	public boolean checkemp1(String orderNo, String empid) {
		
		return prodect_OrderDao.checkemp1(orderNo,empid);
	}

	public void updatsql(String sql) {
		// TODO Auto-generated method stub
		prodect_OrderDao.updatsql(sql);
	} 

	/*
	 *É¾³ýshagpia
	 */
	public int delsg(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<obj.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return this.prodect_OrderDao.delsg(ids);
		
		
	}

	public int delRC(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<obj.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return this.prodect_OrderDao.delRC(ids);
	}
	
}

/**
 * 
 */
package com.fuao.fajxc.dao.impl.stockpile;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.util.Assert;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.stockpile.StockpileDetailsDao;
import com.fuao.fajxc.util.PageBuilder;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;

/**
 * @author 蔡亚俊
 *
 * 2011-7-29
 */
public class StockpileDetailsDaoImpl extends BaseDaoImpl implements StockpileDetailsDao {

	/**
	 * 根据条件查询产品信息列表，也可以不传条件
	 * @param andhql
	 * @return
	 */
	public List getProductList(String andhql)
	{
		Query query = this.getSession().createQuery(andhql);
		if(query.list().size()>0)
		{
			return query.list();
		}
		return null;
	}
	
	/**
	 * 查询仓库中产品列表
	 * @param hql
	 * @return
	 */
	public List getProductByDepot(String hql)
	{
		Query query = this.getSession().createQuery(hql);
		Iterator it=query.list().iterator();
		List<Product> products = new ArrayList<Product>();
		
		while(it.hasNext())
		{
			Object[] obj = (Object[])it.next();
			Product product = new Product();
			System.out.println(" length : "+obj.length);
			for(int i=0;i<obj.length;i++)
			{
				
				System.out.println(" ["+(i+1)+"] "+obj[i]);
			}
			Depot depot = (Depot)getObject("from Depot where del = 0 and id = "+obj[0]);
			System.out.println(depot.getId());
			Property property = (Property)this.getObject("from Property where delflag = 0 and id = "+obj[1]);
			System.out.println(property.getId());
			
			int shelfcount = getCount("from Product where depot.id = "+obj[0]+" and property.id = "+obj[1]+" and usestate = 0");
			int buttomcount = getCount("from Product where depot.id = "+obj[0]+" and property.id = "+obj[1]+" and usestate = 1");
			
			product.setDepot(depot);
			product.setProperty(property);
			product.setTmp2(shelfcount+"");
			product.setTmp1(buttomcount+"");
			
			products.add(product);
		}
		
		System.out.println(products.size());
		if(products.size()>0)
		{
			return products;
		}
		return null;
	}
	
	/**
	 * 查询商品数量
	 * @param andhql
	 * @return
	 */
	public int getCount(String andhql)
	{
		System.out.println("and hql : "+andhql);
		Query query = this.getSession().createQuery(andhql);
		int result = (Integer)query.list().size();
		if(result>0)
		{
			return result;
		}
		return 0;
	}
	
	/**
	 * 获取对象
	 * @param andhql
	 * @return
	 */
	public Object getObject(String hql)
	{
		System.out.println("hql : "+hql);
		Query query = this.getSession().createQuery(hql);
		return query.list().get(0);
	}
	
	/**
	 * 遍历对象分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlObjectPages(String hql,int pageNo,int pageSize,
			Object... values) 
	{
		Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}
	
	/**
	 * 遍历字段分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(final String hql,final int pageNo,final int pageSize,
			final Object... values) {
		Assert.hasText(hql);
		return (Pages) getHibernateTemplate().execute(new HibernateCallback() {

			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				String countQueryString = " select count (*) " + removeSelect(removeOrders(hql));
				
				 System.out.println(" countQueryString : "+countQueryString);
				List<?> countlist = getHibernateTemplate().find(countQueryString, values);
				System.out.println("countlist  : "+countlist.size());
				long totalCount =  countlist.size();

				if (totalCount < 1) {
					return PageBuilder.createEmptyPage();
				}
				Pages page = PageBuilder.createPage(pageNo, totalCount,pageSize);
				int startIndex = page.getRecordStart();
				Query query = createQuery(session, hql, values);
				List<Object> list = query.setFirstResult(startIndex).setMaxResults(pageSize).list();
				
				Iterator it=list.iterator();
				List<Object> products = new ArrayList<Object>();
				
				while(it.hasNext())
				{
					Object[] obj = (Object[])it.next();
					Product product = new Product();
					
					Depot depot = (Depot)getObject("from Depot where del = 0 and id = "+obj[0]);
					System.out.println(depot.getId());
					Property property = (Property)getObject("from Property where delflag = 0 and id = "+obj[1]);
					System.out.println(property.getId());
					System.out.println("``````````````~~~~~~~~~~~~~~~~~");
					int shelfcount = getCount("from Product where depot.id = "+obj[0]+" and property.id = "+obj[1]+" and usestate = 0");
					int buttomcount = getCount("from Product where depot.id = "+obj[0]+" and property.id = "+obj[1]+" and usestate = 1");
					
					product.setDepot(depot);
					product.setProperty(property);
					product.setTmp2(shelfcount+"");
					product.setTmp1(buttomcount+"");
					
					products.add(product);
				}
				page.setPageList(products);
				return page;
			}
		});
	}

	public List getObject1(String hql) {
		System.out.println("hql : "+hql);
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
}

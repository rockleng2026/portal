package com.fuao.fajxc.dao.impl.stockpile;

import java.io.Serializable;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.impl.purchase.PurOrderDaoImpl;
import com.fuao.fajxc.dao.stockpile.WarehousingDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Storage;
import com.fuao.fajxc.vo.StorageInfo;
import com.fuao.fajxc.vo.Users;

@SuppressWarnings("unused")
public class WarehousingDaoImpl extends  BaseDaoImpl implements WarehousingDao {
	
	
	
	private static Logger logger = Logger.getLogger(PurOrderDaoImpl.class);
	
	/**
	 * 分页查询入库单
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values){
		Pages pages=null;
		try	{
			pages=super.paginationQuery(hql, pageNo, pageSize, values);
			System.out.println("cm:  ---> DAO ---> exHqlPages() ---> 分页查询 执行后， 打印pages 的值：" + pages);
		}
		catch(Exception ex) {
			ex.printStackTrace();
			logger.error("分页时出错",ex);
		}
		return pages;
	}

	
	
	/**
	 * 添加入库商品信息
	 */
	public Storage addStorage(Storage storage){
		
		boolean flag = false;
		try{
			this.getHibernateTemplate().saveOrUpdate(storage);
			return storage;
		}catch(Exception ex){
			ex.printStackTrace();
			logger.error("添加入库商品信息出错",ex);
		}
		
		return null;
	}
	
	/**
	 * 添加入库单信息
	 */
	public Storage addStorageObj(Storage storage){
		try{
			this.getHibernateTemplate().save(storage);
		}catch(Exception ex){
			ex.printStackTrace();
			logger.error("添加入库商品信息出错",ex);
		}
		return storage;
	}
	
	/**
	 * 删除入库商品信息
	 */
	public boolean delStorage(Object[] ids){
		System.out.println("cm:  ---> DAO ---> delStorage() ---> 进入删除DAO" );
		for(int i=0;i<ids.length;i++){
			System.out.println("cm:  ---> DAO ---> delStorage() ---> ids = "+ids[i]);
		}
		boolean flag = false;
		try {
			String strHql = "update Storage b set delflag = 1 where b.id in(:ids)";
			Query query = this.getSession().createQuery(strHql);
			query.setParameterList("ids",ids);
			int iCount = query.executeUpdate();
			if(iCount > 0){
				flag = true;
			}
		} catch (Exception ex) {
			logger.error("删除入库商品信息出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}
	
	/**
	 * 修改入库商品信息
	 */
	public boolean editStorage(Storage storage){
		System.out.println("cm:  ---> DAO ---> editStorage() ---> " );
		boolean flag = false;
		try{
			this.getHibernateTemplate().update(storage);
			flag = true;
		}catch(Exception ex){
			ex.printStackTrace();
			logger.error("修改入库商品信息出错",ex);
		}
		return flag;
	}
	
	/**
	 * 根据条件查询入库商品信息
	 */
	public List someStorage(String strHql){
		System.out.println("cm:  ---> DAO ---> getStorageByConditions() ---> " );
		try {
			Query query=this.getSession().createQuery("from Storage where delflag=0 " + strHql +"order by storageId desc");
			return query.list();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("根据条件查询入库商品信息出错",e);			
		}
		return null;
	}
	
	/**
	 * 添加入库详单
	 */
	public StorageInfo addStorageInfo(StorageInfo storageInfo){
		
		try{
			this.getHibernateTemplate().saveOrUpdate(storageInfo);
			
		}
		catch(Exception ex){
			logger.error("添加入库详单出错",ex);
			logger.debug(ex);
			ex.printStackTrace();
		}
		return storageInfo;
	}
	
	
	/**
	 * 添加入库详单
	 */
	public StorageInfo addStorageInfoObj(StorageInfo storageInfo){
		System.out.println("CM： --->  进入添加入库详表 DAO 类中    --->    --->   ");
		try{
			this.getHibernateTemplate().save(storageInfo);
			System.out.println("CM： --->  进入添加入库详表 DAO 类中    --->  添加成功！！！  --->   ID = " + storageInfo.getStorageInfoId());
			return storageInfo;
		}
		catch(Exception ex){
			logger.error("添加入库详单出错",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 删除入库详单
	 */
	public boolean delStorageInfo(String addhql) {
		boolean flag=false;
		try
		{
			String hql="delete from StorageInfo where 1=1 "+addhql;
			Query query=this.getSession().createQuery(hql);
			int i=query.executeUpdate();
			if(i>0){
				flag=true;
			}
		}
		catch(Exception ex)
		{
			logger.error("删除入库单详细出错",ex);
			ex.printStackTrace();
		}
		return flag;
	}
	
	
	/**
	 * 查找入库类型
	 */
	public List selType(String addhql){
		String hql="from AllType where type=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	
	/**
	 * 
	 * 查询
	 * 
	 */
		public List select(String hql)
		{
			Query query=this.getSession().createQuery(hql);
			return query.list();
		}
	
	/**
	 * 获得入库商品信息总数
	 */
	public int getCountStorage(String addHql){
		System.out.println("cm:  ---> DAO ---> getCountBatchexp() ---> 获得入库商品信息总数" );
		int iCount = 0;
		String strHql = "from Batchexp where delflag = 0 " + addHql;
		try {
			iCount = super.getHibernateTemplate().find(strHql).size();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("获得入库商品信息总数出错",e);		
		}
		return iCount;
	}
	
	/**
	 * 根据用户名和密码，获得该用户对象
	 */
	public Users getUsersByLoginName(String loginname,String password)
	{
		String hql="from Users where loginName=? and password=?";
		Query query = this.getSession().createQuery(hql);
		query.setString(0, loginname);
		query.setString(1, password);
		Users users = new Users();
		
		if(query.list().size()>0)
		{
			users = (Users)query.list().get(0);
		}
		else {
			users.setUserId(0);
		}
		return users;
	}



	public Object addobj(Object ojb) {
		// TODO Auto-generated method stub
		try {
			super.add(ojb);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ojb;
	}
	
}

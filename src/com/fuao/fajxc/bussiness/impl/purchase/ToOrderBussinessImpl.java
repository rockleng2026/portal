package com.fuao.fajxc.bussiness.impl.purchase;
import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.bussiness.purchase.ToOrderBussiness;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.purchase.ToOrderDao;
import com.fuao.fajxc.util.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ToOrder;
public class ToOrderBussinessImpl implements ToOrderBussiness{
		private  ToOrderDao  toOrderDao;
		
		public ToOrderDao getToOrderDao() {
			return toOrderDao;
		}

		public void setToOrderDao(ToOrderDao ToOrderDao) throws Exception{
			this.toOrderDao = ToOrderDao;
		}

		/**
		 * 添加到货单(non-Javadoc)
		 */
		public boolean addData(ToOrder data) throws Exception {
				try {
					toOrderDao.add(data);
				} catch (Exception e) {
					throw e;
				}
				return true;
		}

		/**
		 * 添加到货单(non-Javadoc)
		 * @return ToOrder
		 */
		public ToOrder addReturnData(ToOrder data) throws Exception {
				ToOrder toOrder = null;
				try {
					toOrder = (ToOrder) toOrderDao.addReturnObject(data);
				} catch (Exception e) {
					throw e;
				}
				return toOrder;
		}
		
		public List<ToOrder> exHql(String hql) {
			List<ToOrder> datas=null;
			try {
				datas=toOrderDao.exHql(hql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return datas;
		}

		public Pages exHqlPages(String hql, int pageNo, int pageSize,
				Object... values){
			Pages pages=null;
			try {
				pages=toOrderDao.exHqlPages(hql, pageNo, pageSize, values);	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pages;
		}

		
		public boolean updateData(ToOrder data) {
			try {
				toOrderDao.updateData(data);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		public ToOrder getToOrderdata(String id) {
			ToOrder data=null;
			try {
				data= (ToOrder) toOrderDao.getToOrderdata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}
		
		
		/**
		 * 获得tableName对象列表
		 * @param hql
		 * @return
		 */
		public List getObjectList(String tableName ,String andhql)
		{
			String hql ="from "+tableName+" where 1=1 "+andhql;
			System.out.println("hql : "+hql);
			return toOrderDao.getObjectList(hql);
		}
		
		
		

		/**
		 * 
		 * @param addhql
		 * @return
		 */
		public boolean updateToOrderByVerify(String addhql){
			return toOrderDao.updateToOrderByVerify(addhql);
		}
		
		
		
}

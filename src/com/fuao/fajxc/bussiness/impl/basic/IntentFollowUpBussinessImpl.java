package com.fuao.fajxc.bussiness.impl.basic;
import java.util.List;

import com.fuao.fajxc.bussiness.basic.IntentFollowUpBussiness;
import com.fuao.fajxc.dao.basic.IntentFollowUpDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.IntentFollowUp;
public class IntentFollowUpBussinessImpl implements IntentFollowUpBussiness{
		private  IntentFollowUpDao  intentFollowUpDao;
		
		public IntentFollowUpDao getIntentFollowUpDao() {
			return intentFollowUpDao;
		}
		
		public void setIntentFollowUpDao(IntentFollowUpDao intentFollowUpDao) throws Exception{
			this.intentFollowUpDao = intentFollowUpDao;
		}

		//添加客户跟进记录
		public boolean addData(IntentFollowUp data) throws Exception {
				try {
					intentFollowUpDao.add(data);
				} catch (Exception e) {
					throw e;
				}
				return true;
		}
		
		/**
		 * 添加客户跟进记录
		 * 返回对象
		 */
		public IntentFollowUp addReturnData(IntentFollowUp data) throws Exception {
				try {
					return (IntentFollowUp) intentFollowUpDao.addReturnObject(data);
				} catch (Exception e) {
					throw e;
				}
		}

		public List<IntentFollowUp> exHql(String hql) {
			List<IntentFollowUp> datas=null;
			try {
				datas=intentFollowUpDao.exHql(hql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return datas;
		}

		public Pages exHqlPages(String hql, int pageNo, int pageSize,
				Object... values){
			Pages pages=null;
			try {
				pages=intentFollowUpDao.exHqlPages(hql, pageNo, pageSize, values);	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pages;
		}

		
		public boolean updateData(IntentFollowUp data) {
			try {
				intentFollowUpDao.updateData(data);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		public IntentFollowUp getIntentFollowUpdata(String id) {
			IntentFollowUp data=null;
			try {
				data= (IntentFollowUp) intentFollowUpDao.getIntentFollowUpdata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}
		
}

package com.fuao.fajxc.bussiness.impl.message;
import java.util.List;

import com.fuao.fajxc.bussiness.message.MessagetypeBussiness;
import com.fuao.fajxc.dao.message.MessagetypeDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Messagetype;
public class MessagetypeBussinessImpl implements MessagetypeBussiness{
		private  MessagetypeDao  messagetypeDao;
		

		public MessagetypeDao getMessagetypeDao() {
			return messagetypeDao;
		}

		public void setMessagetypeDao(MessagetypeDao messagetypeDao) {
			this.messagetypeDao = messagetypeDao;
		}

		public boolean addData(Messagetype data) throws Exception {
				try {
					messagetypeDao.update(data);
				} catch (Exception e) {
					throw e;
				}
				return true;
		}

		public List<Messagetype> exHql(String hql) {
			List<Messagetype> datas=null;
			try {
				datas=messagetypeDao.exHql(hql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return datas;
		}

		public Pages exHqlPages(String hql, int pageNo, int pageSize,
				Object... values){
			Pages pages=null;
			try {
				pages=messagetypeDao.exHqlPages(hql, pageNo, pageSize, values);	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pages;
		}

		
		public boolean updateData(Messagetype data) {
			try {
				messagetypeDao.updateData(data);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		public Messagetype getMessagetypedata(String id) {
			Messagetype data=null;
			try {
				data= (Messagetype) messagetypeDao.getMessagetypedata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}

		public Messagetype getMessageTypedata(String id) {
			Messagetype data=null;
			try {
				data= (Messagetype) messagetypeDao.getMessagetypedata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}
		
}

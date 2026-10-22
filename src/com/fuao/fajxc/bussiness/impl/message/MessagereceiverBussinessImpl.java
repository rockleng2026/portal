package com.fuao.fajxc.bussiness.impl.message;
import java.util.List;
import com.fuao.fajxc.bussiness.message.MessagereceiverBussiness;
import com.fuao.fajxc.dao.message.MessagereceiverDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Messagereceiver;
public class MessagereceiverBussinessImpl implements MessagereceiverBussiness{
		private  MessagereceiverDao  messagereceiverDao;
		public MessagereceiverDao getMessagereceiverDao() {
			return messagereceiverDao;
		}

		public void setMessagereceiverDao(MessagereceiverDao messagereceiverDao) {
			this.messagereceiverDao = messagereceiverDao;
		}

		public boolean addData(Messagereceiver data) throws Exception {
				try {
					messagereceiverDao.add(data);
				} catch (Exception e) {
					throw e;
				}
				return true;
		}

		public List<Messagereceiver> exHql(String hql) {
			List<Messagereceiver> datas=null;
			try {
				datas=messagereceiverDao.exHql(hql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return datas;
		}

		public Pages exHqlPages(String hql, int pageNo, int pageSize,
				Object... values){
			Pages pages=null;
			try {
				pages=messagereceiverDao.exHqlPages(hql, pageNo, pageSize, values);	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pages;
		}

		
		public boolean updateData(Messagereceiver data) {
			try {
				messagereceiverDao.updateData(data);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		public Messagereceiver getMessagereceiverdata(String id) {
			Messagereceiver data=null;
			try {
				data= (Messagereceiver) messagereceiverDao.getMessagereceiverdata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}
		
}

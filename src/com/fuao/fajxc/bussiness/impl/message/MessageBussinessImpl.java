package com.fuao.fajxc.bussiness.impl.message;
import java.util.List;
import com.fuao.fajxc.bussiness.message.MessageBussiness;
import com.fuao.fajxc.dao.message.MessageDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Message;
import com.fuao.fajxc.vo.Messagereceiver;
public class MessageBussinessImpl implements MessageBussiness{
		private  MessageDao  messageDao;
		
		public MessageDao getMessageDao() {
			return messageDao;
		}
		public void setMessageDao(MessageDao messageDao) {
			this.messageDao = messageDao;
		}



		public boolean addData(Message data) throws Exception {
			try {
				messageDao.add(data);
			} catch (Exception e) {
				throw e;
			}
			return true;
	}
		

		public List<Message> exHql(String hql) {
			List<Message> datas=null;
			try {
				datas=messageDao.exHql(hql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return datas;
		}

		public Pages exHqlPages(String hql, int pageNo, int pageSize,
				Object... values){
			Pages pages=null;
			try {
				pages=messageDao.exHqlPages(hql, pageNo, pageSize, values);	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pages;
		}

		
		public boolean updateData(Message data) {
			try {
				messageDao.updateData(data);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		public Message getMessagedata(String id) {
			Message data=null;
			try {
				data= (Message) messageDao.getMessagedata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}
		/**
		 * 查询
		 * @param hql
		 * @return
		 */
		public List getObjectList(String entityName,String condition )
		{
			String hql = "from "+entityName+" where 1=1 "+condition;
			return messageDao.getObjectList(hql);
		}
		/**
		 * 查询
		 * @author 阙超强
		 * 2011-11-22 14:00:07
		 */
		public Object getObject(String entityName,String cond){
			String hql = "from "+entityName+" where 1=1 "+cond;
			Object object = messageDao.getObject(hql); 
			return object;
		}
		
		/**
		 * 获得已读或未读信息
		 * @param restypeid 员工或客户标识
		 * @param eocid 员工或客户id
		 * @param readfalg 是否已读 
		 * @return
		 */
		public List<Messagereceiver> someMessageres(int restypeid,String eocid,String readfalg){
			List<Messagereceiver> list=null;
			String hql="from Messagereceiver where messagetype.messagetypeid="+restypeid+" and receiverer="+eocid+" and readfalg="+readfalg+" and delfalg=0 ";
			list=messageDao.execHQL(hql);
			return list;
		}
		
		/**
		 * 删除信息
		 * @return
		 */
		public boolean delmessage(Object[] ids) {
			// TODO Auto-generated method stub
			Object[] obj=new Object[ids.length];
			for(int i=0;i<ids.length;i++)
			{
				obj[i]=Integer.parseInt(ids[i].toString());
			}
			boolean flag=messageDao.delmessage(obj);
			return flag;
		}
		
		
		/**
		 * 读取信息
		 * @return
		 */
		public boolean duqumessage(Object[] duqu) {
			// TODO Auto-generated method stub
			Object[] obj=new Object[duqu.length];
			for(int i=0;i<duqu.length;i++)
			{
				obj[i]=Integer.parseInt(duqu[i].toString());
			}
			boolean flag=messageDao.duqumessage(duqu);
			return flag;
		}
		
		/**
		 * 查看的时候修改状态
		 */
		public boolean dumessage(int  message)
		{	
			boolean flag= messageDao.dumessage(message);
			return flag;
		}
		
		/**
		 * 删除Message信息
		 * @return
		 */
		public boolean delsendmes(Object[] ids) {
			// TODO Auto-generated method stub
			Object[] obj=new Object[ids.length];
			for(int i=0;i<ids.length;i++)
			{
				System.out.println("idsssaaa"+ids[i].toString());
				obj[i]=Integer.parseInt(ids[i].toString());
			}
			boolean flag=messageDao.delsendmes(obj);
			return flag;
		}
		/**
		 * 删除消息
		 */
		public boolean delMessage(int  id){
			boolean flag=messageDao.delMessage(id);
			return flag;
		}
		/**
		 * 删除消息类型
		 * @return
		 */
		public boolean delmesstype(Object[] ids){
			Object[] obj=new Object[ids.length];
			for(int i=0;i<ids.length;i++)
			{
				obj[i]=Integer.parseInt(ids[i].toString());
			}
			boolean flag=messageDao.delmesstype(obj);
			return flag;
		}
		public int exeUpdateSql(String sql) {
			return messageDao.execSQLUpdate(sql);
			
		}
		public boolean duqu1message(Object[] duqu) {
			Object[] obj=new Object[duqu.length];
			for(int i=0;i<duqu.length;i++)
			{
				obj[i]=Integer.parseInt(duqu[i].toString());
			}
			boolean flag=messageDao.duqu1message(duqu);
			
			return flag;
			
		}
		
		public List getProject(String hql){
			return messageDao.getAllProject(hql);
		}
		/******
		 * 根据员工编号得到员工集合
		 */
		public Object getEmp(Class clazz, Integer id){
			return messageDao.getEmp(clazz, id);
		}
		public void addReceiver(Object receiver){
			messageDao.addReceiver(receiver);
		}
		/********
		 * 添加保存对象
		 */
		public void addObject(Object obj){
			messageDao.addObject(obj);
		}
		public List exeSql(String sql){
			return messageDao.execSQL(sql);
		}
		public List exeHql(String hql){
			return messageDao.execHQL(hql);
		}
		/*******
		 * 修改消息对象
		 */
		public void updateObj(Object obj){
			messageDao.updateObj(obj);
		}
		public void delObj(Object obj){
			messageDao.delObj(obj);
		}
}

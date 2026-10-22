package com.fuao.fajxc.bussiness.message;
import java.util.List;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Message;
import com.fuao.fajxc.vo.Messagereceiver;

public interface MessageBussiness {
		
		/*
		 * 客户基本资料
		 */
		public boolean addData(Message data)throws Exception;
		
		/*
		 *修改 客户基本资料
		 */
		public boolean updateData(Message data);
		
		
		public Message getMessagedata(String id);
		/*
		 *特殊查询客户基本资料
		 */
		public List<Message>  exHql(String hql);
		
		/*
		 *执行分页查询客户基本资料
		 */
		public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
		
		/**
		 * 查询
		 * @param hql
		 * @return
		 */
		public List getObjectList(String entityName,String condition );
		
		/**
		 * 获得已读或未读信息
		 * @param restypeid 员工或客户标识
		 * @param eocid 员工或客户id
		 * @return
		 */
		public List<Messagereceiver> someMessageres(int restypeid,String eocid,String readfalg);
		
		/**
		 * 删除信息
		 * @return
		 */
		public boolean delmessage(Object[] ids);
		
		/**
		 * 读取信息
		 * @return
		 */
		public boolean duqumessage(Object[] duqu);
		/**
		 * 读取状态改变
		 */
		public boolean duqu1message(Object[] duqu);
		/**
		 * 查看的时候修改状态
		 * @return
		 */
		public boolean dumessage(int  message);
		
		/**
		 * 删除Message信息
		 * @return
		 */
		public boolean delsendmes(Object[] ids);
		
		/**
		 * 删除Message信息
		 * @return
		 */
		public boolean delMessage(int  id);
		/**
		 * 删除消息类型
		 * @param ids
		 * @return
		 */
		public boolean delmesstype(Object[] ids);
		/**
		 * 查询
		 * @author 阙超强
		 * 2011-11-22 14:00:07
		 */
		public Object getObject(String entityName,String cond);
		
		/**
		 * 
		 * 执行sql修改
		 */
		public int exeUpdateSql(String sql);
		
		/**
		 * 得到所有项目名称
		 * @param hql
		 * @return
		 */
		public List getProject(String hql);
		/******
		 * 根据员工编号得到员工集合
		 */
		public Object getEmp(Class clazz, Integer id);
		/*****
		 * 保存对象
		 */
		public void addReceiver(Object obj);
		/********
		 * 添加保存对象
		 */
		public void addObject(Object obj);
		public List exeSql(String sql);
		public List exeHql(String hql);
		/*******
		 * 修改消息对象
		 */
		public void updateObj(Object obj);
		public void delObj(Object obj);
}

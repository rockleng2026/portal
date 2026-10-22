package com.fuao.fajxc.dao.message;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Message;

public interface MessageDao extends BaseDao{

	/*
	 * 客户基本资料
	 */
	public boolean addData(Message data)throws Exception;
	
	/*
	 *修改 客户基本资料
	 */
	public boolean updateData(Message data)throws Exception ;
	
	
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
	public List getObjectList(String hql );
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
	 * 读取状态修改
	 * @return
	 */
	public boolean duqu1message(Object[] duqu);
	/**
	 * 查看的时候修改状态
	 * @return
	 */
	public boolean dumessage(int id);
	
	/**
	 * 删除信息Message
	 * @return
	 */

	public boolean delsendmes(Object[] ids);
	
	/**
	 * 删除信息Message
	 * @return
	 */
	
	public boolean delMessage(int id);
	/**
	 * 删除消息类型
	 * @param ids
	 * @return
	 */
	public boolean delmesstype(Object[] ids);
	
	/**
	 * 查询对象
	 * @author 阙超强 
	 * 2011-11-22 14:02:28
	 */
	public Object getObject(String hql);
	
	public List getAllProject(String hql);
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
	/******
	 * 修改对象　
	 */
	public void updateObj(Object obj);
	/******
	 * 删除对象　
	 */
	public void delObj(Object obj);
}

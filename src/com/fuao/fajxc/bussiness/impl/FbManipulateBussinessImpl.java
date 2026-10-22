package com.fuao.fajxc.bussiness.impl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.bussiness.FbManipulateBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.dao.FbManipulateDao;
import com.fuao.fajxc.util.Pages;

public class FbManipulateBussinessImpl  implements FbManipulateBussiness {

	//日志记录
	private static Logger logger = Logger.getLogger(FbManipulateBussinessImpl.class);
	
	//注入表单操作DAO
	private FbManipulateDao fbManipulateDao;
	//注入审核Bussiness
	private AuditingBussiness audBuss;
	
	//为表单操作DAO添加get和set方法
	public FbManipulateDao getFbManipulateDao() {
		return fbManipulateDao;
	}
	public void setFbManipulateDao(FbManipulateDao fbManipulateDao) {
		this.fbManipulateDao = fbManipulateDao;
	}
	
	/**
	 * 添加表单
	 */
	public Object addForm(Object obj, List fb,HttpServletRequest request) {
		
		//定义要返回的对象并初始化
		Object returnobj = null;
		try{
			
		    //添加对象后并返回该对象
			returnobj = fbManipulateDao.addForm(obj);
		}catch (Exception e) {
			
			//有异常便记录日志返回NULL
			logger.debug(e);
			return null;
		}
		return returnobj;
	}
	/**
	 * 根据表名和条件查询相应列表集合
	 * @param tableName  表名
	 * @param andhql     条件
	 * @return
	 */
	public List getForm(String tableName,String andhql)
	{
		List list = new ArrayList();
		try
		{
			list = fbManipulateDao.getForm(tableName, andhql);
		}
		catch(Exception e)
		{
			logger.debug(e);
		}
		return list;
	}
	
	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,Object... values) 
	{
		return fbManipulateDao.exHqlPages(hql, pageNo, pageSize, values);
	}
	public int updateBills(String hql) {
		if(fbManipulateDao.updateForm(hql)){
			return 1;
		}
		return 0;
	}
	public AuditingBussiness getAudBuss() {
		return audBuss;
	}
	public void setAudBuss(AuditingBussiness audBuss) {
		this.audBuss = audBuss;
	}
	
}

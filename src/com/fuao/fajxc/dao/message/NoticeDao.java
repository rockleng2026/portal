package com.fuao.fajxc.dao.message;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;

public interface NoticeDao extends BaseDao{
	public void addNotice(Object obj);
	public List getNotice(String hql);
	public Object getObjectById(Class clazz,Integer id);
	public void updateNotice(String hql);
	
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
}

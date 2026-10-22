package com.fuao.fajxc.dao.system;

import java.util.List;


import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.PaymentLog;

public interface DocumentDao extends BaseDao {

	/**
	 *执行分页查询单据类型记录资料
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 查询单据类型
	 */
	public List selDocmark(String hql);
	
	/**
	 * 添加单据类型
	 * @return
	 */
	public boolean addDoc(Docmark docm);
	/**
	 * 删除单据类型
	 * @return
	 */
	public boolean delDoc(Docmark docm);
	
	/**
	 * 更新单据类型
	 */
	public boolean updateDoc(Docmark docm);
	/*******
	 * 得到集合
	 * @param hql
	 * @return
	 */
	public List exHql(String hql);
}

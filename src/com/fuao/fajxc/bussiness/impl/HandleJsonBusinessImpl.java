/**
 * 
 */
package com.fuao.fajxc.bussiness.impl;

import java.util.List;


import com.fuao.fajxc.bussiness.HandleJsonBusiness;
import com.fuao.fajxc.dao.HandleJsonDao;

/**
 * @author 14011
 *
 */
public class HandleJsonBusinessImpl implements HandleJsonBusiness {

	private HandleJsonDao jsondao;
	
	/**
	 * 根据实体名，和条件，获得对象列表
	 * @param entityName
	 * @param condition
	 * @return
	 */
	public List ObjectList(String entityName ,String condition)
	{
		List list = null;
		try
		{
			String hql = " from "+entityName+" where 1=1 "+condition;
			list = jsondao.ObjectList(hql);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}

	public HandleJsonDao getJsondao() {
		return jsondao;
	}

	public void setJsondao(HandleJsonDao jsondao) {
		this.jsondao = jsondao;
	}
}

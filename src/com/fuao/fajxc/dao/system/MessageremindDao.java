package com.fuao.fajxc.dao.system;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Messageremind;
/**
 * 提醒功能Dao
 * @author 14012
 *
 */
public interface MessageremindDao extends BaseDao {
	
	/**
	 * 添加或者修改功能
	 * @param mr
	 * @return
	 */
	public boolean addorupmessageremind(Messageremind mr);
	
	/**
	 * 删除功能提醒
	 */
	public boolean delmessageremin(String id);
	
	/**
	 * 查询功能提醒信息
	 */
	public Pages exHqlObjectPages(String hql,int pageNo,int pageSize,
			Object... values) ;
	

}

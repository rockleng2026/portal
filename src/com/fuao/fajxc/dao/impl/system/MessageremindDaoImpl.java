package com.fuao.fajxc.dao.impl.system;

import com.fuao.fajxc.dao.system.MessageremindDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Messageremind;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;

public class MessageremindDaoImpl extends BaseDaoImpl implements MessageremindDao  {

	/**
	 * 添加或者更数据
	 */
	public boolean addorupmessageremind(Messageremind mr) {
		try {
			super.update(mr);
			
			return true;
		} catch (Exception e) {
			
			e.printStackTrace();
			
			return false;
		}
		
	}

	/**
	 * 删除数据
	 */
	public boolean delmessageremin(String id ) {
		
		try {
			super.del(Messageremind.class, id);
			
			return true;
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return false;
	}

	/**
	 * 分页查询数据
	 */
	public Pages exHqlObjectPages(String hql, int pageNo, int pageSize,
			Object... values) {
		
		return super.paginationQuery(hql, pageNo, pageSize, values);
	}


}

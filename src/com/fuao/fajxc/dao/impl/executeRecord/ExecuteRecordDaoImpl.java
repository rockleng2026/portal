package com.fuao.fajxc.dao.impl.executeRecord;


import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.dao.executeRecord.ExecuteRecordDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Executerecord;

/**
 * 执行的操作记录     数据层实现类
 * @author 阙超强 14015 
 * @date 2011-12-23 15:06:21
 * */
public class ExecuteRecordDaoImpl extends BaseDaoImpl implements ExecuteRecordDao{

	//增加
	public void addData(Executerecord data) {
		try {
			super.add(data);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	//更新
	public boolean updateData(Executerecord data)  {
		try {
			super.update(data);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}

	//执行hql语句
	public Object exHql(String hql) {
		Object object = super.getSession().createQuery(hql).uniqueResult();
		return object;
	}
	
	//执行分页查询
	public Pages exHqlPages(String hql, int pageNo, int pageSize, Object... values) {
			Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}
	
	/**
	 * 执行sql语句
	 * @author 阙超强 14015
	 * @date 2011-12-23 10:52:52
	 */
	public String executeSql(String sql) {
		Query query = this.getSession().createSQLQuery(sql);
		
		String returnValue = "";
		
		List list =query.list();
		
          if(list != null && list.size()>0){
        	  
        	  returnValue= list.get(0).toString();
        	  
        	  returnValue = returnValue.substring(1);
          }
          
		return returnValue;
	}
}

package com.fuao.fajxc.bussiness.orderTemplate;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.WorkLog;

/**
 * 
 * @author 阙超强 14015
 * @time 2012-1-6 17:14:02
 *
 */
public interface WorkLogBussiness {
	
	/**
	 * 添加日志 
	 * @param workLog
	 * @return WorkLog对象
	 */
	public WorkLog addReturn(WorkLog workLog);
	
	/**
	 * 分页
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exeHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 根据单个标识查询对象
	 * @param id 单个对象的唯一标识
	 * @return Object 执行后返回的对象
	 */
	public WorkLog getById(int id);
	
	/**
	 * 添加批注
	 * @return boolean
	 */
	public boolean addReply(WorkLog workLog);
	
	/**
	 * 执行HQL语句
	 * @return
	 */
	public List exeHql(String hql);
	
	/**
	 * 执行SQL语句
	 * @return
	 */
	public String executeSql(String sql);
}

package com.fuao.fajxc.bussiness.executeRecord;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;

/**
 * 执行记录 公司最新动态
 * 
 * @author 阙超强 14015 
 * @date 2011-12-23 15:20:26
 */
public interface ExecuteRecordBussiness {
	/*
	 * 添加 操作记录 最新动态
	 */
	public boolean addData(Executerecord data);
	
	/*
	 *修改 操作记录  最新动态
	 */
	public boolean updateData(Executerecord data);
	
	/*
	 * 执行hql查询    只返回一条记录
	 */
	public Object exHql(String hql);

	/*
	 * 执行hql查询   
	 */
	public List exHqls(String hql);
	
	/*
	 *执行分页查询
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/*
	 * 修改executerecord表  添加已查看员工记录
	 */
	public boolean updateExeSeenEmpId(int id,int empid);
	
	/*
	 * 执行sql语句
	 */
	public String executeSql(String sql);
	
}

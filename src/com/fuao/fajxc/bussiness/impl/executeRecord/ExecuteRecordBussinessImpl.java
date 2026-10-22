package com.fuao.fajxc.bussiness.impl.executeRecord;

import java.util.List;

import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.dao.executeRecord.ExecuteRecordDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
/**
 * 执行记录   业务层实现类
 * @author 阙超强 14015 
 * @date 2011-12-23 15:49:32
 *
 */
public class ExecuteRecordBussinessImpl implements ExecuteRecordBussiness{

	private ExecuteRecordDao executeRecordDao;
	
	public ExecuteRecordDao getExecuteRecordDao() {
		return executeRecordDao;
	}

	public void setExecuteRecordDao(ExecuteRecordDao executeRecordDao) {
		this.executeRecordDao = executeRecordDao;
	}

	//添加
	public boolean addData(Executerecord data) {
		try {
			executeRecordDao.add(data);
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	//更新
	public boolean updateData(Executerecord data) {
		
		return executeRecordDao.updateData(data);
	}

	//执行hql语句
	public Object exHql(String hql) {
		
		return executeRecordDao.exHql(hql);
	}

	//执行hql语句 返回集合
	public List exHqls(String hql) {
		
		return executeRecordDao.execHQL(hql);
	}
	
	//执行分页查询
	public Pages exHqlPages(String hql, int pageNo, int pageSize, Object... values){
		Pages pages=null;
		try {
			pages=executeRecordDao.exHqlPages(hql, pageNo, pageSize, values);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pages;
	}

	//修改executerecord表  添加已查看员工记录
	public boolean updateExeSeenEmpId(int id,int empid){
		//拿出 动态记录的对象    
		String getExeHql = "From Executerecord as tb where 1 = 1 and tb.id = " + id;
		Executerecord executerecord = (Executerecord) executeRecordDao.exHql(getExeHql);
		
		//修改   添加登录id为已查看过此动态信息
		executerecord.setSeenEmpId(executerecord.getSeenEmpId()+empid+",");
		
		boolean result = executeRecordDao.updateData(executerecord);
		
		return result;
	}
	
	/**
	 * 执行sql语句
	 * @author 阙超强 14015
	 * @date 2011-12-23 10:52:52
	 */
	public String executeSql(String sql) {
		
		return executeRecordDao.executeSql(sql);
	}
}

package com.fuao.fajxc.dao.executeRecord;


import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Executerecord;

/**
 * 执行的操作记录     数据层接口类
 * @author 阙超强 14015 
 * @date 2011-12-23 15:06:21
 * */
public interface ExecuteRecordDao extends BaseDao{

	//执行添加
	public void addData(Executerecord data);
	
	//更新
	public boolean updateData(Executerecord data);
	
	//执行hql语句
	public Object exHql(String hql);
	
	//执行分页
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	//执行sql语句
	public String executeSql(String sql);
}

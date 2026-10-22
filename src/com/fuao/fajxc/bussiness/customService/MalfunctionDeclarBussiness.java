package com.fuao.fajxc.bussiness.customService;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Conkoutask;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Sendmessage;

/**
 * 客户故障申报业务接口
 * @author 14012
 *
 */
public interface MalfunctionDeclarBussiness {
	
	/**
	 * 添加或修改故障申报
	 * @return
	 */
	public boolean addorupdate(ConkOut co,Conkoutask coa);
	
	public boolean addorupdate(ConkOut co);
	
	public boolean addorupdate(Conkoutask coa);
	
	/**
	 * 查询故障信息
	 */
	public Pages get(final String hql, final int pageNo,final int pageSize, final Object... values);
	
	/**
	 *查询单个故障信息
	 *
	 */
	public ConkOut getco ( Class cls,String id);
	/**
	 * 删除故障信息
	 */
	
	/**
	 * 添加处理故障结果
	 */
	public boolean addResult(ConkOut co);
	
	/**
	 * 根据登录名查找用户
	 */
	public Employee getEmp(String loginName);
	
	/**
	 * 查找相应的List
	 * @param hql
	 * @return
	 */
	public List somelist(String hql);
	
	/**
	 * 修改故障单
	 */
	public int updateConkout(String hql);
	
	/**
	 * 根据ID查询故障
	 */
	public ConkOut getConkOut(String id);
	
	public Object getObj(Class clazz,Integer id);
	
	public void updObj(Object obj);
	
	public void addObje(Object obj);
	
	public void addBySQL(String sql);
	
	public List queryBySQL(String sql);
	
	public void exeSQL(String sql);
	/*
	 *执行分页查询客户基本资料
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
}

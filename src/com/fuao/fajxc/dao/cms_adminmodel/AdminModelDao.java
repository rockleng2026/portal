package com.fuao.fajxc.dao.cms_adminmodel;

import java.util.List;

import com.fuao.fajxc.vo.Fa_Cms_Admin;
import com.fuao.fajxc.vo.Fa_Cms_AdminModel;

public interface AdminModelDao {
	/**
	 * 模块列表
	 * @param hql
	 * @return
	 */
	public List modelList(String hql);
	/**
	 * 新增模块
	 * @param obj
	 */
	public void addModel(Object obj);
	
	/**
	 * 修改模块
	 * @param obj
	 */
	public void updateModel(Fa_Cms_AdminModel model);
	
	/**
	 * 根据主键加载模块
	 * @param clazz
	 * @param id
	 * @return
	 */
	public Fa_Cms_AdminModel getModelById(Class clazz,Integer id);
	
	/**
	 * 删除模块
	 * @param obj
	 */
	public void deleteModel(Fa_Cms_AdminModel model);
	
	/**
	 * 查询模块表总记录数
	 * @param sql
	 * @return
	 */
	public int countData(String sql);
	
	/**
	 * 分页
	 * @param current
	 * @param row
	 * @param sql
	 * @return
	 */
	public List splitPages(int current,int row,String sql);
	
	public List printList(List liss);
	
	
	public List getObjects(String hql,Object[] params);
	public List getOneMenu(String sqlname);

    public List getAllModels(int m);
	
	public List getOnTrees();
	
	public List getToTrees(String ca);
	
	public List getthTrees(String ca);
	
	public List getbyObject(Object obj, Object ob);
	
	public List getByTwoGrade(Fa_Cms_Admin obj,Fa_Cms_AdminModel ob);
}

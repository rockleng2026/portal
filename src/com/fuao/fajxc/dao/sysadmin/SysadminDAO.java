package com.fuao.fajxc.dao.sysadmin;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Fa_Cms_Admin;
/****
 * 管理员DAO
 * @author Administrator
 *
 */
public interface SysadminDAO {
	
	//添加管理员
	public void addAdmin(Fa_Cms_Admin admin);
	//修改管理员
	public void updateAdmin(Fa_Cms_Admin admin);
	//修改密码
	public void updateAdminPassword(Fa_Cms_Admin admin);
	/****
	 * 注销开通
	 */
	public void updateSta(int userid,int sta);
	/**
	 * 根据ID获得对象
	 */
	public Object getDeptById(Class clazz, Integer id);
	public Object getAdminById(Class clazz, Integer id);
	//注销
	
	/**
	 * 分页
	 * @param pg
	 * @return
	 */
	public List splitPages(int current,int row,String sql);
	public List printList(List liss);
	
	/**
	 * 得到总记录数s
	 * @return
	 */
	public int  countData(String sql);
	//绑定部门
	public List<Department> getDept();
	//绑定权限
	
}

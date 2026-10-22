/**
 * 
 */
package com.fuao.fajxc.bussiness.system.impl;

import com.fuao.fajxc.bussiness.system.MenuFunctionSystemBussiness;
import com.fuao.fajxc.dao.system.MenuFunctionSystemDao;
import com.fuao.fajxc.vo.FunctionInfo;

/**
 * @author 蔡亚俊
 *
 * 2011-7-20
 */
public class MenuFunctionSystemBussinessImpl implements MenuFunctionSystemBussiness {

	private MenuFunctionSystemDao menuFunctionSystemDao;

	/**
	 * 添加或修改菜单项
	 * @param info
	 * @return
	 */
	public int saveOrUpdate(FunctionInfo info)
	{
		return menuFunctionSystemDao.saveOrUpdate(info);
	}
	
	/**
	 * 删除菜单项
	 * @param info
	 * @return
	 */
	public int delFunctionMenu(FunctionInfo info)
	{
		return menuFunctionSystemDao.delFunctionMenu(info);
	}
	
	public void setMenuFunctionSystemDao(MenuFunctionSystemDao menuFunctionSystemDao) {
		this.menuFunctionSystemDao = menuFunctionSystemDao;
	}
	
	
}

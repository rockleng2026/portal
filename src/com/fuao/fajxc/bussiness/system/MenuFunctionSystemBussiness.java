/**
 * 
 */
package com.fuao.fajxc.bussiness.system;

import com.fuao.fajxc.vo.FunctionInfo;

/**
 * @author 蔡亚俊
 *
 * 2011-7-20
 */
public interface MenuFunctionSystemBussiness {

	/**
	 * 添加或修改菜单项
	 * @param info
	 * @return
	 */
	public int saveOrUpdate(FunctionInfo info);
	
	/**
	 * 删除菜单项
	 * @param info
	 * @return
	 */
	public int delFunctionMenu(FunctionInfo info);
}

/**
 * 
 */
package com.fuao.fajxc.dao.impl.system;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.bussiness.system.FunctionInfoSystemBussiness;
import com.fuao.fajxc.dao.system.FunctionInfoSystemDao;
import com.fuao.fajxc.dao.system.MenuFunctionSystemDao;
import com.fuao.fajxc.vo.FunctionInfo;

/**
 * @author 蔡亚俊
 *
 * 2011-7-20
 */
public class MenuFunctionSystemDaoImpl extends HibernateDaoSupport implements MenuFunctionSystemDao {

	private FunctionInfoSystemDao functionInfoSystemDao;
	
	/**
	 * 添加或修改菜单项
	 * @param info
	 * @return
	 */
	public int saveOrUpdate(FunctionInfo info)
	{
		System.out.println(" into saveOrUpdate ..... ");
		System.out.println(info.getFunctionId()==null);
		System.out.println(info.getFunctionId());
		int result = 0;
		
		
		System.out.println(" 新增：   functioninfo id : "+info.getFunctionId()==null);
		this.getSession().saveOrUpdate(info);
		FunctionInfo functionInfo = functionInfoSystemDao.getFunctionInfoByLinkFunctionName(info.getLinkFunctionName());
		if(functionInfo.getFunctionId()>0)
		{
			result = 1;
		}
		return result;
	}
	
	/**
	 * 删除菜单项
	 * @param info
	 * @return
	 */
	public int delFunctionMenu(FunctionInfo info)
	{
		System.out.println(" into delfunctionmenu ..... ");
		int result = 0;
		if(info.getFunctionId()>0)
		{
			this.getSession().delete(info);
			result = 1;
		}
		System.out.println("result = "+result);
		return result;
	}

	public void setFunctionInfoSystemDao(FunctionInfoSystemDao functionInfoSystemDao) {
		this.functionInfoSystemDao = functionInfoSystemDao;
	}
	
	
}

package com.fuao.fajxc.bussiness.contract;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Contract;
import com.fuao.fajxc.vo.Employee;

/**
 * 合同管理业务层
 * @author 14012
 *
 */
public interface ContractBiz {
	
	/**
	 * 添加合同
	 */
	public boolean addorup(Contract c);
	
	/**
	 * 查询合同列表
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	/**
	 * 添加     返回对象
	 * @return 
	 */
	public Contract addReturn(Contract c);
	
	public Pages paginationQuery(final String hql, final int pageNo,final int pageSize, final Object... values);

	/**
	 * 根据ID查询合同对象
	 * @param id
	 * @return
	 */
	public Contract getOneContract(String id );
	
	public Contract getOne(String hql );
	
	public Employee  getEmployee(String hql);
}

package com.fuao.fajxc.bussiness.contract.impl;

import java.util.List;

import com.fuao.fajxc.bussiness.contract.ContractBiz;
import com.fuao.fajxc.dao.contract.ContractDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Contract;
import com.fuao.fajxc.vo.Employee;
/**
 * 合同管理
 * @author 14012
 *
 */
public class ContractBizImpl implements ContractBiz{
	
	private ContractDao cdao;

	public ContractDao getCdao() {
		return cdao;
	}

	public void setCdao(ContractDao cdao) {
		this.cdao = cdao;
	}

	//添加
	public boolean addorup(Contract c) {
		try {
			cdao.update(c);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}

	/**
	 * 添加     返回对象
	 * @return 
	 */
	public Contract addReturn(Contract c) {
		try {
			Contract contract = (Contract) cdao.addReturnObject(c);
			return contract;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
	
	public Pages paginationQuery(String hql, int pageNo, int pageSize,
			Object... values) {
		
		return cdao.paginationQuery(hql, pageNo, pageSize, values);
	}

	public Contract getOneContract(String id) {
		
		try {
			return (Contract)cdao.select(Contract.class, Integer.parseInt(id));
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			return null;
		}
	}


public Contract getOne(String hql) {
	Contract c = null;
	List list =  cdao.execHQL(hql);
	if(list != null && list.size()>0){
		c=(Contract)list.get(0);
	}
	return c;
}


public Employee getEmployee(String hql) {
	Employee emp=null;
	List list =  cdao.execHQL(hql);
	if(list != null && list.size()>0){
		emp=(Employee)list.get(0);
	}
	
	return emp;
}
}

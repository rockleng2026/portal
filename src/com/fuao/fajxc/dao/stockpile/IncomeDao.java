package com.fuao.fajxc.dao.stockpile;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Income;
import com.fuao.fajxc.vo.IncomeInfo;

public interface IncomeDao extends BaseDao {

	/**
	 * 分页查询报溢单
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 添加报溢单
	 * @returrn
	 */
	public boolean addIncome(Income income);
	
	/**
	 * 修改报溢单
	 * @return
	 */
	public boolean editIncome(Income income);
	
	/**
	 * 删除报溢单
	 * @return 
	 */
	public boolean delIncome(Object[] obj);
	
	/**
	 * 查找报溢单
	 * @return
	 */
	public List selIncome(String addhql);
	
	/**
	 * 添加报溢详细
	 * @return
	 */
	public boolean addIncomeInfo(IncomeInfo incomeInfo);
	
	/**
	 * 删除报溢单详细
	 * @return
	 */
	public boolean delIncomeInfo(String addhql);
	
	
	/**
	 * 查找报损报溢详细
	 * @return
	 */
	public List someIncomeInfo(String addhql);
	
}

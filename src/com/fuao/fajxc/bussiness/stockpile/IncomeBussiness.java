package com.fuao.fajxc.bussiness.stockpile;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Income;
import com.fuao.fajxc.vo.IncomeInfo;

public interface IncomeBussiness {

	/**
	 * 分页查询报溢单
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 查找报溢单
	 * @return
	 */
	public List selIncome(String addhql);
	
	
	/**
	 * 查找报损报溢详细
	 * @return
	 */
	public List someIncomeInfo(String addhql);
	
	/**
	 * 添加/修改报溢单(根据标识add ord edit)
	 * @return
	 */
	public boolean addOredit(String mark,Income income,String models,String price,String count,String sum);
	
	/**
	 * 修改报益单的入库状态为已入库
	 */
	public boolean upstatu(Income income);

	
	/**
	 * 删除报溢单
	 * @return
	 */
	public boolean delIncome(Object[] obj);

}

package com.fuao.fajxc.bussiness.stockpile;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Ruin;
import com.fuao.fajxc.vo.RuinInfo;

public interface ProfitOrlossBussiness  {

	/**
	 * 分页查询出库单
	 * @return
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/**
	 * 添加报损/报溢单
	 * @return
	 */
	public boolean addPorLoss(Ruin ruin);
	
	/**
	 * 添加报损单
	 * 返回对象
	 */
	public Ruin addReturnPorLoss(Ruin ruin);
	
	/**
	 * 删除报损/报溢单
	 * @return
	 */
	public boolean delPorLoss(Object[] ids);
	
	/**
	 * 修改报损/报溢单
	 * @return 
	 */
	public boolean editPorLoss(Ruin ruin);
	
	/**
	 * 根据条件查找出库单
	 * @return 
	 */
	public List somePorLoss(String addhql);
	
	/**
	 * 添加报损/报溢详单
	 * @return
	 */
	public boolean addPorLossInfo(RuinInfo rinfo);
	
	/**
	 * 删除报损/报溢详单
	 * @return
	 */
	public boolean delPorLossInfo(String addhql);
	
	/**
	 * 根据条件查找报损/报溢详单
	 * @return
	 */
	public List somePorLossInfo(String addhql);
	
	/**
	 * 执行审核成功后业务
	 * @return
	 */
	public boolean auditingPass(String orderNo);
}

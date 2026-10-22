package com.fuao.fajxc.bussiness.purchase;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ApplyBuy;
import com.fuao.fajxc.vo.ApplyBuyinfo;

/**
 * 请购单业务逻辑层接口
 * @author 14012
 *
 */
public interface RequisitioningBusssiness {
	
	/**
	 * 添加请购单
	 * @param applyBuy
	 * @return
	 */
public int adda(ApplyBuy applyBuy );

public int adda(ApplyBuyinfo applyBuy );

/**
 * 查询单个对象
 * @param cls
 * @param id
 * @return
 */
public Object getObj(Class cls,String field, String id);

/**
 * 插入请购单详细信息
 * @return
 */
public boolean addApplyBuyInfo(ApplyBuyinfo applyBuyinfo);
/**
 * 分页查询
 * @param hql
 * @return
 */
public Pages paginationQuery(String hql, int pageNo, int pageSize,
		Object... values);
/**
 * 根据请购单ID查询请购单详细信息
 */
public List getappluInfo(String id);

/**
 * 修改请购单信息
 */
public boolean upApplyBuy(ApplyBuy applyBuy);

/**
 * 修改请购单详细信息
 */

public boolean upApplyBuyInfo(ApplyBuyinfo applyBuyinfo);

/**
 * 查询请购单
 */
public ApplyBuy getApplyBuy(int id);
/**
 * 查找请购单List
 */
public List getObjList(String hql);
}

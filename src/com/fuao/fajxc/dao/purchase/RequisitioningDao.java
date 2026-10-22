package com.fuao.fajxc.dao.purchase;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.ApplyBuy;
import com.fuao.fajxc.vo.ApplyBuyinfo;
/**
 * 请购单Dao接口
 * @author 14012
 *
 */

public interface RequisitioningDao extends BaseDao {
	/**
	 * 添加请购单并返回请购单ID
	 */
	public int adda(ApplyBuy applyBuy);

	public int adda(ApplyBuyinfo applyBuy);
}

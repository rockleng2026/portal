package com.fuao.fajxc.dao.commodity;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Field;
/**
 * 商品类型Dao
 * @author 14012
 *
 */
public interface CommodityTypeDao extends BaseDao {
	
	/**
	 * 添加商品类型
	 * 并返回添加后的ID
	 */
	public Field addobj(Field field);

}

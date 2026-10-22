package com.fuao.fajxc.dao.commodity;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.Field;
import com.fuao.fajxc.vo.Model;

/**
 * 商品信息DAO接口
 * @author 14012
 *
 */
public interface CommodityDao extends BaseDao {
	
	/**
	 * 插入对象后返回ID
	 * 
	 */

	public int saveField(Field f);
	
	/**
	 * 插入或者修该一个对象后
	 * 将该对象返回
	 * @param cla
	 * @return
	 */
	public Object getObj(Model model);
	

}

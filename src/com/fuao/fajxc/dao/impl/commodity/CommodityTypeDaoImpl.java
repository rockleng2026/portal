package com.fuao.fajxc.dao.impl.commodity;

import com.fuao.fajxc.dao.commodity.CommodityTypeDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Field;
 /**
  * 商品类型Dao实现类
  * @author 14012	
  *
  */
public class CommodityTypeDaoImpl extends BaseDaoImpl implements CommodityTypeDao {

	public Field addobj(Field field) {
		this.getHibernateTemplate().saveOrUpdate(field);
		return field;
	}

}

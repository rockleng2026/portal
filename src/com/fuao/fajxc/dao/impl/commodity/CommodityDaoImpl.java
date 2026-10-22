package com.fuao.fajxc.dao.impl.commodity;

import com.fuao.fajxc.dao.commodity.CommodityDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.Field;
import com.fuao.fajxc.vo.Model;
/**
 * 商品信息DAO实现类
 * @author 14012
 *
 */
public class CommodityDaoImpl extends BaseDaoImpl implements CommodityDao {

	public int saveField(Field f) {
		super.getHibernateTemplate().save(f);
		
		return f.getId();
	}

	public Object getObj(Model model) {
		this.getHibernateTemplate().saveOrUpdate(model);
		return model;
	}

}

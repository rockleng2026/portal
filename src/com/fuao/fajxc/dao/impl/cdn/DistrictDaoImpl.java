package com.fuao.fajxc.dao.impl.cdn;

import com.fuao.fajxc.dao.cdn.DistrictDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.District;

public class DistrictDaoImpl extends BaseDaoImpl implements DistrictDao {

	public District findDistrictById(Integer id) {
		try {
			return (District)super.select(District.class, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}

package com.fuao.fajxc.dao.cdn;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.District;

public interface DistrictDao extends BaseDao {
	/**
	 * 根据id查找一个区域
	 * **/
	public District findDistrictById(Integer id);

}

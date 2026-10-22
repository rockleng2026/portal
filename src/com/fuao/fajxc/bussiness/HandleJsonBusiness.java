package com.fuao.fajxc.bussiness;

import java.util.List;

public interface HandleJsonBusiness {

	/**
	 * 根据实体名，和条件，获得对象列表
	 * @param entityName
	 * @param condition
	 * @return
	 */
	public List ObjectList(String entityName ,String condition);
}

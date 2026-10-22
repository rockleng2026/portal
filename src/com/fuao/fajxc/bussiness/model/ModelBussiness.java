package com.fuao.fajxc.bussiness.model;

import java.util.List;

public interface ModelBussiness {
	/**
	 * 根据条件查找机房存放在List中
	 */
	public List someModel(String hql);
   
	public List someSales(String hql);
}

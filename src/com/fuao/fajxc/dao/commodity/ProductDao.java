package com.fuao.fajxc.dao.commodity;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.Product;

public interface ProductDao extends BaseDao  {
	
	public Product addProductObj(Product product);
	
	/**
	 * 删除产品信息 根据入库详单ID
	 */
	public boolean delProductByStorageInfoId(String strHqlId);
	
	public Product addProductObjs(Product product);
	
}

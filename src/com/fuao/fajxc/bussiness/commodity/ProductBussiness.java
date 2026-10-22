package com.fuao.fajxc.bussiness.commodity;

import java.util.List;

import com.fuao.fajxc.vo.Product;

public interface ProductBussiness {
	// 添加产品
	public Product addProductObj(Product product);
	// 根据入库详单ID 删除产品
	public boolean delProductByStorageInfoId(String strHqlId);
	
	//入库单审核通过后根据入库详细ID修改产品的状态为可以使用
	public boolean upproductStatu(String ids);
	
	//根据hql语句，查询列表
	public List<Product> getProductList(String strHql);
	public List selectList(String strHql);
	
	public Product addProductObjs(Product product);
}


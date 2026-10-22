package com.fuao.fajxc.bussiness.impl.commodity;

import java.util.List;

import org.apache.log4j.Logger;

import com.fuao.fajxc.bussiness.commodity.ProductBussiness;
import com.fuao.fajxc.dao.commodity.ProductDao;
import com.fuao.fajxc.vo.Product;

public class ProductBussinessImpl implements ProductBussiness {
	
	private ProductDao productDao;

	public ProductDao getProductDao() {
		return productDao;
	}

	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	public Product addProductObj(Product product) {
		return productDao.addProductObj(product);
	}

	public boolean delProductByStorageInfoId(String strHqlId) {
		
		return productDao.delProductByStorageInfoId(strHqlId);
	}

	public boolean upproductStatu(String ids) {
		String sql = "update product set usestate = 2 where storageInfoId in ("+ids+")";
		int result = productDao.execSQLUpdate(sql);
		if(result>0)
		{
			return true;
		}
		return false;
	}
	
	public List<Product> getProductList(String strHql) {
		// TODO Auto-generated method stub
		return (List<Product>)productDao.execHQL(strHql);
	}

	public static void main(String[] args) {
		int a[] = {1,2,3,4,5,6,9,7,8};
		System.out.println(a.toString());
	}

	public List selectList(String strHql) {
		// TODO Auto-generated method stub
		return (List)productDao.execHQL(strHql);
	}

	public Product addProductObjs(Product product) {
		return productDao.addProductObjs(product);
	}


}

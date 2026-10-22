package com.fuao.fajxc.dao.impl.commodity;

import org.hibernate.Query;

import com.fuao.fajxc.dao.commodity.ProductDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.vo.Product;

public class ProductDaoImpl extends BaseDaoImpl implements ProductDao {

	public Product addProductObj(Product product) {
		try {
			super.getHibernateTemplate().save(product);
			System.out
					.println("CM： ---> ProductDaoImpl ---> addProductObj 添加商品信息成功   --->  返回最新添加商品表  --->  ID =  "
							+ product.getId());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("添加商品信息出错");
		}
		return product;
	}

	// 添加纯JDBC
	public Product addProductObjs(Product product) {
		String sql = "insert into product(propertyId,barcode,depotId,storageInfoId,usestate,useSum,parentId,delflag) values("
				+ product.getProperty().getId()
				+ ",'"
				+ product.getBarcode()
				+ "',"
				+ product.getDepot().getId()
				+ ","
				+ product.getStorageInfo().getStorageInfoId()
				+ ","
				+ product.getUsestate()
				+ ","
				+ product.getUseSum()
				+ ","
				+ product.getParentId() + ",'" + product.getDelflag() + "')";
		Query query = this.getSession().createSQLQuery(sql);
		query.executeUpdate();
		return product;
	}

	public boolean delProductByStorageInfoId(String strHqlId) {
		boolean flag = false;
		try {
			String hql = "delete from Product where 1=1 " + strHqlId;
			Query query = this.getSession().createQuery(hql);
			int i = query.executeUpdate();
			if (i > 0) {
				flag = true;
			}
		} catch (Exception ex) {
			logger.error("删除产品信息出错", ex);
			ex.printStackTrace();
		}
		return flag;
	}

}

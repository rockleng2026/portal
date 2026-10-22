package com.fuao.fajxc.bussiness.impl.stockpile;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.fuao.fajxc.bussiness.stockpile.WarehousingBussiness;
import com.fuao.fajxc.dao.stockpile.WarehousingDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Storage;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.StorageInfo;
import com.fuao.fajxc.vo.Users;
/**
 * 入库单管理 Bussiness
 * @author 陈萌
 */
public class WarehousingBussinessImpl implements WarehousingBussiness {
	
	
	private WarehousingDao warehousingDao;
	
	
	public WarehousingDao getWarehousingDao() {
		return warehousingDao;
	}

	public void setWarehousingDao(WarehousingDao warehousingDao) {
		this.warehousingDao = warehousingDao;
	}

	/**
	 * 分页查询入库单
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values){
		System.out.println("cm:  ---> Bussiness ---> exHqlPages() --->  分页查询入库单" );
		Pages pages = null;
		try {
			pages=warehousingDao.exHqlPages(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pages;
	}
	
	// 循环添加入库单、入库详单、产品表
	public boolean addAffairsWarehousingAll(Storage storage,String toOrderNum, String piciNo){
		boolean booleanStorage = false;
		
		
		return booleanStorage;		
	}

	/**
	 * 添加入库单信息
	 */
	public Storage addStorage(Storage storage){
		
		Storage storag = warehousingDao.addStorage(storage);	
		return storag;
	}
	
	public Storage addStorageObj(Storage storage){
		return warehousingDao.addStorageObj(storage);
	}
	
	/**
	 * 删除入库单信息，可批量删除入库单信息
	 */
	public boolean delStorage(Object[] object){
		Object[] obj = new Object[object.length];
		for(int i = 0; i < object.length; i++){
			try{
			obj[i] = Integer.parseInt(object[i].toString());
			}catch(Exception e){
				System.out.println("CM： --->  BIZ  delete  --->   delStorage --->   delete error\n errorInfo:");
				e.printStackTrace();
			}
		}
		return warehousingDao.delStorage(obj);
	}
	
	/**
	 * 修改入库单信息
	 */
	public boolean editStorage(Storage storage){
		System.out.println("cm : ---> Bussiness ---> editStorage() --> ");
		return warehousingDao.editStorage(storage);
	}
	
	/**
	 * 根据条件查询入库单信息
	 */
	public List someStorage(String strHql){
		System.out.println("cm : ---> Bussiness  ---> getStorageByConditions() --> ");
		return warehousingDao.someStorage(strHql);
	}

	/**
	 * 查询
	 */
	public List select(String hql)
	{
		return warehousingDao.select(hql);
	}
	/**
	 * 查找入库类型
	 */
	public List selType(String addhql){
		return warehousingDao.selType(addhql);
	}
	

	/**
	 * 根据用户名和密码，获得该用户对象
	 * @param loginname
	 * @param password
	 * @return
	 */
	public Users getUsersByLoginName(String loginname,String password){
		return warehousingDao.getUsersByLoginName(loginname, password);
	}
	
	/**
	 * 添加入库详单
	 */
	public StorageInfo addStorageInfo(StorageInfo storageInfo){
		return warehousingDao.addStorageInfo(storageInfo);
	}

	/**
	 * 添加入库详单
	 */
	public StorageInfo addStorageInfoObj(StorageInfo storageInfo){
		return warehousingDao.addStorageInfoObj(storageInfo);
	}

	/**
	 * 删除入库详单
	 * @param addhql
	 * @return boolean
	 */
	public boolean delStorageInfo(String addhql) {
		return this.warehousingDao.delStorageInfo(addhql);
	}
	
	
	

	/**
	 * main方法
	 */
	public static void main(String[] args){
		System.out.println("cm : ---> Bussiness  ---> main() --> ");
		ApplicationContext ac=new FileSystemXmlApplicationContext
		("/src/applicationContext*.xml");
		WarehousingBussiness wb=(WarehousingBussiness)ac.getBean("warehousingBussiness");
		
		
		// 添加
		
		// 查询
		String hql="from Storage b where b.delflag=0 order by b.id desc";
		
		System.out.println("cm : ---> 分页 ："+wb.exHqlPages(hql, 1, 2, null));
		
		Storage s = (Storage)wb.someStorage(" and id=1").get(0);
		
		

		System.out.println("cm : ---> -------->"+s.getStorageInfos());
		
	}

	public List getStorageInfo(String hql) {
		
		return warehousingDao.execHQL(hql);
	}

	public Object add(Object ojb) {
		// TODO Auto-generated method stub
		return warehousingDao.addobj(ojb);
	}
	
}

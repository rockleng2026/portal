package com.fuao.fajxc.bussiness.stockpile;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Batchexp;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Storage;
import com.fuao.fajxc.vo.StorageInfo;
import com.fuao.fajxc.vo.Users;

public interface WarehousingBussiness {
	
	/**
	 * 分页查询入库单
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	

	public boolean addAffairsWarehousingAll(Storage storage,String toOrderNum, String piciNo);

	/**
	 * 添加入库商品信息
	 */
	public Storage addStorage(Storage storage);
	
	public Object add(Object ojb);
	/**
	 * 添加入库单
	 */
	public Storage addStorageObj(Storage storage);
	
	/**
	 * 删除入库商品信息
	 */
	public boolean delStorage(Object[] object);
	
	
	/**
	 * 删除入库详单
	 */
	public boolean delStorageInfo(String addhql) ;
	
	
	/**
	 * 修改入库商品信息
	 */
	public boolean editStorage(Storage storage);
	
	/**
	 * 根据条件查询入库商品信息
	 */
	public List someStorage(String strHql);
	
	/**
	 * 查询
	 */
	public List select(String hql);
	
	/**
	 * 查找入库类型
	 */
	public List selType(String addhql);
	
	/**
	 * 添加入库详单
	 */
	public StorageInfo addStorageInfo(StorageInfo storageInfo);

	/**
	 * 添加入库详单
	 */
	public StorageInfo addStorageInfoObj(StorageInfo storageInfo);
	
	
	/**
	 * 根据用户名和密码，获得该用户对象
	 */
	public Users getUsersByLoginName(String loginname,String password);
	
	/**
	 * 根据入库信息ID查询入库详细列表
	 */
	public List getStorageInfo(String hql);
}

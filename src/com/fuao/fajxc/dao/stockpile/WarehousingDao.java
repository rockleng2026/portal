package com.fuao.fajxc.dao.stockpile;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Storage;
import com.fuao.fajxc.vo.StorageInfo;
import com.fuao.fajxc.vo.Users;

public interface WarehousingDao extends BaseDao {
	
	/**
	 * 分页查询入库单
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	

	/**
	 * 添加入库单信息
	 */
	public Storage addStorage(Storage storage);
	
	/**
	 * 添加入库单信息
	 */
	public Storage addStorageObj(Storage storage);
	
	/**
	 * 删除入库单信息
	 */
	public boolean delStorage(Object[] object);
	
	/**
	 * 修改入库单信息
	 */
	public boolean editStorage(Storage storage);
	
	/**
	 * 根据条件查询入库单信息
	 */
	public List someStorage(String strHql);
	
	/**
	 * 查询
	 */
	public List select(String hql);
	
	/**
	 * 查找入库单的入库业务类型
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
	 * 删除  入库详单
	 */
	public boolean delStorageInfo(String addhql) ;
	
	
	/**
	 * 获得入库单信息总数
	 */
	public int getCountStorage(String strHql);
	
	/**
	 * 根据用户名和密码，获得该用户对象
	 */
	public Users getUsersByLoginName(String loginname,String password);


	public Object addobj(Object ojb);
	
}

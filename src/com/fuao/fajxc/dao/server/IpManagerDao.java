package com.fuao.fajxc.dao.server;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.IPConfiguration;


public interface IpManagerDao extends BaseDao {

	/*
	 * 分页Ip管理(查询)
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	
	/*
	 * 添加ip
	 */
	public boolean addIp(IPConfiguration configuration);

   /*
    * 修改ip
    */
	public boolean updateIp(IPConfiguration configuration);
	
	/*
	 * 删除ip
	 */
   public boolean delIp(Object [] ids);
	
   /*
    * 查询数据库里是否有Ip地址
    */
   public boolean selectName(String name);
   
   /*
    * 根据Id查询
    */
   public IPConfiguration find(Integer ipcid);
   
   /*
    *改IP状态 为使用
    */
   public boolean updateipc(Object [] ids);
   
   /*
    * 改IP状态为禁用
    */
   public boolean updateipc1(Object [] ids);
   
   /*
    * 根据ID修改状态
    */
   public boolean updateById(Integer ipcid,String ipcstate);
   
   public List getObject(String tablename,Integer id);
   
   public List getObject1(String tablename,Integer id);
   
}

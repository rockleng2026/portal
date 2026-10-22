package com.fuao.fajxc.bussiness.server;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.IPConfiguration;

public interface IpServer{
	
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
    * 查新是否数据库已有了Ip地址
    */

   public boolean selectName(String  name);
   
   /*
    * 根据id查询单个
    */
   public IPConfiguration find(Integer ipcid);
   
   /*
    * ip状态该使用为禁用 
    */
   public boolean updateState0(Object [] ids);
   /*
    * ip状态改禁用为使用
    */
   public boolean updateState1(Object [] ids);
   
   /*
    * 根据ID来修改IP状态
    */
   public boolean updateById(Integer ipcid,String ipcstate);
   public List getObject(String tablename,Integer id);
   public List getObject1(String tablename,Integer id);
   
}

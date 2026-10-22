package com.fuao.fajxc.dao.servers;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.Cabinet;
import com.fuao.fajxc.vo.ElectHouse;

public interface ServerDao extends BaseDao{
	//根据机房查询地市
	public List getProvinceAndCity(String name,int start,int pasize);
	// 根据客户名称查
	public List customer(String name);
	//得到省份
	public List getProvince();
	//得到市
	public List getCity();
	// 根据前台输入城市的拼音或名称模糊查询
	public List cityByname(String name,int start,int pasize);
	// 根据城市编号得到机房
	public List houseByCityid(int cityid);
	// 根据IP得到upserver
	public List ipByupserver(String ip,int start,int pasize);
	// 根据机房得到机柜ID
	public List cardByHouse(int houseid);
	// 根据机柜ID 得到机柜
	public Object getObj(Class cla,int id);
	// 根据客户得到上架单
	public List customerByKh(int customerid,int start,int pasize);

	//得到机柜
	public Cabinet getCabinetDaos(int cid);
	//得到机房
	public ElectHouse getElectHouseDaos(int eid);
	//查询地区下的机房信息
	public List getElectByCity(String cityname);
	//根据机房查询 机柜信息
	public List getCabinetByHouse(Integer id);

	//查询所有地区的同时查出其机房名称
	public List getCandH();
	
	//遍历省市
	public List getSuper();
	public List getCityBySuperid(Integer superid); 
	//  得到所有省份
	public List getAllSheng();
	//根据城市查询这个城市的所有机房
	public List getElectByCityid(Integer cityid);
	public List get(Integer id);
	public List selElects(String stg);
	public List getCityBySuperid(int superid);
	
	//查询2
	public List getHousefromnames(String name);
	public List getIpByupservers(String ip);
	public List getCustomerByKHs(int customerid);
	public List getCityByNames(String name);
}

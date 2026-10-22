package com.fuao.fajxc.serser.service;

import java.util.List;

import com.fuao.fajxc.util.IterfaceConmens;
import com.fuao.fajxc.vo.Cabinet;
import com.fuao.fajxc.vo.DownServer;
import com.fuao.fajxc.vo.ElectHouse;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.UpServer;

public interface SerajaxService extends IterfaceConmens{
     
	public List selList();
	//添加
	public void add(Cabinet cabinet);
	public Object getConmensById(Class clazz, Integer id) ;
	//删除机房
	public void delEle(ElectHouse electHouse);
	//根据electid得到对应的Cabinet
	public List get(Integer electid);
	//删除机柜
	public void delCabin(Cabinet cabinet);
	//查询机房
	public List findELe(String electname);
	//
	public void saveEle(ElectHouse electHouse);

	public List selbyUps(int p,int s);
	
	//修改机柜
	public void updateCa(Cabinet cabinet);
	public Cabinet delC(Integer caid);
	
	public UpServer selByserID(int m);

	//上架
	public boolean  updUpserv(UpServer up); 
	//查询日志
	public int selAllLoggers(int m);
    public List spliPages(int current,int size,int m);
    public boolean addDownSer(DownServer dow);
    
    public List getOnceObject(Class oneClass,String names,String values);

	
	public List find(Integer caid);
	
	public List findUp(Integer caid);
	
	public List<ElectHouse> findEle();
	
	public void updateInc(Integer electid,Integer caid);
	
	public List<Cabinet> findAll();
	
	public void updateUp(Integer caid,Integer id);
	
	public List<SaleOrder> findAllSale();
	
	public List<Product> findAllPro();
	
	public void updateHouses(ElectHouse ehse);

    public void saveupser(UpServer ups);
    public List getsaleNode(String node);
    //更新上架表
    public boolean updateAllupsers(UpServer us);
    public List getUsersAll(String logname);
    //上架单里下架状态
    public void updaUperStat(UpServer us);
    public void saveDownSers(DownServer ds);
    //修改上架状态
    public void upsaveStats(UpServer ups);
    //ip操作
    public List IPManage(String hsql);
    public ElectHouse getElehouseObj(int hid);
}

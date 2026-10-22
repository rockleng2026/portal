package com.fuao.fajxc.serser.dao;

import java.util.List;

import com.fuao.fajxc.util.IterfaceConmens;
import com.fuao.fajxc.vo.Cabinet;
import com.fuao.fajxc.vo.DownServer;
import com.fuao.fajxc.vo.ElectHouse;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.UpServer;

public interface SerajaxDao extends IterfaceConmens{
     
	public List selList();
	//添加
	public void Add(Cabinet cabinet);
	//
	public Object getConmensById(Class clazz, Integer id) ;
	//根据id
	public List get(Integer id);
	//删除机房
	public void delEle(ElectHouse electHouse);
	//根据id得到一个cabinet
	// 删除机柜
	public void delCabin(Cabinet cabinet);
	
	//按机房名查询
	public List findEle(String electName);
	//
	public void saveEle(ElectHouse electHouse);
	
	public List selbyUps(int p,int s);
	//修改机柜
	public void updateCab(Cabinet cabinet);
	//
	public Cabinet delC(Integer caid);
	
	//上架查询
	public UpServer selByserID(int m);

	//上架
	public boolean  updUpserv(UpServer up); 
	
	public int selAllLoggers(int m);
    public List spliPages(int current,int size,int m);
    //增加下架
    public boolean addDownSer(DownServer dow);
    
    public List getOnceObject(Class oneClass,String names,String values);

	
	public List find(Integer caid);
	
	public List findUp(Integer serverid);
	
	public Product findPr(Integer pid);
	
	public List<ElectHouse> findEle();
	
	public void updateinC(Integer electid,Integer caid);
	
	public List findByC(Integer electid);
	
	public List<Cabinet> findAll();
	
	public void updateU(Integer caid,Integer id);
	
	public List<SaleOrder> findAllSale(String mt);
	
	public List<Product> findAllPro();
    //按机柜号查询位置
	public List<UpServer>findCabUper(int caid);
	//保存服务器
	public int saveupser(UpServer ups);
	//查询销售单号信息
	 public List getsaleNode(String node);
	 //查询产品
	 public List getProductList(int m);
	 //加载仓库
	 public List getStorage();
	 
	 public List getstorageId(int mp);
	 
	 public boolean updateAllupsers(UpServer us);
	 
	 public List getUsersAll(String logname);
	    //上架单里下架状态
	 public void updaUperStat(UpServer us);
	 
	 public int saveDownSers(DownServer ds);
	 
	 public void upsaveStats(UpServer ups);
	 
	 public List getRoomCode(String hsql);
	 //获取当前机房
	 public ElectHouse getElehouseObj(int id);
	 //ip操作
	 public List IPManage(String hsql);
	 //更新ip
	 public void updatIPs(IPConfiguration ipc);
	 //更新机房
	 public void updateHouses(ElectHouse ehse);
}

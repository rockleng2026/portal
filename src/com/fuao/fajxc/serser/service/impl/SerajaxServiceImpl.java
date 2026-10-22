package com.fuao.fajxc.serser.service.impl;

import java.util.Iterator;
import java.util.List;

import org.aspectj.weaver.IntMap;
import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import com.fuao.fajxc.serser.dao.SerajaxDao;
import com.fuao.fajxc.serser.service.SerajaxService;
import com.fuao.fajxc.vo.Cabinet;
import com.fuao.fajxc.vo.DownServer;
import com.fuao.fajxc.vo.ElectHouse;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.UpServer;

public class SerajaxServiceImpl implements SerajaxService{
    
	private SerajaxDao serDao;
	public SerajaxDao getSerDao() {
		return serDao;
	}

	public void setSerDao(SerajaxDao serDao) {
		this.serDao = serDao;
	}

	public boolean deleteDate(Object obj) {
	
		return this.serDao.deleteDate(obj);
	}

	public Object getObjDate(int id) {

		return this.serDao.getObjDate(id);
	}

	public List getdateList(Object obj) {

		return null;
	}

	public boolean saveDate(Object obj) {

		return this.serDao.saveDate(obj);
	}
   //’º”√πÒ∫≈
	public boolean updateDate(Object obj) {
	
		return this.serDao.updateDate(obj);
	}

	@SuppressWarnings("unchecked")
	public List selList() {
		System.out.println("I service");
		return this.serDao.selList();
	}


	public void add(Cabinet cabinet) {
//		Cabinet cabinet2 =(Cabinet)this.serDao.getConmensById(Cabinet.class, cabinet.getCaid());
//		if(cabinet2 != null)
//		{
//			
//		}
		this.serDao.Add(cabinet);
	}
	public Object getConmensById(Class clazz, Integer id) {
		return this.serDao.getConmensById(clazz, id);
	}

	public void delEle(ElectHouse electHouse) {
		this.serDao.delEle(electHouse);
	}

	
	public List get(Integer electid) {
		return this.serDao.get(electid);
	}

	public void delCabin(Cabinet cabinet) {
		this.serDao.delCabin(cabinet);
	}

	public List findELe(String electname) {
		return this.serDao.findEle(electname);
	}

	public void saveEle(ElectHouse electHouse) {
		this.serDao.saveEle(electHouse);
	}

	public List selbyUps(int p, int s) {
		return serDao.selbyUps(p, s);
	}

	public void updateCa(Cabinet cabinet) {
		this.serDao.updateCab(cabinet);
	}

	public Cabinet delC(Integer caid) {
	   return this.serDao.delC(caid);
	}


	public UpServer selByserID(int m) {
		return this.serDao.selByserID(m);
	}


	public boolean updUpserv(UpServer up) {
		return this.serDao.updUpserv(up);
	}

	public int selAllLoggers(int m){
		return this.serDao.selAllLoggers(m);
	}

	public List spliPages(int current, int size, int m) {
		return this.serDao.spliPages(current, size, m);
	}

	public boolean addDownSer(DownServer dow) {
		
		return false;
	}

	public List getOnceObject(Class oneClass, String names,String values) {

		return this.serDao.getOnceObject(oneClass, names, values);
	}


	public List find(Integer caid) {
		System.out.println("caidmmmm="+caid);
		return this.serDao.find(caid);
	}

	public List findUp(Integer caid) {
		return this.serDao.findUp(caid);
	}

	public List<ElectHouse> findEle() {
		return this.serDao.findEle();
	}

	public void updateInc(Integer electid, Integer caid) {
		this.serDao.updateinC(electid, caid);
	}

	public List<Cabinet> findAll() {
		return this.serDao.findAll();
	}

	public void updateUp(Integer caid, Integer id) {
		this.serDao.updateU(caid, id);
	}


	public List<SaleOrder> findAllSale() {
		return null;
	}

	public List<Product> findAllPro() {
		return this.serDao.findAllPro();
	}

	public void saveupser(UpServer ups) {
		int id = this.serDao.saveupser(ups);
		UpServer uServer=new UpServer();
		uServer.setId(id);
		String arr[] = ups.getServerIp().split(",");
		for (String string : arr) {
			List list = this.serDao.IPManage("from IPConfiguration p where p.ipcaddress='"+string+"'");
			for (Iterator iterator = list.iterator(); iterator.hasNext();) {
				IPConfiguration ips = (IPConfiguration) iterator.next();
				ips.setUpNo(uServer);
				ips.setIpcstate(1+"");
				this.serDao.updatIPs(ips);
			}
		}
	}

	public List getsaleNode(String node) {
		return this.serDao.getsaleNode(node);
	}

	public List getProductList(int m) {
		return this.serDao.getProductList(m);
	}

	public boolean updateAllupsers(UpServer us) {
		return this.serDao.updateAllupsers(us);
	}

	public List getUsersAll(String logname) {
		return this.serDao.getUsersAll(logname);
	}

	public void updaUperStat(UpServer us) {
		this.serDao.updaUperStat(us);
	}

	public void saveDownSers(DownServer ds) {
		int id=this.serDao.saveDownSers(ds);
		UpServer uServer=new UpServer();
		uServer.setId(id);
		String arr[] = ds.getServerIp().split(",");
		for (String string : arr) {
			List list = this.serDao.IPManage("from IPConfiguration p where p.ipcaddress='"+string+"'");
			for (Iterator iterator = list.iterator(); iterator.hasNext();) {
				IPConfiguration ips = (IPConfiguration) iterator.next();
				ips.setUpNo(null);
				ips.setIpcstate(0+"");
				this.serDao.updatIPs(ips);
			}
		}
		
	}

	public void upsaveStats(UpServer ups) {
		this.serDao.upsaveStats(ups);
	}

	public List IPManage(String hsql) {
		return this.serDao.IPManage(hsql);
	}

	public ElectHouse getElehouseObj(int hid) {
		
		return this.serDao.getElehouseObj(hid);
	}

	public void updateHouses(ElectHouse ehse) {
		this.serDao.updateHouses(ehse);
		
	}
}

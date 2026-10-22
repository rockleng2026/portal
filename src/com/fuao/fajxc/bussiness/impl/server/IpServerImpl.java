package com.fuao.fajxc.bussiness.impl.server;

import java.util.List;

import com.fuao.fajxc.bussiness.server.IpServer;
import com.fuao.fajxc.dao.server.IpManagerDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.IPConfiguration;

public class IpServerImpl implements IpServer {

	private IpManagerDao managerDao;
	
	
	public IpManagerDao getManagerDao() {
		return managerDao;
	}

	public void setManagerDao(IpManagerDao managerDao) {
		this.managerDao = managerDao;
	}

	public boolean addIp(IPConfiguration configuration) {
		return this.managerDao.addIp(configuration);
	}

	public boolean delIp(Object [] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<obj.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return this.managerDao.delIp(obj);
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		return this.managerDao.exHqlPages(hql, pageNo, pageSize, values);
	}

	public boolean updateIp(IPConfiguration configuration) {
		return this.managerDao.updateIp(configuration);
	}

	public boolean selectName(String name) {
		return this.managerDao.selectName(name);
	}

	public IPConfiguration find(Integer ipcid) {
		return this.managerDao.find(ipcid);
	}

	/*
	 * ½ûÓÃIP
	 */
	public boolean updateState0(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<obj.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return this.managerDao.updateipc(obj);
	}

	/*
	 * Ê¹ÓÃIP
	 */
	public boolean updateState1(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<obj.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return this.managerDao.updateipc1(obj);
	}

	public boolean updateById(Integer ipcid, String ipcstate) {
		return this.managerDao.updateById(ipcid, ipcstate);
	}

	public List getObject(String tablename, Integer id) {
		return this.managerDao.getObject(tablename, id);
	}

	public List getObject1(String tablename, Integer id) {
		return this.managerDao.getObject1(tablename, id);
	}

}

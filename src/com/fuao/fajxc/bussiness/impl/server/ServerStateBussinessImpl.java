package com.fuao.fajxc.bussiness.impl.server;

import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.bussiness.server.ServerStateBussiness;
import com.fuao.fajxc.dao.server.AssemblyServerDao;
import com.fuao.fajxc.dao.server.ServerStateDao;
import com.fuao.fajxc.util.Pages;

public class ServerStateBussinessImpl implements ServerStateBussiness {

	private AssemblyServerDao asd;
	private ServerStateDao ssd;
	
	
	
	
	public ServerStateDao getSsd() {
		return ssd;
	}


	public void setSsd(ServerStateDao ssd) {
		this.ssd = ssd;
	}


	public AssemblyServerDao getAsd() {
		return asd;
	}


	public void setAsd(AssemblyServerDao asd) {
		this.asd = asd;
	}



	public List selProduct(String addhql) {
		return asd.selProduct(addhql);
	}


	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		return asd.exHqlPages(hql, pageNo, pageSize, values);
	}


	public boolean changeState(int state,int id) {
		boolean flag2=false;
		boolean flag=false;
		try
		{
			flag=ssd.changeState(state, id);
			if(flag){
				if(state==1)
					flag2=ssd.appenduseNum(id);
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}




	
}

package com.fuao.fajxc.dao.impl.server;

import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.server.ServerStateDao;

public class ServerStateDaoImpl extends BaseDaoImpl implements ServerStateDao {

	public boolean changeState(int state,int id) {
		boolean flag=false;
		try
		{
			String hql="update Product set usestate=? where id=?";
			Query query=this.getSession().createQuery(hql);
			query.setParameter(0, state);
			query.setParameter(1, id);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}
	
	public boolean appenduseNum(int id)
	{
		boolean flag=false;
		try
		{
			String hql="update Product set useSum=useSum+1 where id=?";
			Query query=this.getSession().createQuery(hql);
			query.setParameter(0, id);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	
}

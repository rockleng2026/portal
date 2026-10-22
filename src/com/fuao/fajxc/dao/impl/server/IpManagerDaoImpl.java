package com.fuao.fajxc.dao.impl.server;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.server.IpManagerDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.IPConfiguration;

@SuppressWarnings("unused")
public class IpManagerDaoImpl extends BaseDaoImpl implements IpManagerDao {
	
	private Logger loggerr = Logger.getLogger(IpManagerDaoImpl.class);

	//添加Ip
	public boolean addIp(IPConfiguration configuration) {
		boolean falg = false;
		String hql="insert into t_ipconfiguration(properID,depoID,ipcname,ipcaddress,ipcarrier,ipcstate,isblack) values("+configuration.getTproperty().getId()+","+configuration.getTdepot().getId()+",'"+configuration.getIpcname()+"','"+configuration.getIpcaddress()+"','"+configuration.getIpcarrier()+"','"+configuration.getIpcstate()+"','"+configuration.getIsblack()+"')";
		Query query = this.getSession().createSQLQuery(hql);
		int i = query.executeUpdate();
		if(i>0)
		{
			falg = true;
		}
		return falg;
	}
	//删除ip
	public boolean delIp(Object [] ids) {
		boolean flag = false;
		try {
			String hql = "update from IPConfiguration as ip set ip.isblack = '1' where ip.ipcId in (:ids)";
			Query query = this.getSession().createQuery(hql);
			query.setParameterList("ids", ids);
			int i = query.executeUpdate();
			if(i>0)
			{
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("删除动作时出错",e);
		}
		return flag;
	}
	
	//分页
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages pages = null;
		
		try {
			pages = super.paginationQuery(hql, pageNo,pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("分页时出错",e);
		}
		
		return pages;
	}

	//修改
	public boolean updateIp(IPConfiguration configuration) {
		boolean flag = false;
		
		try {
			this.getHibernateTemplate().merge(configuration);
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("修改时出错",e);
		}
		return flag;
	}
	public boolean selectName(String name) {
		boolean falg = false;
		String hql = "from IPConfiguration as ip where ip.ipcaddress ='"+name+"'";
		List list = this.getHibernateTemplate().find("from IPConfiguration as ip where ip.ipcaddress ='"+name+"'");
		
//		Query query = this.getSession().createQuery(hql);
//		int num = query.executeUpdate();
		if(list != null && list.size() >0){
			falg = true;
		}
		return falg;
	}
	public IPConfiguration find(Integer ipcid) {
		String hql  = "from IPConfiguration as ip where ip.ipcId="+ipcid;
		List list = this.getHibernateTemplate().find(hql);
		IPConfiguration configuration = (IPConfiguration) list.get(0);
		return configuration;
	}
	/*
	 * 改使用为禁用
	 */
	public boolean updateipc(Object[] ids) {
		boolean falg = false;
		String hql = "update IPConfiguration as ip set ip.ipcstate='0' where ip.ipcId in (:ids) ";
		Query query = this.getSession().createQuery(hql);
		query.setParameterList("ids", ids);
		int num = query.executeUpdate();
		if(num > 0 )
		{
			falg = true;
		}
		
		return falg;
	}
	/*
	 * 改禁用为使用
	 */
	public boolean updateipc1(Object[] ids) {
		boolean falg = false;
		String hql = "update IPConfiguration as ip set ip.ipcstate='1' where ip.ipcId in (:ids) ";
		Query query = this.getSession().createQuery(hql);
		query.setParameterList("ids", ids);
		int num = query.executeUpdate();
		if(num > 0 )
		{
			falg = true;
		}
		return falg;
	}
	/*
	 *根据ID修改Ip状态
	 */
	public boolean updateById(Integer ipcid, String ipcstate) {
		boolean flag = false;
		String  hql = "update IPConfiguration as ip set ip.ipcstate='"+ipcstate+"' where ip.ipcId="+ipcid;
		Query query =this.getSession().createQuery(hql);
		int num = query.executeUpdate();
		if(num >0){
			flag = true;
		}
		return flag;
	}
	public List getObject(String tablename, Integer id) {
		String hql = "from "+tablename+" as t where 1=1 and t.id = "+id;
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
	public List getObject1(String tablename, Integer id) {
		String hql = "from "+tablename+" as t where 1=1 and t.storageInfoId = "+id;
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
	
   
}

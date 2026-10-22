package com.fuao.fajxc.dao.impl.system;

import java.util.List;

import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.system.UploadDao;
import com.fuao.fajxc.vo.EmployeeFjfb;


public class UploadDaoImpl extends BaseDaoImpl implements UploadDao {

	public boolean del(String ids) {
		  String id[] = ids.split(",");
			Object[] obj = new Object[id.length];
			for(int i=0; i<id.length;i++)
			{
				obj[i] =Integer.parseInt(id[i].toString());
			}
			boolean flag=false;
			String hql="delete BizScfjb where id in(:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids", obj);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
			return flag;
	}
	public boolean del(String tableName,String ids) {
		  String id[] = ids.split(",");
			Object[] obj = new Object[id.length];
			for(int i=0; i<id.length;i++)
			{
				obj[i] =Integer.parseInt(id[i].toString());
			}
			boolean flag=false;
			String hql="delete "+tableName+" where id in(:ids)";
			Query query=this.getSession().createQuery(hql);
			query.setParameterList("ids", obj);
			int i=query.executeUpdate();
			if(i>0)
				flag=true;
			return flag;
	}
	public List select(String ids) {
         String sql = "select * from employee_fjfb where id in ("+ids+")";
         System.out.println(sql);
			List list = super.execSQL(sql);
			return list;
			
	}
	public List<EmployeeFjfb> selectEmpById(String strEmpId){
		String hql = "from EmployeeFjfb e where e.employee.id = " + strEmpId;
        System.out.println(hql);
		List list = super.execHQL(hql);
		return list;
	}
	public List select(String tableName,String ids) {
        String sql = "select * from "+tableName+" where id in ("+ids+")";
        System.out.println(sql);
			List list = super.execSQL(sql);
			return list;
	}

}

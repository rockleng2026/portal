package com.fuao.fajxc.dao.sysadmin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.util.BaseDao;
import com.fuao.fajxc.util.MD5;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Fa_Cms_Admin;

public class SysadminDAOImpl extends BaseDao implements SysadminDAO{
	
	//添加管理员
	public void addAdmin(Fa_Cms_Admin admin){
	     this.getHibernateTemplate().save(admin);	
	}
	//修改管理员
	public void updateAdmin(Fa_Cms_Admin admin){
		Session session = (Session) super.getSessionFactory().getCurrentSession();
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = dateFormat2.format(admin.getRegdate());
		String sql="update Fa_Cms_Admin set username='"+admin.getUsername()+"',admin_password='"+admin.getAdmin_password()+"',email='"+admin.getEmail()+"',regdate='"+now+"',deptid='"+admin.getDepts().getId()+"' where user_id="+admin.getUser_id();
		Query query = session.createQuery(sql);
		query.executeUpdate();
		session.close();
	}
	//修改密码
	public void updateAdminPassword(Fa_Cms_Admin admin){
		Session session = (Session) super.getSessionFactory().getCurrentSession();
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		String now = dateFormat2.format(admin.getRegdate());
//		String sql="update Fa_Cms_Admin set username='"+admin.getUsername()+"',admin_password='"+admin.getAdmin_password()+"',email='"+admin.getEmail()+"',regdate='"+now+"',deptid='"+admin.getDepts().getId()+"' where user_id="+admin.getUser_id();
		String sql="update Fa_Cms_Admin set admin_password='"+admin.getAdmin_password()+"' where user_id="+admin.getUser_id();
		 Query query = session.createQuery(sql);
		 query.executeUpdate();
		 session.close();
	}
	//注销
	
	/**
	 * 分页
	 * @param pg
	 * @return
	 */
	public List splitPages(int current,int row,String sql){
		 System.out.println(current);
		 System.out.println(row);
		 Session session = (Session)super.getSessionFactory().getCurrentSession();
		 Query query = session.createQuery(sql);
		 System.out.println(query);
		 query.setFirstResult(current);
		 query.setMaxResults(row);	
		 List<Fa_Cms_Admin> list=query.list();
		 System.out.println(list.size());
		 System.out.println(list.get(0).getEmail());
		 return printList(list);
	}
	//组装数据
	@SuppressWarnings("unchecked")
	public List printList(List liss){
		System.out.println(""+liss.size());
		List list=new ArrayList();
		int count=1;		
		System.out.println("fdas"+liss.get(0));
		
		for(int i=0;i<liss.size();i++){
			Fa_Cms_Admin admin=(Fa_Cms_Admin)liss.get(i);	

			   Department depts=(Department) this.getDeptById(Department.class, admin.getDepts().getId());
				Map m=new HashMap();
				m.put("num", count++);
				m.put("userid", admin.getUser_id());  //类别ID
				m.put("username",admin.getUsername());  //类别名称
				m.put("email", admin.getEmail());
				m.put("did", depts.getId());
				m.put("dname", depts.getName());
				m.put("pwd", admin.getAdmin_password());
				if(admin.getAdmin_status()==1){
				    m.put("sta","注销"); // 开通1，注销0
				}
				if(admin.getAdmin_status()==0){
					m.put("sta","有效"); //
				}
				m.put("pOper", "aa");// 操作
				list.add(m);
		}
			    return list;
	}
	
	/**
	 * 得到总记录数
	 * @return
	 */
	public int  countData(String sql){
		Session session = (Session) super.getSessionFactory().getCurrentSession();
	    Query query = session.createSQLQuery(sql);
	    System.out.println(query.uniqueResult().toString());
	    int count = Integer.parseInt(query.uniqueResult().toString());
	    System.out.println(count);
		return count;
	}
	//绑定部门
	public List<Department> getDept(){
		String sql="from Department where delflag=0";
		return this.getHibernateTemplate().find(sql);
	}
	
	/**
	 * 根据ID获得对象
	 */
	public Object getDeptById(Class clazz, Integer id) {
		return super.getHibernateTemplate().get(Department.class, id);
	}
	
	/****
	 * 注销开通
	 */
	public void updateSta(int userid,int sta){
		Session session = (Session) super.getSessionFactory().getCurrentSession();
		String hql="update Fa_Cms_Admin set admin_status="+sta+" where user_id="+userid;
		Query query = session.createQuery(hql);
		query.executeUpdate();
		session.close();
		
	}
	
	/**
	 * 根据ID获得对象
	 */
	public Object getAdminById(Class clazz, Integer id) {
		return super.getHibernateTemplate().get(Fa_Cms_Admin.class, id);
	}

}

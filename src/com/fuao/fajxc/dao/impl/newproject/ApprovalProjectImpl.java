package com.fuao.fajxc.dao.impl.newproject;

/*******
 * 审批项目实现方法。
 */

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.newproject.ApprovalProject;
import com.fuao.fajxc.util.BaseDao;
import com.fuao.fajxc.vo.Approverecord;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.fuao.fajxc.vo.NewApprove;
import com.fuao.fajxc.vo.NewParticipator;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewWatch;
import com.mchange.v2.c3p0.impl.NewPooledConnection;

public class ApprovalProjectImpl extends BaseDaoImpl  implements ApprovalProject {
	

	// 审批列表
	public List<NewApprove> getApproveList(){
		String hql="from NewApprove where appstatus=0";
		return this.getHibernateTemplate().find(hql);
	}
	
	/**
	 * 根据主键加载数据
	 * @param clazz
	 * @param id
	 * @return
	 */
	public Object getObjById(Class clazz,Integer id){
		return super.getHibernateTemplate().get(clazz, id);
	}
	
	// 根据审批对象修改审批信息
	public void updateApprove(NewApprove app){
		Session session = this.getSessionFactory().getCurrentSession();
		String hql = "update NewApprove SET appstatus="+app.getAppstatus()+",approveinfo='"+app.getApproveinfo()+"' WHERE id="+app.getId()+"";
		Query query=session.createQuery(hql);
		query.executeUpdate();
	}
	
	// 添加审批记录
	public void addRecord(Approverecord record){
		Session session = this.getSessionFactory().getCurrentSession();
		String hql="INSERT INTO approverecord(projectname,approveemp,applypeople,apptime,approveinfo,ispass) VALUES('"+record.getProjectname()+"','"+record.getApproveemp()+"','"+record.getApplypeople()+"','"+record.getApptime()+"','"+record.getApproveinfo()+"',"+record.getIspass()+")";
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	
	/***
	 * 根据名称模糊查询
	 */
	public List getProject(String projectname,Employee emp){
		String hql="select n.id from NewProject n where n.projectname LIKE '%"+projectname+"%' ORDER BY n.begintime DESC";
		List list= this.getHibernateTemplate().find(hql);
		return list;
	}
	
	/******
	 * 修改项目状态
	 */
	public void updatePrj(NewProject project){
		Session session = this.getSessionFactory().getCurrentSession();
		String hql="update NewProject set projectstatus="+project.getProjectstatus()+" where id="+project.getId();
		Query query=session.createQuery(hql);
		query.executeUpdate();
	}
	
	/*******
	 * 根据项目对象找到所有参与人员　
	 */
	public List cyrByPid(NewProject project){
		String hql="from NewWatch where project.id="+project.getId();
		return this.getHibernateTemplate().find(hql);
	}
	
	/****
	 * 保存参与人
	 */
	public void addcyr(NewWatch watch){
		String hql="insert into new_watch(pid,empid) values("+watch.getProject().getId()+","+watch.getEmp().getId()+")";
		Session session=this.getSession();
		Query query= session.createSQLQuery(hql);
		query.executeUpdate();
	}

	/**
	 * 根据id查找员工方法二
	 *@return 
	 */
	public Employee getEmpByEId(int id)
	{
	    String hql="from Employee e where e.id="+id;
	    List list= this.getHibernateTemplate().find(hql);
	    Employee emp=new Employee();
	    if(list.size()>0){
	    	emp=(Employee)list.get(0);
	    }
	    return emp;
	}
	
	public void updateApprovemoney(Employee employee){
		this.getHibernateTemplate().update(employee);
	}
	
	/**
	 * 添加项目查看者
	 */
	public void addPrjWatcher(NewWatch obj){
		String hql="insert into new_watch(pid,empid) values("+obj.getProject().getId()+","+obj.getEmp().getId()+")";
		Session session=this.getSession();
		Query q= session.createSQLQuery(hql);
		q.executeUpdate();
	}
}

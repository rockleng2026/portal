package com.fuao.fajxc.dao.project;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.fuao.fajxc.vo.Project;
import com.fuao.fajxc.vo.ProjectEmp;
import com.fuao.fajxc.vo.ProjectEmpLead;
import com.fuao.fajxc.vo.ProjectLead;

public class ProjectImpl extends BaseDaoImpl implements ProjectDao {

	/****
	 * 分页查询分页列表
	 */
	public Pages getAllPrj(String hql, int pageNo, int pageSize, Object values) {
		return super.paginationQuery(hql, pageNo, pageSize, values);
	}

	/***
	 * 发起项目添加
	 */
	public void savePrj(Project prj) {
        this.getHibernateTemplate().save(prj);
	}

	/***
	 * 修改项目进度
	 */
	public void updatePrj(Project prj) {
		//项目进度，监督领导，领导评论，项目功能，项目描述，预计完成时间,leadname,leadevaluate,prjfunction,prjdes,yjendtime
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = dateFormat2.format(prj.getYjendtime());
		Session session = this.getSessionFactory().getCurrentSession();
		String hql = "update Project set prjplan="+prj.getPrjplan()+",leadname='"+prj.getLeadname()+"',leadevaluate='"+prj.getLeadevaluate()+"',prjfunction='"+prj.getPrjfunction()+"',prjdes='"+prj.getPrjdes()+"',yjendtime='"+now+"' where id="+prj.getId()+" ";
		System.out.println(hql);
		Query query=session.createQuery(hql);
		query.executeUpdate();
	}
	
	// 绑定部门表
	public List<Department> getAllDept(){
		String hql="from Department where delflag=0";
		return getHibernateTemplate().find(hql);
	}
	
	// 根据项目编号得到对象
	public Object getPrjById(Class clazz, Integer id){
		return  super.getHibernateTemplate().get(clazz, id);
	}
	
	// 根据项目编号得到参与人员
	public List<Map<String, String>> getEmpByPrjid(int prjid){
		String hql="from ProjectEmp where prj.id="+prjid + " and isinvite=2";
		List<ProjectEmp> list=this.getHibernateTemplate().find(hql);
		List<Map<String, String>> emplist=new ArrayList<Map<String, String>>();		
		for(int i=0;i<list.size();i++){
			Map<String, String> mp=new HashMap<String, String>();
			ProjectEmp prjemp=(ProjectEmp)list.get(i);
			System.out.println(prjemp.getEmployee().getName());
			System.out.println(prjemp.getPrj().getPrjname());
			int empid=prjemp.getEmployee().getId();
			Employee emp=(Employee)super.getHibernateTemplate().get(Employee.class, empid);
			mp.put("empid", empid+"");
			mp.put("ename", prjemp.getEmployee().getName());
			emplist.add(i, mp);
		}
		return emplist;
	}
	
	// 添加参与人员信息
	public void savePrjEmp(ProjectEmp prjemp){
		this.getHibernateTemplate().save(prjemp);
	}
	/******
	 * 根据员工编号获取员工进度条显示
	 */
	public ProjectEmp empPlan(int empid){
		String hql="from ProjectEmp where empid="+empid;
		List<ProjectEmp> prjemp=(List<ProjectEmp>) this.getHibernateTemplate().find(hql);
		ProjectEmp emp=new ProjectEmp();
		if(prjemp.get(0)!=null){
			emp= prjemp.get(0);
		}
		return emp; 
	}

	/***
	 * 根据员工编号与邀请级别得到任务对象
	 */
	public ProjectEmp inviteEmp(int empid){
		// isinvite=1表示发送了邀请
		String hql="from ProjectEmp where isinvite=1 and empid="+empid;
		List<ProjectEmp> prjemp=(List<ProjectEmp>) this.getHibernateTemplate().find(hql);
		ProjectEmp emp=new ProjectEmp();
		if(prjemp.size()>0){
			emp= prjemp.get(0);
		}
		return emp; 
	}

	/*****
	 * 根据登录的用户名得到 employee对象
	 */
	public Employee getEmp(String empno){
		String hql="from Employee where empNo='"+empno+"'";
		List<Employee> list= this.getHibernateTemplate().find(hql);
		Employee emp=null;
		if(list!=null && list.size()>0){
			emp= list.get(0);
		}
		return emp;
		
	}

	public void updateMission(ProjectEmp prjemp) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String now = sdf.format(prjemp.getPrjyjendtime());
		String d=sdf.format(new Date());
		String begintime=sdf.format(prjemp.getPrjbegintime());
		String endtime=sdf.format(prjemp.getPrjendtime());
		String hql = "update ProjectEmp set empid="+prjemp.getEmployee().getId()+",prjrw='"+prjemp.getPrjrw()+"',prjyjendtime='"+now+"',prjbegintime='"+begintime+"',prjendtime='"+endtime+"',prjempplan="+prjemp.getPrjempplan()+
		",warn="+prjemp.getWarn()+",isinvite="+prjemp.getIsinvite()+",leadname='"+prjemp.getLeadname()+"',leadevaluate='"+prjemp.getLeadevaluate()+"',prjuptime='"+d+"', jobdes='"+prjemp.getJobdes()+"' where id="+prjemp.getId();
		System.out.println(hql);
		Query query = super.getSessionFactory().getCurrentSession().createQuery(hql);
		int i= query.executeUpdate();
		System.out.println(i);
	}
	
	
	public void updateIsvite(ProjectEmp prjemp){
		String hql = "update ProjectEmp set isinvite="+prjemp.getIsinvite()+" where id="+prjemp.getId();
		System.out.print(hql);
		Query query = super.getSessionFactory().getCurrentSession().createQuery(hql);
		query.executeUpdate();
	}
	
	/******
	 * 改变邀请状态
	 */
	public void changeIsvite(int prjempid,int isvite){
		String hql="update ProjectEmp set isvite="+isvite+" where id="+prjempid;		
	}
	
	
	// 根据项目编号得到获取员工任务
	public List<ProjectEmp> prjEmp(int prjid){
		String hql="from ProjectEmp where prj.id="+prjid+" and isinvite=2";
		List<ProjectEmp> list=this.getHibernateTemplate().find(hql);		
		return list;
	}
	
	// 获取这一周内的所有员工项目进度的动态消息
	public List<ProjectEmp> updatePrjmsg(String zd,int prjid){
		Date date=new Date();
		// 得到当前时间
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String now = dateFormat2.format(date);
		date.setDate(date.getDate()+7); // 一周内
		String d = dateFormat2.format(date);
		String hql="from ProjectEmp where "+zd+"<='"+d+"' and "+zd+">='"+now+"' and prjid="+prjid;
		List<ProjectEmp> uptimelist= this.getHibernateTemplate().find(hql);
		return uptimelist;
	}
	
	//获取这一周内的领导动态消息
	public List<ProjectEmpLead> getLeadMsg(String zd){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String now = sdf.format(date);
		date.setDate(date.getDate()+7);
		String d = sdf.format(date);
		String hql = "from Project p,ProjectLead l where p.id = l.prjid and "+zd+"<='"+d+"' and "+zd+">='"+now+"'";
		List<ProjectEmpLead> leadlist = this.getHibernateTemplate().find(hql);
		return leadlist;
	}

	/**
	 * 根据empNo查询员工信息
	 */
	public Employee getEmployeeByEmpNo(String empno){
		String hql = "from Employee where 1 = 1 and empNo='"+empno+"' ";
		Query query = this.getSession().createQuery(hql);
		if(null!=query.list() && query.list().size()>0){
			Employee emp = (Employee)query.list().get(0);
			return emp;
		}
		return null;
	}


	public ProjectEmp getProjectEmpByEmpid(Integer empid) {
		String sqls = "from ProjectEmp where 1=1 and employee.id="+empid;
		System.out.println(sqls);
		Query query = this.getSession().createQuery(sqls);
		if(query.list()!=null && query.list().size()>0){
		ProjectEmp pe = (ProjectEmp)query.list().get(0);
		return pe;
		}
		return null;
	}
	
	//根据登录人查询是否为项目负责人
	public Project getPrjByManager(String manager){
		String hql = "from Project where 1=1 and prjmanager ='"+manager+"' ";
		Query query = this.getSession().createQuery(hql);
		if(query.list()!=null && query.list().size()>0){
			Project project = (Project)query.list().get(0);
			return project;
		}
		return null;
	}

	//根据登录人查询其是否 为领导
	public Project getPrjByLeadname(String leadname) {
		String hql = "from Project where 1=1 and leadname ='"+leadname+"'";
		Query query = this.getSession().createQuery(hql);
		if(query.list()!=null && query.list().size()>0){
			Project project = (Project)query.list().get(0);
			return project;
		}
		return null;
	}
	
	//根据登录人查询其是否为项目发起人
	public Project getPrjByStartperson(String startpersonname) {
		String hql = "from Project where 1=1 and startperson ='"+startpersonname+"' ";
		Query query = this.getSession().createQuery(hql);
		if(query.list()!=null && query.list().size()>0){
			Project project = (Project)query.list().get(0);
			return project;
		}
		return null;
	}

	public List<Department> getAllDept(String hql) {
		List depts = this.getHibernateTemplate().find(hql);
		return depts;
	}
	
	// 查询当前时间项目详细信息
	public List<ProjectEmp> getProcessByTime(String zd,int prjid,String time){
		
		String hql="from ProjectEmp where "+zd+"='"+time+"' and prjid="+prjid+"";
		List<ProjectEmp> uptimelist= this.getHibernateTemplate().find(hql);
		System.out.println(uptimelist.size());
		return uptimelist;
	}
	
	// 查询月份的项目详细信息
	public List<ProjectEmp> getProcessByYue(String zd,int prjid,String yue){
		String hql="from ProjectEmp where month("+zd+")="+yue+" and prjid="+prjid+"";
		List<ProjectEmp> uptimelist= this.getHibernateTemplate().find(hql);
		System.out.println(uptimelist.size());
		return uptimelist;
    }
	
	// 查询今年的项目详细信息
	public List<ProjectEmp> getProcessByYear(String zd,int prjid){
		Date date=new Date();
		// 得到当前时间
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy");
		String now = dateFormat2.format(date);			
		String hql="from ProjectEmp where year("+zd+")='"+now+"' and prjid="+prjid+"";
		List<ProjectEmp> uptimelist= this.getHibernateTemplate().find(hql);
		System.out.println(uptimelist.size());
		return uptimelist;
	}
	
	// 添加人员领导信息表数据
	public void addEmpLead(ProjectEmpLead emplead){
//		Session session= this.getHibernateTemplate().getSessionFactory().getCurrentSession();
//		 Transaction tx = session.beginTransaction();
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String now = dateFormat2.format(emplead.getPjtime());	
		String hql = "insert into projectemplead(prjempid,leadname,leadevaluate,pjtime) value("+emplead.getPrjemp().getId()+",'"+emplead.getLeadname()+"','"+emplead.getLeadevaluate()+"','"+now+"')";
		System.out.print(hql);
		Query query = super.getSessionFactory().getCurrentSession().createSQLQuery(hql);
		int i= query.executeUpdate();
		System.out.println(i);
//		tx.commit();
//	    session.close();
		
	}
	
	// 领导跟进项目
	public void leadGj(ProjectLead prjlead){
//		Session session= this.getHibernateTemplate().getSessionFactory().getCurrentSession();
//		 Transaction tx = session.beginTransaction();
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String now = dateFormat2.format(prjlead.getPjtime());	
		String hql = "insert into projectlead(prjid,leadname,leadevaluate,pjtime) value("+prjlead.getPrj().getId()+",'"+prjlead.getLeadname()+"','"+prjlead.getLeadevaluate()+"','"+now+"')";
		System.out.print(hql);
		Query query = super.getSessionFactory().getCurrentSession().createSQLQuery(hql);
		int i= query.executeUpdate();
		System.out.println(i);
//		tx.commit();
	}
	
	// 根据员工任务编号得到其对应的领导评价
	public List<ProjectEmpLead> leadPJByEmpid(int prjempid){
		String hql="from ProjectEmpLead where prjemp.id="+prjempid;
		List<ProjectEmpLead> p=this.getHibernateTemplate().find(hql);
		System.out.println(p.size());
		return p;
	}
	
	// 根据项目编号得到其对应的领导评价
	public List<ProjectLead> leadPJByPrjid(int prjid){
		String hql="from ProjectLead where prj.id="+prjid;
		List<ProjectLead> p=this.getHibernateTemplate().find(hql);
		System.out.println(p.size());
		return p;
	}
	
	// 根据员工编号与项目编号得到员工的具体任务，一周内的时间
	@SuppressWarnings("deprecation")
	public List<ProjectEmp> proempByPidAndEid(int empid,int prjid){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String now = sdf.format(date);
		date.setDate(date.getDate()+7);
		String d = sdf.format(date);
		String hql="from ProjectEmp where employee.id="+empid+" and prj.id="+prjid+" and prjuptime>='"+now+"' and prjuptime<='"+d+"'";
		List<ProjectEmp> plist= this.getHibernateTemplate().find(hql);
		return plist;
	}
	
	// 根据员工编号与项目编号得到员工的具体任务，当天的时间
	@SuppressWarnings("deprecation")
	public List<ProjectEmp> proempByTime(int empid,int prjid,String time){
		String hql="from ProjectEmp where employee.id="+empid+" and prj.id="+prjid+" and prjuptime='"+time+"'";
		List<ProjectEmp> plist= this.getHibernateTemplate().find(hql);
		return plist;
	}
	
	// 我的地盘查询月份的详细信息
	public List<ProjectEmp> myProcessByYue(int empid,int prjid,String yue){
		String hql="from ProjectEmp where month(prjuptime)="+yue+" and prjid="+prjid+" and employee.id="+empid;
		List<ProjectEmp> uptimelist= this.getHibernateTemplate().find(hql);
		System.out.println(uptimelist.size());
		return uptimelist;
    }
	// 查询今年的项目详细信息
	public List<ProjectEmp> getmyProcessByYear(int empid,int prjid){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		String now = sdf.format(date);
		String hql="from ProjectEmp where year(prjuptime)='"+now+"' and prjid="+prjid+" and employee.id="+empid;
		List<ProjectEmp> uptimelist= this.getHibernateTemplate().find(hql);
		System.out.println(uptimelist.size());
		return uptimelist;
	}
	// 根据部门编号得到部门信息
	public Department getdeptById(int deptid){
		String hql="from Department where id="+deptid;
		List<Department> d= this.getHibernateTemplate().find(hql);
		Department dept=d.get(0);
		return  dept;
	}

}

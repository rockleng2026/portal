package com.fuao.fajxc.dao.impl.newproject;

/*******
 * 项目列表。
 */

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.newproject.Project;
import com.fuao.fajxc.vo.CommonScfjb;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.NewApprove;
import com.fuao.fajxc.vo.NewDocument;
import com.fuao.fajxc.vo.NewParticipator;
import com.fuao.fajxc.vo.NewPrjdept;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewWatch;

public class ProjectImpl extends BaseDaoImpl implements Project {
	
	// 我的项目。
	public List myproject(int empid){
		System.out.println("aa");
		System.out.println(empid);
		return null;
	}
	
	/**
	 * 项目列表
	 */
	public List getAllProjects(String hql){
		try {
			System.out.println(hql);
			List list = this.getHibernateTemplate().find(hql);
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 所有部门信息
	 */
	public List<Department> getAllDepts(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	/**
	 * 所有员工
	 */
	public List<Employee> getAllEmps(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	/**
	 * 立项
	 */
	public void addProject(Object obj){
		this.getHibernateTemplate().save(obj);
	}
	
	// 下面这个方法没用到
	public void add(NewProject project){
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    	String begintime = sdf.format(project.getBegintime());
	    	String endtime = sdf.format(project.getEndtime());
	    	String sql = "insert into new_project(projectname,schedule,projecttype,launcher,begintime,endtime,projectinfo,approver,projectstatus,isdel) " +
			" values('"+project.getProjectname()+"',0,"+project.getMissiontype().getId()+",'"+project.getLauncher()+"','"+begintime+"','"+endtime+"','"+project.getProjectinfo()+"',"+project.getEmployee().getId()+","+project.getProjectstatus()+","+project.getIsdel()+")";
	       System.out.println(sql);
	       Query query = this.getSession().createSQLQuery(sql);
	       query.executeUpdate();
	}
	/**
	 * 新增参与部门
	 */
	public void addPrjdept(NewPrjdept obj){
		String hql="insert into new_prjdept(pid,deptid) values("+obj.getProject().getId()+","+obj.getDept().getId()+")";
		Session session=this.getSession();
		Query q= session.createSQLQuery(hql);
		q.executeUpdate();
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
	/**
	 * 加载项目类别
	 */
	public List getPrjType(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	/**
	 * 新增参与人
	 */
	public void addCyr(NewParticipator p){
		System.out.println(p.getProject().getId());
		System.out.println(p.getEmployee().getId());
		System.out.println(p.getIsagree());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String now = sdf.format(date);
		String content = "项目管理";
		try {
			String hql = "insert into new_participator(pid,inviteemp,invitetime,content,isagree) values("+p.getProject().getId()+","+p.getEmployee().getId()+",'"+now+"','"+content+"',"+p.getIsagree()+")";
			System.out.println(hql);
			Session session = this.getSession();
			Query query = session.createSQLQuery(hql);
			query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	/**
	 * 添加附件
	 */
	public void addFj(Object obj){
		this.getHibernateTemplate().save(obj);
	}
	/**
	 * 加载审批人
	 */
	public List getPrjApprover(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	/**
	 * 删除
	 */
	public void delete(Object obj){
	   this.getHibernateTemplate().delete(obj);
	}
	/**
	 * 删除项目(假删除)
	 */
	public void delproject(Integer id){
		String sql = "update new_project set isdel=1 where id="+id;
		System.out.println(sql);
		Session session = this.getSession();
		Query query = session.createSQLQuery(sql);
		query.executeUpdate();
	}
	/**
	 * 修改
	 */
	public void updateObj(Object obj){
		this.getHibernateTemplate().update(obj);
	}
	/**
	 * 根据ID查询对象
	 */
	public Object getObjectById(Class clazz,Integer id){
		return this.getHibernateTemplate().get(clazz, id);
	}
	/**
	 * 根据项目ID查询参与部门
	 */
	public List getPrjdept(int pid){
		String hql="from NewPrjdept where project.id="+pid; 
		return this.getHibernateTemplate().find(hql);
	}

	/**
	 * 根据项目ID查询查看者
	 */
	public List getPrjwatch(int pid){
		String hql="from NewWatch where project.id="+pid; 
		return this.getHibernateTemplate().find(hql);
	}
	/**
	 * 根据项目ID查询参与人
	 */
	public List getCyr(int pid){
		String hql = "from NewParticipator as np where np.isagree=2 and np.newProject.id="+pid;
		return this.getSession().createQuery(hql).list();
	}
	/**
	 * 修改参与部门
	 */
	public void updateProject(NewPrjdept obj) {
		String hql="update new_prjdept set deptid="+obj.getDept().getId()+" where pid="+obj.getProject().getId();
		Session session = this.getSession();
		Query query = session.createSQLQuery(hql);
		query.executeUpdate();
	}
	
	/**
	 * 删除参与部门
	 */
	public void deletePrjdept(Integer pid){
		String sql="delete from new_prjdept where pid="+pid;
		Session session = this.getSession();
		Query query = session.createSQLQuery(sql);
		query.executeUpdate();
	}
	/**
	 * 删除查看者
	 */
	public void deletePrjwatch(Integer pid){
		String sql="delete from new_watch where pid="+pid;
		Session session = this.getSession();
		Query query = session.createSQLQuery(sql);
		query.executeUpdate();
	}
	/**
	 * 删除参与人
	 */
	public void deleteCyr(int pid){
		String sql = "delete from new_participator where pid="+pid;
		Session session = this.getSession();
		Query query = session.createSQLQuery(sql);
		query.executeUpdate();
	}
	
	/**
	 * 根据员工编号查询员工对象
	 */
	public Employee getEmployeeByEmpNo(String empNo){
		String strHql = "from Employee e where 1 = 1 and e.empNo = '" + empNo + "' ";
		try {
			Query query = this.getSession().createQuery(strHql);
			if(null!=query.list()&&query.list().size()>0){
				Employee emp = (Employee)query.list().get(0);
				return emp;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 根据项目ID查询审批表对象
	 */
	public List getApproveByPid(int pid) {
		try {
			String hql = "from NewApprove where newproject.id="+pid;
			System.out.println(hql);
			return this.getHibernateTemplate().find(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 根据员工ID查询属于他的消息
	 */
	public List getMessagereceiver(String empid){
		String hql = "from Messagereceiver where receiverer='"+empid+"' and tmp2='project' and readfalg='0'";
		System.out.println(hql);
		return this.getHibernateTemplate().find(hql);
	}
	
	/**
	 * 点击查看,显示属于这个员工消息详情,供员工办理
	 * @param sql
	 * @return
	 */
	public List empOfMessage(String empid){
		try {
			String hql="from Messagereceiver r where r.delfalg=0 " +
					" and r.readfalg=0 and r.tmp2='project' and r.receiverer='"+empid+"'";
			List list= this.getHibernateTemplate().find(hql);
			System.out.println(list.size());
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 根据员工ID和项目ID得到参与人记录
	 * @param empid
	 * @param pid
	 * @return
	 */
	public List getNewParticipatorByEmpidAndPid(int empid,int pid){
		String hql = "from NewParticipator where employee.id="+empid+" and project.id="+pid;
		System.out.println(hql);
		List list = this.getHibernateTemplate().find(hql);
		return list;
	}
	
	public List getMessreceiverByPid(String receiver,int pid){
		String hql = "from Messagereceiver where tmp2='project' and receiverer='"+receiver+"' and project.id="+pid;
		System.out.println(hql);
		return this.getHibernateTemplate().find(hql);
	}

	public void addCyr(Object obj) {
		// TODO Auto-generated method stub
		
	}
	
	/********
	 * 根据审批人与项目编号
	 */
	public NewApprove appByPid(int pid,int empid){
		String hql="from NewApprove where newproject.id="+pid+" and approveemp.id="+empid;
		List list= this.getHibernateTemplate().find(hql);
		if(list.size()>0){
			NewApprove app= (NewApprove)list.get(0);
			return app;
		}else{
			return null;
		} 
	}

	/**
	 * 项目变更,只能邀请新的参与人,原来的参与人不显示在层里
	 * @param pid
	 * @return
	 */
	public List getParticipatorByPid(int pid){
		String hql = "from NewParticipator as np where np.newProject.id="+pid;
		return this.getHibernateTemplate().find(hql);
	}
	
	/**
	 * 根据项目ID查询查看人
	 * @param pid
	 * @return
	 */
	public List getWatcherByPid(int pid){
	try {
		String hql = "from NewWatch where project.id="+pid;
		return this.getHibernateTemplate().find(hql);
	} catch (Exception e) {
		e.printStackTrace();
	}
	  return null;	
	}
	
	public List getWatch(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	
	public List getPar(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	
	/**
	 * 修改项目时,上传附件,先删除
	 */
	public void deleteDocument(int pid){
		String sql = "delete from new_document where pid="+pid;
		Session session = this.getSession();
		Query query = session.createSQLQuery(sql);
		query.executeUpdate();
	}
	
	/**
	 * 权限设置1,判断登陆人是否是参与人
	 * @param pid
	 * @param empid
	 * @return
	 */
	public List getNpByPidAndEmpid(int pid,int empid){
		String hql = "from NewParticipator where project.id="+pid+" and employee.id="+empid;
		return this.getHibernateTemplate().find(hql);
	}
	
	/**
	 * 权限设置2,判断登陆人是否是项目查看者
	 * @param pid
	 * @param empid
	 * @return
	 */
	public List getWaByPidAndEmpid(int pid,int empid){
		String hql = "from NewWatch where project.id="+pid+" and emp.id="+empid;
		return this.getHibernateTemplate().find(hql);
	}
	
	/**
	 * 立项
	 */
	public int lx(NewProject project){
		logger.error("lx");
		java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String begintime=dateFormat2.format(project.getBegintime());
		String endtime=dateFormat2.format(project.getEndtime());
		String sql="insert into new_project(projectname, schedule,projecttype,launcher, begintime, endtime, projectinfo, projectstatus, money, isdel, approver) " +
		" values('"+project.getProjectname()+"',"+project.getSchedule()+","+project.getMissiontype().getId()+",'"+project.getLauncher()+"','"+begintime+"','"+endtime+"','"+project.getProjectinfo()+"',"+project.getProjectstatus()+","+project.getMoney()+","+project.getIsdel()+","+project.getEmployee().getId()+")";
		logger.error("lx"+sql);
		System.out.println(sql);
		Session session = this.getSessionFactory().getCurrentSession();
		logger.error("lx2222");
		Query query=session.createSQLQuery(sql);
		logger.error("lx333");
		int i= query.executeUpdate();
		logger.error("lx4");
		String hql="from NewProject order by id desc";
		logger.error("lx5");
		List list= this.getHibernateTemplate().find(hql);
		logger.error("lx6");
		int id=0;
		if(list!=null && list.size()>0){
			logger.error("lx7");
			NewProject prj=(NewProject) list.get(0);
			id=prj.getId();
			logger.error("lx8");
		}
		
		return id;
	}
	
	/*********
	 * 添加附件
	 */
	public void addFj(NewDocument document){
		//String sql="insert into new_document(filepath,pid,filename) values('"+document.getFilepath()+"',"+document.getNewProject().getId()+"',"+document.getFilename()+"')";
		String sql="insert into new_document(filepath,pid,filename) values('"+document.getFilepath()+"',"+document.getNewProject().getId()+",'"+document.getFilename()+"')";
		System.out.println(sql);
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(sql);
		int i= query.executeUpdate();
		System.out.println(i);
	}
	
	// 项目下面的所有任务列表
	public  List prjtask(int pid){		
		String hql="from NewFunction where flag=0 and parentid=-1 and newProject.id="+pid; 
		List list=this.getHibernateTemplate().find(hql);
		return list;
	}
	/****
	 * 根据项目ID查询这个项目下的功能并返回的是当前登录人执行的任务列表
	 */
	public List taskByFid(int fid){
		String hql="from NewTask where flag=0 and function.id="+fid+" ORDER BY begintime DESC";
		List tasklist= this.getHibernateTemplate().find(hql);
		return  tasklist;
	}

	
	public List getEmpByDept(int did){
		String hql = "from Employee where department.id="+did;
		return this.getHibernateTemplate().find(hql);
	}


	/**
	 * 添加附件2--
	 * @param fbsbh
	 * @param beanName
	 * @param request
	 * @return
	 */
	public void addFJ2(String fjlj,String beanName,String fjmc,String fjhz, String prid) {
			String hql="insert into common_scfjb(fjlj,tmp,fjmc,fjhz,tmp1) values('"+fjlj+"','"+beanName+"','"+fjmc+"','"+fjhz+"','"+prid+"')";
			Session session=this.getSession();
			Query q= session.createSQLQuery(hql);
			q.executeUpdate();
	}

	public List getDepartmentByEmp(int eid) {
		String hql = "from Department where employee.id="+eid;
		return this.getHibernateTemplate().find(hql);
	}

}

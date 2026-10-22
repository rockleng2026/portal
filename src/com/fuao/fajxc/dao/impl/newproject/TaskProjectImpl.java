package com.fuao.fajxc.dao.impl.newproject;

/*******
 * 任务分配实现方法。
 */

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.mapping.Array;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.newproject.TaskProject;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewFunctionDelRecord;
import com.fuao.fajxc.vo.NewFunctionRecord;
import com.fuao.fajxc.vo.NewPrjtresource;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewTask;
import com.fuao.fajxc.vo.Scheduleplan;
import com.fuao.fajxc.vo.Taskplan_saleorder;

public class TaskProjectImpl extends BaseDaoImpl implements TaskProject {
	
	// 项目下面的所有任务列表
	public  List prjtask(int pid){
		
		String hql="from NewFunction where flag=0 and newProject.id="+pid; 
		List list=this.getHibernateTemplate().find(hql);
		return list;
	}
	/****
	 * 根据项目ID查询这个项目下的功能并返回的是当前登录人执行的任务列表
	 */
	public List projectlist(int empid){
		String hql="select f.id from NewFunction f where flag=0 and f.finishtasktype=1";
		List list=this.getHibernateTemplate().find(hql);
		System.out.println(list.size());
		String fid="";
		for(int i=0;i<list.size();i++){
			fid+=","+list.get(i);
		}
		fid=fid.replaceFirst(",", "");
		if(fid.trim().length()<=0){
			fid="''";
		}
		String hql2="from NewTask where flag=0 and emp.id="+empid+" and function.id in("+fid+") ORDER BY begintime DESC";
		List tasklist= this.getHibernateTemplate().find(hql2);
		return  tasklist;
	}
	// 得到所有项目当状态为进行中和延迟时）
	public List getProject(int empid){
		// 根据当前登陆人的id去找出参与我这个项目人的对象
		String sql="select p.newProject.id from NewParticipator as p where p.isagree=2 and p.employee.id="+empid; 
		List list= this.getHibernateTemplate().find(sql);
		String id="";
		for(int i=0;i<list.size();i++){
			int pid=Integer.parseInt(list.get(i).toString());
			id+=","+pid;
		}
		id=id.replaceFirst(",", "");
		if(id.trim().length()<=0){
			id="''";
		}
		String hql="from NewProject where projectstatus in(2,3,4) and isdel=0 and  id in("+id+")";  
		List projectlist=this.getHibernateTemplate().find(hql);
		
		return projectlist;
	}
	/**
	 * 根据主键加载数据
	 * @param clazz
	 * @param id
	 * @return
	 */
	public Object getObj(Class clazz,Integer id){
		return super.getHibernateTemplate().get(clazz, id);
	}
	
	/********
	 * 根据任务的执行时间与执行人与任务Id去查询这个人用没有日志
	 */
	public List logByTask(NewTask newtask){
		
		String hql="from Scheduleplan where employee.id="+newtask.getEmp().getId()+" and function.id="+newtask.getFunction().getId()+" ORDER BY isplan desc";
		return  this.getHibernateTemplate().find(hql);
	}
	
	/****
	 * 通过功能ID得到这个功能下当前登录人的任务日志
	 */
	public NewTask functionByLog(Scheduleplan schel){
		String hql="from NewTask where function.id="+schel.getFunction().getId()+" and emp.id="+schel.getEmployee().getId();
		List list=this.getHibernateTemplate().find(hql);
		NewTask task=new NewTask();
		if(list.size()>0){
			task=(NewTask)list.get(0);
		}
		
		return task;
	}
	
	/********
	 * 添加保存附件
	 */
	public void add(NewTask task){
		this.getHibernateTemplate().saveOrUpdate(task);
	}
	
	/********
	 * 保存日志
	 */
	public void addLog(Scheduleplan schel){
		this.getHibernateTemplate().save(schel);
	}
	
	/******
	 * 根据任务ID 得到功能对象 ID
	 */
	public int getFun(int taskid){
		String hql="select t.function.id from NewTask t where t.id="+taskid;
		List list= this.getHibernateTemplate().find(hql);
		int i=0;
		if(list.size()>0){
			i=Integer.parseInt(list.get(0).toString());
		}
		return i;
	}
	
	/******
	 * 根据当前登录人去得到项目负责人
	 */
	public List projectlist(Employee emp){
		String hql="from NewProject where  projectstatus in(2,3) and isdel=0 ";
		List prjlist = this.getHibernateTemplate().find(hql);
		String str="";
		for(int i=0;i<prjlist.size();i++){
			NewProject project=(NewProject)prjlist.get(i);
			if(project.getEmployee().getId().equals(emp.getId())){
				str+=","+project.getId();
			}
			if(project.getLauncher().equals(emp.getName())){
				str+=","+project.getId();
			}
		}
		hql+=" and id in(''"+str+")";
		hql+=" ORDER BY begintime DESC";
		prjlist=this.getHibernateTemplate().find(hql);
		return prjlist;
	}
	/****
	 * 根据任务功能编号得到这个任务下面的所有参与人员
	 */
	public List taskemp(int fid){
		String hql="select nt.emp.id from NewTask nt where nt.function.id="+fid;
		List tasklist= this.getHibernateTemplate().find(hql);
		List emplist=new ArrayList();
		for(int i=0;i<tasklist.size();i++){
			int empid=Integer.parseInt(tasklist.get(i).toString());
			Employee emp= (Employee)super.getHibernateTemplate().get(Employee.class, empid);
			emplist.add(emp);
		}
		return emplist;
	}
	
	/******
	 *  得到所有员工列表
	 */
	public List allEmp(){
		String hql="from Employee where isLeave=1 and delflag=0";
		return this.getHibernateTemplate().find(hql);
	}
	/*****
	 * 根据执行与功能编号得到任务对象
	 */
	public NewTask getNewTask(int empid,int fid){
		String hql="from NewTask where function.id="+fid+" and emp.id="+empid;
		List list = this.getHibernateTemplate().find(hql);
		NewTask newtask=new NewTask();
		if(list!=null && list.size()>0){
			newtask=(NewTask)list.get(0);
		}
		
		return newtask;
	}
	
	/****
	 * 保存newtask对象
	 */
	public void addNewTas(NewTask task){
		this.getHibernateTemplate().save(task);
	}
	
	/******
	 * 删除对象
	 */
	public void delTas(int empid,int fid){
		String hql="delete from NewTask where function.id="+fid+" and emp.id="+empid;
		Session session=this.getSession();
		Query query= session.createQuery(hql);
		int i= query.executeUpdate();
	}
	
	/****
	 *  保存任务记录
	 */
	public void addRecord(NewFunctionRecord record){
		this.getHibernateTemplate().save(record);
	}

	/******
	 * 删除任务后还要删除项目功能表里的数据
	 */
	public void del(int fid){
		
		// 删除存在的父类型
		String fhql="from NewFunction where flag=0 and parentid="+fid;
		List funlist=this.getHibernateTemplate().find(fhql);
		// 得到所有的任务模块的编号
		String str="";
		if(funlist.size()>0){
			for(int i=0;i<funlist.size();i++){
				NewFunction fun=(NewFunction)funlist.get(i);
			    str+=","+fun.getId();
			}
			str+=","+fid;
		}else{
			str=","+fid;
		}
		
		String sqllsit = "from NewTask as nt where flag=0 and nt.function.id in (''"+str+")";
	    List listtask = this.getHibernateTemplate().find(sqllsit); 
	    
	    String tmp = "";
	    for(int i = 0;i<listtask.size();i++)
	    {
	    	NewTask task = (NewTask) listtask.get(i);
	    	if(task != null)
	    	{
	    		tmp += task.getId()+",";
	    	}
	    }
	    String strfid = "";
	    if(tmp != null && !tmp.equals(""))
	    {
	    	strfid = tmp.substring(0, tmp.length()-1);
	    }else
	    {
	    	strfid = "''";
	    }
	    logger.equals("strfid:"+strfid);
		
		String hql="update NewTask set flag=1 where id in("+strfid+")";
		Session session=this.getSession();
		Query query= session.createQuery(hql);
		query.executeUpdate();
		
		String sql="update NewFunction set flag=1 where id in(''"+str+")";
	    Query query2=session.createQuery(sql);
	    query2.executeUpdate();
	    
	    String sql1 = "update scheduleplan set taskid=null where taskid in(''"+str+")";
	    Query query1 = this.getSession().createSQLQuery(sql1);
	    query1.executeUpdate();
	    
	    //删除与之相关的项目消费记录
	    String prjthql = "delete from new_prjtresource where fid in ("+strfid+")";
	    Query query3 = this.getSession().createSQLQuery(prjthql);
	    query3.executeUpdate();
	    java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    Date date=new Date();
	    String nowstr=dateFormat2.format(date);
	    // 添加删除任务记录
	    if(funlist.size()>0){
			for(int i=0;i<funlist.size();i++){
				NewFunction fun=(NewFunction)funlist.get(i);
				String insersql="insert into new_function_delRecord(fid,flag,deldate) value("+fun.getId()+",0,'"+nowstr+"')";
				query1 = this.getSession().createSQLQuery(insersql);
			    query1.executeUpdate();
			}
			NewFunction fun=(NewFunction)this.getObj(NewFunction.class, fid);
			String insersql="insert into new_function_delRecord(fid,flag,deldate) value("+fun.getId()+",0,'"+nowstr+"')";
			query1 = this.getSession().createSQLQuery(insersql);
		    query1.executeUpdate();
		}else{
			NewFunction fun=(NewFunction)this.getObj(NewFunction.class, fid);
			String insersql="insert into new_function_delRecord(fid,flag,deldate) value("+fun.getId()+",0,'"+nowstr+"')";
			query1 = this.getSession().createSQLQuery(insersql);
		    query1.executeUpdate();
		}
	}
	
	/*******
	 * 根据项目编号得到参与人
	 */
	public List cyrByPid(int pid){
		String hql="from NewParticipator where newProject.id="+pid+" and isagree=2";
		return this.getHibernateTemplate().find(hql);
	}
	
	/******
	 * 根据功能编号得到这个功能下任务总进度，办理后的
	 */
	public double jdByFid(NewFunction function){
		String hql="from NewTask where function.id="+function.getId();
		List functionlist= this.getHibernateTemplate().find(hql);
		if(functionlist==null && functionlist.size()<=0){	
			return 0;
		}else{
			// 得到总人数，得到现有的任务进度再用100-去现有的
			double zongjd=functionlist.size()*100;
			double allcyrjd=0;
			// 得到这个任务下所有参与人员的进度
			for(int i=0;i<functionlist.size();i++){
				NewTask task=(NewTask)functionlist.get(i);
				allcyrjd+=task.getSchedule();
			}
			// 算出这个任务的现在的总进度
			Double jd=(allcyrjd/zongjd)*100;
			// 保留两位小数
			String str=jd.toString();
			str=str.trim();
			jd=Double.valueOf(str);
			DecimalFormat df = new DecimalFormat("0.00");
			String funjd= df.format(jd);
			// 修改任务进度
			String updhql="update new_function set fstate="+funjd+" where id="+function.getId();
			Session session=this.getSession();
			Query query=session.createSQLQuery(updhql);
			query.executeUpdate();

			// 再判断这个任务有没有父级并修改父级任务
			if(function.getParentid()!=-1){
				 Double parentjd=0d;
				 hql="from NewFunction where flag=0 and parentid="+function.getParentid();	
				 functionlist=this.getHibernateTemplate().find(hql);
				 int size=0;
				 for(int i=0;i<functionlist.size();i++){
					 NewFunction parentfun=(NewFunction)functionlist.get(i);
					 // 算出单个任务进度 
					 String dghql="from NewTask where flag=0 and function.id="+parentfun.getId();
					 List dglist=this.getHibernateTemplate().find(dghql);
					 for(int j=0;j<dglist.size();j++){
						 NewTask dgtask=(NewTask)dglist.get(j);
						 parentjd+=dgtask.getSchedule();
						 size+=dglist.size();
					 }
				 }
				 parentjd=(parentjd/(size*100))*100;
				// 保留两位小数
				str=parentjd.toString();
				parentjd=Double.valueOf(str);
				funjd= df.format(parentjd);
				// 修改父类任务进度
				updhql="update new_function set fstate="+funjd+" where id="+function.getParentid();
				query=session.createSQLQuery(updhql);
				query.executeUpdate();
				return parentjd;
			}else{
				return jd;
			}
		}
	}
	/******
	 * 移交记录根据任务ID修改消费记录
	 */
	public void updateSource(NewPrjtresource resource){
            this.getHibernateTemplate().merge(resource);
	}
	
	/*****
	 * 项目进度的添加
	 */
	public void jdByPid(NewFunction fun){

		// 算出这个任务的进度并影响其项目进度
		String prjhql="from NewFunction where id="+fun.getId(); 
		List projectlist=this.getHibernateTemplate().find(prjhql);
		NewFunction project=new NewFunction();
		if(projectlist!=null && projectlist.size()>0){
			project=(NewFunction)projectlist.get(0);
		}
		// 得到这个项目下的所有功能任务
		List newfunctionlist= this.prjtask(project.getNewProject().getId());
		double zongprjjd=newfunctionlist.size()*100;// 项目总进度
		double allfunctionjd=0; // 所有功能进度
		if(newfunctionlist!=null && newfunctionlist.size()>0){
			for(int i=0;i<newfunctionlist.size();i++){
				NewFunction function=(NewFunction)newfunctionlist.get(i);
				System.out.println(function.getFstate());
				allfunctionjd+=function.getFstate();
			}
		}
		// 算出这个项目的现在的总进度
		Double prjjd=(allfunctionjd/zongprjjd)*100;
		// 保留两位小数
		String prjstr=prjjd.toString();
		prjstr=prjstr.trim();
		prjjd=Double.valueOf(prjstr);
		DecimalFormat df = new DecimalFormat("0.00");
		String prjstrjd= df.format(prjjd);
		
		// 修改项目进度
		String updprjhql="";
		if(prjjd<100){
			updprjhql="update new_project set schedule="+prjstrjd+" where id="+project.getNewProject().getId();
		}
		if(prjjd>=100){
			updprjhql="update new_project set schedule="+prjstrjd+",projectstatus=4 where id="+project.getNewProject().getId();
		}
		Session session=this.getSession();
		Query query=session.createSQLQuery(updprjhql);
		query.executeUpdate();
	}
	
	public List getDomark(){
		String hql = "from Docmark where temp1!='' and temp2!=''";
		return this.getHibernateTemplate().find(hql);
	}
	
	/**
	 * 向项目任务和订单的中间表写数据
	 */
	public void addPlan_Order(String sql){
		try {
			Session session = this.getSessionFactory().getCurrentSession();
			Query query = session.createSQLQuery(sql);
			query.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	/**
	 * 取到所有订单类型
	 * 袁天龙 2012-12-3
	 */
	public List getDocmark(){
		String hql = "from Docmark";
		return this.getHibernateTemplate().find(hql);
	}
	
	/*******
	 * 给任务审批与项目消费记录表添加数据。
	 * 胡宝林 2012-12-4
	 */
	public void addPrjresource(NewPrjtresource resource){
		this.getHibernateTemplate().save(resource);
	}
	
	/*******
	 * 修改记录
	 * 胡宝林 2012-12-5
	 */
	public void updateResource(NewPrjtresource resource){
		this.getHibernateTemplate().merge(resource);
	}
	
	/******
	 * 根据项目负责人的名字得到员工对象
	 */
	public Employee getLauncher(String launcher){
		String hql="from Employee where name='"+launcher+"'";
		List list= this.getHibernateTemplate().find(hql);
		Employee emp=new Employee();
		for(int i=0;i<list.size();i++){
			emp=(Employee)list.get(0);
		}
		return emp;
	}
	
	/*********
	 * 修改task_saleorder表的状态
	 */
	public void updateTaskSaleorder(Taskplan_saleorder tso){
		this.getHibernateTemplate().merge(tso);
	}
	

	public List getDepartment(String hql){
		List list = this.getHibernateTemplate().find(hql);
		return list;
	}
	
	//根据项目id去查询这个项目的参与部门
	public List getPrjdeptByPid(int pid){
		String hql = "from NewPrjdept where project.id="+pid;
		List list = this.getHibernateTemplate().find(hql);
		return list;
	}
	
	public List getDepartmentByEmp(int eid){
		String hql = "from Department where employee.id="+eid;
		return this.getHibernateTemplate().find(hql);
	}
	

	/***********
	 * 根据任务编号与执行人得到具体的任务 
	 */
	public List taskByFidAndExecute(int fid,int empid){
		// 首先找到这个类下面的子类，再根据执行人去子类里面找任务
		String fhql="from NewFunction where flag=0 and parentid="+fid;
		List funlist=this.getHibernateTemplate().find(fhql);
		String str="";
		if(funlist.size()>0){
			for(int i=0;i<funlist.size();i++){
				NewFunction function=(NewFunction)funlist.get(i);
				str+=","+function.getId();
			}
		}
		String hql="from NewTask WHERE function.id in (''"+str+") AND emp.id="+empid;
		return this.getHibernateTemplate().find(hql);
	}
	
	/********
	 * 修改功能模块时间
	 */
	public void updateFunEndtime(NewFunction function){
		this.getHibernateTemplate().merge(function);
	}
	
	/***********
	 * 修改父类任务
	 */
	public void updateParentTask(int fid,Employee oldemp,Employee newemp){
		// 根据任务编号得到父类型任务
		String hql="from NewFunction where flag=0 and parentid="+fid;
		List parentlist=this.getHibernateTemplate().find(hql);
		for(int i=0;i<parentlist.size();i++){
			// 找到所有的子任务
			NewFunction function=(NewFunction)parentlist.get(i);
			// 根据子级任务与旧执行人员找到任务编号，找到了则加以修改
			hql="from NewTask where function.id="+function.getId()+" and emp.id="+oldemp.getId();
			List tasklist=this.getHibernateTemplate().find(hql);
			if(tasklist!=null && tasklist.size()>0){
				for(int j=0;j<tasklist.size();j++){
					NewTask task=(NewTask)tasklist.get(j);
					task.setEmp(newemp);
					this.getHibernateTemplate().merge(task);
				}
			}
		}
	}
	

}

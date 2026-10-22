package com.fuao.fajxc.dao.impl.mission;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.mission.MissionDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Mission;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewParticipator;
import com.fuao.fajxc.vo.NewProject;
import com.fuao.fajxc.vo.NewTask;

public class MissionDaoImpl extends BaseDaoImpl implements MissionDao{


	//添加任务	
	public boolean addData(Object data) throws Exception {
		this.getHibernateTemplate().merge(data);
		return true;
	}
	//添加任务 返回对象
	public Object addReturn(Object data) throws Exception {
		Object object = this.getHibernateTemplate().merge(data);
		return object;
	}

	public List<Object> exHql(String hql) {
		List<Object> datas=null;
		try {
		datas = super.execHQL(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return datas;
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
			Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	public Mission getMissiondata(String id) {
		try {
			return (Mission) super.select(Mission.class,Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateData(Mission data)throws Exception  {
			super.update(data);
			return true;
	}

	public List getObjectList(String hql )
	{
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}

	/**
	 * 删除信息
	 * @return
	 */
	public boolean delmission(Object[] ids) {
		System.out.println("int[].length:");
		boolean flag=false;
		String hql="delete Mission where taskId in(:ids)";
		Query query=this.getSession().createQuery(hql);
		query.setParameterList("ids", ids);
		int i=query.executeUpdate();
		if(i>0)
			flag=true;
		return flag;
	}
	
	/**
	 * 读取信息
	 * @return
	 */
	public boolean duqumission(Object[] duqu) {
		//获得当前时间
		Date now = new Date();
		DateFormat d3 = DateFormat.getDateTimeInstance();
	    String str3 = d3.format(now);
	    
		
		System.out.println("int[].length:");
		boolean flag=false;
		String hql="update Missionreceiver set readfalg=1,receivetime='"+str3+"' where receiverid in(:duqu)";
		Query query=this.getSession().createQuery(hql);
		query.setParameterList("duqu", duqu);
		int i=query.executeUpdate();
		if(i>0)
			flag=true;
		return flag;
	}
	
	/**
	 * 删除信息Mission
	 * @return
	 */
	public boolean delsendmes(Object[] ids) {
		System.out.println("int[].length:");
		boolean flag=false;
		String hql="update Mission set delfalg=1 where missionid in(:ids)";
		Query query=this.getSession().createQuery(hql);
		query.setParameterList("ids", ids);
		int i=query.executeUpdate();
		if(i>0)
			flag=true;
		return flag;
	}
	
	/**
	 * 删除信息类型Mission
	 * @return
	 */
	public boolean delmesstype(Object[] ids) {
		System.out.println("int[].length:");
		boolean flag=false;
		String hql="update Missiontype set delflag=1 where messagetypeid in(:ids)";
		Query query=this.getSession().createQuery(hql);
		query.setParameterList("ids", ids);
		int i=query.executeUpdate();
		if(i>0)
			flag=true;
		return flag;
	}
	/**
	 * 执行更新语句
	 * @param hql
	 * @return 影响的条数
	 */
	public int exehqlupdate(String hql) {
		int i=0;
		try{
			Query query=this.getSession().createQuery(hql);
			i=query.executeUpdate();
		}catch(Exception ex){
			ex.printStackTrace();
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
	
	/**********
	 * 根据编号得到对象
	 */
	public Object getObj(Class cla,int id){
		return super.getHibernateTemplate().get(cla, id);
	}
	
	/********
	 * 添加项目任务
	 */
	public void addproject(NewFunction function){
		 this.getHibernateTemplate().saveOrUpdate(function);
	}
	
	/******
	 *  得到所有员工列表
	 */
	public List allEmp(){
		String hql="from Employee where isLeave=1 and delflag=0";
		return this.getHibernateTemplate().find(hql);
	}
	
	/**********
	 * 给任务分配参与人员
	 */
	public void addtask(NewTask task){
		this.getHibernateTemplate().save(task);
	}
	
	/****************
	 * 根据项目编号得到这个项目下面的所有参与人
	 */
	public List functionByPid(int pid){
		String hql="from NewParticipator where newProject.id="+pid+" and isagree=2";
		return this.getHibernateTemplate().find(hql);
	}
	
	/*********
	 * 修改我们的项目功能任务
	 */
	public void updateNewFunction(NewFunction function){
		this.getHibernateTemplate().update(function);
	}
	
	/*******
	 * 查询类型
	 */
	public List alltype(){
	   String hql="from Missiontype where superid in (1,-1)";
       return this.getHibernateTemplate().find(hql);
	}
	
	/****************
	 * 根据项目编号得到这个项目下面的所有任务
	 */
	public List funByPid(int pid){
		String hql="from NewFunction where newProject.id="+pid+" and fstate<100";
		return this.getHibernateTemplate().find(hql);
	}
	
}

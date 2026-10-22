package com.fuao.fajxc.dao.impl.newproject;

/*******
 * 问题的处理。
 */

/*
 * author:wangxiong
 * email:wangxiong@fuaotech.com
 */

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.newproject.QuestionProject;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewProblem;
import com.fuao.fajxc.vo.NewQuestion;

public  class QuestionProjectImpl extends BaseDaoImpl implements QuestionProject {

	private static Logger logger = Logger.getLogger(QuestionProjectImpl.class);

	// 查询问题所有的问题列表
	public List select() {
		String hql = "from NewQuestion";
		List list = this.getHibernateTemplate().find(
				"from NewQuestion as nq where 1=1 ");
		return list;
	}

	// //查询已经在进行中的项目
	public List findBynewPro() {
		List list = null;
		try {
			String hql =  "from NewProject as np where 1=1 and np.projectstatus not in(0,1)";
			return this.getHibernateTemplate().find(hql);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("讨论问题com.fuao.fajxc.dao.impl.newproject");
		}
		return list;
	}

	// 分页
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages pages = null;
		try {
			pages = super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("分页出错");
		}
		return pages;
	}

	// 查询所有的邀请人
	public List findByPart() {
		List listdata = null;
		try {
			listdata = this
					.getHibernateTemplate()
					.find(
							"from NewParticipator as npart where 1=1 and npart.isagree=2");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("查询邀请人");
		}
		return listdata;
	}

	// 查询每个问题的所有评论
	public List getObject(String tableName, Integer id) {
		String hql = "from " + tableName + " as npbl where 1=1 and npbl.id="
				+ id;
		List list = null;
		try {
			list = this.getHibernateTemplate().find(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List getObject2(String tableName, Integer id) {
		String hql = "from " + tableName + " as npbl where 1=1 and npbl.newProject.id="
				+ id;
		List list = null;
		try {
			list = this.getHibernateTemplate().find(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 添加一条评论
	public boolean saveProblem(NewProblem newProblem) {
		boolean flag = false;
		String sql="";
		if(newProblem.getNewQuestion() !=null)
		{
			sql = "insert into new_problem(contents,empid,time,problemortask,isend,pid,count) values('"+newProblem.getContents()+"',"+newProblem.getEmployee().getId()+",'"+newProblem.getTime()+"',"+newProblem.getProblemortask()+","+newProblem.getIsend()+","+newProblem.getNewQuestion().getId()+","+newProblem.getCount()+")";
		}
		if(newProblem.getScheduleplan() != null)
		{
			sql = "insert into new_problem(contents,empid,time,problemortask,isend,count,sid) values('"+newProblem.getContents()+"',"+newProblem.getEmployee().getId()+",'"+newProblem.getTime()+"',"+newProblem.getProblemortask()+","+newProblem.getIsend()+","+newProblem.getCount()+","+newProblem.getScheduleplan().getId()+")";
		}
		Query query = this.getSession().createSQLQuery(sql);
		if(new Integer(query.executeUpdate())>0)
		{
			flag = true;
		}
		return flag;
	}

	//查询任何表的List
	public List findObj(String hql) {
		Query query = this.getSession().createQuery(hql);
		List list = query.list();
		return list;
	}

	public String findObj1(){
		String sql  = "select id from (select * from new_project as p where p.projectstatus not in (0,1)) as a where a.begintime=(select max(begintime) from (select * from new_project as p where p.projectstatus not in (0,1)) as b)";
		//List list = null;
		Query query = this.getSession().createSQLQuery(sql);
		List list=query.list();
		String id="";
		if(list!=null && list.size()>0){
			id=query.list().get(0).toString();
		}
		System.out.println(id);
		return id;
	}

//	public List findById()
//	{
//		return null;
//	}
	// public static void main(String[] args) {
	// ApplicationContext ac=new
	// FileSystemXmlApplicationContext("/src/applicationContext*.xml");
	// QuestionProject q = (QuestionProject) ac.getBean("questiondao");
	// List list1 = q.select();
	// if(list1 != null)
	// {
	// System.out.println("映射完整");
	// }
	// }

	public List findById(Integer id) {
		String hql = "from NewFunction as nf where 1=1 and nf.newProject.id="+id;
		return this.getHibernateTemplate().find(hql);
	}

	public List findByCount(Integer id) {
		String hql = "from NewProblem as np where 1=1 and np.newQuestion.id="+id;
		return this.getHibernateTemplate().find(hql);
	}
	public List findByCount1(Integer id) {
		String hql = "from NewProblem as np where 1=1 and np.scheduleplan.id="+id;
		return this.getHibernateTemplate().find(hql);
	}

	//添加项目问题
	public boolean saveQuestion(NewQuestion newQuestion) {
		boolean falg = false;
		String sql = "insert into new_question(questionname,quizpeople,pid,lastdate,questioninfo,handlestatus,fj,indexdemos) values('"+newQuestion.getQuestionname()+"',"+newQuestion.getEmployee().getId()+","+newQuestion.getPid()+",'"+newQuestion.getLastdate()+"','"+newQuestion.getQuestioninfo()+"',"+newQuestion.getHandlestatus()+",'"+newQuestion.getFj()+"',"+newQuestion.getIndexdemos()+")";
		Query query = this.getSession().createSQLQuery(sql);
		if(new Integer(query.executeUpdate())>0)
		{
			falg = true;
		}
		return falg;
	}

//	/修改项目问题
	public boolean updateQuestion(NewQuestion newQuestion) {
		boolean falg = false;
		try {
			this.getHibernateTemplate().merge(newQuestion);
			falg = true;
		} catch (Exception e) {
			logger.error("修改项目问题");
		}
		return falg;
	}
	/*
	 * 删除问题
	 */
	public boolean del(NewQuestion newQuestion) {
		boolean flag = false;
		try {
			this.getHibernateTemplate().delete(newQuestion);
			flag = true;
		} catch (Exception e) {
			logger.error("删除问题");
		}
		return flag;
	}

	/*
	 *提交问题
	 */
	public boolean updatastate(Integer state,Integer questid) {
		boolean falg = false;
		try {
			String sql = "update new_question set handlestatus = "+new Integer(state)+" where id ="+questid;
			Query query = this.getSession().createSQLQuery(sql);
			if(new Integer(query.executeUpdate())>0)
			{
				falg = true;
			}
		} catch (Exception e) {
			logger.error("提交问题");
		}
		return falg;
	}

	public Integer findBycount(Integer questid) {
		
		return null;
	}

	public boolean updatequsetion(Integer count,Integer id) {
		boolean falg = false;
		String sql = "update new_question set pid ="+count+" where id="+id;
		Query query = this.getSession().createSQLQuery(sql);
		if(new Integer(query.executeUpdate())>0)
		{
			falg = true;
		}
		return falg;
	}

	public List findByAll() {
		String hql = "from NewQuestion as nq where 1=1 and nq.handlestatus not in(0)";
		return this.getHibernateTemplate().find(hql);
	}

	public List findBytask(String id) {
		String hql = "from NewTask as nt where 1=1 and nt.function.id in ("+id+")";
		return this.getHibernateTemplate().find(hql);
	}

	public NewFunction findfunction(String entityName,Integer id) {
		
		NewFunction function = (NewFunction) this.getHibernateTemplate().get(entityName, id);
		return function;
	}
	/************
	 * 根据任务编号得到对象
	 */
	public Object getObj(Class clazz,Integer id){
		return super.getHibernateTemplate().get(clazz, id);
	}
	
}

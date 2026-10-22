package com.fuao.fajxc.dao.impl.basic;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.action.LoginAction;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.dao.basic.EmployeeDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.CustomerMove;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.EmployeeGrade;
import com.fuao.fajxc.vo.Leavesimple;
import com.fuao.fajxc.vo.UserRelation;
import com.fuao.fajxc.vo.UserRelationtypesb;

public class EmployeeDaoImpl extends BaseDaoImpl implements EmployeeDao {
   private EmployeeDao employeeDao;
   
	public EmployeeDao getEmployeeDao() {
	return employeeDao;
}


public void setEmployeeDao(EmployeeDao employeeDao) {
	this.employeeDao = employeeDao;
}


	private static Logger logger = Logger.getLogger(LoginAction.class);
	/**
	 * 获得员工信息
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List selEmp(int first, int max,String addhql) {
		String hql="from Employee where delflag=0"+addhql+" order by id desc";
		Query query=this.getSession().createQuery(hql);
		query.setFirstResult(first);
		query.setMaxResults(max);
		return query.list();
	}
	
	
	/**
	 * 获得总的员工数
	 * @return
	 */
	public int selCount(String addhql) {
		System.out.println("count");
		String hql="from Employee where delflag=0"+addhql;
		return super.getHibernateTemplate().find
		(hql).size();
	}

	/**
	 * 添加员工
	 * @return
	 */
	public boolean addEmp(Employee emp) {
		boolean flag=true;
		try
		{
			this.getHibernateTemplate().save(emp);
		}
		catch(Exception ex)
		{
			logger.error("添加员工错误",ex);
			flag=false;
			ex.printStackTrace();
		}
		return flag;
	}
	
	/**
	 * 根据id查找员工
	 *@return 
	 */
	public Employee oneEmp(int id)
	{
	    Employee emp=null;
	    String hql="from Employee e where e.id=?";
	    Query query=this.getSession().createQuery(hql);
	    query.setParameter(0, id);
	    if(query.list()!=null){
	        emp=(Employee) query.list().get(0);
	    }
	    return emp;
	}
	/**
	 * 更新员工信息
	 * @return
	 */
	public boolean updateEmp(Employee emp) {
		boolean flag=false;
		try{
			this.getHibernateTemplate().update(emp);
			flag=true;
		}
		catch(Exception ex){
			logger.error("更新员工错误",ex);
		}
		return flag;
	}
	
	/**
	 * 删除员工
	 * @return
	 */
	public boolean delEmp(Object[] ids) {
		System.out.println("int[].length:");
		boolean flag=false;
		String hql="update Employee e set delflag=1 where e.id in(:ids)";
		Query query=this.getSession().createQuery(hql);
		query.setParameterList("ids", ids);
		int i=query.executeUpdate();
		if(i>0){
			flag=true;
		}
		return flag;
	}
	
	/**
	 * 删除用户
	 * @return 
	 */
	public boolean delUser(Object[] ids) {
		boolean flag=false;
		String hql = "update Users e set delflag=1 where e.mark='employee' and e.customerOrEmployeeId in(:ids)";
		Query query = this.getSession().createQuery(hql);
		query.setParameterList("ids", ids);
		int i = query.executeUpdate();
		if(i>0){
			flag=true;
		}
		return flag;
	}
	
	/**
	 * 查找所有部门
	 * @return
	 */
	public List selDep(String addhql) {
		String hql="from Department where delflag=0"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	public List selEmps(String hql) {
		System.out.println("empDao");
		Query query=this.getSession().createQuery(hql);
		System.out.println("dao    "+query.list().size());
		return query.list();
	}


	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages pages=null;
		try
		{
			pages=super.paginationQuery(hql, pageNo, pageSize, values);
			System.out.println(pages);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			logger.error("下架单分页时出错Dao",ex);
		}
		return pages;
	}
	
	// 获得附表类别，根据类别名称
	public UserRelationtypesb getAllByName(String strName){
		UserRelationtypesb usertype = null;
		String strHql = "from UserRelationtypesb u where u.name =" + strName + "";
		Query query = this.getSession().createQuery(strHql);
		if(null!=query.list()){
			usertype = (UserRelationtypesb)query.list().get(0);
		}
		return usertype;
	}
	// 获得附表类别，根据类别ID
	public UserRelationtypesb getAllById(int iId){
		UserRelationtypesb usertype = null;
		String strHql = "from UserRelationtypesb u where u.id =" + iId + "";
		Query query = this.getSession().createQuery(strHql);
		if(null!=query.list()){
			usertype = (UserRelationtypesb)query.list().get(0);
		}
		return usertype;
	}
	public List getAllRelationByUuidAndTypeId(String strUuid, int iTypeId){
		// 根据员工ID获得员工uuid
		UserRelation userRelation = null;
		String strHql = "from UserRelation u where u.fbuuid='"+strUuid+"' and u.relationTypeId="+iTypeId;
		Query query = this.getSession().createQuery(strHql);
		return query.list();
	}
	/**
	 * 删除附件
	 * @param strUuid
	 * @return
	 */
	public int deleteFjById(int id){
		try {
			String strSql = "DELETE FROM employee_fjfb WHERE employeeId = "+id;
			super.execSQLUpdate(strSql);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	/**
	 * 根据条件和实体名，获取对象列表
	 * @param entityName
	 * @param condition
	 * @return
	 */
	public List ObjectList(String hql)
	{
		Query query = this.getSession().createQuery(hql);
		return query.list();
	}
	/**
	 * 删除UserRelation表
	 * 批量删除 根据ID集合
	 * @return
	 */
	public int delUserRelationByIds(String strBean, String strIds){
		System.out.println("Debugging MC --->  EmployeeDaoImpl---delUserRelationByIds()   --->  strIds = "+strIds+"  --->   ");
		String strHql="delete "+strBean+" e where e.id in ("+strIds+")";
		try{
			Query query=this.getSession().createQuery(strHql);
			
			int i = query.executeUpdate();
			if(i>0){
				System.out.println("Debugging MC --->  delUserRelationByIds   --->    --->   删除成功");
				return 1;
			}else{
				System.out.println("Debugging MC --->  delUserRelationByIds   --->    --->   删除失败");
				return 0;
			}
		}catch(Exception e){
			System.out.println("Debugging MC --->  delUserRelationByIds   --->    --->   删除报错");
			e.printStackTrace();
			return 2;
		}
	}
	/**
	 * 添加家庭成员
	 * @param userRelation
	 * @return 
	 */
	public int addUserRelation(UserRelation userRelation){
		System.out.println("Debugging MC --->  EmployeeDaoImpl   --->  addUserRelation()  --->  UserRelation = "+userRelation);
		try{
			this.getHibernateTemplate().saveOrUpdate(userRelation);
			System.out.println("Debugging MC --->  EmployeeDaoImpl   --->  addUserRelation()  --->  添加成功  getId= "+userRelation.getId());
			return 1;
		}catch(Exception e){
			System.out.println("Debugging MC --->  EmployeeDaoImpl   --->  addUserRelation()  --->  添加报错啦");
			e.printStackTrace();
		}
		return 0;
	}
	public Employee getEmployeeByEmpIdentity(String strEmpIdentity){
		String strHql = "from Employee e where 1 = 1 and e.cardid = '" + strEmpIdentity + "' ";
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
	 * 根据员工工号查询员工对象
	 * @param strEmpNo
	 * @return
	 */
	public Employee getEmployeeByEmpNo(String strEmpNo){
		String strHql = "from Employee e where 1 = 1 and e.empNo = '" + strEmpNo + "' ";
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
	
	
	// 修改家庭成员
	public int updateUserRelation(UserRelation userRelation){
		System.out.println("******************Debugging MC --> EmployeeDaoImpl.javas 进入到  updateUserRelation(UserRelation userRelation) 方法！******************\n");
		try {
			this.getHibernateTemplate().saveOrUpdate(userRelation);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}	
	
	/***
	 * 员工离职
	 */
	public void emplz(int empid,String leavereason,String leavetime){
		String hql="update Employee set leaveReason='"+leavereason+"',leavetime='"+leavetime+"',isLeave=0 where id="+empid;
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createQuery(hql);
		int i= query.executeUpdate();
		System.out.println(i);
	}
	
	/***
	 * 根据员工编号查询客户
	 */
	public List<Customer> customerByEid(int empid,String customerType){
		String hql="from Customer where del=0 and vendition="+empid+" and customerType2="+customerType;
		List<Customer> customerlist= this.getHibernateTemplate().find(hql);
		System.out.println(customerlist.size());
		return customerlist;
	}
	
	/******
	 * 客户移交负责人
	 */
	public void yjCustomer(int empid,int customerid){
		String hql="update Customer set vendition="+empid+" where customerId="+customerid;
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createQuery(hql);
		int i= query.executeUpdate();
		System.out.println(i);
	}
	// 根据项目编号得到对象
	public Object getCustomer(Class clazz, Integer id){
		return  super.getHibernateTemplate().get(clazz, id);
	}
	/*****
	 * 添加任务移交记录
	 */
	public void saveYJ(CustomerMove cusmove){
		this.getHibernateTemplate().save(cusmove);
	}
	/********
	 * 查看移交记录
	 */
	public List<CustomerMove> customerJL(int cid){
		String hql="from CustomerMove where customer.customerId="+cid;
		return this.getHibernateTemplate().find(hql);
	}
	/******
	 * 添加请假单
	 */
	public void addLeavesimple(Leavesimple leave){
		// 请假的开始时间
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String begintime = dateFormat.format(leave.getBegintime());//当前日期
		String endtime = dateFormat.format(leave.getEndtime());//当前日期
		String hql="INSERT INTO leavesimple(empid,begintime,endtime,content,manager,superson,admin,leavetype) VALUE("+leave.getEmpid()+",'"+begintime+"','"+endtime+"','"+leave.getContent()+"','"+leave.getManager()+"','"+leave.getSuperson()+"','"+leave.getAdmin()+"',"+leave.getLeavetype()+")";
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		int i= query.executeUpdate();
		System.out.println(i);
	}
	/******
	 * 根据员工ID得到这个员工今天有没有请假
	 */
	public List getLeavesimpleByEmpid(int empid){
		// 请假的开始时间
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now=new Date();
		String date = dateFormat.format(now);
		System.out.println(date);
		String hql="from Leavesimple l where empid="+empid+" and begintime<='"+date+"' and endtime>='"+date+"'";
		List list=this.getHibernateTemplate().find(hql);
		System.out.println(list.size());
		return list;
	}
	public static void main(String[] args)
	{
		ApplicationContext ac=new FileSystemXmlApplicationContext
		("/src/applicationContext*.xml");
		EmployeeBussiness emd=(EmployeeBussiness) ac.getBean("empBussiness");
		
		//添加
		//List list=emd.selEmp(1, 3);
		//System.out.println(list.size());
		//添加员工
//		Employee emp=new Employee();
//		emp.setName("aaaff");
//		System.out.println(emd.addEmp(emp));
		//根据Id查找员工
//		Employee em=emd.oneEmp(9);
//		System.out.println(em.getName());
		//更新员工信息
//		Employee emp=new Employee();
//		emp.setId(1);
//		emp.setName("蔡志鹏");
//		System.out.println(emd.updateEmp(emp));
		//删除员工
//		Object[] ids={3,4};
//		System.out.println(emd.delEmp(ids));
//		System.out.println(emd.selEmps(""));
	}


	public List<Employee> exHql(String hql) {
		List<Employee> datas=null;
		try{
			datas=super.execHQL(hql);
		}catch(Exception e)
		{
		    e.printStackTrace();	
		}
		return datas;
	}
	
	/******
	 * 得到这个员工下所参与的项目
	 */
	public List projectByEid(int empid){
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
		String hql="from NewProject where projectstatus in(2,3) and isdel=0 and  id in("+id+")";  
		List projectlist=this.getHibernateTemplate().find(hql);
		
		return projectlist;
	}
	/******
	 * 得到员工的职位
	 */

	public List emplevel() {
	
		String hql="from EmployeeGrade";
		List<EmployeeGrade> emplevellist=this.getHibernateTemplate().find(hql);
		return emplevellist;
	}


	public Boolean emplevel(String emplevel, String strid) {
		int empgradeid=Integer.parseInt(emplevel);
		int empid=Integer.parseInt(strid);
		if(empgradeid!=0){
		String hql="update employee set gradeid="+emplevel+" where id="+strid;
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
	
		int s=query.executeUpdate();
		}
		return true;
	}
	/**
	 * 添加员工业务
	 */
	/**
	 * 添加员工业务数据
	 */
	public void addOperationDeparts(int typeid, int empid, double money,
			String creatTime, String explain,int temp){
		String hql="INSERT INTO operationEmployeematch(typeid,empid,money,creatTime,explaines,temp) VALUE("+typeid+","+empid+","+money+",'"+creatTime+"','"+explain+"',"+temp+")";
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	/**
	 * 修改员工业务数据--temp=-1
	 */
	public void addOperationEmployee(int id,int empid,double money,String creatTime,String explains,int temp){
		String hql="update operationEmployeematch set money="+money+",empid="+empid+",creatTime='"+creatTime+"',explaines='"+explains+"' where id="+id+" and temp="+temp;
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	/**
	 * 删除员工业务数据
	 */
	public void DelOperationEmployee(int empid, int typeid, int temp){
		String hql="DELETE FROM operationEmployeematch WHERE empid="+empid+" and typeid="+typeid+" and temp="+temp;
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}


	public Object updatesql(String sqla) {
		Session session=this.getSessionFactory().getCurrentSession();
		Query query=session.createQuery(sqla);
		query.executeUpdate();
		return null;
	}


	public boolean adda(String sql) {
		// TODO Auto-generated method stub
		 Session session=this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(sql);
		query.executeUpdate();;
		return true;
	}


	public Object empDao(Employee emp) {
  

	this.getHibernateTemplate().saveOrUpdate(emp);
	return emp.getId();
		
	}
}

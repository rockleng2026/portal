package com.fuao.fajxc.bussiness.impl.basic;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Query;
import org.hibernate.Session;

import com.fuao.fajxc.bussiness.FbManipulateBussiness;
import com.fuao.fajxc.bussiness.FieldPropertyBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.dao.FbManipulateDao;
import com.fuao.fajxc.dao.FieldPropertyDao;
import com.fuao.fajxc.dao.basic.EmployeeDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.PageBean;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.CustomerMove;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.EmployeeFjfb;
import com.fuao.fajxc.vo.FieldProperty;
import com.fuao.fajxc.vo.Leavesimple;
import com.fuao.fajxc.vo.UserRelation;
import com.fuao.fajxc.vo.UserRelationtypesb;


public class EmployeeBussinessImpl  implements EmployeeBussiness {
	
	/**
	 * 声明员工Dao
	 */
	private EmployeeDao empDao;
	
	private FbManipulateDao fbManipulateDao;
	private FieldPropertyDao fieldPropertyDao;

	/**
	 * 获得分页员工信息
	 * @return
	 */
	public PageBean selEmp(int pagesize, int page,String addhql) {
		System.out.println("bussince");
		int allRow = empDao.selCount(addhql);    //总记录数    
        System.out.println(allRow);
        int totalPage = PageBean.countTotalPage(pagesize, allRow);	//总页数    
        final int offset = PageBean.countOffset(pagesize, page);	  //当前页开始记录    
        final int length = pagesize;	    //每页记录数    
        final int currentPage = PageBean.countCurrentPage(page);    
        List list = empDao.selEmp(offset, length,addhql);	   //"一页"的记录    
			
		//把分页信息保存到Bean中
		PageBean pageBean = new PageBean();
		pageBean.setPageSize(pagesize);
		pageBean.setCurrentPage(currentPage);
		pageBean.setAllRow(allRow);
		pageBean.setTotalPage(totalPage);
		pageBean.setList(list);
		pageBean.init();
		return pageBean;
	}
	
	/**
	 * 添加员工
	 * @return
	 */
	public boolean addemp(Employee emp,List<FieldProperty> listFieldProperty, HttpServletRequest request){
		
		boolean b = empDao.addEmp(emp);
		
		//附加附件
		Map<String,String> map=new HashMap<String,String>();  
		Object mapp = request.getSession().getAttribute("sczj");
		if(null !=mapp){
			map = (Map)mapp;
			request.getSession().removeAttribute("sczj");		
		    System.out.println("Debugging MC --->     --->    --->   获取的附件信息MAP集合是："+map);	
		}
	    //SimpleDateFormat(String pattern) 
	    //用给定的模式和默认语言环境的日期格式符号构造SimpleDateFormat。
	    //"yyyy-MM-dd'T'HH:mm:ss.SSSZ"    随便选择什么格式
	    Date date=new Date();
	    String dt = new String(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date));
        if(map != null){
        	for(Map.Entry<String, String> entry: map.entrySet()) {  
 			    System.out.print(entry.getKey() + ":" + entry.getValue() + "\t");  
	 			EmployeeFjfb bizscfjb = new EmployeeFjfb();
	 			bizscfjb.setAttachmentName(entry.getKey());
	 			bizscfjb.setAttachmentPath(entry.getValue());
	 			bizscfjb.setUploadTime(dt);
	 			bizscfjb.setEmployee(emp);
	 			try {
					empDao.add(bizscfjb);	// 添加附件
					System.out.println("Debugging MC --->     --->    --->   添加附件成功");
				} catch (Exception e) {
					System.out.println("Debugging MC --->     --->    --->   添加附件失败，错误如下：");
					e.printStackTrace();
					return false;
				}
        	}	 
       }
		return b;
	}

	/**
	 * 添加员工
	 * @return Employee员工对象
	 */
	public Employee addReturnEmp(Employee emp,List<FieldProperty> listFieldProperty, HttpServletRequest request){
		
		Employee employee = null;
		try {
			employee = (Employee) empDao.addReturnObject(emp);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		//附加附件
		Map<String,String> map=new HashMap<String,String>();  
		Object mapp = request.getSession().getAttribute("sczj");
		if(null !=mapp){
			map = (Map)mapp;
			request.getSession().removeAttribute("sczj");		
		    System.out.println("Debugging MC --->     --->    --->   获取的附件信息MAP集合是："+map);	
		}
	    //SimpleDateFormat(String pattern) 
	    //用给定的模式和默认语言环境的日期格式符号构造SimpleDateFormat。
	    //"yyyy-MM-dd'T'HH:mm:ss.SSSZ"    随便选择什么格式
	    Date date=new Date();
	    String dt = new String(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date));
        if(map != null){
        	for(Map.Entry<String, String> entry: map.entrySet()) {  
 			    System.out.print(entry.getKey() + ":" + entry.getValue() + "\t");  
	 			EmployeeFjfb bizscfjb = new EmployeeFjfb();
	 			bizscfjb.setAttachmentName(entry.getKey());
	 			bizscfjb.setAttachmentPath(entry.getValue());
	 			bizscfjb.setUploadTime(dt);
	 			bizscfjb.setEmployee(emp);
	 			try {
					empDao.add(bizscfjb);	// 添加附件
					System.out.println("Debugging MC --->     --->    --->   添加附件成功");
				} catch (Exception e) {
					System.out.println("Debugging MC --->     --->    --->   添加附件失败，错误如下：");
					e.printStackTrace();
					return null;
				}
        	}	 
       }
        return employee;
	}


	//获得单个员工对象
	public Employee oneEmp(int id) {
		return empDao.oneEmp(id);
	}

	/**
	 * 更新员工信息
	 * @return
	 */
	public boolean updateEmp(Employee emp, HttpServletRequest request){
		boolean b = empDao.updateEmp(emp);
		
		//附加附件
		Map<String,String> map=new HashMap<String,String>();  
		Object mapp = request.getSession().getAttribute("sczj");
		if(null !=mapp){
			map = (Map)mapp;
		    System.out.println("Debugging MC --->     --->    --->   获取的附件信息MAP集合是："+map);
			request.getSession().removeAttribute("sczj");			
		}
	    //SimpleDateFormat(String pattern) 
	    //用给定的模式和默认语言环境的日期格式符号构造SimpleDateFormat。
	    //"yyyy-MM-dd'T'HH:mm:ss.SSSZ"    随便选择什么格式
	    Date date=new Date();
	    String dt = new String(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date));
        if(map != null){
        	for(Map.Entry<String, String> entry: map.entrySet()) {  
 			    System.out.print("Debugging MC --->     --->    --->   "+entry.getKey() + ":" + entry.getValue() + "\t");  
	 			EmployeeFjfb bizscfjb = new EmployeeFjfb();
	 			bizscfjb.setAttachmentName(entry.getKey());
	 			bizscfjb.setAttachmentPath(entry.getValue());
	 			bizscfjb.setUploadTime(dt);
	 			bizscfjb.setEmployee(emp);
	 			try {
					empDao.add(bizscfjb);
					System.out.println("Debugging MC --->     --->    --->   添加附件成功");
				} catch (Exception e) {
					System.out.println("Debugging MC --->     --->    --->   添加附件失败，错误如下：");
					e.printStackTrace();
					return false;
				}
        	}	 
       }
		return b;
	}


	/**
	 * 删除员工
	 * @return
	 */
	public boolean delEmp(Object[] ids) {
		Object[] obj = new Object[ids.length];
		for(int i=0;i<ids.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		boolean flag = empDao.delEmp(obj);
		if(flag){
			flag=empDao.delUser(obj);
			System.out.println("flag:"+flag);
		}
		return flag;
	}


	/**
	 * 查找
	 */
	public List selDep(String hql) {
		return empDao.selDep(hql);
	}

	public List getAllRelationfb(String strEntityName, String strHql){
		List listRelation = new ArrayList();
		
		return listRelation;
	}
 
	public List selEmps(String addhql) {
		System.out.println("empBussiness");
		String hql="from Employee where delflag=0"+addhql;
		List list=empDao.selEmps(hql);
		System.out.println("list:"+list.size());
		if(list!=null)
			return list;
		else
			return null;
	}
	
	public Employee getEmployeeByEmpIdentity(String strEmpIdentity){
		if(null==strEmpIdentity||strEmpIdentity==""){
			return null;
		}
		return empDao.getEmployeeByEmpIdentity(strEmpIdentity);
	}
	/**
	 * 根据员工工号查询员工对象
	 * @param strEmpNo
	 * @return
	 */
	public Employee getEmployeeByEmpNo(String strEmpNo){
		if(null==strEmpNo||strEmpNo==""){
			return null;
		}
		return empDao.getEmployeeByEmpNo(strEmpNo);
	}

	public UserRelationtypesb getAllById(int iId){
		return empDao.getAllById(iId);
	}

	public Pages paginationQuery(String hql, int pageNo, int pageSize,
			Object... values) {
		return empDao.exHqlPages(hql, pageNo, pageSize, values);
	}
	
	// 获得附表类别，根据类别名称
	public UserRelationtypesb getAllByName(String strName){
		return empDao.getAllByName(strName);
	}
	 
	
	// 获得user_relation表中的List，根据员工ID  和   附表类别
	public List getAllRelationByUuidAndTypeId(String strUuid, int iTypeId){
		return empDao.getAllRelationByUuidAndTypeId(strUuid, iTypeId);
	}
	/**
	 * 根据条件和实体名，获取对象列表
	 * @param entityName
	 * @param condition
	 * @return
	 */
	public List ObjectList(String entityName,String condition)
	{
		String hql = " from "+entityName+" where 1=1 "+condition;
		return empDao.ObjectList(hql);
	}
	/**
	 * 删除UserRelation表
	 * 批量删除 根据ID集合
	 * @return
	 */
	public int delUserRelationByIds(String strBean, String strIds){
		return empDao.delUserRelationByIds(strBean, strIds);
	}
	/**
	 * 添加家庭成员
	 * @param userRelation
	 * @return 
	 */
	public int addUserRelation(UserRelation userRelation){
		return empDao.addUserRelation(userRelation);
	}
	
	/**
	 * 删除附件
	 * @param strUuid
	 * @return
	 */
	public int deleteFjById(int id){
		return empDao.deleteFjById(id);
	}
	
	public EmployeeDao getEmpDao() {
		return empDao;
	}
	public void setEmpDao(EmployeeDao empDao) {
		this.empDao = empDao;
	}
	public FbManipulateDao getFbManipulateDao() {
		return fbManipulateDao;
	}
	public void setFbManipulateDao(FbManipulateDao fbManipulateDao) {
		this.fbManipulateDao = fbManipulateDao;
	}

	public FieldPropertyDao getFieldPropertyDao() {
		return fieldPropertyDao;
	}

	public void setFieldPropertyDao(FieldPropertyDao fieldPropertyDao) {
		this.fieldPropertyDao = fieldPropertyDao;
	}

	public List<Employee> exHql(String hql) {
		List<Employee> datas=null;
		try{
			datas=empDao.exHql(hql);
		
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datas;
	}
	/***
	 * 员工离职
	 */
	public void emplz(int empid,String leavereason,String leavetime){
		this.empDao.emplz(empid, leavereason, leavetime);
	}
	
	/***
	 * 根据员工编号查询客户
	 */
	public List<Customer> customerByEid(int empid,String customerType){
		return this.empDao.customerByEid(empid,customerType);
	}
	/******
	 * 客户移交负责人
	 */
	public void yjCustomer(int empid,int customerid){
		this.empDao.yjCustomer(empid, customerid);
	}
	// 根据项目编号得到对象
	public Object getCustomer(Class clazz, Integer id){
		return  this.empDao.getCustomer(clazz, id);
	}
	/*****
	 * 添加任务移交记录
	 */
	public void saveYJ(CustomerMove cusmove){
		this.empDao.saveYJ(cusmove);
	}
	/********
	 * 查看移交记录
	 */
	public List<CustomerMove> customerJL(int cid){
		return this.empDao.customerJL(cid);
	}
	/******
	 * 添加请假单
	 */
	public void addLeavesimple(Leavesimple leave){
		this.empDao.addLeavesimple(leave);
	}
	/******
	 * 根据员工ID得到这个员工今天有没有请假
	 */
	public List getLeavesimpleByEmpid(int empid){
		return this.empDao.getLeavesimpleByEmpid(empid);
	}
	/******
	 * 员工人员的绑定　
	 */
	public List setEmp() {
		String hql="from Employee WHERE isLeave=1 AND delflag=0 AND department !=1";
		List list=empDao.selEmps(hql);
		System.out.println("list:"+list.size());
		if(list!=null)
			return list;
		else
			return null;
	}
	
	/******
	 * 得到这个员工下所参与的项目
	 */
	public List projectByEid(int empid){
		return empDao.projectByEid(empid);
	}

	public List emplevel() {
		// TODO Auto-generated method stub
		return empDao.emplevel();
	}
	/**
	 * 新增加修改员工的级别
	 * @param emplevel
	 * @return
	 */
	public Boolean editempgrade(String emplevel,String strid) {
		
		return empDao.emplevel(emplevel,strid);
	}
   /**
    * 添加员工业务数据
    */
	public void addOperationDepart(int typeid, int empid, double money,
			String creatTime, String explain,int temp) {
		 this.empDao.addOperationDeparts(typeid, empid, money,creatTime, explain,temp);
		
    }
	
	/**
	 * 修改员工业务temp=-1
	 */
    public void addOperationEmployee(int id,int empid,double money,String creatTime,String explains,int temp){
    	this.empDao.addOperationEmployee(id, empid, money, creatTime, explains,temp);
    }
    /**
	 * 删除员工业务数据
	 */
    public void DelOperationEmployee(int empid,int typeid,int temp){
    	this.empDao.DelOperationEmployee(empid, typeid, temp);
    }

public List selectObect(String hql) {
	// TODO Auto-generated method stub
	return empDao.execHQL(hql);
}

public void empworkposit(String empworkposition, String strId) {
	int postid=Integer.parseInt(empworkposition);
	int strid=Integer.parseInt(strId);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date d = null;
	try {
		d = sdf.parse(sdf.format(new Date()));
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	Timestamp date1=new Timestamp(d.getTime());
	System.out.println(date1);
	String d1=String.valueOf(date1);
	String sql="insert into workposition_employee(positionid,empid,edittime) values ("+postid+","+strid+",'"+d1+"')";
	
	empDao.execSQLUpdate(sql);
	
}

public void addOperationDepart(int typeid, int empid, double money,
		String creatTime, String explain){
	// TODO Auto-generated method stub
}
public Object updatesql(String sqla) {
	// TODO Auto-generated method stub
	return empDao.updatesql(sqla);

}

public boolean add(String sql) {
	// TODO Auto-generated method stub
	return empDao.adda(sql);
}

public Object addemp(Employee emp) {
 return	empDao.empDao(emp);     
	
}

}


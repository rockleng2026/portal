package com.fuao.fajxc.dao.mission;
import java.util.Date;
import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Missiontype;
public interface MissiontypeDao extends BaseDao{
	/*
	 * 客户基本资料
	 */
	public boolean addData(Missiontype data)throws Exception;
	
	/*
	 *修改 客户基本资料
	 */
	public boolean updateData(Missiontype data)throws Exception ;
	
	
	public Missiontype getMissiontypedata(String id);
	/*
	 *特殊查询客户基本资料
	 */
	public List<Object>  exHql(String hql);
	
	/*
	 *执行分页查询客户基本资料
	 */
	public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
	
	/******
	 * 添加类型
	 */
	public void addType(int superid,String name,String date);
	/******
	 * 添加类型--付飞翔
	 */
	public void addTypes(int superid,String name,String date,int isflag);
	/**
	 * 运维组添加员工信息
	 */
	public void addOperationGroup(int operid,String empids,String empnames,String nowstr);
	/**
	 * 修改运维员工信息
	 */
	public void editOperationGroup(int id,String empids,String vempnames,String nowstr);
	/******
	 * 添加部门
	 */
	public void addDept(int superid,String name,String date);
	/*******
	 * 修改类型
	 */
	public void updateType(int superid,String supername,String date);
	/*******
	 * 修改部门
	 */
	public void updateDept(int superid,String supername,String date);
	/**********
	 * 删除类型 
	 */
	public void delType(int id);
	/**********
	 * 删除部门
	 */
	public void delDept(int id);
	/**
	 * 根据类别 ID查其详细信息
	 */
	public List getMissionById(int id);
	/**排序方法
	 * @param ids
	 * @param isle
	 * @param v1
	 * @param squ1
	 * @param squnummax
	 * @param id1
	 * @param id2
	 * @return
	 */
	public boolean updateorderby(int ids,int isle,int v1,int squ1,int squnummax,int id1,int id2);
	
	/**
	 * 更换部门
	 * @param empid
	 * @param posid
	 * @return
	 */
	
/**
 * 查找主管
 * @param depId
 * @return
 */
	public List seldirectorId(int depId);
/**
 * 编辑部门信息
 * @param depid
 * @param tel
 * @param zhuguan
 * @param isbj
 * @param fiiale
 * @param filialemark
 * @param deptname 
 * @param depno 
 * @param lslevel 
 * @return
 */
	public boolean editdepent(int depid, String tel, String zhuguan, int isbj,
			int fiiale, String filialemark, String deptname, String depno, int lslevel);

public boolean changeworkpos(String empid, int posid, int v1);
/**
 * 删除部门
 * @param deptid
 * @param islevel 
 * @return
 */
public boolean deldept(String x[]);

/***
 * 给临时部门的人分配职位
 * @param empid
 * @param depid
 * @return
 */
public boolean setemployye(int empid, int depid);
/**
 *显示职位和任务
 * @param deptid
 * @return
 */

public String xianshi(int deptid);

public List<Department> seldept(int deptid);

public void resetposition(String n1);

public void resetDeptqum();
/**
 * 添加部门业务
 */

public void addOperation(int typeid, int departid, double money,
		String creatTime, String explain);
/**
 * 修改部门业务
 */
public void updateOperationDepart(int oid,double money,
		String creatTime, String explain);
/**
 * 删除部门业务
 */
public void delDepOperation(int deptid,int typeid);
/**
 * 添加部门年月额度数据
 */
public void addAuditline(int deptid, double money1, double money2,
		double money3, double money4, double money5, double money6,
		double money7, double money8, double money9, double money10,
		double money11, double money12, double jd1, double jd2, double jd3,
		double jd4, double sbn, double xbn, double year, int temp, int isflag,
		String creatTime);
/**
 * 修改部门年月额度数据
 */
public void updateAuditline(int oid, double money1, double money2,
		double money3, double money4, double money5, double money6,
		double money7, double money8, double money9, double money10,
		double money11, double money12, double jd1, double jd2, double jd3,
		double jd4, double sbn, double xbn, double year, int temp, int isflag,
		String creatTime);
/**
 * 删除部门年月额度数据
 */
public void delAuditline(int foreignId, int temp, int isflag);
}

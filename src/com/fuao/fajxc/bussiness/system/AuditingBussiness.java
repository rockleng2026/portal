package com.fuao.fajxc.bussiness.system;

import java.util.List;
import java.util.Map;


import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.OperationDepartmentmatch;
import com.fuao.fajxc.vo.OperationEmployeematch;
import com.fuao.fajxc.vo.VerifyOrder;

public interface AuditingBussiness {

	
	
	/**
	 * 循环部门插入auditingOrder
	 * @return
	 */
	public int addAuditingOrder(String otype,String oNo,String entityName,String filialemark);
	public int addAuditingOrder2(String otype,String oNo,String entityName,String filialemark);
	/**
	 * 日子模块的审批流程添加
	 * @param otype
	 * @param oNo
	 * @param entityName
	 * @param filialemark
	 * @return
	 */
	public int addAuditingOrder3(Employee emp,String oNo,String entityName,String filialemark);
	
	public int addAuditingOrderNotice(String otype,String oNo,String entityName,String filialemark);
	/**
	 * 根据条件查找AuditingOrderTab中的数据
	 * @return
	 */
	public List someauditingOrder(String addhql);
	
    /**
     * 执行审核单据的一系列操作（改变审核状态，改变单据的审核标识）
     * @return
     */
	public int AudtintingRound(String hql,AuditingOrderTab aot,String tab,String afiled,String orderName);
	public int AudtintingRound1(String hql,AuditingOrderTab aot,String tab,String afiled,String orderName,String marks);
	public int AudtintingRound2(String hql,AuditingOrderTab aot,String tab,String afiled,String orderName,String marks);
	
	/**
	 * 根据条件查找VerifyOrderEmployee中的员工，用于判断员工是否有审核的权限
	 * @return
	 */
	public List someVerifyOrderEmployee(String addhql);
	
	/**
	 * 获得某种类型单的单号集合
	 * @param orderType	 实体名
	 * @param empid		当前登录员工id
	 * @return
	 */
	public String getOrderNOList(String orderType,String empid,String orderNo,String state);
	
	
	/**
	 * 查看登录用户是否能够审核
	 * @param orderNo
	 * @param empid
	 * @return
	 */
	public boolean checkemp(String orderNo,String empid);
	
	/**
	 * 查找审核状态
	 * @param orderNo
	 * @param empid
	 * @return
	 */
	public boolean state(String tab,String orderNo,String order,String state);
	/**
	 * 查看登录用户是否能够审核
	 * @param orderNo
	 * @param empid
	 * @return
	 */
	public boolean checkemp1(String orderNo,String empid);
	public boolean checkemp2(String rvid,String empid);
	
	/*
	 * 资源核实单审批
	 */
	public int addAuditingOrderRC(String otype,String rcid,String entityName1,String filialemark);
	
	/**
	 * 执行update
	 * @param hql
	 * @return
	 */
	public boolean updatehql(String hql);
	

	/**
	 * 查看是否是分公司的审核流程
	 * @param filialemark
	 * @param otype
	 * @return
	 */
	public VerifyOrder gettVerifyOrder(String filialemark,String otype);
	

	public List getObjectList(String entityName,String condition);
	public void addAuditingOrder(AuditingOrderTab aot);
	/***
	 * 根据编号得到对象
	 */
	public Object getObj(Class clazz,Integer id);
	/**********
	 * 根据采购单去查找审核类型
	 */
	public Docmark typeBymark(String mark);
	/***********
	 * 根据业务类型，当前登录人，单据标识对象查找得到员工审核业务对象
	 */
	public OperationEmployeematch getOper(Docmark docmark,int empid);
	/***********
	 * 根据订单编号和表查找出对应的审核金额，暂时只用purorder表做示例.
	 */
	public double objByprice(String tab,String orderNo,String orderName,String priceFiled);
	/*****************
	 * 得到月，季，半年，年金额
	 */
	public Map<String, Double> yjnByemp(int empid);
	/**
	 * 根据业务类型与员工编号得到OperationDepartmentmatch对象
	 */
	public OperationDepartmentmatch operBydept(int typeid,int empid);
	/*****************
	 * 得到月，季，半年，年金额
	 */
	public Map<String, Double> yjnBydept(int empid);
	/************
	 * 找到员工每月，年，半年，季度的业务审核金额
	 */
	public Map<String, Double> empByprice(OperationEmployeematch operemp);
	/************
	 * 找到部门每月，年，半年，季度的业务审核金额
	 */
	public Map<String, Double> deptByprice(OperationDepartmentmatch operdept);
	/********
	 * 根据当前登录人找到主管编号
	 */
	public String getZG(int empid);
	
	public Object updAllObj(Object obj);
	
	public List getAll(String hql);
	public void updObj(Object obj);
	public void add(Object obj);
}

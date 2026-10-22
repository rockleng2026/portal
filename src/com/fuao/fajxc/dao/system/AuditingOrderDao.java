package com.fuao.fajxc.dao.system;

import java.util.List;
import java.util.Map;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.OperationDepartmentmatch;
import com.fuao.fajxc.vo.OperationEmployeematch;
import com.fuao.fajxc.vo.VerifyOrder;
import com.fuao.fajxc.vo.VerifyOrderEmployee;



public interface AuditingOrderDao extends BaseDao {

	/**
	 * 根据单据类型查找VerifyOrder
	 * @return
	 */
	public VerifyOrder oneOrder(String otype);
	
	/**
	 * 插入auditingOrder
	 * @return
	 */
	public boolean addAuditingOrder(AuditingOrderTab aot);
	
	/**
	 * 根据条件查找AuditingOrderTab中的数据
	 * @return
	 */
	public List someauditingOrder(String addhql);
	
	/**
	 * 查看表中的数据为接收的
	 * @return
	 */
	public List state(String hql);
	
	/**
	 * 更新相应数据
	 * @return
	 */
	public boolean updateAuditing(String hql);
	/**
	 * 查询入库单ID
	 * @return
	 */
	public int  selectStorageId(String storageNo);
	/**
	 * 查询入库详细信息ID
	 * @return
	 */
	public List selectStrorageinfoId(int storageId);
	/**
	 * 查询需要入库产品的Id
	 * @return
	 */
	public List selectProduct(int storageInfoId);
	
	
	
	/**
	 * 查询报损单ID
	 * @return
	 */
	public int  selectRuinId(String ruinNO);
	/**
	 * 查询报损单详细ID
	 * @return
	 */
	public List selectRuininfoId(int ruinId);
	public boolean selLastAot1(String orderNo);
	/**
	 * 查询到货单的ID
	 * @return
	 */
	public int selectToOrderID(String returnOrderNO);
	/**
	 * 查询采购订货单的ID
	 * @return
	 */
	public int selectPurOrderID(String returnOrderNO);
	
	/**
	 * 查询某张单据最后一个审核的部门
	 * @return
	 */
	public boolean selLastAot(String orderNo);
	
	/**
	 * 根据条件查找VerifyOrderEmployee中的员工，用于判断员工是否有审核的权限
	 * @return
	 */
	public List someVerifyOrderEmployee(String addhql);

	public List getObjectList(String hql);
	/***
	 * 根据编号得到对象
	 */
	public Object getObj(Class clazz,Integer id);
	/**********
	 * 根据部门查找有没有授权给其他员工
	 */
	public OperationEmployeematch operEmp(String typeid,int deptid);
	/**********
	 * 根据采购单去查找审核类型
	 */
	public Docmark typeBymark(String mark);
	/**
	 * 根据业务类型与员工编号得到OperationEmployeematch对象
	 */
	public OperationEmployeematch operByemp(int typeid,int empid);
	/***********
	 * 根据订单编号和表查找出对应的审核金额，暂时只用purorder表做示例.
	 */
	public double objByprice(String tab,String orderNo,String orderName,String priceFiled);
	/*****************
	 * 得到月，季，半年，年金额员工
	 */
	public Map<String, Double> yjnByemp(int empid);
	/**
	 * 根据业务类型与员工编号得到OperationDepartmentmatch对象
	 */
	public OperationDepartmentmatch operBydept(int typeid,int empid);
	/*****************
	 * 得到月，季，半年，年金额，部门
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
	
	public List getAll(String hql);
	public void updObj(Object obj);
}

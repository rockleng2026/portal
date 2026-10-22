package com.fuao.fajxc.dao.cwtj_ygyj;

import java.util.List;
import java.util.Map;

public interface YgyjDao {
	//统计当月
	public List countNow();
	//统计上个月订单
	public List countLastMonth();
	//统计最近6个月
	public List countSixMonth();
	//统计总量
	public List countTotal();

//-------------统计订单金额------------------//
	//统计当月订单金额
	public List countNowMoney();
	//统计上个月订单金额
	public List countLastMonthMoney();
	//统计最近6个月订单金额
	public List countSixMonthMoney();
	//统计总订单金额
	public List countTotalMoney();
	
	//----------某个员工的订单详细信息-------//
	public List orderInfo(int empid,int mon);
	//以前
	public List orderBefore(int empid,int year);
	//总计
	public List orderTotal(int empid);
	
	//----------某个员工的订单金额-------//
	public List orderMoney(int empid,int mon);
	//以前
	public List orderBeforeMoney(int empid,int year);
	//总计
	public List orderTotalMoney(int empid);
//--------------查询月份下 季付 半年付 年付的订单数量----------------//
	public List tj(int month);
	
	//查询 季付 半年付 年付的订单金额
	public List countMoney(int month);
	
	//统计以前的季付 半年付  年付的订单量
	public List countBefore(int year);
	
	//统计以前的 季付 半年付 年付的金额
	public List countBeforeJe(int year);
	
	//统计总计的季付  半年付 年付订单数量
	public List selTotal();
	
	//统计总计的季付  半年付 年付订单金额
	public List selTotalMoney();
}

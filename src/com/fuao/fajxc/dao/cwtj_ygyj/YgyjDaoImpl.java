package com.fuao.fajxc.dao.cwtj_ygyj;

import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;

public class YgyjDaoImpl extends BaseDaoImpl implements YgyjDao{
	//统计当月员工订单
	public List countNow() {
		Session session = super.getSession();
		String sql = "select e.name,COUNT(s.saleOrderNo),e.id from employee e,saleorder s " +
				"where e.id=s.empid and (MONTH(begintime))=MONTH(CURDATE()) group by e.name,e.id";
		System.out.println(sql);
		Query query = session.createSQLQuery(sql);
		List yjList = query.list();
		return yjList;
	}
	
	// 统计上个月员工订单
	public List countLastMonth(){
		Session session = super.getSession();
		String sql = "select e.name,COUNT(s.saleOrderNo),e.id from employee e,saleorder s " +
				"where e.id=s.empid and (MONTH(begintime))=(MONTH(CURDATE()))-1 group by e.name,e.id";
		System.out.println(sql);
		Query query = session.createSQLQuery(sql);
		List lastmonthList = query.list();
		return lastmonthList;
	}
	
	//统计最近6个月订单
	public List countSixMonth() {
		Session session = super.getSession();
		String sql = "select e.name,COUNT(s.saleOrderNo),e.id from employee e,saleorder s " +
				"where e.id=s.empid and (MONTH(begintime)) between (MONTH(CURDATE()))-6 and MONTH(CURDATE()) group by e.name,e.id";
		Query query = session.createSQLQuery(sql);
		List sixmonth = query.list();
		return sixmonth;
	}

	//统计每个员工总订单
	public List countTotal() {
		Session session = super.getSession();
		String sql = "select e.name,COUNT(s.saleOrderNo) as num,e.id from employee e,saleorder s " +
				"where e.id=s.empid group by e.name,e.id";
		Query query  = session.createSQLQuery(sql);
		List total = query.list();
		return total;
	}
	
	
	//-----------------------统计订单金额----------------------------//
	/**
	 *  本月订单金额
	 */
	public List countNowMoney(){
		Session session = this.getSession();
		String sql = "select e.name,SUM(price) as money,e.id from saleorder s,employee e where e.id=s.empid and MONTH(begintime)=MONTH(CURDATE()) group by e.name,e.id";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	/**
	 * 统计上个月订单金额
	 * @return
	 */
	public List countLastMonthMoney(){
		Session session = this.getSession();
		String sql = "select e.name,SUM(price) as money,e.id as eid from saleorder s,employee e where e.id=s.empid and (MONTH(begintime))=(MONTH(CURDATE())-1) group by e.name,eid";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	/**
	 * 统计最近6个月订单金额
	 * @return
	 */
	public List countSixMonthMoney(){
		Session session = this.getSession();
		String sql = "select e.name,SUM(price) as money,e.id as eid from saleorder s,employee e where e.id=s.empid and (MONTH(begintime)) between (MONTH(CURDATE())-6) and MONTH(CURDATE()) group by e.name";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	/**
	 * 统计总订单金额
	 * @return
	 */
	public List countTotalMoney(){
		Session session = this.getSession();
		String sql = "select e.name,SUM(price) as money,e.id as eid from saleorder s,employee e where e.id=s.empid group by e.name";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	
	//--------------统计某个员工的订单详细信息=------//
	public List orderInfo(int empid,int mon){
		Session session = this.getSession();
		String sql = "select MONTH(begintime) as mon, COUNT(saleOrderNo) as num,s.pay_style,e.name from saleorder s,alltype a,employee e" +
				" where a.id=s.pay_style and e.id=s.empid and e.id="+empid+" and MONTH(begintime)="+mon+" and s.pay_style in(15,16,17,18)" +
				" group by s.pay_style,e.name";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	
	//统计某个员工以前的订单详细信息
	public List orderBefore(int empid,int year){
		Session session = this.getSession();
		String sql = "select COUNT(saleOrderNo) as num,s.pay_style,e.name from saleorder s,alltype a,employee e" +
				" where a.id=s.pay_style and e.id=s.empid and e.id="+empid+" and YEAR(begintime)="+year+" and s.pay_style in(15,16,17,18)" +
				" group by s.pay_style,e.name";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	
	//统计某个员工总的的订单详细信息
	public List orderTotal(int empid){
		Session session = this.getSession();
		String sql = "select COUNT(saleOrderNo) as num,s.pay_style,e.name from saleorder s,alltype a,employee e" +
				" where a.id=s.pay_style and e.id=s.empid and e.id="+empid+" and s.pay_style in(15,16,17,18)" +
				" group by s.pay_style,e.name";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	
	//以前金额
	public List orderBeforeMoney(int empid, int year) {
		Session session = this.getSession();
		String sql = "select SUM(price) as num,s.pay_style,e.name from saleorder s,alltype a,employee e" +
				" where a.id=s.pay_style and e.id=s.empid and e.id="+empid+" and YEAR(begintime)="+year+" and s.pay_style in(15,16,17,18)" +
				" group by s.pay_style,e.name";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	
	//--------------统计某个员工的订单金额=------//
	public List orderMoney(int empid, int mon) {
		Session session = this.getSession();
		String sql = "select MONTH(begintime) as mon, SUM(price) as money,s.pay_style,e.name from saleorder s,alltype a,employee e" +
				" where a.id=s.pay_style and e.id=s.empid and e.id="+empid+" and MONTH(begintime)="+mon+" and s.pay_style in(15,16,17,18)" +
				" group by s.pay_style,e.name";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	
	//总计金额
	public List orderTotalMoney(int empid) {
		Session session = this.getSession();
		String sql = "select SUM(price) as money,s.pay_style from saleorder s,alltype a,employee e" +
				" where a.id=s.pay_style and e.id=s.empid and e.id="+empid+" and s.pay_style in(15,16,17,18)" +
				" group by s.pay_style";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}

	//--------------查询月份下 季付 半年付 年付的订单数量----------------//
	public List tj(int month){
		Session session = this.getSession();
		String sql = "select MONTH(begintime) as month, COUNT(saleOrderNo) as num,s.pay_style from saleorder s,alltype a " +
				"where a.id=s.pay_style and s.pay_style in(15,16,17,18) and MONTH(begintime)="+month+" group by s.pay_style";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}

	//查询 季付 半年付 年付的订单金额
	public List countMoney(int month) {
		Session session = this.getSession();
		String sql = "select MONTH(begintime) as month, SUM(price) as num,s.pay_style from saleorder s,alltype a where a.id=s.pay_style and s.pay_style in(15,16,17,18) and MONTH(begintime)="+month+" group by s.pay_style";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	
	//统计以前的订单数量
	public List countBefore(int year){
		Session session = this.getSession();
		String sql = "select YEAR(begintime) as year,COUNT(saleOrderNo) as num,s.pay_style from saleorder s,alltype a " +
				" where a.id=s.pay_style and s.pay_style in(16,17,18)" +
				" and (YEAR(begintime))="+year +
				" group by s.pay_style,year";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	
	//统计以前的 季付 半年付 年付的金额
	public List countBeforeJe(int year){
		Session session = this.getSession();
		String sql = "select YEAR(begintime) as year,SUM(price) as money,s.pay_style from saleorder s,alltype a " +
				" where a.id=s.pay_style and s.pay_style in(15,16,17,18)" +
				" and (YEAR(begintime))="+year+ " group by s.pay_style,year";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	
	//统计总计的季付  半年付 年付订单数量
	public List selTotal(){
		Session session = this.getSession();
		String sql = "select COUNT(saleOrderNo) as num,s.pay_style from saleorder s,alltype a" +
				" where a.id=s.pay_style  and s.pay_style in(15,16,17,18)" +
				" group by s.pay_style";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
	
	//统计总计的季付  半年付 年付订单金额
	public List selTotalMoney(){
		Session session = this.getSession();
		String sql = "select SUM(price) as money,s.pay_style from saleorder s,alltype a" +
				" where a.id=s.pay_style  and s.pay_style in(15,16,17,18)" +
				" group by s.pay_style";
		Query query = session.createSQLQuery(sql);
		List list = query.list();
		return list;
	}
}

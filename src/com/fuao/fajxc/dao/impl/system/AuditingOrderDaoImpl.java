package com.fuao.fajxc.dao.impl.system;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.system.AuditingOrderDao;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Auditline;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.OperationDepartmentmatch;
import com.fuao.fajxc.vo.OperationEmployeematch;
import com.fuao.fajxc.vo.PurOrder;
import com.fuao.fajxc.vo.ReturnOrder;
import com.fuao.fajxc.vo.Ruin;
import com.fuao.fajxc.vo.Storage;
import com.fuao.fajxc.vo.VerifyOrder;

public class AuditingOrderDaoImpl extends BaseDaoImpl implements AuditingOrderDao {

	public boolean addAuditingOrder(AuditingOrderTab aot) {
		boolean flag=false;

		try
		{
			this.getHibernateTemplate().save(aot);
			
			flag=true;
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return flag;
	}

	public VerifyOrder oneOrder(String otype) {
		VerifyOrder vio=null;
		String hql="from VerifyOrder where ordertype.mark=?";
		Query query=this.getSession().createQuery(hql);
		query.setParameter(0, otype);
		//System.out.println("query.list:"+query.list().size());
		if(query.list().size()>0){
			vio=(VerifyOrder)query.list().get(0);
			return vio;
		}
		else
			return null;
	}

	public List someauditingOrder(String addhql) {
		String hql="from AuditingOrderTab where 1=1 "+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	public List state(String hql){
		Query q=this.getSession().createQuery(hql);
		
		return q.list();
	}
	public boolean updateAuditing(String hql) {
	    boolean flag=false;
	    System.out.println(hql);
	    try
	    {
	    	System.out.println("************************");
	    	Query query=this.getSession().createQuery(hql);
	    	int i=query.executeUpdate();
	    	if(i>0)
	    		flag=true;
	    }
	    catch(Exception ex)
	    {
	    	ex.printStackTrace();
	    }
		return flag;
	}
	
	//商品入库修改状态
	public int selectStorageId(String storageNo){
		String hql=" from Storage where storageNo='"+storageNo+"'";
		Storage s= (Storage)this.getSession().createQuery(hql).uniqueResult();
		System.out.println(s.getStorageId());
		 int a=s.getStorageId();
		return a;
	}
	public List selectStrorageinfoId(int storageId)
	{
		String hql="from  StorageInfo where storageId='"+storageId+"'";
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	public List selectProduct(int storageInfoId){
		String hql="from Product where storageInfoId='"+storageInfoId+"'";
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	
	
	//商品报损删除商品
	public int selectRuinId(String ruinNo) {
		String hql=" from Ruin where ruinNo='"+ruinNo+"'";
		Ruin r= (Ruin)this.getSession().createQuery(hql).uniqueResult();
		System.out.println(r.getId());
		 int a=r.getId();
		return a;
	}
	public List selectRuininfoId(int ruinNoId) {
		String hql="from  RuinInfo where ruinId='"+ruinNoId+"'";
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	
	//采购退货单生活后修改订单和到货单状态
	public int selectToOrderID(String returnOrderNO){
		String hql=" from ReturnOrder where purReturnNo='"+returnOrderNO+"'";
		ReturnOrder r= (ReturnOrder)this.getSession().createQuery(hql).uniqueResult();
		System.out.println(r.getToOrder().getId());
		 int a=r.getToOrder().getId();
		return a;
	}
	public int selectPurOrderID(String returnOrderNO)
	
	{	String hql=" from ReturnOrder where purReturnNo='"+returnOrderNO+"'";
		ReturnOrder r= (ReturnOrder)this.getSession().createQuery(hql).uniqueResult();
		System.out.println(r.getPurOrder().getId());
		int a=r.getPurOrder().getId();
		return a;
	}
	
	public boolean selLastAot(String orderNo) {
		String hql="from AuditingOrderTab where orderNo='"+orderNo+"' order by auditingOrder desc";
		Query query=this.getSession().createQuery(hql);
		List list = query.list();
		query.setFirstResult(0);
		query.setMaxResults(1);
		AuditingOrderTab aot=(AuditingOrderTab) query.list().get(0);
		
		
		int mark = aot.getAuditingOrder();
		String hql2 = "from AuditingOrderTab where orderNo='"+orderNo+"' and mark = '"+mark+"'";
		Query query2=this.getSession().createQuery(hql2);
		
		List<AuditingOrderTab> list1 = query2.list();
		List list2= new ArrayList();
		String str="";
		for(int i=0; i<list1.size(); i++){
	
			str+= list1.get(i).getMark();
		}
		if(str.indexOf("2")==-1){
			int j=0;
			for(int i=0; i<list1.size(); i++){
				if(list1.get(i).getAuditingFlag()!=0){
					j++;
				}
			}
			if(list1.size() == j){
				return true;
			}
		}else{
			for(int i=0; i<list1.size(); i++){
				if(list1.get(i).getAuditingFlag()!=0){
					return true;
				}
			}
			
		}
		return true;
	}
	
	public boolean selLastAot1(String orderNo) {
		String hql="from AuditingOrderTab where rvid='"+orderNo+"' order by auditingOrder desc";
		Query query=this.getSession().createQuery(hql);
		List list = query.list();
		query.setFirstResult(0);
		query.setMaxResults(1);
		AuditingOrderTab aot=(AuditingOrderTab) query.list().get(0);
		
		
		int mark = aot.getAuditingOrder();
		String hql2 = "from AuditingOrderTab where rvid='"+orderNo+"' and mark = '"+mark+"'";
		Query query2=this.getSession().createQuery(hql2);
		
		List<AuditingOrderTab> list1 = query2.list();
		List list2= new ArrayList();
		String str="";
		for(int i=0; i<list1.size(); i++){
	
			str+= list1.get(i).getMark();
		}
		if(str.indexOf("2")==-1){
			int j=0;
			for(int i=0; i<list1.size(); i++){
				if(list1.get(i).getAuditingFlag()!=0){
					j++;
				}
			}
			if(list1.size() == j){
				return true;
			}
		}else{
			for(int i=0; i<list1.size(); i++){
				if(list1.get(i).getAuditingFlag()!=0){
					return true;
				}
			}
			
		}
		return true;
	}
	
	public static void main(String[] args)
	{
		ApplicationContext ac=new FileSystemXmlApplicationContext
		("/src/applicationContext*.xml");
		//AuditingBussiness emd=(AuditingBussinessImpl) ac.getBean("auditingBussiness");
		AuditingOrderDao aod=(AuditingOrderDaoImpl)ac.getBean("auditingDao");
//		AuditingOrderTab at=aod.selLastAot("CGO-2011082600002");
//		System.out.println(at.getId());
//		List list=aod.someauditingOrder(" and orderNo='CGO-2011082600021' and department.id=4");
//		System.out.println(list.size());
		List verList=aod.someVerifyOrderEmployee(" and verifyOrder.ordertype='CK'");
		System.out.println(verList.size());
	}

	public List someVerifyOrderEmployee(String addhql) {
		String hql="from VerifyOrderEmployee where 1=1"+addhql;
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}

	public List getObjectList(String hql) {
		Query query=this.getSession().createQuery(hql);
		return query.list();
	}
	/****************
	 * 根据ID得到对象
	 * @param clazz
	 * @param id
	 * @return
	 */
	public Object getObj(Class clazz,Integer id){
		return super.getHibernateTemplate().get(clazz, id);
	}

	/**********
	 * 根据部门查找有没有授权给其他员工
	 */
	public OperationEmployeematch operEmp(String typeid,int deptid){
		String hql="from OperationEmployeematch where type.id="+typeid+" and temp="+deptid;
		List optlist=this.getHibernateTemplate().find(hql);
		OperationEmployeematch operemp=new OperationEmployeematch();
		if(optlist!=null && optlist.size()>0){
			operemp=(OperationEmployeematch)optlist.get(0);
		}
		return operemp;
	}
	
	/**********
	 * 根据采购单去查找审核类型
	 */
	public Docmark typeBymark(String mark){
		String hql="from Docmark where temp1='"+mark+"'";
		List doclist=this.getHibernateTemplate().find(hql);
		Docmark docmark=new Docmark();
		if(doclist!=null && doclist.size()>0){
			docmark=(Docmark)doclist.get(0);
		}
		return docmark;
	}
	
	/**
	 * 根据业务类型与员工编号得到OperationEmployeematch对象
	 */
	public OperationEmployeematch operByemp(int typeid,int empid){
		String hql="from OperationEmployeematch where type.id="+typeid+" and employee.id="+empid;		
		List opemplist=this.getHibernateTemplate().find(hql);
		OperationEmployeematch operemp=new OperationEmployeematch();
		if(opemplist!=null && opemplist.size()>0){
			operemp=(OperationEmployeematch)opemplist.get(0);
		}
		return operemp;
	}
	
	/**
	 * 根据业务类型与员工编号得到OperationDepartmentmatch对象
	 */
	public OperationDepartmentmatch operBydept(int typeid,int empid){
		// 根据当前登录员工找到其部门
		Employee emp=(Employee)this.getObj(Employee.class, empid);
		String hql="from OperationDepartmentmatch where type.id="+typeid+" and dept.id="+emp.getDepartment().getId();		
		List opdeptlist=this.getHibernateTemplate().find(hql);
		OperationDepartmentmatch operdept=new OperationDepartmentmatch();
		if(opdeptlist!=null && opdeptlist.size()>0){
			operdept=(OperationDepartmentmatch)opdeptlist.get(0);
		}
		return operdept;
	}
	
	/***********
	 * 根据订单编号和表查找出对应的审核金额，暂时只用purorder表做示例.
	 */
	public double objByprice(String tab,String orderNo,String orderName,String priceFiled){
		String hql="select "+priceFiled+" from "+tab+" where "+orderName+"='"+orderNo+"'";
		List list=this.getHibernateTemplate().find(hql);
		double price=0;
		if(list!=null && list.size()>0){
			String strprice=list.get(0).toString();
			if(strprice!=null && strprice.trim().length()>0){
				price=Double.parseDouble(strprice);
			}
		}
		return price;
	}
	

	/*****************
	 * 得到月，季，半年，年金额
	 */
	public Map<String, Double> yjnByemp(int empid){
		// 得到当前月
		Date date=new Date();
		int year=date.getYear()+1900;
		int yue=date.getMonth()+1;
		// 得到当前月所属季度段
		String jd="";
		if(yue==1||yue==2||yue==3){
			jd="1,2,3";
		}
		if(yue==4||yue==5||yue==6){
			jd="4,5,6";
		}
		if(yue==7||yue==8||yue==9){
			jd="7,8,9";
		}
		if(yue==10||yue==11||yue==12){
			jd="10,11,12";
		}
		// 得到半年段
		String bn="";
		if(yue==1||yue==2||yue==3||yue==4||yue==5||yue==6){
			bn="1,2,3,4,5,6";
		}
		if(yue==7||yue==8||yue==9||yue==10||yue==11||yue==12){
			bn="7,8,9,10,11,12";
		}
		double yearprice=0;
		double bnprice=0;
		double jdprice=0;
		double monthprice=0;
		// 根据当前登录人得到其所有审核通过今年的价格
		String hql="from AuditingOrderTab where handlestate=2 and employees='"+empid+"' and empOrdept='emp' and year(auditingtime)="+year;
		List list=this.getHibernateTemplate().find(hql);
		for(int i=0;i<list.size();i++){
			AuditingOrderTab aot=(AuditingOrderTab)list.get(i);
			if(aot.getPrice()!=null){
				yearprice+=aot.getPrice();
			}
		}
		// 得到半年金额
		hql="from AuditingOrderTab where handlestate=2 and employees='"+empid+"' and empOrdept='emp' and year(auditingtime)="+year+" and month(auditingtime) in("+bn+")";
		list=this.getHibernateTemplate().find(hql);
		for(int i=0;i<list.size();i++){
			AuditingOrderTab aot=(AuditingOrderTab)list.get(i);
			if(aot.getPrice()!=null){
				bnprice+=aot.getPrice();
			}
		}
		// 得到季度金额
		hql="from AuditingOrderTab where handlestate=2 and employees='"+empid+"' and empOrdept='emp' and year(auditingtime)="+year+" and month(auditingtime) in("+jd+")";
		list=this.getHibernateTemplate().find(hql);
		for(int i=0;i<list.size();i++){
			AuditingOrderTab aot=(AuditingOrderTab)list.get(i);
			if(aot.getPrice()!=null){
				jdprice+=aot.getPrice();
			}
		}
		hql="from AuditingOrderTab where handlestate=2 and employees='"+empid+"' and empOrdept='emp' and year(auditingtime)="+year+" and month(auditingtime)="+yue;
		list=this.getHibernateTemplate().find(hql);
		for(int i=0;i<list.size();i++){
			AuditingOrderTab aot=(AuditingOrderTab)list.get(i);
			if(aot.getPrice()!=null){
				monthprice+=aot.getPrice();
			}
		}
		// 封装到集合中
		Map<String, Double> map=new HashMap<String, Double>();
		map.put("monthprice", monthprice);
		map.put("jdprice", jdprice);
		map.put("bnprice", bnprice);
		map.put("yearprice", yearprice);
		return map;
	}
	
	
	/*****************
	 * 得到月，季，半年，年金额
	 */
	public Map<String, Double> yjnBydept(int empid){
		// 得到当前月
		Date date=new Date();
		int year=date.getYear()+1900;
		int yue=date.getMonth()+1;
		// 得到当前月所属季度段
		String jd="";
		if(yue==1||yue==2||yue==3){
			jd="1,2,3";
		}
		if(yue==4||yue==5||yue==6){
			jd="4,5,6";
		}
		if(yue==7||yue==8||yue==9){
			jd="7,8,9";
		}
		if(yue==10||yue==11||yue==12){
			jd="10,11,12";
		}
		// 得到半年段
		String bn="";
		if(yue==1||yue==2||yue==3||yue==4||yue==5||yue==6){
			bn="1,2,3,4,5,6";
		}
		if(yue==7||yue==8||yue==9||yue==10||yue==11||yue==12){
			bn="7,8,9,10,11,12";
		}
		double yearprice=0;
		double bnprice=0;
		double jdprice=0;
		double monthprice=0;
		// 得到当前登录人所在部门下面所有的员工。
		String empstr=this.empByDeptid(empid);
		// 根据当前登录人得到其所有审核通过今年的金额
		String hql="from AuditingOrderTab where handlestate=2 and employees in("+empid+") and empOrdept='dept' and year(auditingtime)="+year;
		List list=this.getHibernateTemplate().find(hql);
		for(int i=0;i<list.size();i++){
			AuditingOrderTab aot=(AuditingOrderTab)list.get(i);
			if(aot.getPrice()!=null){
				yearprice+=aot.getPrice();
			}
		}
		// 得到半年金额
		hql="from AuditingOrderTab where handlestate=2 and employees in("+empid+") and empOrdept='dept' and year(auditingtime)="+year+" and month(auditingtime) in("+bn+")";
		list=this.getHibernateTemplate().find(hql);
		for(int i=0;i<list.size();i++){
			AuditingOrderTab aot=(AuditingOrderTab)list.get(i);
			if(aot.getPrice()!=null){
				bnprice+=aot.getPrice();
			}
		}
		// 得到季度金额
		hql="from AuditingOrderTab where handlestate=2 and employees in("+empid+") and empOrdept='dept' and year(auditingtime)="+year+" and month(auditingtime) in("+jd+")";
		list=this.getHibernateTemplate().find(hql);
		for(int i=0;i<list.size();i++){
			AuditingOrderTab aot=(AuditingOrderTab)list.get(i);
			if(aot.getPrice()!=null){
				jdprice+=aot.getPrice();
			}
		}
		hql="from AuditingOrderTab where handlestate=2 and employees in("+empid+") and empOrdept='dept' and year(auditingtime)="+year+" and month(auditingtime)="+yue;
		list=this.getHibernateTemplate().find(hql);
		for(int i=0;i<list.size();i++){
			AuditingOrderTab aot=(AuditingOrderTab)list.get(i);
			if(aot.getPrice()!=null){
				monthprice+=aot.getPrice();
			}
		}
		// 封装到集合中
		Map<String, Double> map=new HashMap<String, Double>();
		map.put("monthprice", monthprice);
		map.put("jdprice", jdprice);
		map.put("bnprice", bnprice);
		map.put("yearprice", yearprice);
		return map;
	}
	
	/**************
	 * 根据部门编号找到这个部门下的所有员工。
	 */
	public String empByDeptid(int empid){
		Employee emp=(Employee)this.getObj(Employee.class,empid);
		String hql="from Employee where isLeave=1 and delflag=0 and department.id="+emp.getDepartment().getId();
		List list=this.getHibernateTemplate().find(hql);
		String empstr="";
		for(int i=0;i<list.size();i++){
			Employee ed=(Employee)list.get(i);
			empstr+=","+ed.getId();
		}
		return empstr;
	}
	
	/************
	 * 找到员工每月，年，半年，季度的业务审核金额
	 */
	public Map<String, Double> empByprice(OperationEmployeematch operemp){
		// 得到当前月
		Date date=new Date();
		int year=date.getYear()+1900;
		int yue=date.getMonth()+1;
		double yearprice=0;  // 年金额
		double bnprice=0;   // 半年金额
		double jdprice=0;   // 季度金额
		double monthprice=0;// 月金额
		String hql="from Auditline where temp=2 and foreignId="+operemp.getId()+" and year(creatTime)="+year;
		List list=this.getHibernateTemplate().find(hql);
		// 根据当前时间找到年度审核金额
		Auditline auditline=new Auditline();
		if(list!=null && list.size()>0){
			auditline=(Auditline)list.get(0);
			yearprice=auditline.getYearmoney();
			if(yue==1){
				monthprice=auditline.getJanuarymoney();
				jdprice=auditline.getFirstquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==2){
				monthprice=auditline.getFebruarymoney();
				jdprice=auditline.getFirstquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==3){
				monthprice=auditline.getMarchmoney();
				jdprice=auditline.getFirstquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==4){
				monthprice=auditline.getAprilmoney();
				jdprice=auditline.getTwoquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==5){
				monthprice=auditline.getMaymoney();
				jdprice=auditline.getTwoquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==6){
				monthprice=auditline.getJunemoney();
				jdprice=auditline.getTwoquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==7){
				monthprice=auditline.getJulymoney();
				jdprice=auditline.getThreequarter();
				bnprice=auditline.getHalfyear2();
			}
			if(yue==8){
				monthprice=auditline.getAugustmoney();
				jdprice=auditline.getThreequarter();
				bnprice=auditline.getHalfyear2();
			}
			if(yue==9){
				monthprice=auditline.getSeptembermoney();
				jdprice=auditline.getThreequarter();
				bnprice=auditline.getHalfyear2();
			}
			if(yue==10){
				monthprice=auditline.getOctobermoney();
				jdprice=auditline.getFourquarter();
				bnprice=auditline.getHalfyear2();
			}
			if(yue==11){
				monthprice=auditline.getNovembermoney();
				jdprice=auditline.getFourquarter();
				bnprice=auditline.getHalfyear2();
			}
			if(yue==12){
				monthprice=auditline.getDecembermoney();
				jdprice=auditline.getFourquarter();
				bnprice=auditline.getHalfyear2();
			}
		}
		// 封装到集合中
		Map<String, Double> map=new HashMap<String, Double>();
		map.put("monthprice", monthprice);
		map.put("jdprice", jdprice);
		map.put("bnprice", bnprice);
		map.put("yearprice", yearprice);
		return map;
	}
	
	/************
	 * 找到部门每月，年，半年，季度的业务审核金额
	 */
	public Map<String, Double> deptByprice(OperationDepartmentmatch operdept){
		// 得到当前月
		Date date=new Date();
		int year=date.getYear()+1900;
		int yue=date.getMonth()+1;
		double yearprice=0;  // 年金额
		double bnprice=0;   // 半年金额
		double jdprice=0;   // 季度金额
		double monthprice=0;// 月金额
		String hql="from Auditline where temp=1 and foreignId="+operdept.getId()+" and year(creatTime)="+year;
		List list=this.getHibernateTemplate().find(hql);
		// 根据当前时间找到年度审核金额
		Auditline auditline=new Auditline();
		if(list!=null && list.size()>0){
			auditline=(Auditline)list.get(0);
			yearprice=auditline.getYearmoney();
			if(yue==1){
				monthprice=auditline.getJanuarymoney();
				jdprice=auditline.getFirstquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==2){
				monthprice=auditline.getFebruarymoney();
				jdprice=auditline.getFirstquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==3){
				monthprice=auditline.getMarchmoney();
				jdprice=auditline.getFirstquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==4){
				monthprice=auditline.getAprilmoney();
				jdprice=auditline.getTwoquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==5){
				monthprice=auditline.getMaymoney();
				jdprice=auditline.getTwoquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==6){
				monthprice=auditline.getJunemoney();
				jdprice=auditline.getTwoquarter();
				bnprice=auditline.getHalfyear1();
			}
			if(yue==7){
				monthprice=auditline.getJulymoney();
				jdprice=auditline.getThreequarter();
				bnprice=auditline.getHalfyear2();
			}
			if(yue==8){
				monthprice=auditline.getAugustmoney();
				jdprice=auditline.getThreequarter();
				bnprice=auditline.getHalfyear2();
			}
			if(yue==9){
				monthprice=auditline.getSeptembermoney();
				jdprice=auditline.getThreequarter();
				bnprice=auditline.getHalfyear2();
			}
			if(yue==10){
				monthprice=auditline.getOctobermoney();
				jdprice=auditline.getFourquarter();
				bnprice=auditline.getHalfyear2();
			}
			if(yue==11){
				monthprice=auditline.getNovembermoney();
				jdprice=auditline.getFourquarter();
				bnprice=auditline.getHalfyear2();
			}
			if(yue==12){
				monthprice=auditline.getDecembermoney();
				jdprice=auditline.getFourquarter();
				bnprice=auditline.getHalfyear2();
			}
		}
		// 封装到集合中
		Map<String, Double> map=new HashMap<String, Double>();
		map.put("monthprice", monthprice);
		map.put("jdprice", jdprice);
		map.put("bnprice", bnprice);
		map.put("yearprice", yearprice);
		return map;
	}
	
	/********
	 * 根据当前登录人找到主管编号
	 */
	public String getZG(int empid){
		Employee emp=(Employee)this.getObj(Employee.class, empid);
		String zgid="";
		if(emp.getDepartment().getEmployee().getId()!=null){
			zgid=emp.getDepartment().getEmployee().getId()+"";
		}
		if(emp.getDepartment().getEmployee().getId()==null && emp.getDepartment().getParentId()!=-1){
			Department dept=(Department)this.getObj(Department.class,emp.getDepartment().getParentId()); // 找到这个部门的上级部门主管
			zgid=dept.getEmployee().getId()+"";
		}
		return zgid;
	}
	
	public List getAll(String hql){
		try {
			return this.getHibernateTemplate().find(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public void updObj(Object obj){
		try{
			super.getSession().beginTransaction();
			super.getSession().update(obj);
			super.getSession().getTransaction().commit();
		}catch(Exception e){
			super.getSession().getTransaction().rollback();
		}
		}


}

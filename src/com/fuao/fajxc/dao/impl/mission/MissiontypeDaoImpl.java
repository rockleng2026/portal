package com.fuao.fajxc.dao.impl.mission;
import java.io.IOException;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import com.fuao.fajxc.bussiness.mission.MissiontypeBussiness;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.mission.MissiontypeDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.DepartmentGrade;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Missiontype;

public class MissiontypeDaoImpl extends BaseDaoImpl implements MissiontypeDao{
	

	public boolean addData(Missiontype data) throws Exception {
		super.add(data);
		return true;
	}

	public List<Object> exHql(String hql) {
		List<Object> datas=null;
		try {
		datas=super.execHQL(hql);
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

	public Missiontype getMissiontypedata(String id) {
		try {
			return (Missiontype) super.select(Missiontype.class,Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateData(Missiontype data)throws Exception  {
			super.update(data);
			return true;
	}
	
	/******
	 * 添加类型
	 */
	public void addType(int superid,String name,String date){
		String hql="INSERT INTO missiontype(name,superid,build_time,isflag) VALUES('"+name+"',"+superid+",'"+date+"',"+superid+")";		
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	/******
	 * 添加类型--付飞翔
	 */
	public void addTypes(int superid,String name,String date,int isflag){
		String hql="INSERT INTO missiontype(name,superid,build_time,isflag) VALUES('"+name+"',"+superid+",'"+date+"',"+isflag+")";		
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	/******
	 * 添加部门业务
	 */
	public void addOperation(int typeid,int departid,double money,String creatTime,String explain){
		String hql="INSERT INTO operationDepartmatch(typeid,departid,money,creatTime,explaines) VALUES("+typeid+","+departid+","+money+",'"+creatTime+"','"+explain+"')";		
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	/**
	 * 运维添加员工信息
	 */
	public void addOperationGroup(int operid,String empids,String empnames,String nowstr){
		String hql="INSERT INTO operationgroup(operid,empids,empnames,creatdate) VALUES("+operid+",'"+empids+"','"+empnames+"','"+nowstr+"')";		
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	/**
	 * 修改运维员工信息
	 */
	public void editOperationGroup(int id,String empids,String vempnames,String nowstr){
		String hql="UPDATE operationgroup SET empids='"+empids+"',creatdate='"+nowstr+"',empnames='"+vempnames+"' WHERE id="+id;		
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	/**
	 * 添加部门年月额度数据
	 */
	public void addAuditline(int deptid, double money1, double money2,
			double money3, double money4, double money5, double money6,
			double money7, double money8, double money9, double money10,
			double money11, double money12, double jd1, double jd2, double jd3,
			double jd4, double sbn, double xbn, double year, int temp, int isflag,
			String creatTime){
		String hql="INSERT INTO Auditline(foreignId,Januarymoney,Februarymoney,marchmoney,Aprilmoney,Maymoney,Junemoney,Julymoney,Augustmoney,Septembermoney,Octobermoney,Novembermoney,Decembermoney,Firstquarter,Twoquarter,Threequarter,Fourquarter,Halfyear1,Halfyear2,Yearmoney,temp,isflag,creatTime) VALUES("+deptid+","+money1+","+money2+","+money3+","+money4+","+money5+","+money6+","+money7+","+money8+","+money9+","+money10+","+money11+","+money12+","+jd1+","+jd2+","+jd3+","+jd4+","+sbn+","+xbn+","+year+","+temp+","+isflag+",'"+creatTime+"')";		
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
		
	}
	/**
	 * 修改部门年月额度数据
	 */
	public void updateAuditline(int oid, double money1, double money2,
			double money3, double money4, double money5, double money6,
			double money7, double money8, double money9, double money10,
			double money11, double money12, double jd1, double jd2, double jd3,
			double jd4, double sbn, double xbn, double year, int temp, int isflag,
			String creatTime){
			String hql="UPDATE  Auditline SET Januarymoney="+money1+",Februarymoney="+money2+",marchmoney="+money3+",Aprilmoney="+money4+",Maymoney="+money5+",Junemoney="+money6+",Julymoney="+money7+",Augustmoney="+money8+",Septembermoney="+money9+",Octobermoney="+money10+",Novembermoney="+money11+",Decembermoney="+money12+",Firstquarter="+jd1+",Twoquarter="+jd2+",Threequarter="+jd3+",Fourquarter="+jd4+",Halfyear1="+sbn+",Halfyear2="+xbn+",Yearmoney="+year+",creatTime='"+creatTime+"' where foreignId="+oid+" and temp="+temp+" and isflag="+isflag;	
			Session session = this.getSessionFactory().getCurrentSession();
			Query query=session.createSQLQuery(hql);
			query.executeUpdate();
		
	}
	/**
	 * 删除部门年月额度数据
	 */
	public void delAuditline(int foreignId, int temp, int isflag){
		
			String hql="DELETE FROM Auditline WHERE foreignId="+foreignId+" and temp="+temp+" and isflag="+isflag;
			Session session = this.getSessionFactory().getCurrentSession();
			Query query=session.createSQLQuery(hql);
			query.executeUpdate();
		
	}
	/******
	 * 修改部门业务
	 */
	public void updateOperationDepart(int oid,double money,String creatTime,String explain){
		String hql="UPDATE operationDepartmatch SET money="+money+",creatTime='"+creatTime+"',explaines='"+explain+"' WHERE id="+oid;
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	/**
	 * 删除部门业务
	 */
	public void delDepOperation(int deptid,int typeid){
		String hql="DELETE FROM operationDepartmatch WHERE departid="+deptid+" and typeid="+typeid;
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	/******
	 * 添加部门
	 */
	public void addDept(int superid,String name,String date){
		String hql="INSERT INTO department(name,parentId,time,delflag) VALUES('"+name+"',"+superid+",'"+date+"',0)";
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	
	
	/*******
	 * 修改类型
	 */
	public void updateType(int superid,String supername,String date){
		String hql="UPDATE missiontype SET name='"+supername+"',build_time='"+date+"' WHERE id="+superid;
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	
	/*******
	 * 修改部门
	 */
	public void updateDept(int superid,String supername,String date){
		String hql="UPDATE department SET name='"+supername+"',time='"+date+"' WHERE id="+superid;
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	
	/**********
	 * 删除类型 
	 */
	public void delType(int id){
		String hql="DELETE FROM missiontype WHERE id="+id;
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	
	/**********
	 * 删除部门
	 */
	public void delDept(int id){
		String hql="DELETE FROM department WHERE id="+id;
		Session session = this.getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(hql);
		query.executeUpdate();
	}
	/**
	 * 根据类别 ID查其详细信息
	 */
	public List getMissionById(int id){
		String hql="from Missiontype where id="+id+" or superid="+id+"";
		return this.getHibernateTemplate().find(hql);
	}
	/**
	 * 
	 * 更换部门信息的位置。
	 * @param ids  本部门id
	 * @param isle 本部门级别
	 * @param v1   目标顺序号
	 * @param squ1 当前部门信息号
	 * @param squnummax 本级别最高序列号
	 * @param id1    序列号最高id
	 * @param id2  目标序列号id
	 * @return
	 */
	 public boolean updateorderby(int ids,int isle,int v1,int squ1,int squnummax,int id1,int id2){
			     if(v1!=0){
				     if(v1>squnummax || v1==squnummax){

				          	String hql2="update department set squnum='"+squnummax+"' WHERE id="+ids;
				          	String hql3="update department set squnum='"+squ1+"' WHERE id="+id1;
				    	 
				    	 Session session = this.getSessionFactory().getCurrentSession();

					       Department     department = new Department();
					       
				         
					   	Query query=session.createSQLQuery(hql2);
						query.executeUpdate();
					    System.out.println(hql2);
					   	Query query1=session.createSQLQuery(hql3);
						query1.executeUpdate();
			           
				      }else{

				            String hql4="update department set squnum="+v1+" WHERE id="+ids;
				            String hql5="update department set squnum="+squ1+" WHERE id="+id2;
				       Session session = this.getSessionFactory().getCurrentSession();
				       Department     department = new Department();
				      
			            
				   	Query query=session.createSQLQuery(hql4);
					query.executeUpdate();
				    System.out.println(hql4);
				   	Query query1=session.createSQLQuery(hql5);
					query1.executeUpdate(); 
					System.out.println(hql4);

			            System.out.println("-----------------");
				      }
	
			   }
			 
		return true;
		
	}
	 
	 /**
	  * 
	  * 更改职位
	  */

	public boolean changeworkpos(String empid, int posid,int v1) {
		
		
		 Session session = this.getSessionFactory().getCurrentSession();
		
		int empid1=Integer.parseInt(empid);
		
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
		String hqlchange="";
		if(v1!=0){
			hqlchange ="insert into workposition_employee(positionid,empid,edittime,positiontype) values ("+posid+","+empid1+",'"+d1+"',"+v1+")";
		}else{
			
			hqlchange ="insert into workposition_employee(positionid,empid,edittime) values ("+posid+","+empid1+",'"+d1+"')";
			System.out.println(hqlchange);
		}
		Query query=session.createSQLQuery(hqlchange);
		int i=query.executeUpdate();
		if(i!=0){
			
			return true;
		}else{
		
		return false;
		}
	}
   /**
    * 查询主管名字
    */
	public List seldirectorId(int depId) {
		String addhql = "select directorId from department where delflag=0 and id="+depId; //获得当前id的部门信息
		 Session session = this.getSessionFactory().getCurrentSession();
	
		Query query=session.createSQLQuery(addhql);
		List list=query.list();
		int directorId=0;
		if (list.size()>0) {
		for (int i = 0; i < list.size(); i++) {
			Object object=list.get(0);
			if(object!=null){
			directorId=(Integer)object;}
		}	}
		String addhql2 = "select name from employee where id="+directorId;
		System.out.println(directorId);
		Query query1=session.createSQLQuery(addhql2);
		List<Employee> list1=query1.list();
		return list1;
	}
/**
 * 修改部门
 */
public boolean editdepent(int depid, String tel, String zhuguan, int isbj,
		int fiiale, String filialemark,String deptname,String depno,int islevel) {
	    int zhuguanid=Integer.parseInt(zhuguan);
	    String addhql = "select directorId from department where delflag=0 and id="+depid; //获得当前id的部门信息
		 Session session = this.getSessionFactory().getCurrentSession();
	System.out.println(zhuguanid);
		Query query=session.createSQLQuery(addhql);
		List list=query.list();
		int directorId=0;
		for (int i = 0; i < list.size(); i++) {
			Object object=list.get(0);
			if(object!=null){
			directorId=(Integer)object;
			}
		}
		String updatsql="";
		//是否有主管，是否是半级机构，如果是半级机构，squnnum设置为0
	
			if(zhuguanid!=0){
				if(isbj==1){
			  updatsql="update department set tel='"+tel+"' , isbj="+isbj+" ,squnum=0"+", directorId="+zhuguanid+" ,fiiale="+fiiale +", filialemark='"+filialemark+"' ,name='"+deptname+"' ,depNo='"+depno+"' , gradeid="+islevel+" where id="+depid;
				}else{
					updatsql="update department set tel='"+tel+"' , isbj="+isbj+", directorId="+zhuguanid+" ,fiiale="+fiiale +", filialemark='"+filialemark+"' ,name='"+deptname+"' ,depNo='"+depno+"' ,  gradeid="+islevel+" where id="+depid;
				}
			}else{
				if(isbj==1){
				 updatsql="update department set tel='"+tel+"' , isbj="+isbj+" ,squnum=0"+" ,fiiale="+fiiale +", filialemark='"+filialemark+"' ,name='"+deptname+"' ,depNo='"+depno+"' ,  gradeid="+islevel+" where id="+depid;
				
				}else {
					updatsql="update department set tel='"+tel+"' , isbj="+isbj+" ,fiiale="+fiiale +", filialemark='"+filialemark+"' ,name='"+deptname+"' ,depNo='"+depno+"' ,  gradeid="+islevel+" where id="+depid;
				}
			
			}
			
		
	   
	   Query query1=session.createSQLQuery(updatsql);
	   int i=query1.executeUpdate();
	   if(i>0){
	   return true;
       }else{
    	
       return false;
      }
}
/**
 * 删除部门，下级有部门对其下级进行删除,对此部门下的员工的部门字段进行修改改成0字段
 */
public boolean deldept(String x[]) {
	
	      for (int i = 0; i < x.length; i++) {
			if(!x[i].equals("") && !x[i].equals(null)){
				String delsqul="update department set delflag=1 where id="+x[i];
				Session session = this.getSessionFactory().getCurrentSession();
				 Query query1=session.createSQLQuery(delsqul);
					query1.executeUpdate();
					String depsql="update employee set department=0 where department="+x[i];
					Query depquery=session.createSQLQuery(depsql);
					depquery.executeUpdate();
				
			}
		}
	

return true;
}

public boolean setemployye(int empid, int depid) {
	
	Session session = this.getSessionFactory().getCurrentSession();
	String sqlString="update employee set department="+depid+" where id="+empid;
	Query depquery4=session.createSQLQuery(sqlString);
	depquery4.executeUpdate();
	
	return true;
}
/**
 * 显示半级机构的人员信息。
 */

public String xianshi(int deptid) {
	Session session = this.getSessionFactory().getCurrentSession();
	
	  String sql1="select id from workposition where deptid="+deptid;
	 
	  String sql0="select name from workposition where deptid="+deptid;
	  Query xsquery=session.createSQLQuery(sql1);  //根据部门id得到这个部门下职位的
	  List<Integer> list= xsquery.list();
	  int leng=list.size();
	  int x[] = new int[leng];  //部门的职位。
	  for (int i = 0; i < list.size(); i++) {
		  Integer object=list.get(i);
		  if(object!=null){
		x[i]=object.intValue();
		 
		  }
		  
	   }
	  Query xsquery0=session.createSQLQuery(sql0);  //根据部门id得到这个部门下职位的
	  

	  String allStr[]=new String[leng];
	  String strname[]=new String[leng];
	  List<Object> list0= xsquery0.list();
	  for (int i = 0; i < list0.size(); i++) {
		  Object object=list0.get(i);
		  System.out.println(object);
		  if(object!=null){
			  strname[i]=object.toString();
		 
		  }
		  
	   }
	  String sql;
	  String sql2;
	  
	  String str="";
	 for (int i = 0; i < x.length; i++) {
		  sql="select empid from workposition_employee where positionid="+x[i];
		  Query xsquery1=session.createSQLQuery(sql);  //根据职位id得到这个职位下的人的id
		  List<Integer> list1= xsquery1.list();
		  int leng1=list1.size();
		  int x1[] = new int[leng1]; 
		  System.out.println(x[i]);
		  for (int j = 0; j < list1.size(); j++) {
			  Integer object1= list1.get(j);
			
			  x1[j]=object1.intValue();
			 
			  sql2="select name from employee where id="+x1[j];
			  Query xsquery2=session.createSQLQuery(sql2);  //根据人id得到人名
			  List<String> list2= xsquery2.list();
				
			  for (int k = 0; k < list2.size(); k++) {
				  
				  String object2=list2.get(k);
				 
				  str=str+object2+" ";
			}
			  
			  
		}
		  str=str+";";
		  
		}	
	 	String namestr[]=str.split(";");
		
		for (int j = 0; j < namestr.length; j++) {
        allStr[j]="&nbsp;&nbsp  "+strname[j]+":"+namestr[j]+"<br><hr size='0.2' style='border: 3px dotted #FFFFFF;noshade;width:200px' color='#FFFFFF' >";
		}
		
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < namestr.length; i++) {
			sb.append(allStr[i]);
		}
        String string1= allStr.toString();
    	String strall=string1.toString();
    	
    	String newStr = sb.toString();
	   return newStr;
}

public List<Department> seldept(int deptid) {
	Session session = this.getSessionFactory().getCurrentSession();
	 List<Department> list = session.createQuery("from Department").list();
	  

	return list;
}

public void resetposition(String n1) {
	
	Session session = this.getSessionFactory().getCurrentSession();
	Department dep=new Department();
	dep.setName(n1);
	dep.setId(1);
	
	
	DepartmentGrade dGrade=new DepartmentGrade();
	dGrade.setDgNum((short) 1);
	
	dep.setDeptgrade(dGrade);
	session.save(dep);	
	
	session.clear();
	session.close();
}
/**
 * 重置部门
 */
public void resetDeptqum() {
	// 把数据库部门信息查询出来
	Session session = this.getSessionFactory().getCurrentSession();
	 List<Department> list = session.createQuery("from Department order by id").list();
	  
	 
	 int id=0;
	 Integer isbj=0;
	
	for (int i = 0; i < list.size(); i++) {
		Object object=list.get(i);
		Department dept=(Department) object;
		id=dept.getId();
		String sql="select isbj from department where id="+id;
		List<Integer> list2=session.createSQLQuery(sql).list();
		for (int j = 0; j < list2.size(); j++) {
			if(list2.get(0)!=null){
			isbj=list2.get(0);
			}
		}
		System.out.println(id);
		System.out.println(isbj);
		String sqlString="";
		 int squnum=1;
		//默认id等于1
		if(isbj==1){   // 半级机构不能更换位置。位置是第一个。
			 sqlString="update department set squnum=0 where id="+id;
			 Query query=session.createSQLQuery(sqlString);
			 query.executeUpdate();
		}else{
			
			for (int j = 0; j < list.size(); j++) {
				
				int parentid=list.get(j).getParentId();//得到父id
				int id1=list.get(j).getId();//得到父id
				if(parentid==id){
					
					 sqlString="update department set squnum="+squnum+" where id="+id1;
				
					 Query query=session.createSQLQuery(sqlString);
					 query.executeUpdate();
					 squnum++;
					 System.out.println(squnum);
					 
				}
				
			}
		}
		
		
	}
	
	
	
	
	
}

	 


}


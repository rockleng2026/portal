package com.fuao.fajxc.bussiness.impl.mission;
import java.util.Date;
import java.util.List;

import com.fuao.fajxc.bussiness.mission.MissiontypeBussiness;
import com.fuao.fajxc.dao.mission.MissiontypeDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.Updatecache;
import com.fuao.fajxc.vo.Workposition;
public class MissiontypeBussinessImpl implements MissiontypeBussiness{
		private  MissiontypeDao  missiontypeDao;
		

		public MissiontypeDao getMissiontypeDao() {
			return missiontypeDao;
		}

		public void setMissiontypeDao(MissiontypeDao missiontypeDao) {
			this.missiontypeDao = missiontypeDao;
		}

		public boolean addData(Missiontype data) throws Exception {
				try {
					missiontypeDao.update(data);
				} catch (Exception e) {
					throw e;					
				}
				return true;
		}

		public List<Object> exHql(String hql) {
			List<Object> datas=null;
			try {
				datas=missiontypeDao.exHql(hql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return datas;
		}

		public Pages exHqlPages(String hql, int pageNo, int pageSize,
				Object... values){
			Pages pages=null;
			try {
				pages=missiontypeDao.exHqlPages(hql, pageNo, pageSize, values);	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pages;
		}

		
		public boolean updateData(Missiontype data) {
			try {
				missiontypeDao.updateData(data);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		public Missiontype getMissiontypedata(String id) {
			Missiontype data=null;
			try {
				data= (Missiontype) missiontypeDao.getMissiontypedata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}

		public Missiontype getMissionTypedata(String id) {
			Missiontype data=null;
			try {
				data= (Missiontype) missiontypeDao.getMissiontypedata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}

		public boolean addData(Updatecache data) {
			try {
				missiontypeDao.add(data);
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
			return true;
		}
		/******
		 * 添加类型
		 */
		public void addType(int superid,String name,String date){
			missiontypeDao.addType(superid, name, date);
		}
		/******
		 * 添加部门
		 */
		public void addDept(int superid,String name,String date){
			missiontypeDao.addDept(superid, name, date);
		}
		/*******
		 * 修改类型
		 */
		public void updateType(int superid,String supername,String date){
			missiontypeDao.updateType(superid, supername, date);
		}
		/*******
		 * 修改部门
		 */
		public void updateDept(int superid,String supername,String date){
			missiontypeDao.updateDept(superid, supername, date);
		}
		/**********
		 * 删除类型 
		 */
		public void delType(int id){
			missiontypeDao.delType(id);
		}
		/**********
		 * 删除部门
		 */
		public void delDept(int id){
			missiontypeDao.delDept(id);
		}
		/**
		 * 根据类别 ID查其详细信息
		 */
		public List getMissionById(int id){
			return missiontypeDao.getMissionById(id);
		}

		public void savemissions(Department wk) {
			
			try {
				this.missiontypeDao.add(wk);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}

		public boolean updetorderby(int ids, int isle, int v1, int squ1,
				int squnummax, int id1, int id2) {
			return missiontypeDao.updateorderby(ids, isle, v1, squ1, squnummax, id1, id2);
			
		}
		public boolean changeworkpos(String empid,int posid,int v1){
			
			
			
			return missiontypeDao.changeworkpos( empid, posid,v1);
		}
   /**
    * 查询主管的名字
    */
		public List seldirectorId(int depId) {
			// TODO Auto-generated method stub
			return missiontypeDao.seldirectorId(depId);
		}
/**
 * 编辑主管
 * 
 */
public boolean editdepent(int depid, String tel, String zhuguan, int isbj,
		int fiiale, String filialemark,String deptname,String depno,int lslevel) {
			
	
	return missiontypeDao.editdepent(depid,tel,zhuguan,isbj,fiiale,filialemark,deptname,depno,lslevel);
	
	
}

public boolean deldept(String x[]) {
	// TODO Auto-generated method stub
	return missiontypeDao.deldept(x);
}

public boolean setemployye(int empid, int depid) {
	// TODO Auto-generated method stub
	return missiontypeDao.setemployye(empid,depid);
}

public String xianshi(int deptid) {
	
	
	
	return missiontypeDao.xianshi(deptid);
	// TODO Auto-generated method stub
	
	
}


public List<Department> seldept(int deptid) {
	return missiontypeDao.seldept(deptid);
	// TODO Auto-generated method stub
	
}
/******
 * 添加类型--付飞翔
 */
public void addTypes(int superid, String name, String date, int isflag) {
	missiontypeDao.addTypes(superid, name, date,isflag);
	

}
/******
 * 添加部门业务--付飞翔
 */
public void addOperationDepart(int typeid,int departid,double money,String creatTime,String explain){
	missiontypeDao.addOperation( typeid,departid,money,creatTime,explain);
}
/**
 * 添加部门年月额度金额数据
 */
public void addAuditline(int deptid,double money1,double money2,double money3,double money4,double money5,double money6,double money7,double money8,double money9,double money10,double money11,double money12,double jd1,double jd2,double jd3,double jd4,double sbn,double xbn,double year,int temp,int isflag,String creatTime){
	missiontypeDao.addAuditline(deptid,money1,money2,money3,money4,money5,money6,money7,money8,money9,money10,money11,money12,jd1,jd2,jd3,jd4,sbn,xbn,year,temp,isflag,creatTime);
}
/**
 * 删除部门年月额度数据
 */
public void delAuditline(int foreignId,int temp,int isflag){
	missiontypeDao.delAuditline(foreignId, temp,isflag);
}
/******
 * 修改部门业务--付飞翔
 */
public void updateOperationDepart(int oid,double money,String creatTime,String explain){
	missiontypeDao.updateOperationDepart(oid,money,creatTime,explain);
}
/**
 * 修改部门年月额度数据
 */
public void updateAuditline(int oid,double money1,double money2,double money3,double money4,double money5,double money6,double money7,double money8,double money9,double money10,double money11,double money12,double jd1,double jd2,double jd3,double jd4,double sbn,double xbn,double year,int temp,int isflag,String creatTime){
	missiontypeDao.updateAuditline(oid,money1,money2,money3,money4,money5,money6,money7,money8,money9,money10,money11,money12,jd1,jd2,jd3,jd4,sbn,xbn,year,temp,isflag,creatTime);
}

/**
 * 删除部门业务
 */
public void delDepOperation(int deptid,int typeid){
	missiontypeDao.delDepOperation(deptid,typeid);
}

public void resetposition(String n1){
	missiontypeDao.resetposition(n1);
	
}
 /**
  * 添加运维员工信息
  */
public void addOperationGroup(int operid,String empids,String empnames,String nowstr){
	missiontypeDao.addOperationGroup(operid,empids,empnames,nowstr);
}
/**
 * 修改运维员工信息
 */
public void editOperationGroup(int id,String empids,String vempnames,String nowstr){
	missiontypeDao.editOperationGroup(id,empids,vempnames,nowstr);
}
public void resetDeptqum() {
	
	missiontypeDao.resetDeptqum();
}

public void update(String hQL) {
	missiontypeDao.execSQLUpdate(hQL);
	
}


}


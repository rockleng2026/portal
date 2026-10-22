package com.fuao.fajxc.bussiness.mission;
import java.util.Date;
import java.util.List;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.Updatecache;
import com.fuao.fajxc.vo.Workposition;

public interface MissiontypeBussiness {
		
		/*
		 * 客户基本资料
		 */
		public boolean addData(Missiontype data)throws Exception;
		
		public boolean addData(Updatecache data)throws Exception;
		
		/*
		 *修改 客户基本资料
		 */
		public boolean updateData(Missiontype data);
		
		
		public Missiontype getMissionTypedata(String id);
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
		 * 添加部门业务
		 */
		public void addOperationDepart(int typeid,int departid,double money,String creatTime,String explain);
		/**
		 * 添加部门年月额度数据
		 */
		public void addAuditline(int deptid,double money1,double money2,double money3,double money4,double money5,double money6,double money7,double money8,double money9,double money10,double money11,double money12,double jd1,double jd2,double jd3,double jd4,double sbn,double xbn,double year,int temp,int isflag,String creatTime);
		/**
		 * 删除部门年月额度数据
		 */
		public void delAuditline(int foreignId,int temp,int isflag);
		/**
		 * 修改部门业务
		 */
		public void updateOperationDepart(int oid,double money,String creatTime,String explain);
		/**
		 * 修改部门年月额度数据
		 */
		public void updateAuditline(int oid,double money1,double money2,double money3,double money4,double money5,double money6,double money7,double money8,double money9,double money10,double money11,double money12,double jd1,double jd2,double jd3,double jd4,double sbn,double xbn,double year,int temp,int isflag,String creatTime);
		/**
		 * 删除部门业务
		 */
		public void delDepOperation(int deptid,int typeid);
		/**
		 * 添加运维员工信息
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
		
		public void savemissions(Department wk);
		
  //更新顺序
		public boolean updetorderby(int ids, int isle, int v1, int squ1,
		int squnummax, int id1, int id2);
		/**
		 * 职位管理
		 * @param employ
		 * @param posid
		 * @param v1 
		 * @return
		 */
		public boolean changeworkpos(String employ,int posid, int v1);
		/**
		 * 查询主管名字
		 */
		public List seldirectorId(int depId);

		public boolean  editdepent(int depid,String tel,String zhuguan,int isbj,int fiiale,String filialemark, String deptname, String depno, int islevel);
       
		/**
		 * 删除部门
		 * @param deptid
		 * @param islevel 
		 */
		public boolean deldept(String x[]);
        /**
         * 给临时部门的人分配职位 
         * @param empid
         * @param depid
         */
		public boolean setemployye(int empid, int depid);
		/**
		 * 显示部门的人员职位
		 * @param deptid
		 */
		public String xianshi(int deptid);

		public List<Department> seldept(int deptid);

		public void resetposition(String n1);

		public void resetDeptqum();

		public void update(String hQL);

		
}

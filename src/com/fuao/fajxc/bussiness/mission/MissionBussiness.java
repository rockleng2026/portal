package com.fuao.fajxc.bussiness.mission;
import java.util.List;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Mission;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewTask;

public interface MissionBussiness {

	
		/*
		 * 发布任务
		 */
		public boolean addData(Object data)throws Exception;
		
		public Object addReturn(Object data) throws Exception;
		/*
		 *修改 任务
		 */
		public boolean updateData(Mission data);
		
		
		public Mission getMissiondata(String id);
		/*
		 *特殊查询任务
		 */
		public List<Object>  exHql(String hql);
		
		/*
		 *执行分页查询任务
		 */
		public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
		
		/**
		 * 查询
		 * @param entityName 实体名
		 * @param adnhql 
		 * @return
		 */
		public List getObjectList(String entityName,String andhql );
		
		
		/**
		 * @param 任务id数组
		 * 删除任务
		 * @return
		 */
		public boolean delmission(Object[] ids);
		
		/**
		 * 读取信息
		 * @return
		 */
		public boolean duqumission(Object[] duqu);
		
		/**
		 * 删除Mission信息
		 * @return
		 */
		public boolean delsendmes(Object[] ids);
		
		/**
		 * 删除消息类型
		 * @param ids
		 * @return
		 */
		public boolean delmesstype(Object[] ids);

		/**
		 * 执行更新语句
		 * @param hql
		 * @return 受影响的条数
		 */
		public int exehqlupdate(String hql);
		
		/******
		 * 根据当前登录人去得到项目负责人
		 */
		public List projectlist(Employee emp);
		/**********
		 * 根据编号得到对象
		 */
		public Object getObj(Class cla,int id);
		/********
		 * 添加项目任务
		 */
		public void addproject(NewFunction function);
		/******
		 *  得到所有员工列表
		 */
		public List allEmp();
		/**********
		 * 给任务分配参与人员
		 */
		public void addtask(NewTask task);
		/****************
		 * 根据项目编号得到这个项目下面的所有参与人员
		 */
		public List functionByPid(int pid);
		/*********
		 * 修改我们的项目功能任务
		 */
		public void updateNewFunction(NewFunction function);
		/*******
		 * 查询类型
		 */
		public List alltype();
		/****************
		 * 根据项目编号得到这个项目下面的所有任务
		 */
		public List funByPid(int pid);
		
}

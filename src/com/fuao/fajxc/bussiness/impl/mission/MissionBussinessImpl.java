package com.fuao.fajxc.bussiness.impl.mission;
import java.util.List;
import com.fuao.fajxc.bussiness.mission.MissionBussiness;
import com.fuao.fajxc.dao.mission.MissionDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Mission;
import com.fuao.fajxc.vo.NewFunction;
import com.fuao.fajxc.vo.NewTask;
public class MissionBussinessImpl implements MissionBussiness{
		private  MissionDao  missionDao;
		


		public MissionDao getMissionDao() {
			return missionDao;
		}


		public void setMissionDao(MissionDao missionDao) {
			this.missionDao = missionDao;
		}

		//添加发布任务
		public boolean addData(Object data) throws Exception {
			try {
				missionDao.addData(data);
			} catch (Exception e) {
				throw e;
			}
			return true;
		}

		//添加发布任务 返回对象 为了记录动态
		public Object addReturn(Object data) throws Exception {
			Object object = null;
			try {
				object = missionDao.addReturn(data);
			} catch (Exception e) {
				throw e;
			}
			return object;
		}
		
		public List<Object> exHql(String hql) {
			List<Object> datas=null;
			try {
				datas=missionDao.exHql(hql);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return datas;
		}

		public Pages exHqlPages(String hql, int pageNo, int pageSize,
				Object... values){
			Pages pages=null;
			try {
				pages=missionDao.exHqlPages(hql, pageNo, pageSize, values);	
			} catch (Exception e) {
				e.printStackTrace();
			}
			return pages;
		}

		
		public boolean updateData(Mission data) {
			try {
				missionDao.updateData(data);
				return true;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}

		public Mission getMissiondata(String id) {
			Mission data=null;
			try {
				data= (Mission) missionDao.getMissiondata(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return data;
		}
		/**
		 * 查询
		 * @param hql
		 * @return
		 */
		public List getObjectList(String entityName,String andhql )
		{
			String hql = "from "+entityName+" where 1=1 "+andhql;
			return missionDao.getObjectList(hql);
		}
		/**********
		 * 根据编号得到对象
		 */
		public Object getObj(Class cla,int id){
			return missionDao.getObj(cla, id);
		}
		
		
		/**
		 * 删除信息
		 * @return
		 */
		public boolean delmission(Object[] ids) {
			// TODO Auto-generated method stub
			Object[] obj=new Object[ids.length];
			for(int i=0;i<ids.length;i++)
			{
				obj[i]=Integer.parseInt(ids[i].toString());
			}
			boolean flag=missionDao.delmission(obj);
			return flag;
		}
		
		/**
		 * 读取信息
		 * @return
		 */
		public boolean duqumission(Object[] duqu) {
			// TODO Auto-generated method stub
			Object[] obj=new Object[duqu.length];
			for(int i=0;i<duqu.length;i++)
			{
				obj[i]=Integer.parseInt(duqu[i].toString());
			}
			boolean flag=missionDao.duqumission(obj);
			return flag;
		}
		
		/**
		 * 删除Message信息
		 * @return
		 */
		public boolean delsendmes(Object[] ids) {
			// TODO Auto-generated method stub
			Object[] obj=new Object[ids.length];
			for(int i=0;i<ids.length;i++)
			{
				obj[i]=Integer.parseInt(ids[i].toString());
			}
			boolean flag=missionDao.delsendmes(obj);
			return flag;
		}
		
		/**
		 * 删除消息类型
		 * @return
		 */
		public boolean delmesstype(Object[] ids){
			Object[] obj=new Object[ids.length];
			for(int i=0;i<ids.length;i++)
			{
				obj[i]=Integer.parseInt(ids[i].toString());
			}
			boolean flag=missionDao.delmesstype(obj);
			return flag;
		}

		/**
		 * 执行更新语句
		 * @param hql语句
		 * @return 受影响的条数
		 */
		public int exehqlupdate(String hql) {
			return missionDao.exehqlupdate(hql);
		}
		
		/******
		 * 根据当前登录人去得到项目负责人
		 */
		public List projectlist(Employee emp){
			return missionDao.projectlist(emp);
		}
		/********
		 * 添加项目任务
		 */
		public void addproject(NewFunction function){
			missionDao.addproject(function);
		}
		/******
		 *  得到所有员工列表
		 */
		public List allEmp(){
			return missionDao.allEmp();
		}
		/**********
		 * 给任务分配参与人员
		 */
		public void addtask(NewTask task){
			missionDao.addtask(task);
		}
		/****************
		 * 根据项目编号得到这个项目下面的所有参与人
		 */
		public List functionByPid(int pid){
			return missionDao.functionByPid(pid);
		}
		/*********
		 * 修改我们的项目功能任务
		 */
		public void updateNewFunction(NewFunction function){
			missionDao.updateNewFunction(function);
		}
		/*******
		 * 查询类型
		 */
		public List alltype(){
			return missionDao.alltype();
		}
		/****************
		 * 根据项目编号得到这个项目下面的所有任务
		 */
		public List funByPid(int pid){
			return missionDao.funByPid(pid);
		}
}

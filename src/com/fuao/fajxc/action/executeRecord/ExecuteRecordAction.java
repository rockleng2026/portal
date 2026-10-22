package com.fuao.fajxc.action.executeRecord;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 员工动态   执行记录Action
 * @author 阙超强 14015
 *@date 2011-12-23 15:09:50
 */
public class ExecuteRecordAction implements ModelDriven<Executerecord>,ServletRequestAware,ServletResponseAware{

	private HttpServletRequest request;
	private HttpServletResponse response;
	
	private Executerecord executerecord;	
	private ExecuteRecordBussiness executeRecordBussiness;
	
	/*模型驱动*/
	public Executerecord getModel() {
		executerecord = new Executerecord();
		return executerecord;
	}
	/*获取request*/
	public void setServletRequest(HttpServletRequest arg0) {

		this.request = arg0;
	}
	/*获取response*/
	public void setServletResponse(HttpServletResponse arg0) {

		this.response = arg0;
	}
	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}
	
	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}
	
	//跳转动态详细信息
	public String goDetail(){
		
		//获取登录员工ID
		Employee employee = (Employee) request.getSession().getAttribute("emp");
		int empid = employee.getId();

		//拿到entityId 为表executerecord的entityId  相关联的实体id
		String strEntityId = request.getParameter("entityId");
		
		//获得动态关联的表   实体名
		String entityName = request.getParameter("entityName");
		
		//拿出点击的那条信息     显示出来
		String hql = "From " + entityName + " as tb where 1 = 1 ";
	
		//判断是否为增  改，strEntityId为-1的话就是查看或删除显示到所有列表
		if(!"-1".equals(strEntityId)){
			hql += "and tb.id in (" + strEntityId + ")";
		}
		
		Pages pages = executeRecordBussiness.exHqlPages(hql, 1, 5, null);
		//判断该数据是否存在
		if(null == pages){
			return "noData";
		}
		request.setAttribute("pages", pages);
		
		return entityName;
	}
	
	
	/**
	 * 更多   动态消息的列表  和 条件查询
	 * @author 阙超强 14015
	 * @date 2011-12-28 17:27:34
	 */
	@SuppressWarnings("unchecked")
	public String goMore(){
		
		//获取登录员工
		Employee emp = (Employee) request.getSession().getAttribute("emp");
		
		//执行sql获得子类ID
		String sonIds = executeRecordBussiness.executeSql("select getChildDeptLst("+emp.getDepartment().getId()+")");

		
		//权限判断  判断当前登录用户是否可以查看到动态
		String hql="from Executerecord as tb where 1 = 1 and (tb.employee.id = "+emp.getId()+" or(tb.employee.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
		" and tb.employee.department.id in ("+sonIds+")))";
		
		//判断是否已经查看过了  seenEmpID为已经查看过员工id
		hql += " and "+emp.getId()+" not in seenEmpId ";
		
		
		/************条件查询需要执行这里*************/
		//获得页面传过来的查询条件
		String strEmpId = request.getParameter("empId");
		String strSelect = request.getParameter("select");
		int empId = 0;
		if(strEmpId != null ){
			empId = Integer.parseInt(strEmpId);
			//判断是否为选择查看全部 (就是是否为-1)
			if(empId != -1){
				hql += " and tb.employee.id = " + empId;
			}
		}
		if(strSelect != null){
			hql += " and tb.content like '%" + strSelect + "%' ";
		}
		/************条件查询需要执行这里END*************/
		//id倒序排列 以显示最新
		hql += " order by tb.id desc ";
		
		//获得分页页码
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if(strPageNo == null || "".equals(strPageNo)){
			    pageNo = 1;
		}else{
				pageNo = Integer.parseInt(strPageNo);
		}
		
		//执行分页查询
		Pages pages = executeRecordBussiness.exHqlPages(hql, pageNo, 20, null);
		//显示出全部的动态
		request.setAttribute("pages", pages);
		
		
		//查出当前登录用户有权限查看的员工信息  显示在下拉列表，供查询使用
		sonIds += "," + emp.getId();
		
		String hqlEmp = "from Employee as tb where 1 = 1 and (tb.id = "+emp.getId()+" or(tb.groups.permissionGrade > "+emp.getGroups().getPermissionGrade()+
		" and tb.department.id in ("+sonIds+")))";
		List<Employee> empList = executeRecordBussiness.exHqls(hqlEmp);
		
		request.setAttribute("empList", empList);
		
		return "moreList";
	}
	

	//
	public String add(){
		
		return null;
	}
	
	//
	public String update(){
		
		return null;
	}
}

package com.fuao.fajxc.action.operation;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.validator.Length;

import com.fuao.fajxc.dao.operation.OperationDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.OperationDepartmentmatch;
import com.opensymphony.xwork2.ActionSupport;

public class DepartmentOperationAction extends ActionSupport implements 

ServletRequestAware,ServletResponseAware {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private OperationDao operationDao;
	private OperationDepartmentmatch operationdept;
	
	
	public HttpServletRequest getRequest() {
		return request;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public HttpServletResponse getResponse() {
		return response;
	}
	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	public OperationDao getOperationDao() {
		return operationDao;
	}
	public void setOperationDao(OperationDao operationDao) {
		this.operationDao = operationDao;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}	
	public OperationDepartmentmatch getOperationdept() {
		return operationdept;
	}
	public void setOperationdept(OperationDepartmentmatch operationdept) {
		this.operationdept = operationdept;
	}
	/**
	 * 列表方法
	 * @return
	 */
	public String list(){
		String pageNo = request.getParameter("pageNo");
		if(null==pageNo){
			pageNo = "1";
		}
		
		String hql = "from OperationDepartmentmatch where 1=1";
		String type = request.getParameter("type");
		String time = request.getParameter("time");
		String dept = request.getParameter("dept");
		System.out.println(type);
		System.out.println(dept);
		if(type!=null && type.trim().length()>0 && !type.equals("-1")){
			hql += " and type.id="+type;
		}
		if(time!=null && time.trim().length()>0){
			hql += " and creatTime='"+time+"'";
		}
		if(dept!=null && dept.trim().length()>0 && !dept.equals("-1")){
			hql += " and dept.id="+dept;
		}
		hql += " order by id desc";
		System.out.println(hql);
		
		Pages pages=operationDao.paginationQuery(hql, Integer.parseInt

(pageNo), 20, null);
		
		//列出所有类型
		String hql2 = "from Missiontype where superid=96";
		List typelist = operationDao.getAllMissiontype(hql2);
		//列出所有部门
		String hql3 = "from Department";
		List deptlist = operationDao.getAllDept(hql3);
		
		request.setAttribute("pages",pages);
		request.setAttribute("list",pages.getPageList());
		request.setAttribute("typelist", typelist);
		request.setAttribute("deptlist", deptlist);
		return "list";
	}
	
	public String addDept(){
		System.out.println("11");
		//列出所有类型
		String hql2 = "from Missiontype where superid=96";
		List typelist = operationDao.getAllMissiontype(hql2);
		//列出所有部门
		String hql3 = "from Department";
		List deptlist = operationDao.getAllDept(hql3);
		request.setAttribute("type", typelist);
		request.setAttribute("dept", deptlist);
		return "adddept";
	}
	
	public String add(){
		OperationDepartmentmatch d = new OperationDepartmentmatch();
		Missiontype type = (Missiontype)operationDao.getMissiontypeById

(Missiontype.class, operationdept.getType().getId());
		Department dept = (Department)operationDao.getDeptById

(Department.class, operationdept.getDept().getId());
		d.setType(type);
		d.setDept(dept);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		d.setCreatTime(sdf.format(date));
		d.setMoney(operationdept.getMoney());
		d.setExplain(operationdept.getExplain());
		operationDao.add(d);
		return "tolist";
	}
}

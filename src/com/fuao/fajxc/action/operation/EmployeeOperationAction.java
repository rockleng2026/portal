package com.fuao.fajxc.action.operation;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.dao.operation.OperationDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.utilinterface.PublicMissionType;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.OperationEmployeematch;
import com.opensymphony.xwork2.ActionSupport;

public class EmployeeOperationAction extends ActionSupport implements ServletRequestAware,ServletResponseAware{
	private HttpServletRequest request;
	private HttpServletResponse response;
	private OperationDao operationDao;
	private OperationEmployeematch operationemp;
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
		this.request = arg0;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}
	public OperationEmployeematch getOperationemp() {
		return operationemp;
	}
	public void setOperationemp(OperationEmployeematch operationemp) {
		this.operationemp = operationemp;
	}
	
	public String list(){
		
		String pageNo = request.getParameter("pageNo");
		if(null==pageNo){
			pageNo = "1";
		}
		
		String type = request.getParameter("type");
		String time = request.getParameter("time");
		String emp = request.getParameter("emp");
		System.out.println(type);
		System.out.println(emp);
		String hql = "from OperationEmployeematch where 1=1";
		if(type!=null && type.trim().length()>0 && !type.equals("-1")){
			hql += " and type.id="+type;
		}
		if(time!=null && time.trim().length()>0){
			hql += " and creatTime='"+time+"'";
		}
		if(emp!=null && emp.trim().length()>0 && !emp.equals("-1")){
			hql += " and employee.id="+emp;
		}
		hql += " order by id desc";
		System.out.println(hql);
		
		Pages pages= operationDao.paginationQuery(hql, Integer.parseInt(pageNo), 20, null);
		//得到所有员工
		String hql2 = "from Employee where isLeave=1 and delflag=0";
		List emplist = operationDao.getAllEmp(hql2);
		//得到所有类型
		String hql3 = "from Missiontype where superid=96";
		List typelist = operationDao.getAllMissiontype(hql3);
		request.setAttribute("pages", pages);
		request.setAttribute("list", pages.getPageList());
		request.setAttribute("type", typelist);
		request.setAttribute("emp", emplist);
		return "list";
	}
	
	public String addEmp(){
		int superid = PublicMissionType.operationtype;
		System.out.println(superid);
		//列出所有类型
		String hql = "from Missiontype where superid="+superid;
		List typelist = operationDao.getAllMissiontype(hql);
		//得到所有员工
		String hql2 = "from Employee where isLeave=1 and delflag=0";
		List emplist = operationDao.getAllEmp(hql2);
		request.setAttribute("type", typelist);
		request.setAttribute("emp", emplist);
		return "addEmp";
	}
	
	public String add(){
		OperationEmployeematch e = new OperationEmployeematch();
		System.out.println(operationemp.getEmployee().getId());
		System.out.println(operationemp.getType().getId());
		System.out.println(operationemp.getExplain());
		System.out.println(operationemp.getMoney());
		Missiontype type = (Missiontype)operationDao.getMissiontypeById(Missiontype.class, operationemp.getType().getId());
		Employee emp = (Employee)operationDao.getDeptById(Employee.class, operationemp.getEmployee().getId());
		e.setType(type);
		e.setEmployee(emp);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		e.setCreatTime(sdf.format(date));
		e.setMoney(operationemp.getMoney());
		e.setExplain(operationemp.getExplain());
		e.setTemp(-1);
		operationDao.add(e);
		return "tolist";
	}
}

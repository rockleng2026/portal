package com.fuao.fajxc.action.basic;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.DepotBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.paging.Page;
import com.fuao.fajxc.util.paging.Result;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 仓库信息
 * 
 * @author 14012
 * 
 */
public class DepotAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {

	private DepotBussiness depotBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Depot depot;
	//添加动态记录
	private ExecuteRecordBussiness executeRecordBussiness;

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	public Object getModel() {
		depot = new Depot();
		return depot;
	}

	/**
	 * 得到request
	 */
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;

	}

	/**
	 * 得到response
	 */
	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;

	}

	public DepotBussiness getDepotBussiness() {
		return depotBussiness;
	}

	public void setDepotBussiness(DepotBussiness depotBussiness) {
		this.depotBussiness = depotBussiness;
	}

	/**
	 * 查询仓库
	 * 
	 * @return
	 */
	public String select()throws Exception {
		String hql = "from Depot where del = 0 ";
		String dpage = request.getParameter("pageNo");
		int pageNo = 1;
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
		}
		String addhql="";
		String name = request.getParameter("cname");
		if (name != null && !name.equals("")) {
			hql += " and name like '%" + name + "%'";
		}
		if(null!=depot.getName())
		{
			addhql += " and name like '%"+URLDecoder.decode(depot.getName(),"UTF-8")+"%'";
		}
		if(null!=depot.getAddress())
		{
			addhql += " and address like '%"+URLDecoder.decode(depot.getAddress(),"UTF-8")+"%'";
		}
		if(null!=depot.getCapacity())
		{
			addhql += " and capacity like '%"+URLDecoder.decode(depot.getCapacity()+"","UTF-8")+"%'";
		}
		if(null!=depot.getTime())
		{
			addhql += " and time like '%"+URLDecoder.decode(depot.getTime(),"UTF-8")+"%'";
		}
		
//		if (dpage != null && !dpage.equals("")) {
//			pageNo = Integer.parseInt(dpage);
//			hql = request.getSession().getAttribute("hql").toString();
//		} else {
//			hql += " order by id desc";
//			request.getSession().setAttribute("hql", hql);
//		}
		hql =hql+addhql+ " order by id desc";
		Map map = (Map)ActionContext.getContext().get("map");
		Pages pages = depotBussiness.paginationQuery(hql, pageNo, 10, null);
		if(request.getParameter("tage")!=null&&request.getParameter("tage").equals("s"))
		{
			PropertyEditor property = new PropertyEditor();
			String strr="";
			String str="";
			if(null != pages.getPageList() && pages.getPageList().size()>0)
			{
				for(int i=0; i<pages.getPageList().size(); i++)
				{
					Depot dep = new Depot();
					dep =(Depot)pages.getPageList().get(i);
					 str=property.getID("selectdepot").toString();
				    str = str.replace("#name#", dep.getName());
					str = str.replace("#address#", dep.getAddress());
					str = str.replace("#capacity#", dep.getCapacity().toString());
					str = str.replace("#time#", dep.getTime());
					str = str.replace("#employee#", dep.getEmployee().getName());
					str = str.replace("#id#", dep.getId().toString());
					strr +=str;		
				}
				pages.setUrl("selecdepot.do");
				strr+="#"+pages.getHtml("selecdepot");
				
			}
			response.setCharacterEncoding("utf-8");
		    try {
				response.getWriter().print(strr);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		request.setAttribute("pages", pages);
		request.getSession().setAttribute("option", map);
		return "success";
	}

	/**
	 * 跳转到添加仓库页面
	 */
	public String addPage() {
		
		List empList = this.depotBussiness.getEmp();
		request.setAttribute("empList", empList);
		return "add";
	}

	/**
	 * 添加仓库
	 * @throws IOException 
	 */
	public String add() throws IOException {
		String empId = request.getParameter("admin");
		Employee emp = depotBussiness.getEmpOme(Integer.parseInt(empId));
		depot.setName(URLDecoder.decode(depot.getName(), "UTF-8"));
		depot.setAddress(URLDecoder.decode(depot.getAddress(), "UTF-8"));
		depot.setEmployee(emp);
		depot.setDel("0");
		Depot depot2 = depotBussiness.addReturnDepot(depot);
		if (depot2 != null) {
			response.getWriter().println(1);
			
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(loginEmp != null){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("添加了一个仓库。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(depot2.getId().toString());
				executerecord.setEntityName("Depot");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
			return null;
		}else
			response.getWriter().println(0);
		return null;
	}

	/**
	 * 根据ID查询到仓库信息 跳转到修改仓库页面
	 */
	public String updatePage() {

		String id = request.getParameter("id");
		// 根据页面传来的仓库ID查询到仓库实体
		Depot depot = (Depot) depotBussiness.getObj(Depot.class, Integer
				.parseInt(id));
		// 查询仓库管理员列表
		List empList = this.depotBussiness.getEmp();
		request.setAttribute("empList", empList);
		request.setAttribute("depot", depot);
		return "upDepot";

	}

	/**
	 * 修改仓库信息
	 */
	public String update() {

		Employee emp = depotBussiness.getEmpOme(Integer.parseInt(request
				.getParameter("admin")));
		depot.setEmployee(emp);
		boolean b = depotBussiness.updateDepot(depot);
		if (b) {
			response.setCharacterEncoding("GBK");
			
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(loginEmp != null){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("修改了一个仓库信息。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(depot.getId().toString());
				executerecord.setEntityName("Depot");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
			return "select";
		}
		return "error";
	}

	/**
	 * 仓库信息
	 */
	public String find() {

		String id = request.getParameter("id");
		// 根据页面传来的仓库ID查询到仓库实体
		Depot depot = (Depot) depotBussiness.getObj(Depot.class, Integer
				.parseInt(id));

		request.setAttribute("depot", depot);
		return "find";
	}

	/**
	 * 删除仓库信息
	 */
	public String del() {
		String id = request.getParameter("id");
		boolean b = depotBussiness.delDepot(Integer.parseInt(id));
		if (b) {
			try {
				response.getWriter().print(1);
				
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(loginEmp != null){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一个仓库信息。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(id);
					executerecord.setEntityName("Depot");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}

			} catch (IOException e) {

				e.printStackTrace();
			}

			return null;
		}
		return null;
	}

	/**
	 * 检查仓库名称是否存在
	 * @throws IOException 
	 */
	public void chenkname() throws IOException
	{
		String name = URLDecoder.decode(request.getParameter("name"),"utf-8");
		String hql = "and name ="+"'"+name+"'";
		List list = depotBussiness.someDepot(hql);
		if(list.size()>0)
		{
			response.getWriter().println(1);
		}
		else
			response.getWriter().println(0);
	}
}

/**
 * 
 */
package com.fuao.fajxc.action.system;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.dao.position.PositionDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.Workgrade;
import com.fuao.fajxc.vo.Workposition;
import com.fuao.fajxc.vo.pagefunction;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

/**
 * @author 蔡亚俊
 * 
 *         2011-7-14
 */
public class PositionSystemAction extends ActionSupport implements ServletRequestAware,ServletResponseAware  {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private PositionDao positiondao;
	private Workposition position;
	java.text.SimpleDateFormat dateFormat2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public PositionDao getPositiondao() {
		return positiondao;
	}

	public void setPositiondao(PositionDao positiondao) {
		this.positiondao = positiondao;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
		
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
		
	}
	
	public Workposition getPosition() {
		return position;
	}

	public void setPosition(Workposition position) {
		this.position = position;
	}

	/**
	 * 岗位列表
	 * 
	 * @return
	 */
	public String positionList() {
		// 根据菜单里面的 funid 得到这个菜单下面的功能
		Map map = (Map)ActionContext.getContext().get("map");
		//页码
		String pageNo=request.getParameter("pageNo");
		if(null == pageNo){
			pageNo ="1";
		}
		String hql="from Workposition";// 分成查询所有的岗位
		Pages pages= positiondao.paginationQuery(hql, Integer.parseInt(pageNo), 15, null);
		//List positionList = positiondao.getAllPositionList();
		System.out.println(ServletActionContext.getRequest()==null);
		if (pages.getPageList().size() > 0) {
			ServletActionContext.getRequest().getSession().setAttribute("positionList", pages.getPageList());
			ServletActionContext.getRequest().setAttribute("option", map);
			request.setAttribute("pages", pages);
			return "positionList";
		}
		return "failure";
	}

	/**
	 * 设置角色权限页面显示
	 * @return
	 */
	public String positionPermsionSet()
	{
		String positionid = request.getParameter("positionid");
		List<FunctionInfo> functionlist = positiondao.getAllFunctions();
		List<FunctionInfo> superfunctionlist = positiondao.getFunctionsBySuperId(0);
		Workposition position= positiondao.getObject(Integer.parseInt(positionid));
		
		System.out.println(" f:  "+position.getFunctionIDs()+"  P:  "+position.getPermissions());
		
		request.getSession().setAttribute("positionid",positionid);
		request.getSession().setAttribute("functionIds", position.getFunctionIDs());
		request.getSession().setAttribute("permissions", position.getPermissions());
		request.getSession().setAttribute("funcntionlist", functionlist);
		request.getSession().setAttribute("superfunctionlist", superfunctionlist);
		request.setAttribute("positiondao", positiondao);
		return "positionfunctionlist";
	}
	
	/**
	 * 给岗位设置权限
	 * @return
	 */
	public String positionQX()
	{
		System.out.println("~~~~~~~~~~~~~~~~         into setRolePermission          ~~~~~~~~~~~~~~~~~~");
		Integer positionid = Integer.parseInt(request.getParameter("positionid"));
		String functionIDs = request.getParameter("functionIDs");
		String permissions = request.getParameter("permissions");
		
		System.out.println("rid : "+positionid+"  f:  "+functionIDs+"   p:   "+permissions);
		
		Workposition position = positiondao.getObject(positionid);
		if(position.getId()>0)
		{
			position.setFunctionIDs(functionIDs);
			position.setPermissions(permissions);
		}
		int result=0;
		if(position!=null && position.getId()>0){
			// 修改
			result = positiondao.updatePosition(position);
		}else{
			// 添加
			result = positiondao.addPosition(position);
		}
		
		System.out.println("result : "+result);
		try 
		{
			if(result>0)
			{
				response.getOutputStream().print("1");
			}
			else
			{
				response.getOutputStream().print("0");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	/**********
	 * 进入到新增岗位页面
	 */
	public String addUI(){
		String flag=request.getParameter("flag");
		String positionid=request.getParameter("positionid");
		if(flag.equals("add")){
			position=null;
		}
		if(positionid!=null && positionid.trim().length()>0){
			position=positiondao.getObject(Integer.parseInt(positionid));
		}
		// 得到所有部门
		String hql="from Department where delflag=0";
		List deptlist=positiondao.execHQL(hql);
		// 得到部门权重类型
		//String gradehql="from Workgrade order by grade desc";
		//List gradelist=positiondao.execHQL(gradehql);
		request.setAttribute("deptlist", deptlist);
		//request.setAttribute("gradelist", gradelist);
		request.setAttribute("flag", flag);
		return "positionUI";
	}
	
	/*******
	 * 添加岗位
	 */
	public String add(){
		String flag=request.getParameter("flag");
		// 设置当前时间
		Date date=new Date();
		String now= dateFormat2.format(date);
		position.setEdittime(now);
		// 判断是添加还是修改
		if(flag!=null && flag.equals("add")){
			positiondao.addPosition(position);
		}else{
			positiondao.update(position);
		}
		return "add";
	}
	
	/**********
	 * 测试页面功能是否有用
	 */
	public String testPage(){
		
		Map map = (Map)ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);
		return "testpage";
	}
	


}

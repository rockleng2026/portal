package com.fuao.fajxc.action.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.system.FunctionInfoSystemBussiness;
import com.fuao.fajxc.bussiness.system.GroupSystemBussiness;
import com.fuao.fajxc.bussiness.system.RoleSystemBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Email;
import com.fuao.fajxc.util.MD5;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.Groups;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Roles;
import com.fuao.fajxc.vo.UserGroupInfo;
import com.fuao.fajxc.vo.Users;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
public class SystemAction implements ModelDriven,ServletRequestAware,ServletResponseAware{

	/**
	 * 日志记录
	 */
	private static Logger logger = Logger.getLogger(SystemAction.class);
	
	private FunctionInfoSystemBussiness functionInfoSystemBussiness;
	private GroupSystemBussiness groupSystemBussiness;
	private RoleSystemBussiness roleSystemBussiness ;
	private EmployeeBussiness empBussiness;
	private CustomerBussiness customerBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	/**
	 * 模块列表
	 * @return
	 */
	public String selectFunctions()
	{
		Map map = (Map)ActionContext.getContext().get("map");
		System.out.println("size : "+map.size());
		System.out.println("execute selectFunctions ........   ");
		List<FunctionInfo> superfunctionlist = functionInfoSystemBussiness.getFunctionsBySuperId(0);
		//
		if(superfunctionlist.size()>0)
		{
			
			request.getSession().setAttribute("superfunctionlist", superfunctionlist);
			ServletActionContext.getRequest().setAttribute("option", map);
			return "functions";
		}
		return "failure";
	}
	
	public String customerList()
	{
		String mark = request.getParameter("mark");
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String hql = " from Customer where del = 0";
		
		hql += " order by customerId desc";
		System.out.println("hql : "+hql);
		Pages pages = functionInfoSystemBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		request.setAttribute("showDiv", "kehu");
		return  "userlist";
	}
	
	/**
	 * 用户列表
	 * @return
	 */
	public String userList()
	{
		
		System.out.println("  execute  userList   .......  ");
		String mark = request.getParameter("mark");
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		List<UserGroupInfo> ugilist = groupSystemBussiness.getGroupInfoList();
		Map map = new HashMap();
		map.put("5.0", "★★★★★");
		map.put("4.5", "★★★★☆");
		map.put("4.0", "★★★★");
		map.put("3.5", "★★★☆");
		map.put("3.0", "★★★");
		map.put("2.5", "★★☆");
		map.put("2.0", "★★");
		map.put("1.5", "★☆");
		map.put("1.0", "★");
		map.put("0.5", "☆");
		
		List<Groups> groupinfolist = new ArrayList<Groups>();
		Map map1 = new HashMap();
		if(ugilist != null && ugilist.size()>0)
		{
			for(int i=0;i<ugilist.size();i++)
			{
				String[] array = ugilist.get(i).getGroupIds().split(",");
				String aaString = "";
				for(int k=0;k<array.length;k++)
				{
					Groups groups = groupSystemBussiness.getObjectByGroupId(Integer.parseInt(array[k]));
					aaString += groups.getGrade()+",";
				}
				String[] bbStrings = aaString.split(",");		//等级grade的数组
				double[] num = new double[100];
				boolean bool=false;
				for(int j=0;j<bbStrings.length;j++){
					String bb=bbStrings[j];
					if(bb.equals("null")){
						bool=true;
					}
				}
				if(bool==false){
					for(int q=0;q<bbStrings.length;q++)				//转换数组类型
					{
						num[q] = Double.parseDouble(bbStrings[q]);
					}
					double temp=num[0]; 
					
					//获取最大值
			        for(int h=1;h<num.length-1;h++)
			        {    
			        	if(num[h]>temp)
			        	{
			        		temp=num[h];	
			        	}
			        } 
					map1.put(ugilist.get(i).getUsers().getUserId(), temp);		//保存那个用户的最大等级
				}
			}
		}
		if(mark.equals("employee"))
		{
			List<Employee> list = (List<Employee>)groupSystemBussiness.getObject("Employee", " and id in (select customerOrEmployeeId from Users where mark='employee')");
			request.setAttribute("emplist", list);
		}
		
		List<Users> userList = functionInfoSystemBussiness.getUserList(mark);
		String hql = " from Users where mark = '"+mark+"'";
		
		hql += " order by userId desc";
		System.out.println("hql : "+hql);
		Pages pages = functionInfoSystemBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		ServletActionContext.getContext().getSession().put("userlist", userList);
		this.request.getSession().setAttribute("ugilist", map1);
		this.request.getSession().setAttribute("map", map);
		if(mark.equals("employee"))
		{
			return "emplist";
		}
		return "userlist";	
	}
	
	/**
	 * 模块菜单功能列表
	 * @return
	 */
	public String functionlist()
	{
		Integer userid = Integer.parseInt(request.getParameter("userid"));
		List<FunctionInfo> functionlist = functionInfoSystemBussiness.getAllFunctions();
		List<FunctionInfo> superfunctionlist = functionInfoSystemBussiness.getFunctionsBySuperId(0);
		Users user = functionInfoSystemBussiness.isExistsUsersByUserId(userid);
		//
		String functionids = "";
		String permissions = "";
		boolean flag = functionInfoSystemBussiness.isPermissionByUserId(userid);
		if(functionlist.size()>0&&superfunctionlist.size()>0)
		{
			if(flag)
			{
				RoleFunctionInfo rff = functionInfoSystemBussiness.isExistsPermissionByUserId(userid);
				functionids = rff.getFunctionIds();
				permissions = rff.getPermissions();

			}
			else 
			{
				Roles roles = roleSystemBussiness.getObject(user.getRoles().getRoleId());
				functionids = roles.getFunctionIds();
				permissions = roles.getPermissions();
			}
			
			request.getSession().setAttribute("functionIds", functionids);
			request.getSession().setAttribute("permissions", permissions);
			request.getSession().setAttribute("userId", userid );
			request.getSession().setAttribute("user", user);
			request.getSession().setAttribute("funcntionlist", functionlist);
			request.getSession().setAttribute("superfunctionlist", superfunctionlist);
			return "functionlist";
		}
		return "failure";
	}
	
	/**
	 * 设置权限
	 * @return
	 */
	public String setPermission()
	{
		System.out.println("execute setPermission ......");
		Integer userid = Integer.parseInt(request.getParameter("userid"));
		String functionIDs = request.getParameter("functionIDs");
		String permissions = request.getParameter("permissions");
		
		Users user = functionInfoSystemBussiness.isExistsUsersByUserId(userid);
		boolean flag = functionInfoSystemBussiness.isPermissionByUserId(userid);
		int result = 0;
		
		if(flag)		//	修改权限
		{
			RoleFunctionInfo rInfo = functionInfoSystemBussiness.isExistsPermissionByUserId(userid);
			rInfo.setFunctionIds(functionIDs);
			rInfo.setPermissions(permissions);
			result = functionInfoSystemBussiness.setPermission(rInfo);
		}
		else			//添加权限
		{
			RoleFunctionInfo rff = new RoleFunctionInfo();
			rff.setUsers(user);
			rff.setFunctionIds(functionIDs);
			rff.setPermissions(permissions);
			result = functionInfoSystemBussiness.setPermission(rff);
		}
		
				
		try {
			if(userid>0&&functionIDs!=null&&permissions!=null)
			{
				System.out.println("result = "+result);
				if(result>0)
				{
					this.response.getWriter().print(result);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			return "failure";
		}
		return null;
	}
	
	/**
	 * 修改状态
	 * @return
	 */
	public String functionStatus()
	{
		System.out.println("execute functionStatus ....  ");
		Integer userid = Integer.parseInt(request.getParameter("userid"));
		Integer status = Integer.parseInt(request.getParameter("state"));
		Users user = functionInfoSystemBussiness.isExistsUsersByUserId(userid);
		
		if(status==1)
		{
			user.setStatus(0);
		}
		if(status==0)
		{
			user.setStatus(1);
		}
		
		try {
			int result = functionInfoSystemBussiness.saveOrUpdateUsers(user);

			if(result!=status)
			{
				this.response.getWriter().print(result);
			}
		} catch (Exception e) {
			// TODO: handle exception
			return "failure";
		}
		return null;
	}
	
	/**
	 * 修改密码 --跳转
	 * @return
	 */
	public String editPass()
	{
		System.out.println("execute editpass  ....  ... ");
		Cookies cookies = new Cookies();
		String loginname = cookies.getCookie(request, "loginName");
		String password = cookies.getCookie(request, "password");
		
		Users users = functionInfoSystemBussiness.getObject(loginname, password);
		if(users.getUserId()>0)
		{
			request.setAttribute("user", users);
		}
		return "edit";
	}

	/**
	 * 修改密码
	 * @return
	 */
	public String editPassword()
	{
		Integer uid = Integer.parseInt(request.getParameter("uid"));
		String password = request.getParameter("password");
		
		Users user = functionInfoSystemBussiness.isExistsUsersByUserId(uid);
		int result = 0;
		if(user.getUserId()>0)
		{
			user.setPassword(password);
			result = functionInfoSystemBussiness.saveOrUpdateUsers(user);
		}
		try 
		{
			if(result>0)
			{
				Cookies cookies = new Cookies();
				cookies.putCookie(response, "password", password);
				response.getOutputStream().print("<center></center>");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	
	//页面跳转
	public String pageSkip()
	{
		Integer userid = Integer.parseInt(request.getParameter("userid"));
		List<Roles> rolelist = roleSystemBussiness.getRolesList();
		List<Groups> groupslist = groupSystemBussiness.getObject("Groups", " and permissionGrade = 0 and grade = 0");
		List<Employee> emplist =  empBussiness.selEmps(" and isloginaccount = 0 and isLeave = 1 and delflag = 0");
		
		System.out.println("aa***********  "+emplist.size());
		Map map = new HashMap();
		map.put("employee", "员工");
		if(rolelist.size()>0&&userid==0)			//添加页面跳转
		{
			List<FunctionInfo> infolist = groupSystemBussiness.getObject("FunctionInfo", " and linkFunctionName like '%列表%'");	
			request.setAttribute("grouplist", groupslist);
			request.setAttribute("emplist", emplist);
			request.setAttribute("rolelist", rolelist);
			request.setAttribute("map", map);
			request.setAttribute("infolist", infolist);
			return "addorupdateuser";
		}
		if(rolelist.size()>0&&userid>0)				//修改页面跳转
		{
			Users user = functionInfoSystemBussiness.isExistsUsersByUserId(userid);
			if(user.getMark().equals("employee"))
			{
				Employee employee = empBussiness.oneEmp(user.getCustomerOrEmployeeId());
				request.setAttribute("object", employee.getName());
				request.setAttribute("objectid", employee.getId());
			}
			request.setAttribute("userskip", user);
			request.setAttribute("rolelist", rolelist);
			request.setAttribute("map", map);
			return "addorupdateuser";
		}
		return null;
	}
	/**
	 * 
	 * 根据用户名查询用户工号作为登录名
	 * @throws IOException 
	 */
	public void loginName() throws IOException
	{
		response.setContentType("text/html");
		String userId=request.getParameter("userId");
		Employee employee = (Employee)empBussiness.selEmps(" and id = "+userId+"").get(0);
		if(employee!=null)
		{
			System.out.println(employee.getEmpNo());
			response.getWriter().print(employee.getEmpNo());
		}
		return ;
	}
	
	/**
	 * 加密
	 * @param loginName		要加密字符串
	 * @param password      加密的密钥
	 * @return
	 */
	public String jiami(String loginName,String password)
	{
		String oldString = loginName;
		String SPKEY = password;
		System.out.println(oldString+"   dddd   "+SPKEY);
		MD5 md5 = new MD5();
		String reValue = md5.get3DESEncrypt(oldString, SPKEY);
		reValue = reValue.trim().intern();
		System.out.println("进行3-DES加密后的内容: " + reValue);
		String reValue2 = md5.get3DESDecrypt(reValue, password);
		System.out.println("进行3-DES解密后的内容: " + reValue2);
		return reValue;
	}
	
	/**
	 * 添加或修改用户
	 * @return
	 */
	public String addOrUpdateUser()
	{
		System.out.println(" ~~~~~~~~~~~~~~  into users  ~~~~~~~~~~~~~~~~~~~");
		try 
		{
			Integer userid = Integer.parseInt(request.getParameter("userid"));
			String loginName = URLDecoder.decode(request.getParameter("loginName"),"utf-8");
			String password = request.getParameter("password");
			String userName = URLDecoder.decode(request.getParameter("userName"),"utf-8");
			String roleId = request.getParameter("roleId");
			String mark = request.getParameter("mark");
			String grouplistname = request.getParameter("grouplistname");
			String groupPermission = request.getParameter("groupPermission");
			String resourcePermission = request.getParameter("resourcePermission");
			
			String jiamiloginName = jiami(loginName,"");	//加密loginname
			String jiamipassword = jiami(password,loginName); //加密password
			
			Employee employee = null;
			Roles r = (Roles)roleSystemBussiness.getObject(Integer.parseInt(roleId));
			int result = 0;			
			if(mark.equals("employee")||mark.equals("customer"))
			{
				if(userid==0)			//添加用户
				{
					if(mark.equals("employee"))		//判断用户类型，类型为employee
					{
						employee = (Employee)empBussiness.selEmps(" and id = '"+userName+"'").get(0);
						if(employee.getId()>0)
						{
							Users user = new Users();
							user.setLoginName(loginName);
							user.setPassword(password);
							user.setMark(mark);
							user.setRoles(r);
							user.setStartTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
							user.setLoginTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
							user.setLastLoginTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
							user.setCounts(0);
							user.setIpPart(this.getIpAddr(request));
							user.setLastIpPart(this.getIpAddr(request));
							user.setStatus(1);
							user.setDelflag("0");
							user.setCustomerOrEmployeeId(employee.getId());
							user.setUserName(employee.getName());
							result = functionInfoSystemBussiness.saveOrUpdateUsers(user);
						}
						
						employee.setIsLoginAccount(1);
						boolean flag = empBussiness.updateEmp(employee,request);	//修改员工表，isloginAccount状态
						System.out.println("flag : "+flag);
					
					}
										
					Users users = functionInfoSystemBussiness.getObject(loginName, password);
					UserGroupInfo ugi = new UserGroupInfo();
					ugi.setUsers(users);
					ugi.setSupergroupIds(grouplistname);
					ugi.setGroupIds(groupPermission);
					ugi.setResourcePermission(resourcePermission);
					int resultpermission  = groupSystemBussiness.saveOrUpdateGroup(ugi);	//添加用户等级权限
				}
				if(userid>0)		//修改用户
				{
					Users user = functionInfoSystemBussiness.isExistsUsersByUserId(userid);
					System.out.println(user.getRoles().getRoleId()+"   "+r.getRoleId());
					if(user.getRoles().getRoleId()!=r.getRoleId())    //修改用户时，，修改角色时，如若id不相等，删除UserGroupInfo表中对象
					{
						List<RoleFunctionInfo> info = this.groupSystemBussiness.getObject("RoleFunctionInfo", " and users.userId = "+userid);
						if(info.size()>0)
						{
							roleSystemBussiness.deleteRoleFunctionInfo(info.get(0));
						}
					}
					user.setLoginName(loginName);
					user.setPassword(password);
					user.setUserName(userName);
					user.setRoles(r);
					
					result = functionInfoSystemBussiness.saveOrUpdateUsers(user)+1;
				}
			}
			else
			{
				response.getOutputStream().print("0");
			}
			
			if(result == 1)
			{
				response.getOutputStream().print(result);
			}
			if(result == 2)
			{
				response.getOutputStream().print(result);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
	/**
	 * 删除用户
	 * @return
	 */
	public String delUser()
	{
		Integer uid = Integer.parseInt(request.getParameter("uid"));
		List<UserGroupInfo> info = this.groupSystemBussiness.getObject("UserGroupInfo", " and users.userId = "+uid);
		List<RoleFunctionInfo> roleinfo = this.groupSystemBussiness.getObject("RoleFunctionInfo", " and users.userId = "+uid);
		int result = 0;
		if(info.size()>0)
		{
			boolean flag = groupSystemBussiness.deleteGroupUserInfo(info.get(0));
		}
		if(roleinfo.size()>0)
		{
			boolean flag1 = roleSystemBussiness.deleteRoleFunctionInfo(roleinfo.get(0));
		}
		Users user = functionInfoSystemBussiness.isExistsUsersByUserId(uid);
		result= functionInfoSystemBussiness.delUsers(user);
		try {
			if(result==1)
			{
				//12.01增加 删除账号时同时修改员工表员工登录状态为没有登录账户
				List  emplist = this.groupSystemBussiness.getObject("Employee", " and empNo =  '"+user.getLoginName()+"'");
				if(emplist.size()>0)
				{
					Employee emp = (Employee)emplist.get(0);
					emp.setIsLoginAccount(0);
					empBussiness.updateEmp(emp, request);
				}
				response.getOutputStream().print(result);
			}
			else
			{
				response.getOutputStream().print(0);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return null;
	}
	
	/**
	 * 根据用户用户类型，获得相应对象列表
	 * @return
	 */
	public String selectEmpOrCust()
	{
		response.setContentType("text/html;charset=GBK");
		String usertype = request.getParameter("usertype");
		String str = "";
		
		if(usertype.equals("employee"))
		{
			List<Employee> employees = empBussiness.selEmps(" and isloginaccount = 0");
			if(employees.size()>0)
			{
				for(int i=0;i<employees.size();i++)
				{
					str += "<option value='"+employees.get(i).getId()+"'>"+employees.get(i).getName()+"</option>";
				}
			}
		}
		if(usertype.equals("customer"))
		{
			List<Customer> customers = customerBussiness.exHql("from Customer where del != 1 and isloginaccount != 1");
			if(customers.size()>0)
			{
				for(int i=0;i<customers.size();i++)
				{
					str += "<option value='"+customers.get(i).getCustomerId()+"'>"+customers.get(i).getCustomerName()+"</option>";
				}
			}
		}
		PrintWriter pw = null;
		try 
		{
			pw = response.getWriter();
			
			if(str.length()>0)
			{
				pw.print(str);
			}
			else
			{
				pw.print("<option value='-1'>没有该类型用户集合</option>");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 组权限列表
	 * @return
	 */
	public String selectGroupPermission()
	{
		response.setContentType("text/html;charset=GBK");
		String groupid = request.getParameter("groupid");
		String str = "<option value=''>---请选择---</option>";
		if(groupid!=null&&!groupid.equals(""))
		{
			List<Groups> grouplist = groupSystemBussiness.getObject("Groups", "and permissionGrade<>0 and grade<>0  and superGroupId = "+groupid);
			for(int i=0;i<grouplist.size();i++)
			{
				str += "<option value='"+grouplist.get(i).getGroupId()+"'>"+grouplist.get(i).getGroupName()+"</option>";
			}
		}
		
		System.out.println("str: "+str);
		try 
		{
			PrintWriter pw = response.getWriter();
			if(str.length()>35)
			{
				pw.print(str);
			}
			else
			{
				pw.print("<option value=''>该组没有成员集合</option>");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return null;
	}
	
	public String openaccount()
	{
		String id = request.getParameter("id");
		String loginName = request.getParameter("loginName");
		String repassword = request.getParameter("repassword");
		List<Customer> customerlist = groupSystemBussiness.getObject("Customer", " and customerId = "+id);
		boolean flag = false;
		if(customerlist.size()>0)
		{
			Customer c = customerlist.get(0);
			c.setCustomerName(loginName);
			c.setCustomerPassword(repassword);
			c.setIsLoginAccount(1);
			flag = customerBussiness.updateData(c);
			if(flag)
			{
				String uri = request.getContextPath();
				String object = request.getRequestURL().substring(0, request.getRequestURL().indexOf(uri));
				System.out.println(uri+"   uri==   "+object);
				String url = object+"/"+uri+"/customService/customProscenium/login.jsp";
				System.out.println("url : "+url);
				String msg  =  "亲爱的"+c.getRealName()+": <br/><br/>欢迎加入福奥科技！<br/><br/>请点击下面的链接登录连接：<br/><br/><A href= "+url+">"+url+"</A>" +
						"<br/><br/>福奥科技人员已经为您开通登录客户系统的账户和密码：<br/>账户："+c.getCustomerName()+"<br/>密码："+c.getCustomerPassword()+"---福奥科技<br/><br/>（这是一封自动产生的email，请勿回复。） ";
				Email sendemail = new Email();
				sendemail.sendEmail(c.getEmail(), "福奥科技客服系统开通登录账户", msg);
			}
		}
		try
		{
			if(flag)
			{
				response.getOutputStream().print("1");
			}
			else
			{
				response.getOutputStream().print("0");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 系统退出
	 * @return
	 */
	public String safetyExit()
	{
		response.setHeader("Pragma","No-cache"); 
		response.setHeader("Cache-Control","no-cache"); 
		response.setDateHeader("Expires", 0); 
		
		request.getSession().invalidate();
		System.out.println("aaaaaaaaaaaa");
		Cookies cook = new Cookies();
		cook.putCookie(response, "loginName", "");
		cook.putCookie(response, "password", "");
		return "safetyexit";
	}
	
	/**
	 * 获取客户端真实IP地址
	 * @param request
	 * @return
	 */
	public String getIpAddr(HttpServletRequest request) {   
	       String ip = request.getHeader("x-forwarded-for");   
	       System.out.println("ip1 = "+ip);
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	           ip = request.getHeader("Proxy-Client-IP");   
	           System.out.println("ip2 = "+ip);
	       }   
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	           ip = request.getHeader("WL-Proxy-Client-IP");
	           System.out.println("ip3 = "+ip);
	       }   
	       if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	           ip = request.getRemoteAddr();
	           System.out.println("ip4 = "+ip);
	       }   
	       return ip;   
	   } 
	
	public void setFunctionInfoSystemBussiness(
			FunctionInfoSystemBussiness functionInfoSystemBussiness) {
		this.functionInfoSystemBussiness = functionInfoSystemBussiness;
	}
	public void setGroupSystemBussiness(GroupSystemBussiness groupSystemBussiness) {
		this.groupSystemBussiness = groupSystemBussiness;
	}
	
	public void setRoleSystemBussiness(RoleSystemBussiness roleSystemBussiness) {
		this.roleSystemBussiness = roleSystemBussiness;
	}

	public void setEmpBussiness(EmployeeBussiness empBussiness) {
		this.empBussiness = empBussiness;
	}
	public void setCustomerBussiness(CustomerBussiness customerBussiness) {
		this.customerBussiness = customerBussiness;
	}

	/* (non-Javadoc)
	 * @see com.opensymphony.xwork2.ModelDriven#getModel()
	 */
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see org.apache.struts2.interceptor.ServletRequestAware#setServletRequest(javax.servlet.http.HttpServletRequest)
	 */
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request = request;
	}
	/* (non-Javadoc)
	 * @see org.apache.struts2.interceptor.ServletResponseAware#setServletResponse(javax.servlet.http.HttpServletResponse)
	 */
	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response = response;
	}
	
	public static void main(String args[])
	{
		System.out.println(System.currentTimeMillis());
		System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
//		String oldString = "蔡亚俊";
//		String SPKEY = "123456";
//		System.out.println(oldString+"   dddd   "+SPKEY);
//		MD5 md5 = new MD5();
//		String reValue = md5.get3DESEncrypt(oldString, "");
//		reValue = reValue.trim().intern();
//		System.out.println("进行3-DES加密后的内容: " + reValue);
//		String reValue2 = md5.get3DESDecrypt(reValue, "");
//		System.out.println("进行3-DES解密后的内容: " + reValue2);
//		
//		String reValue11 = md5.get3DESEncrypt(SPKEY, oldString);
//		reValue11 = reValue11.trim().intern();
//		System.out.println("进行3-DES加密后的内容: " + reValue11);
//		String reValue4 = md5.get3DESDecrypt(reValue11, oldString);
//		System.out.println("进行3-DES解密后的内容: " + reValue4);
	}

}

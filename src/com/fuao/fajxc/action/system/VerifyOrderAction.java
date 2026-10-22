package com.fuao.fajxc.action.system;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.system.VerifyOrderBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Docmark;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.VerifyOrder;
import com.fuao.fajxc.vo.VerifyOrderDepartment;
import com.fuao.fajxc.vo.VerifyOrderEmployee;
import com.opensymphony.xwork2.ModelDriven;

public class VerifyOrderAction implements ModelDriven,ServletRequestAware,ServletResponseAware{
    private static Logger  logger  = Logger.getLogger(VerifyOrder.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private VerifyOrderBussiness verifyOrderBusiness;
	private VerifyOrder verifyorder ;
	public int count = 0;
	public String skippage()
	{	
		String mark = request.getParameter("mark")==null?"":request.getParameter("mark");
		String vid = request.getParameter("vid")==null?"":request.getParameter("vid");
		List<Department> departlist = verifyOrderBusiness.getObject("Department", " and delflag = 0");
		request.setAttribute("departlist", departlist);
		
		if(mark.equals("edit")||mark.equals("find"))
		{
			VerifyOrder verifyOrder = (VerifyOrder)verifyOrderBusiness.getObject("VerifyOrder", " and id = "+vid).get(0);
			List<VerifyOrderEmployee> verifyOrderEmployee = verifyOrderBusiness.getObject("VerifyOrderEmployee", " and verifyOrderId = "+vid+" order by remark");
			Map map = new HashMap();
			for(int i=0;i<verifyOrderEmployee.size();i++)
			{
				String empString = "";
				List<Employee> employees = null;
				System.out.println(verifyOrderEmployee.get(i).getEmployees());
				if(null != verifyOrderEmployee.get(i).getEmployees() && (verifyOrderEmployee.get(i).getEmployees()!= "" && !verifyOrderEmployee.get(i).getEmployees().equals("")) &&
						(verifyOrderEmployee.get(i).getEmployees() != "[]" && !verifyOrderEmployee.get(i).getEmployees().equals("[]"))){
				 empString = verifyOrderEmployee.get(i).getEmployees().substring(0,verifyOrderEmployee.get(i).getEmployees().length()-1);
				 employees = verifyOrderBusiness.getObject("Employee", " and id in ("+empString+")");
				}
				employees = verifyOrderBusiness.getObject("Employee", " and id in ("+empString+")");
				map.put(verifyOrderEmployee.get(i).getDepartment().getId(), employees);
			}
			request.setAttribute("verifyOrder", verifyOrder);
			request.setAttribute("veriorderemployeelist", verifyOrderEmployee);
			request.setAttribute("veriorderemployeemap", map);
			
		}
		
		// 绑定得到所有部门
		String hql="from Department where delflag=0";
		List deptlist=verifyOrderBusiness.exHql(hql);
		request.setAttribute("deptlist", deptlist);
		
		List<Docmark> doclist=verifyOrderBusiness.getObject("Docmark", "");
		System.out.println("doclist:::::"+doclist);
		if(doclist.size()>0){
			request.setAttribute("doclist", doclist);
		}
		
		if(mark.equals("find"))
		{
			return "selectverifyorder";
		}else if(mark.equals("edit")){
			return "editverityorder";
		}else{
			return "success";
		}
	}

	
	public String add()
	{
		System.out.println(11111111);
		try 
		{
			String remark = verifyorder.getOrdertype().getAname();
			String emps = request.getParameter("emps");
			
			Docmark docmark=null;
			if(remark!=null){
				docmark=(Docmark)verifyOrderBusiness.getObject("Docmark", " and mark='"+remark+"'").get(0);
			}
			System.out.println("aname::::::::::"+docmark.getAname());
			verifyorder.getOrdertype().setAname(docmark.getAname());
			boolean flag = verifyOrderBusiness.addVerifyOrder(verifyorder);		//添加审核流程
			
			VerifyOrder verify = (VerifyOrder)verifyOrderBusiness.getObject("VerifyOrder", " and ordertype = '"+verifyorder.getOrdertype()+"' and departments = '"+verifyorder.getDepartments()+"'").get(0);
			String emp = emps.substring(0,emps.length()-1);
			String depart = verifyorder.getDepartments().substring(0,verifyorder.getDepartments().length()-1);
			String[] departmentsplit = depart.split(",");
			List<Department> dlist = new ArrayList<Department>();
			for(int i=0;i<departmentsplit.length;i++)
			{
				Department department = (Department)verifyOrderBusiness.getObject("Department", " and id in ("+departmentsplit[i]+")").get(0);
				dlist.add(department);				//为部门进行排序
			}
			List<Employee> empList = verifyOrderBusiness.getObject("Employee", " and id in ("+emp+")");
			
			//添加审核流程员工
			for(int i=0;i<dlist.size();i++)
			{
				String empString  = "";
				for(int j=0;j<empList.size();j++)
				{
					if(empList.get(j).getDepartment().getId()==dlist.get(i).getId())
					{
						empString += empList.get(j).getId()+",";
					}
				}
				
				VerifyOrderEmployee employee = new VerifyOrderEmployee();
				employee.setDepartment(dlist.get(i));
				employee.setVerifyOrder(verify);
				employee.setEmployees(empString);
				employee.setRemark("");
				
				boolean flag1 = verifyOrderBusiness.addVerifyOrderEmployee(employee);
			}
			
			if(flag)
			{
				response.getOutputStream().print("1");
			}
			else
			{
				response.getOutputStream().print("0");
			}
		} catch (Exception e) {
			e.printStackTrace();
			e.printStackTrace();
		}
		return null;
	}
	
	public String edit()
	{
		try 
		{
			String emps = request.getParameter("emps");
			String remark = verifyorder.getOrdertype().getAname();
			Docmark docmark=null;
			if(remark!=null){
				docmark=(Docmark)verifyOrderBusiness.getObject("Docmark", " and mark='"+remark+"'").get(0);
			}
			verifyorder.getOrdertype().setAname(docmark.getAname());
			
			//根据审核流程Id，删除VerifyOrderEmployee审核流程员工所有的数据
			VerifyOrder order = (VerifyOrder)verifyOrderBusiness.getObject("VerifyOrder", " and id = "+verifyorder.getId()).get(0);
			
			String[] departsplit = order.getDepartments().split(",");
			boolean flagDelEmp = true;
			for(int i=0;i<departsplit.length;i++)
			{
				List<VerifyOrderEmployee> list = new ArrayList();
				if(null != departsplit[i] && departsplit[i] != "" && !departsplit[i].equals("")){
				  list = verifyOrderBusiness.getObject("VerifyOrderEmployee", " and verifyOrder.id = "+verifyorder.getId()+" and department.id = "+departsplit[i]);
				}
				  if(list.size()>0)
				{
					VerifyOrderEmployee employee = list.get(0);
					flagDelEmp = verifyOrderBusiness.delVerifyOrderEmployee(employee);
				}
			}
			
			//根据审核流程Id ，修改审核流程
			VerifyOrder object = (VerifyOrder)verifyOrderBusiness.getObject("VerifyOrder", " and id = "+verifyorder.getId()).get(0);
			object.setDepartments(verifyorder.getDepartments());
			object.setOrdertype(verifyorder.getOrdertype());
			object.getOrdertype().setAname(verifyorder.getOrdertype().getAname());
			boolean flag = verifyOrderBusiness.editVerifyOrder(object);
			
			//根据审核流程id，重新添加审核流程的员工
			boolean flagEmp = false;
			if(flag)
			{
				if(flagDelEmp)
				{
					VerifyOrder editverifyorder = (VerifyOrder)verifyOrderBusiness.getObject("VerifyOrder", " and id = "+verifyorder.getId()).get(0);
					
					String emp = emps.substring(0,emps.length()-1);
					String depart = editverifyorder.getDepartments().substring(0,editverifyorder.getDepartments().length()-1);
					String[] departmentsplit = depart.split(",");
					List<Department> dlist = new ArrayList<Department>();
					for(int i=0;i<departmentsplit.length;i++)
					{
						Department department = (Department)verifyOrderBusiness.getObject("Department", " and id in ("+departmentsplit[i]+")").get(0);
						dlist.add(department);				//为部门进行排序
					}
					List<Employee> empList = verifyOrderBusiness.getObject("Employee", " and id in ("+emp+")");
					
					for(int i=0;i<dlist.size();i++)
					{
						String empString  = "";
						for(int j=0;j<empList.size();j++)
						{
							if(empList.get(j).getDepartment().getId()==dlist.get(i).getId())
							{
								empString += empList.get(j).getId()+",";
							}
						}
						
						VerifyOrderEmployee employee = new VerifyOrderEmployee();
					employee.setDepartment(dlist.get(i));
						employee.setVerifyOrder(editverifyorder);
						employee.setEmployees(empString);
						employee.setRemark((i+1)+"");
						
						flagEmp = verifyOrderBusiness.addVerifyOrderEmployee(employee);		//添加某个部门的审核员工人员
					}
				}
			}
			System.out.println("flagEmp : "+flagEmp);
			if(flagEmp)
			{
				response.getOutputStream().print("1");
			}
			else
			{
				response.getOutputStream().print("0");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String delete1()
	{
		String id=request.getParameter("id");
//		boolean flagDelEmp = false;
//		boolean flag = false;
//		//根据审核流程Id，先删除审核流程员工
//		List<VerifyOrderEmployee> employees = verifyOrderBusiness.getObject("VerifyOrderEmployee", " and verifyOrder.id = "+verifyorder.getId());
//		for(int i=0;i<employees.size();i++)
//		{
//			flagDelEmp = verifyOrderBusiness.delVerifyOrderEmployee(employees.get(i));
//		}
//		//根据审核流程Id， 删除审核流程
//		if(flagDelEmp || employees.size()==0)
//		{
//			VerifyOrder order = (VerifyOrder)verifyOrderBusiness.getObject("VerifyOrder", " and id = "+verifyorder.getId()).get(0);
//			flag = verifyOrderBusiness.delVerifyOrder(order);
//		}
//		
//		try 
//		{
//			if(flag)
//			{
//				response.getOutputStream().print("1");
//			}
//			else
//			{
//				response.getOutputStream().print("0");
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		return null;
	}
	

	public String checkordertype() throws IOException
	{

		String ot=request.getParameter("ot");//订单类型 eg. XSDD
		logger.debug("ot:"+ot);
		List<Docmark> dt = verifyOrderBusiness.getObject("Docmark", " and mark = '"+ot+"'");
		int otid = ((Docmark)dt.get(0)).getId();
		List<VerifyOrder> orders=verifyOrderBusiness.getObject("VerifyOrder", " and ordertype.id = "+otid);
		int result = orders.size();
		logger.debug("r : "+result);
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
			e.printStackTrace();
		}

		return null;
	}
	
	/**
	 * 添加审核流程	
	 * @return
	 */
	public String addDepartment()
	{
		String mark=request.getParameter("mark");
		response.setContentType("text/html;charset=GBK");
		List<Department> departlist = verifyOrderBusiness.getObject("Department", " and delflag = 0");
		String str = "";
		if(departlist.size()>0)
		{
			count = count +1;
			str += "<TR id='addTr"+count+"'><TD width='304px' height=30 align=right>部       门：</TD>	<TD width='410px' class=category >";
			if(mark.equals("0"))
			{
			str += "<select id='department"+count+"' name='department"+count+"'  onchange='selectEmp(this.value,"+count+")'> ";
			}else
			{
				str += "<select id='department"+count+"' name='department"+count+"'  onchange='selectEmp1(this.value,"+count+")'> ";
			}
			str += "<option value=''>请选择</option>";
			for(int i=0;i<departlist.size();i++)
			{
				str += "<option value='"+departlist.get(i).getId()+"'>"+departlist.get(i).getName()+"</option>";
			}
		}
		
		str += "</select>&nbsp;	<FONT color=#ff0000 id='department"+count+"Msg'>*</FONT></TD><TD width='320px' id='employee"+count+"' name='employee"+count+"' class=category>" +
				"</TD><td width='100px' class=category><input id='' name='' type='button' value='删除' onclick='deltr(\"addTr\",\""+count+"\")' /></td></TR>";
		try 
		{
			PrintWriter pw = response.getWriter();
			if(str.length()>0)
			{
				pw.print(str);
			}
			else
			{
				pw.print("");
			}
		} catch (Exception e) {
		}
		return null;
	}
	
	public String selectEmp()
	{
		response.setContentType("text/html;charset=GBK");
		String departId = request.getParameter("departId");
		String mark = request.getParameter("mark");
		
		String count = request.getParameter("count");
		List<Employee> emplist = verifyOrderBusiness.getObject("Employee", " and delflag = 0 and department.id = "+departId);
		String str = "";
		String str1="";
		if(emplist.size()>0)
		{
			
			for(int i=0;i<emplist.size();i++)
			{	
				String departmentId= emplist.get(i).getDepartment().getId().toString();
				str+="<input id='del"+count+"' name='' type='hidden' value='"+departmentId+"'/>";
				String a=emplist.get(i).getName();
				if(emplist.get(i).getDepartment().getEmployee() != null)
				{	if(mark.equals("0"))
				{
					//System.out.println("d:e:idsssss   "+emplist.get(i).getDepartment().getEmployee().getId());
					if(emplist.get(i).getId()==emplist.get(i).getDepartment().getEmployee().getId())		//如果是该部门主管默认选中
					{logger.debug("d:e:id   "+emplist.get(i).getDepartment().getEmployee().getId());
						str += " <input checked='checked' onclick='oc("+emplist.get(i).getId()+","+emplist.get(i).getDepartment().getId()+","+count+")' type='checkbox' id='"+emplist.get(i).getId()+"' name='"+emplist.get(i).getDepartment().getId()+"' value='"+emplist.get(i).getId()+"' style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px' />"+emplist.get(i).getName();
						str1+=emplist.get(i).getId()+","+emplist.get(i).getDepartment().getId()+","+count;
					}
					else
					{
						str += " <input type='checkbox' onclick='oc("+emplist.get(i).getId()+","+emplist.get(i).getDepartment().getId()+","+count+")' id='"+emplist.get(i).getId()+"' name='"+emplist.get(i).getDepartment().getId()+"' value='"+emplist.get(i).getId()+"' style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px' />"+emplist.get(i).getName();
					}
				}
				else
				{
					str += " <input type='checkbox' onclick='oc("+emplist.get(i).getId()+","+emplist.get(i).getDepartment().getId()+","+count+")' id='"+emplist.get(i).getId()+"' name='"+emplist.get(i).getDepartment().getId()+"' value='"+emplist.get(i).getId()+"' style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px' />"+emplist.get(i).getName();
				}
				}
				else
				{
					
					str += " <input type='checkbox' onclick='oc("+emplist.get(i).getId()+","+emplist.get(i).getDepartment().getId()+","+count+")' id='"+emplist.get(i).getId()+"' name='"+emplist.get(i).getDepartment().getId()+"' value='"+emplist.get(i).getId()+"' style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px' />"+emplist.get(i).getName();
				}
			}
		}
		str += "<br/>";
		logger.debug("str : "+str);
		try 
		{
			PrintWriter pw = response.getWriter();
			if(str.length()>0)
			{
				pw.print(str+"*"+str1);
			}
			else
			{
				pw.print("");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	int num=0;
	 int aa[]= null;
	public String verifyEmployee(){
		 
		num =num+1;
		String employeeId=request.getParameter("employeeId");
		int id=Integer.parseInt(employeeId);
		String departmenId= request.getParameter("departmentId");
		int dpId=Integer.parseInt(departmenId);
		String countID= request.getParameter("count");
		int count=Integer.parseInt(countID);

		List<Employee> ey=verifyOrderBusiness.getObject("Employee",  " and delflag = 0 and id = "+id+"");
		List<Department>  dp=verifyOrderBusiness.getObject("Department", " and delflag = 0 and id = "+dpId+"");
//		List<Employee> eydpId=verifyOrderBusiness.getObject("Employee",  " and delflag = 0 and department = "+dpId+"");
//		int employeesId[]=new int[eydpId.size()];
//		for(int i=0;i<eydpId.size();i++)
//		{	
//			int a=eydpId.get(i).getId();
//			employeesId[i]=a;
//			System.out.println(a);
//		}
//		for(int j=0;j<employeesId.length;j++)
//		{
//			if(employeesId[j]==id)
//			{
//				
//			}
//		}
		logger.debug(dp.get(0).getName());
		logger.debug(ey.get(0).getName());
		String eyName=ey.get(0).getName();
		String dpName=dp.get(0).getName();
		String DepartmentId=dp.get(0).getId().toString();
		response.setCharacterEncoding("utf-8");
		String str="";
		str +="<table align='center'  id='tab"+id+"'><tr id='tr"+count+"'  align='center' border='1' bgcolor='white'><td width='200px'>部　门："+dpName+"</td><td align='left' width='145px'>员　工:"+eyName+"<label id='lab"+id+"' value='"+dpId+"'></label></td><td>" +
				"<input id='ipt"+id+"' name='ipt' onblur='ascertain("+id+")' type='text'  style='width:30px'/></td></tr></table>";
		
		logger.debug("return str:"+str);
		try {
			PrintWriter pw = response.getWriter();
			if(str.length()>0)
			{
			
				pw.print(str);
			}
			else
			{
				pw.print("");
			}
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
		return null;
	}
	public String addmany()
	{
		String[] yg;
		String[] bm;
		String[] order;
		String count=request.getParameter("count1");
		String bmcount=request.getParameter("bmcount1");
		String ordervalue=request.getParameter("ordervalue");
		logger.debug("recieve order"+ordervalue);
		response.setCharacterEncoding("utf-8");

		yg=count.split(",");
		bm=bmcount.split(",");
		order=ordervalue.split(",");

		String a="";
		String str="<table id='deltable'>";
	
		for (int i = 0; i < order.length; i++) {
			int aa=0;
			logger.debug("第  "+i+"圈"+order[i]);
			if (!StringUtil.isnull(order[i])){
				for (int j = i+1; j < order.length; j++) {
					if (!StringUtil.isnull(order[j])) {
						if (order[i].equals( order[j])) {//顺序相等的计算了，不等的情况呢
							if(aa==0)
							{
								a+=order[i]+",";
								List<Employee> ey=verifyOrderBusiness.getObject("Employee",  " and delflag = 0 and id = "+yg[i]+"");
								List<Department>  dp=verifyOrderBusiness.getObject("Department", " and delflag = 0 and id = "+bm[i]+"");

								str+="<tr align='center'><td width='300px'>"+dp.get(0).getName()+"</td><td width='300px'>"+ey.get(0).getName()+"</td><td width='300px'>审核顺序："+order[j]+"</td></tr>";
							}
							a+=order[j]+",";
							aa++;
							List<Employee> ey=verifyOrderBusiness.getObject("Employee",  " and delflag = 0 and id = "+yg[j]+"");
							List<Department>  dp=verifyOrderBusiness.getObject("Department", " and delflag = 0 and id = "+bm[j]+"");
							str+="<tr align='center'><td width='300px'>"+dp.get(0).getName()+"</td><td width='300px'>"+ey.get(0).getName()+"</td><td width='300px'>审核顺序："+order[j]+"</td></tr>";
							
							order[j] = "";
							
						}
						
						
					}else{
						//order 没有重复的
					}
				}
			}
			
		}
		logger.debug("order:"+a);
		if(!StringUtil.isnull(str))
		{
			str+="<td>"+"<INPUT id='radio1' type='radio' name='rb' style='border: 0px' value='1' />只需一人审核" +
							"</td><td><INPUT id='radio2' type='radio' name='rb' style='border: 0px' value='2' />多人必须审核" +
							"</td><td><INPUT id='radio0'  type='radio' name='rb' style='border: 0px' value='0' checked='checked'/>顺序审核</td>";
		}else{
			str+="</td><td><INPUT id='radio0'  type='radio' name='rb' style='border: 0px' value='0' checked='checked'/>顺序审核</td>";
		}
		str+="</table>";
		logger.debug("return data:"+str);
		try {
			response.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
}
	//增加
	public String addOrder1(){
		String shunxu=request.getParameter("ordervalue");//审核顺序
		String bmId1= request.getParameter("bmId");//审核部门
		String bmId= request.getParameter("bmId1");
		String eyId=request.getParameter("eyId");//审核员工
		String order=request.getParameter("order");//一人审核或多人审核
		String remark=request.getParameter("remark");//单据标识
		logger.debug(order);
 		String[] sx=shunxu.split(",");
 		String[] bm=bmId1.split(",");
 		String[] ey=eyId.split(",");
 		String[] bi=bmId.split(",");
 		String[] s=shunxu.split(",");
 		String cc="";
 		boolean flag1 =false;
 		boolean flag=false;
 		Docmark docmark=null;
//		if(remark!=null){
//			docmark=(Docmark)verifyOrderBusiness.getObject("Docmark", " and mark='"+remark+"'").get(0);
//		}
 		String b="0";
//		
		for(int i=0;i<bm.length;i++)
		{
			if(b.equals("0")||(b.equals(bm[i])==false))
			if(bm[i]!=null&&(bm[i].equals("")==false)&&(bm[i].equals("undefined")==false))
			{
			VerifyOrder verifyorder=new VerifyOrder();
			Docmark d = new Docmark();
			d.setId(Integer.parseInt(remark));
//			verifyorder.getOrdertype().setAname(docmark.getAname());
		//	verifyorder.getOrdertype().setMark(remark);
			verifyorder.setOrdertype(d);
			verifyorder.setDepartments(bm[i]);
			verifyorder.setEmpOrdept("emp");
			flag=verifyOrderBusiness.addVerifyOrder(verifyorder);//查入审核部门
			b=bm[i];
			}
			
		}
		for(int j=0;j<bi.length;j++)
		{
			Department dt=new Department();
			
			dt.setId(Integer.parseInt(bi[j]));
			VerifyOrder verify = (VerifyOrder)verifyOrderBusiness.getObject("VerifyOrder", " and ordertype='"+remark+"'and departments='"+bi[j]+"'").get(0);
			logger.debug(verify.getId());
			VerifyOrderEmployee voe= new VerifyOrderEmployee();	
			
			voe.setDepartment(dt);
			voe.setEmployees(ey[j]);
			voe.setVerifyOrder(verify);
			voe.setOrderVerify(sx[j]);	
			voe.setRemark("");
			
			
			//插入员工审核是一人或多人
			for(int i=0;i<s.length;i++)
			{
				int ic=0;
				if(s[i]!=null&&!"".equals(s[i]))
				for(int c=i+1;c<s.length;c++)
				{
					if(s[c].equals(s[i]))
					{
						if(ic==0)
						{
							cc+=s[i]+",";
						}
						s[c]="";
						ic++;
					}
					
				}
			}
			String[] ccc=cc.split(",");
			for(int a=0;a<ccc.length;a++)
			{
				if(sx[j].equals(ccc[a]))
				{
					voe.setVerifyState(order);
					logger.debug(sx[j]);
					break;
				}
				else {
					voe.setVerifyState("0");
				}
			}
			//插入审核员工
			flag1 = verifyOrderBusiness.addVerifyOrderEmployee(voe);
			
		}
		try {
			if(flag1&&flag)
			{
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("0");
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	//修改
	public String addOrder2() throws IOException{
		System.out.println("aaaa");
		String shunxu=request.getParameter("ordervalue");//审核顺序
		String bmId1= request.getParameter("bmId1");//审核部门
		String eyId=request.getParameter("eyId");//审核员工
		String order=request.getParameter("order");//一人审核或多人审核
		String remark=request.getParameter("remark");//单据标识
		logger.debug(order);
 		String[] sx=shunxu.split(",");
 		String[] bm=bmId1.split(",");
 		String[] ey=eyId.split(",");
 		String cc="";
 		boolean flag1 =false;
 		boolean flag=false;
 		Docmark docmark=null;
 		
		if(remark!=null){
			docmark=(Docmark)verifyOrderBusiness.getObject("Docmark", " and mark='"+remark+"'").get(0);
		}
		System.out.println(docmark.getId());
		for(int i=0;i<bm.length;i++)
		{
			
			List<VerifyOrder> verifyOrder=verifyOrderBusiness.getObject("VerifyOrder", " and orderType='"+docmark.getId()+"' and departments="+bm[i]+"");
			if(verifyOrder.size()==0)
			{
				verifyorder.setOrdertype(docmark);
				verifyorder.setDepartments(bm[i]);
				verifyorder.setEmpOrdept("emp");
				flag=verifyOrderBusiness.addVerifyOrder(verifyorder);//查入审核部门
			}
		}
		for(int i=0;i<bm.length;i++)
		{
			List<VerifyOrder> verifyOrder=verifyOrderBusiness.getObject("VerifyOrder", " and orderType='"+docmark.getId()+"' and departments="+bm[i]+"");
			List<VerifyOrderEmployee> verifyorderEmployee=verifyOrderBusiness.getObject("VerifyOrderEmployee", " and verifyOrder='"+verifyOrder.get(0).getId()+"' and department='"+bm[i]+"' " );
			for(int j=0;j<verifyorderEmployee.size();j++)
			{
				verifyOrderBusiness.delVerifyOrderEmployee(verifyorderEmployee.get(j));
			}
		}
		for(int i=0;i<bm.length;i++)
		{
			List<VerifyOrder> verifyOrder=verifyOrderBusiness.getObject("VerifyOrder", " and orderType='"+docmark.getId()+"' and departments="+bm[i]+"");
		
			Department dt=new Department();
			dt.setId(Integer.parseInt(bm[i]));
			VerifyOrderEmployee voe=new VerifyOrderEmployee();
			voe.setDepartment(dt);
			voe.setEmployees(ey[i]);
			voe.setRemark("");
			voe.setVerifyOrder(verifyOrder.get(0));
			voe.setOrderVerify(sx[i]);
			voe.setVerifyState(order);
			flag=verifyOrderBusiness.addVerifyOrderEmployee(voe);//查入审核员工
			if(flag==false)
			{
				response.getWriter().print("0");
				return null;
			}
		}
		response.getWriter().print("1");
		return null;

	}
	//审核流程列表
	public String pageslist()
	{
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String hql = " from VerifyOrder where 1=1 ";
		
		hql += "order by id desc";
		logger.debug("pageslist hql:"+hql);
		Pages pages = verifyOrderBusiness.exHqlPages1(hql, Integer.parseInt(pageNo), 10, null);
		List list = pages.getPageList();
		if(pages.getAllCount()>0)
		{
		System.out.println("数据量大小"+list.size());
		String[] orderType=new String[list.size()];
		String[] departments=new String[list.size()];
		String[] dtid=new String[list.size()];
		for(int i=0;i<list.size();i++)
		{
			departments[i]=((Docmark)list.get(i)).getAname();
			dtid[i]=((Docmark)list.get(i)).getId().toString();
			int id=((Docmark)list.get(i)).getId();
			List<VerifyOrder> verifyOrder =verifyOrderBusiness.getObject("VerifyOrder", " and ordertype = "+id);
			for(int j=0;j<verifyOrder.size();j++)
			{
				
				Department depart = (Department)verifyOrderBusiness.getObject("Department", " and id = "+verifyOrder.get(j).getDepartments()).get(0);
				if(j!=verifyOrder.size()-1&&j==0)
				{
					orderType[i]=depart.getName()+",";
				}
				else if(j==0)
				{
					orderType[i]=depart.getName();
				}
				else if(j==verifyOrder.size()-1&&j!=0)
				{
					orderType[i]+=depart.getName();
				}
				else{
					orderType[i]+=depart.getName()+",";
				}
				
			}
			
		}

		request.setAttribute("order", dtid);
		request.setAttribute("orderType", orderType);
		request.setAttribute("departments",departments);
		}
		request.setAttribute("pages", pages);
		return "pageslist";
	}
	
	//详细信息
	public String selectInfo()
	{	
		String ordertype=request.getParameter("order");
		 String verifyState="";
		List<VerifyOrder> verifyOrder = verifyOrderBusiness.getObject("VerifyOrder", " and ordertype = '"+ordertype+"'");
		boolean empOrdept=false;
		// 判断是通过员工审还是部门审核.
		for(int i=0;i<verifyOrder.size();i++){
			VerifyOrder veorder=verifyOrder.get(i);
			if(veorder.getEmpOrdept().equals("emp")){
				empOrdept=true;
				break;
			}
		}
		if(empOrdept==true){
			List<VerifyOrderEmployee> vOrderEmployee= new ArrayList();
			List<VerifyOrderEmployee> verifyOrderEmployee = verifyOrderBusiness.getObject("VerifyOrderEmployee", " and verifyOrderId in (select id from VerifyOrder where   ordertype = '"+ordertype+"') order by orderVerify");
			for(int j=0;j<verifyOrderEmployee.size();j++)
			{
				vOrderEmployee.add(verifyOrderEmployee.get(j));
			}
			
	
	
			 String[] employeeName=new String[vOrderEmployee.size()];
			 for(int i=0;i<vOrderEmployee.size();i++)
			 {
				 List<Employee> employee = verifyOrderBusiness.getObject("Employee", " and id = "+vOrderEmployee.get(i).getEmployees());
				 employeeName[i]=employee.get(0).getName();
				 if((vOrderEmployee.get(i).getVerifyState().equals("0")==false)&&vOrderEmployee.get(i).getVerifyState().equals("1"))
				 {
					 verifyState="1";
				 }else if((vOrderEmployee.get(i).getVerifyState().equals("0")==false)&&vOrderEmployee.get(i).getVerifyState().equals("2"))
				 {
					 verifyState="2";
				 }
				 else
				 {
					 verifyState="0";
				 }
					 
			 }
			 for(int i=0;i<vOrderEmployee.size();i++)
			 {
				 if((vOrderEmployee.get(i).getVerifyState().equals("0")==false)&&vOrderEmployee.get(i).getVerifyState().equals("1"))
				 {
					 verifyState="1";
					 break;
				 }else if((vOrderEmployee.get(i).getVerifyState().equals("0")==false)&&vOrderEmployee.get(i).getVerifyState().equals("2"))
				 {
					 verifyState="2";
					 break;
				 }
				 else
				 {
					 verifyState="0";
				 }
					 
			 }
			request.setAttribute("vOrderEmployee", vOrderEmployee);
			request.setAttribute("employeeName", employeeName);
		}else{
			verifyState="0";// 顺序审核
			String hql="from VerifyOrderDepartment where remark='"+verifyOrder.get(0).getOrdertype().getId()+"' order by orderVerify";
			List vOrderDepartment=verifyOrderBusiness.exHql(hql);
			request.setAttribute("vOrderDepartment", vOrderDepartment);
		}
		request.setAttribute("verifyOrder", verifyOrder.get(0).getOrdertype());
		request.setAttribute("verifyState", verifyState);
		request.setAttribute("empOrdept", empOrdept);
		
		return "selectverifyorder";
	}
	//删除
	public String delete()
	{
		String id=request.getParameter("id");
		boolean flag=false;
		boolean flag1=false;
		List<VerifyOrder> verifyOrder = verifyOrderBusiness.getObject("VerifyOrder", " and ordertype = "+id+"");
		String[] voId=new String[verifyOrder.size()];
		String[] bmId=new String[verifyOrder.size()];
		for(int i=0;i<verifyOrder.size();i++)
		{
			voId[i]=verifyOrder.get(i).getId().toString();
			bmId[i]=verifyOrder.get(i).getDepartments().toString();
			List<VerifyOrderEmployee> vo =verifyOrderBusiness.getObject("VerifyOrderEmployee", " and department = '"+bmId[i]+"' and verifyOrder='"+voId[i]+"'");
			for(int j=0;j<vo.size();j++)
			{
				flag=verifyOrderBusiness.delVerifyOrderEmployee(vo.get(j));
			}
				flag1=verifyOrderBusiness.delVerifyOrder(verifyOrder.get(i));
				
		}
		try 
		{
			if(flag&&flag1)
			{
				response.getOutputStream().print("1");
			}
			else
			{
				response.getOutputStream().print("0");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public String update(){
		String order=request.getParameter("order");
		
		List<VerifyOrderEmployee> vOrderEmployee= new ArrayList();
		List<VerifyOrder> verifyOrder = verifyOrderBusiness.getObject("VerifyOrder", " and ordertype = '"+order+"'");

		List<VerifyOrderEmployee> verifyOrderEmployee = verifyOrderBusiness.getObject("VerifyOrderEmployee", " and verifyOrderId in (select id from VerifyOrder where   ordertype = '"+order+"') order by orderVerify");
		for(int j=0;j<verifyOrderEmployee.size();j++)
		{
			vOrderEmployee.add(verifyOrderEmployee.get(j));
		}
		 String[] employeeName=new String[vOrderEmployee.size()];
		 String[] employeeid=new String[vOrderEmployee.size()];
		 String verifyState="";
		 String eid="";
		 String dtid="";
		 for(int i=0;i<vOrderEmployee.size();i++)
		 {
			 List<Employee> employee = verifyOrderBusiness.getObject("Employee", " and id = "+vOrderEmployee.get(i).getEmployees());
			 employeeName[i]=employee.get(0).getName();
			 employeeid[i]=employee.get(0).getId().toString();
			 eid+=employee.get(0).getId().toString()+",";
			 dtid+=vOrderEmployee.get(i).getDepartment().getId()+",";
		 }
		 request.setAttribute("dtid", dtid);
		 request.setAttribute("eid", eid);
		 request.setAttribute("employeeid", employeeid);
		request.setAttribute("vOrderEmployee", vOrderEmployee);
		request.setAttribute("employeeName", employeeName);
		request.setAttribute("verifyOrder", verifyOrder.get(0).getOrdertype());
		return "editverityorder";
	}
	public String delverify(){
		String bmid=request.getParameter("bmId");
		String userid=request.getParameter("userId");
		String verifyId=request.getParameter("verifyId");
		boolean flag=false;
		List<VerifyOrderEmployee> vo =verifyOrderBusiness.getObject("VerifyOrderEmployee", " and department = '"+bmid+"' and employees="+userid+" and verifyOrder='"+verifyId+"'");
		if(vo.size()>0)
		{
			flag=verifyOrderBusiness.delVerifyOrderEmployee(vo.get(0));
			List<VerifyOrderEmployee> verifyOrder =verifyOrderBusiness.getObject("VerifyOrderEmployee", " and department = '"+bmid+"' and verifyOrder='"+verifyId+"'");
			if(verifyOrder.size()==0)
			{
				List<VerifyOrder> vorder =verifyOrderBusiness.getObject("VerifyOrder", " and departments = '"+bmid+"' and id='"+verifyId+"'");
				verifyOrderBusiness.delVerifyOrder(vorder.get(0));
			}
		}
		try {
			if(flag)
			{
					response.getOutputStream().print("1");
			}else{
				response.getOutputStream().print("0");
			}
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		return null;
	}
	public String updatevf()
	{
		
		
		
		String shunxu=request.getParameter("ordervalue");//审核顺序
		String bmId1= request.getParameter("bmId");//审核部门
		String bmId= request.getParameter("bmId1");
		String eyId=request.getParameter("eyId");//审核员工
		String order=request.getParameter("order");//一人审核或多人审核
		String remark=request.getParameter("remark");//单据标识
		System.out.println(order);
 		String[] sx=shunxu.split(",");
 		String[] bm=bmId1.split(",");
 		String[] ey=eyId.split(",");
 		String[] bi=bmId.split(",");
 		String[] s=shunxu.split(",");
 		String cc="";
 		boolean flag1 =false;
 		boolean flag=false;
 		Docmark docmark=null;
//		if(remark!=null){
//			docmark=(Docmark)verifyOrderBusiness.getObject("Docmark", " and mark='"+remark+"'").get(0);
//		}
//		
		for(int i=0;i<bm.length;i++)
		{
			if(bm[i]!=null&&(bm[i].equals("")==false)&&(bm[i].equals("undefined")==false)){
			VerifyOrder verifyorder=new VerifyOrder();
			Docmark d = new Docmark();
			d.setId(Integer.parseInt(remark));
//			verifyorder.getOrdertype().setAname(docmark.getAname());
		//	verifyorder.getOrdertype().setMark(remark);
			verifyorder.setOrdertype(d);
			verifyorder.setDepartments(bm[i]);
			verifyorder.setEmpOrdept("emp");
			for(int j=0;j<bi.length;j++)
			{
				List<VerifyOrder> verify = verifyOrderBusiness.getObject("VerifyOrder", " and ordertype='"+remark+"'and departments='"+bi[j]+"'");
				if(verify.size()==0)
					{
						flag=verifyOrderBusiness.addVerifyOrder(verifyorder);//查入审核部门
					}
			}
			
			}
			
		}
		for(int j=0;j<bi.length;j++)
		{
			Department dt=new Department();
			
			dt.setId(Integer.parseInt(bi[j]));
			VerifyOrder verify = (VerifyOrder)verifyOrderBusiness.getObject("VerifyOrder", " and ordertype='"+remark+"'and departments='"+bi[j]+"'").get(0);
			System.out.println(verify.getId());
			VerifyOrderEmployee voe= new VerifyOrderEmployee();	
			
			voe.setDepartment(dt);
			voe.setEmployees(ey[j]);
			voe.setVerifyOrder(verify);
			voe.setOrderVerify(sx[j]);	
			voe.setRemark("");
			
			
			//插入员工审核是一人或多人
			for(int i=0;i<s.length;i++)
			{
				int ic=0;
				if(s[i]!=null&&!"".equals(s[i]))
				for(int c=i+1;c<s.length;c++)
				{
					if(s[c].equals(s[i]))
					{
						if(ic==0)
						{
							cc+=s[i]+",";
						}
						s[c]="";
						ic++;
					}
					
				}
			}
			String[] ccc=cc.split(",");
			for(int a=0;a<ccc.length;a++)
			{
				if(sx[j].equals(ccc[a]))
				{
					voe.setVerifyState(order);
				}
				else {
					voe.setVerifyState("0");
				}
			}
			//插入审核员工
			flag1 = verifyOrderBusiness.addVerifyOrderEmployee(voe);
			
		}
		try {
		response.getWriter().print("1");	
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	public String dtName(){
		String btid=request.getParameter("btid");
		Docmark dt=(Docmark)verifyOrderBusiness.getObject("Docmark", " and id="+btid+" ").get(0);
		response.setCharacterEncoding("utf-8");
		String name=dt.getMark();
		try {
			response.getWriter().print(name);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	public String  delemployee()
	{
		String dtid=request.getParameter("dtid");
		String emid=request.getParameter("emid");
		String order=request.getParameter("order");
		
		List<VerifyOrder> vorder =verifyOrderBusiness.getObject("VerifyOrder", " and departments = "+Integer.parseInt(dtid)+" and orderType="+Integer.parseInt(order)+"");
		for(int i=0;i<vorder.size();i++)
		{
			List<VerifyOrderEmployee> verifyOrder =verifyOrderBusiness.getObject("VerifyOrderEmployee", " and department = "+Integer.parseInt(dtid)+" and verifyOrder="+vorder.get(i).getId()+" and employees="+Integer.parseInt(emid)+"");
			for(int j=0;j<verifyOrder.size();j++)
			{
				verifyOrderBusiness.delVerifyOrderEmployee(verifyOrder.get(j));
				List<VerifyOrderEmployee> verifyOrder1 =verifyOrderBusiness.getObject("VerifyOrderEmployee", " and verifyOrder="+vorder.get(i).getId()+"");
				if(verifyOrder1.size()==0)
				{
					List<VerifyOrder> vorder1 =verifyOrderBusiness.getObject("VerifyOrder", " and departments = "+Integer.parseInt(dtid)+" and orderType="+Integer.parseInt(order)+"");
					verifyOrderBusiness.delVerifyOrder(vorder1.get(0));
				}
			}
			List<VerifyOrderEmployee> verifyOrder1 =verifyOrderBusiness.getObject("VerifyOrderEmployee", " and verifyOrder="+vorder.get(i).getId()+"");
		}
		update();
		System.out.println("aaaa");
		return "editverityorder";
	}
	public void setVerifyOrderBusiness(VerifyOrderBussiness verifyOrderBusiness) {
		this.verifyOrderBusiness = verifyOrderBusiness;
	}

	public Object getModel() {
		verifyorder = new VerifyOrder();
		return verifyorder;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
	}

	
	/************
	 * 勾选部门时，显示部门并且可输入顺序
	 */
	public String selectDept(){
		String deptid=request.getParameter("deptid");
		System.out.println(deptid);
		String[] arr=deptid.split(",");
		System.out.println(arr.length);
		System.out.println(arr[0].length());
		String str="<table align='center'>";
		if(arr[0]!=null && arr[0].trim().length()>0){
			for(int i=0;i<arr.length;i++){
				int did=Integer.parseInt(arr[i]);
				Department dept=(Department)verifyOrderBusiness.getObjectById(Department.class, did);
				str +="<tr align='center' border='1' bgcolor='white'><td width='200px'>部　门："+dept.getName()+"</td><td>" +
				"<input id='ipt"+dept.getId()+"' name='ipt' onblur='ascertain("+dept.getId()+")' type='text'  style='width:30px'/></td></tr>";
			}
			str+="</table>";
		}else{
			str="<span  style='text-align: center;' color='red'>请选择部门！</span>";
		}
		
		
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);	
			} catch (IOException e) {
				e.printStackTrace();
			}
		return null;
	}
	
	//增加审核部门订单类型
	public String addDeptOrder(){
		String shunxu=request.getParameter("ordervalue");//审核顺序
		String bbmId= request.getParameter("bbmId");//审核部门
		String remark=request.getParameter("remark");//单据标识
 		String[] sx=shunxu.split(",");
 		String[] bm=bbmId.split(",");
 		String cc="";
 		boolean flag1 =false;
 		boolean flag=false;
 		Docmark docmark=null;
 		String b="0";
		for(int i=0;i<bm.length;i++)
		{
			if(b.equals("0")||(b.equals(bm[i])==false))
			if(bm[i]!=null&&(bm[i].equals("")==false)&&(bm[i].equals("undefined")==false))
			{
			VerifyOrder verifyorder=new VerifyOrder();
			Docmark d = new Docmark();
			d.setId(Integer.parseInt(remark));
			verifyorder.setOrdertype(d);
			verifyorder.setDepartments(bm[i]);
			verifyorder.setEmpOrdept("dept");
			flag=verifyOrderBusiness.addVerifyOrder(verifyorder);//查入审核部门
			b=bm[i];
			}
			
		}
		for(int j=0;j<bm.length;j++)
		{
			Department dt=new Department();
			dt.setId(Integer.parseInt(bm[j]));
			VerifyOrder verify = (VerifyOrder)verifyOrderBusiness.getObject("VerifyOrder", " and ordertype='"+remark+"'and departments='"+bm[j]+"'").get(0);
			VerifyOrderDepartment vodept=new VerifyOrderDepartment();
			
			vodept.setDepartment(dt);
			vodept.setVerifyOrder(verify);
			vodept.setOrderVerify(sx[j]);	
			vodept.setRemark(remark);
			
			
			//插入部门审核是一人或多人
			if(sx.length>0 && sx[0]!=null && sx[0].trim().length()>0){
				cc="1";
			}else{
				cc="0";
			}
			vodept.setVerifyState(cc);
			//插入审核部门
			flag1 = verifyOrderBusiness.addVerifyOrderDepartment(vodept);
			
		}
		try {
			if(flag1&&flag)
			{
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("0");
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	

}

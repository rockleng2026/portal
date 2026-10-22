package com.fuao.fajxc.action;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fuao.fajxc.bussiness.HandleJsonBusiness;
import com.fuao.fajxc.bussiness.LoginBussiness;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.Groups;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.Questioncategory;
import com.fuao.fajxc.vo.SaleOrder;


public class HandleJsonAction {

	private HandleJsonBusiness jsonbiz;
	
	private List<Questioncategory> questioncategorylist ;
	private List<Department> departlist;
	private List<CommodityTpye> commoditylist ;
	private List<Missiontype> missiontypelist ;
	private List<Groups> groupslist;
	private List<FunctionInfo> functioninfolist;
	
	
	
	
	
    
	/**
	 * 获取问题列表目录
	 * @return
	 */
	public String getQuestionCategoryList()
	{
		List<Questioncategory> list = jsonbiz.ObjectList("Questioncategory", " and questioncategory.id !=''");
		questioncategorylist = new ArrayList<Questioncategory>();
		for(Questioncategory qc : list)
		{
			if(qc.getQuestioncategory().getId()==1)
			{
				Questioncategory question = new Questioncategory();
				question.setId(qc.getId());
				question.setSuperid(0);
				question.setQuestionName(qc.getQuestionName());
				question.setChild(this.buildNode(qc.getId(), list));
				questioncategorylist.add(question);
			}
		}
		System.out.println("qc size : "+questioncategorylist.size());
		return "qclist";
	}
	
	/**
	 * 添加问题列表目录的子目录
	 * @param parentid
	 * @param function
	 * @return
	 */
	public List<Questioncategory> buildNode(int parentid ,List<Questioncategory> function)
	{
		List<Questioncategory> childlist = new ArrayList<Questioncategory>();
		for(Questioncategory f : function)
		{
			Questioncategory node = new Questioncategory();
			if(f.getQuestioncategory().getId()!=0&&f.getQuestioncategory().getId()==parentid)
			{
				node.setId(f.getId());
				node.setSuperid(f.getQuestioncategory().getId());
				node.setQuestionName(f.getQuestionName());
				List<Questioncategory> children = buildNode(f.getId(),function);
				if(null!=children && children.size()>0)
				{
					node.setChild(children);
				}
			}
			childlist.add(node);
		}
		return childlist;
	}
	
	/**
	 * 获取部门列表目录
	 * @return
	 */
	public String getDepartementList()
	{
		//List<Department> list = jsonbiz.ObjectList("Department", " and parentId !=-1 and delflag= 0 ");
		List<Department> list = jsonbiz.ObjectList("Department", " and delflag=0  order by squnum  ");
		departlist = new ArrayList<Department>();
		for(Department d : list)
		{
			if(d.getParentId() == 0)
			{
				Department ment = new Department();
				ment.setId(d.getId());
				ment.setParentId(d.getParentId());
				ment.setName(d.getName());
				ment.setChild(this.buildDepartmentNode(d.getId(), list));
				departlist.add(ment);
			}
		}
		System.out.println("depart size : "+departlist.size());
		return "dlist";
	}
	
	/**
	 * 添加部门列表目录的子目录
	 * @param parentid
	 * @param function
	 * @return
	 */
	public List<Department> buildDepartmentNode(int parentid ,List<Department> function)
	{
		List<Department> childlist = new ArrayList<Department>();
		for(Department f : function)
		{
			Department node = new Department();
			if(f.getParentId()!=0&&f.getParentId()==parentid)
			{
				node.setId(f.getId());
				node.setParentId(f.getParentId());
				node.setName(f.getName());
				List<Department> children = buildDepartmentNode(f.getId(),function);
				if(null!=children && children.size()>0)
				{
					node.setChild(children);
				}
			}
			childlist.add(node);
		}
		return childlist;
	}
	
	public String getcommoditList()
	{
		List<CommodityTpye> list = jsonbiz.ObjectList("CommodityTpye", " and id !=1");
		commoditylist = new ArrayList<CommodityTpye>();
		for(CommodityTpye ct : list)
		{
			if(ct.getSuperid().getId()==1)
			{
				CommodityTpye ctt = new CommodityTpye();
				ctt.setId(ct.getId());
				ctt.setSuperidd(0);
				ctt.setTypeName(ct.getTypeName());
				ctt.setChild(this.commodit(ct.getId(), list));
				commoditylist.add(ctt);
			}
		}
		System.out.println("qc size : "+commoditylist.size());
		return "cdlist";
	}
	
	/**
	 * 添加问题列表目录的子目录
	 * @param parentid
	 * @param function
	 * @return
	 */
	public List<CommodityTpye> commodit(int parentid ,List<CommodityTpye> function)
	{
		List<CommodityTpye> childlist = new ArrayList<CommodityTpye>();
		for(CommodityTpye c : function)
		{
			CommodityTpye node = new CommodityTpye();
			if(c.getSuperid().getId()!=0&&c.getSuperid().getId()==parentid)
			{
				node.setId(c.getId());
				node.setSuperidd(c.getSuperid().getId());
				node.setTypeName(c.getTypeName());
				List<CommodityTpye> children = commodit(c.getId(),function);
				if(null!=children && children.size()>0)
				{
					node.setChild(children);
				}
			}
			childlist.add(node);
		}
		return childlist;
	}
	/**
	 * 获取任务类别列表目录
	 * @return
	 */
	public String getmisssiontype()
	{
		System.out.println("getmisssiontype");
		List<Missiontype> list = jsonbiz.ObjectList("Missiontype"," ");
		missiontypelist = new ArrayList<Missiontype>();
		for(Missiontype qc : list)
		{
			if(qc.getSuperid()==-1)
			{
				Missiontype mtype = new Missiontype();
				mtype.setId(qc.getId());
				mtype.setSuperid(0);
				mtype.setName(qc.getName());
				mtype.setChild(this.buildchildmissiontype(qc.getId(), list));
				missiontypelist.add(mtype);
			}
		}
		System.out.println("qc size : "+missiontypelist.size());
		return "missiontypelist";
	}
	
	/**
	 * 添加任务类别列表目录的子目录
	 * @param parentid
	 * @param function
	 * @return
	 */
	public List<Missiontype> buildchildmissiontype(int parentid ,List<Missiontype> function)
	{
		List<Missiontype> childlist = new ArrayList<Missiontype>();
		for(Missiontype f : function)
		{
			Missiontype node = new Missiontype();
			if(f.getSuperid()!= -1 &&f.getSuperid()==parentid)
			{
				node.setId(f.getId());
				node.setSuperid(f.getSuperid());
				node.setName(f.getName());
				List<Missiontype> children = buildchildmissiontype(f.getId(),function);
				if(null!=children && children.size()>0)
				{
					node.setChild(children);
				}
			}
			childlist.add(node);
		}
		return childlist;
	}
	
	public String getGroupsGrade()
	{
		groupslist = new ArrayList<Groups>();
		try{
		List<Groups> list = jsonbiz.ObjectList("Groups", "");
		if(list.size()>0)
		{
			for(Groups g : list)
			{
				Groups group = new Groups();
				if(g.getSuperGroupId()==1)
				{
					group.setGroupId(g.getGroupId());
					group.setSuperGroupId(g.getSuperGroupId());
					group.setGroupName(g.getGroupName());
					group.setGrade(g.getGrade());
					group.setChild(this.buildGroupsGrade(g.getGroupId(), list));
					groupslist.add(group);
				}
			}
		}
		}catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("grade : "+groupslist.size());
		return "groupsgrade";
	}
	/**
	 * 
	 * @param parentid
	 * @param function
	 * @return
	 */
	public List<Groups> buildGroupsGrade(int parentid ,List<Groups> function)
	{
		List<Groups> glist = new ArrayList<Groups>();
		for(Groups g : function)
		{
			Groups group = new Groups();
			if(g.getSuperGroupId()==parentid)
			{
				group.setGroupId(g.getGroupId());
				//group.setGroupId(g.getGroupId());
				group.setSuperGroupId(g.getSuperGroupId());
				group.setGroupName(g.getGroupName());
				group.setGrade(g.getGrade());
				List<Groups> gglist = this.buildGroupsGrade(g.getGroupId(), function);
				if(gglist!=null&&gglist.size()>0)
				{
					group.setChild(gglist);
				}
			}
			glist.add(group);
		}
		return glist;
	}
	
	public static void main(String args[])
	{
		String paths[] = {"applicationContext.xml","applicationContext-system.xml","applicationContext-basic.xml","applicationContext-commodity.xml","applicationContext-customService.xml","applicationContext-financial.xml","applicationContext-login.xml","applicationContext-message.xml","applicationContext-purchasing.xml","applicationContext-sale.xml","applicationContext-server.xml","applicationContext-stat.xml","applicationContext-stockpile.xml"};
		ApplicationContext context = new ClassPathXmlApplicationContext(paths);
		HandleJsonBusiness biz = (HandleJsonBusiness)context.getBean("JsonBiz");
		LoginBussiness login = (LoginBussiness)context.getBean("Loginbussiness");
		List<Employee> list = biz.ObjectList("Employee", " and id = 10");
		System.out.println(list.get(0).getGroups().getGroupName()+"    "+list.get(0).getGroups().getGrade());
//		List<Employee> emplist = biz.ObjectList("Employee", " and department.id = "+list.get(0).getDepartment().getId());
//		for(Employee e : emplist)
//		{
//			System.out.println("   "+e.getName()+"    "+e.getGroups().getGroupName()+"     "+e.getGroups().getGrade());
//		}
		List<Groups> glist = biz.ObjectList("Groups", " and superGroupId = "+list.get(0).getGroups().getSuperGroupId()+" and grade<"+list.get(0).getGroups().getGrade());
		String grade = "";
		for(Groups g : glist)
		{
			System.out.println("     "+g.getGroupName()+"   "+g.getGrade());
			grade += g.getGroupId()+",";
		}
		//List<Employee> emlist = biz.ObjectList("Employee", " and groups")
		List<Employee> elist = biz.ObjectList("Employee", " and groups.superGroupId = "+list.get(0).getGroups().getSuperGroupId()+" and groups.grade <"+list.get(0).getGroups().getGrade());
		String empids = "";
		for(Employee e : elist)
		{
			System.out.println("   "+e.getName()+"    "+e.getGroups().getGroupName()+"     "+e.getGroups().getGrade());
			empids += e.getId()+",";
		}
		System.out.println("empids : "+empids );
		List<SaleOrder> solist = biz.ObjectList("SaleOrder", " and employee.id in ("+empids.substring(0,empids.length()-1)+")");
		for(SaleOrder s : solist)
		{
			System.out.println("sale : "+s.getSaleOrderNo()+"   e name : "+s.getEmployee().getName());
		}
	}
	
	public HandleJsonBusiness getJsonbiz() {
		return jsonbiz;
	}

	public void setJsonbiz(HandleJsonBusiness jsonbiz) {
		this.jsonbiz = jsonbiz;
	}

	public List<Questioncategory> getQuestioncategorylist() {
		return questioncategorylist;
	}

	public void setQuestioncategorylist(List<Questioncategory> questioncategorylist) {
		this.questioncategorylist = questioncategorylist;
	}

	public List<Department> getDepartlist() {
		return departlist;
	}

	public void setDepartlist(List<Department> departlist) {
		this.departlist = departlist;
	}

	public List<CommodityTpye> getCommoditylist() {
		return commoditylist;
	}

	public void setCommoditylist(List<CommodityTpye> commoditylist) {
		this.commoditylist = commoditylist;
	}
	
	public List<Groups> getGroupslist() {
		return groupslist;
	}

	public void setGroupslist(List<Groups> groupslist) {
		this.groupslist = groupslist;
	}

	

	public List<Missiontype> getMissiontypelist() {
		return missiontypelist;
	}

	public void setMissiontypelist(List<Missiontype> missiontypelist) {
		this.missiontypelist = missiontypelist;
	}

	public List<FunctionInfo> getFunctioninfolist() {
		return functioninfolist;
	}

	public void setFunctioninfolist(List<FunctionInfo> functioninfolist) {
		this.functioninfolist = functioninfolist;
	}
	
}

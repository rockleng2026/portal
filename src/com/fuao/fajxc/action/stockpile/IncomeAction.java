package com.fuao.fajxc.action.stockpile;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.stockpile.IncomeBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Income;
import com.fuao.fajxc.vo.Ruin;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class IncomeAction implements ServletRequestAware,ServletResponseAware,ModelDriven {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private Income income;
	private IncomeBussiness incomeBussiness;
	//获得报溢单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	private Object[] ids;
	Cookies ck = new Cookies();
	private AuditingBussiness audBussiness;
	//型号集合
	private String models;
	//单据集合
	private String prices;
	//数量集合
	private String counts;
	//单品总价集合
	private String sums;

	
	

	public String getPrices() {
		return prices;
	}

	public void setPrices(String prices) {
		this.prices = prices;
	}

	public String getCounts() {
		return counts;
	}

	public void setCounts(String counts) {
		this.counts = counts;
	}

	public String getSums() {
		return sums;
	}

	public void setSums(String sums) {
		this.sums = sums;
	}

	public String getModels() {
		return models;
	}

	public void setModels(String models) {
		this.models = models;
	}

	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	public Object[] getIds() {
		return ids;
	}

	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	public IncomeBussiness getIncomeBussiness() {
		return incomeBussiness;
	}

	public void setIncomeBussiness(IncomeBussiness incomeBussiness) {
		this.incomeBussiness = incomeBussiness;
	}

	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
	}

	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response=response;
	}

	public Object getModel() {
		income=new Income();
		return income;
	}
	
	
	/**
	 * 查找显示
	 * @return
	 */
	public String select()
	{
		String marker=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker);
		request.setAttribute("taskid", taskid);
		
		//获得权限标识
		Map map = (Map)ActionContext.getContext().get("map");
		ServletActionContext.getRequest().setAttribute("option", map);
		
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String addhql="";
		//模糊查找的报损报溢单编号
		String purNo=request.getParameter("incomeNo");
		if(purNo!=null){
			addhql+=" and incomeNo like '%"+purNo+"%'";
		}
		System.out.println("addhql"+addhql);
		String hql="from Income where delflag=0"+addhql;
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+sid;
		}
		hql += " order by id desc";
		
		System.out.println("hql:"+hql);
		System.out.println("pageNo:"+pageNo);
		Pages pages=incomeBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		System.out.println("pages"+pages);
		request.setAttribute("pages", pages);
		return "success";
	}
	
	
	/**
	 * 添加显示
	 * @return
	 */
	public String addShow()
	{
		
		String PorL="BY-"+serial.getSerialNumber();
		request.setAttribute("BY", PorL);
		
		return "add";
	}
	
	
	/**
	 * 更新显示
	 * @return
	 */
	public String updateShow()
	{
		System.out.println("updateShow~~~~~~~~");
		String id=request.getParameter("cid");
		System.out.println("id~~~~"+id);
		if(id!=null&&id!="")
		{
			List list=incomeBussiness.selIncome(" and id="+Integer.parseInt(id));
			if(list!=null){
				Income income=(Income) list.get(0);
				request.setAttribute("oneRuin", income);
			}
		}
		return "add";
	}
	
	/**
	 * 添加报溢单
	 * @return 
	 */
	public String add()
	{
		try
		{
			income.setRemark(new String(income.getRemark().getBytes("GBK"), "UTF-8"));
			boolean flag=incomeBussiness.addOredit("add", income, models, prices, counts, sums);
			if(flag){
				int marker=audBussiness.addAuditingOrder("BY",income.getIncomeNo(),"Income",ck.getCookie(request, "filialemark"));
				System.out.println("marker:"+marker);
				if(marker==0)
					response.getWriter().print("0");
				else if(marker==2)
					response.getWriter().print("2");
				else
					response.getWriter().print("1");
			}
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 修改报溢单
	 * @return
	 */
	public String edit()
	{
		System.out.println(income.getIncomeNo());
		System.out.println("model:"+models);
		System.out.println("price:"+prices);
		System.out.println("count:"+counts);
		System.out.println("sum:"+sums);
		try
		{
			income.setRemark(new String(income.getRemark().getBytes("GBK"), "UTF-8"));
			boolean flag=incomeBussiness.addOredit("edit", income, models, prices, counts, sums);
			if(flag)
				response.getWriter().print("0");
			else 
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * 查询详细信息
	 * @return
	 */
	public String detail()
	{
		String id=request.getParameter("cid");
		String orderNo=request.getParameter("dNo");
		//获取info
		String info = request.getParameter("info");
		if(id!=null){
			List list=incomeBussiness.selIncome(" and id="+Integer.parseInt(id));
			if(list!=null){
				Income income=(Income) list.get(0);
				request.setAttribute("incomeList", income);
			}
		}
		String empid=ck.getCookie(request, "employeeId");
		System.out.println("ck::::"+empid);
		boolean flag=audBussiness.checkemp(orderNo, empid);
		System.out.println("saleActionflag:::::"+flag);
		if(flag){
			request.setAttribute("mark", "mark");
		}
		boolean flag1=audBussiness.checkemp1(orderNo, empid);
		if(flag1)
		{
			request.setAttribute("quanxian", "quanxian");
		}
		if(null != info && ( info == "info" || info.equals("info"))){
			
			if(orderNo!=null){
				String addhql2=" and orderNo='"+orderNo+"'";
				
				List audList=audBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if(null != audList && audList.size()>0){
					
					String depid = ck.getCookie(request, "departmentId");
					
					for(int i=0; i<audList.size(); i++){
						
						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
						
						if(aot.getDepartment().getId() == Integer.parseInt(depid)&& aot.getAuditingFlag() ==0 ){
							
							//表示未审核
							request.setAttribute("flage", 0);
							
						}else if(aot.getDepartment().getId() == Integer.parseInt(depid)&&
								(aot.getAuditingFlag() ==1 ||aot.getAuditingFlag()==2)){
							
							//表示已经审核
							request.setAttribute("flage", 1);
							
							request.setAttribute("aot", aot);
							
						}
					}
					
				}				
			}
		}
		
		return "detail";
	}
	
	/**
	 * 删除报溢单数据
	 * @return
	 */
	public String del()
	{
		boolean flag=incomeBussiness.delIncome(ids);
		try
		{
			if(flag){
				response.getWriter().print("0");
			}
			else{
				response.getWriter().print("1");
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return null;
	}

}

package com.fuao.fajxc.action.stockpile;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.impl.stockpile.ProfitOrlossBussinessImpl;
import com.fuao.fajxc.bussiness.stockpile.ProfitOrlossBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.dao.impl.stockpile.OutBoundDaoImpl;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Ruin;
import com.fuao.fajxc.vo.RuinInfo;
import com.fuao.fajxc.vo.StatInfo;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 报损Action
 * @author 14012
 *
 */
public class TheDamageTheGoodAction implements ModelDriven,
		ServletRequestAware, ServletResponseAware {

	//获得报损单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	private static Logger logger = Logger.getLogger(TheDamageTheGoodAction.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private ProfitOrlossBussiness proOrloss;
	private AuditingBussiness audBussiness;
	private Ruin ruin;
	private Object[] ids;
	//获得条形码
	private String code;
	//获得损益描述
	private String desc;
	//获得处理方式
	private String dispose;
	//获得价格
	private String price;

	Cookies ck = new Cookies();
	
	//添加动态记录
	private ExecuteRecordBussiness executeRecordBussiness;
	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getDispose() {
		return dispose;
	}

	public void setDispose(String dispose) {
		this.dispose = dispose;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	/**
	 * @return the ids
	 */
	public Object[] getIds() {
		return ids;
	}

	/**
	 * @param ids the ids to set
	 */
	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	/**
	 * @return the proOrloss
	 */
	public ProfitOrlossBussiness getProOrloss() {
		return proOrloss;
	}

	/**
	 * @param proOrloss the proOrloss to set
	 */
	public void setProOrloss(ProfitOrlossBussiness proOrloss) {
		this.proOrloss = proOrloss;
	}

	/**
	 * @return the request
	 */
	public HttpServletRequest getRequest() {
		return request;
	}

	/**
	 * @param request the request to set
	 */
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	/**
	 * @return the response
	 */
	public HttpServletResponse getResponse() {
		return response;
	}

	/**
	 * @param response the response to set
	 */
	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.response=arg0;
	}

	public Object getModel() {
		// TODO Auto-generated method stub
		ruin=new Ruin();
		return ruin;
	}

	/**
	 * 报损/报溢单进入添加页面显示
	 */
	public String addPorLoss()
	{
		String PorL="PorL-"+serial.getSerialNumber();
		request.setAttribute("PorL", PorL);
		
		return "newPorLoss";
	}
	
	/**
	 * 添加报损/报溢单
	 * @return
	 */
	public String add()
	{
		boolean flag=this.addAndedit("add");
		try
		{
			if(flag){
				int marker=audBussiness.addAuditingOrder("PorL",ruin.getRuinNo(),"Ruin",ck.getCookie(request, "filialemark"));
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
			logger.error("添加采购订单时出错",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 添加或修改盘点单
	 * @param addOredit
	 * @return
	 */
	public boolean addAndedit(String addOredit)
	{
		try {
		    ruin.setRemark(URLDecoder.decode(ruin.getRemark(),"utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		boolean flag=false;
		if(addOredit.equals("add"))
		{
			Ruin ru = proOrloss.addReturnPorLoss(ruin);
			if(null != ru){
				flag = true;
				
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("添加了一个报损单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(ru.getId().toString());
					executerecord.setEntityName("Ruin");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
			}else{
				flag = false;
			}
			
		}
		else
		{
			flag=proOrloss.editPorLoss(ruin);
			String cid=request.getParameter("id");
			if(cid!=null)
			{
				proOrloss.delPorLossInfo(" and ruinId="+cid);
				System.out.println("删除了");
			}
			
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("修改了一个报损单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(ruin.getId().toString());
				executerecord.setEntityName("Ruin");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
		}
		System.out.println(434334);
		boolean flag2=false;
		if(flag)
		{
			System.out.println("进入Info");
			String[] codes=code.split(",");
			String[] descs=desc.split(",");
			System.out.println("codes.leng"+codes.length);
			System.out.println("descs.leng"+descs.length);
			String[] disposes=dispose.split(",");
			String[] prices=price.split(",");
			for(int i=0;i<codes.length;i++)
			{
				System.out.println("进入循环");
				RuinInfo ruins=new RuinInfo();
				ruins.setRuin(ruin);
				Product product=new Product();
				product.setId(Integer.parseInt(codes[i]));
				ruins.setProduct(product);
				try
				{
					System.out.println("aaaaaaaaa"+"23aa");
					System.out.println("bbbbbbbb"+URLDecoder.decode(disposes[i],"utf-8"));
					ruins.setDescribes("2232df");
					ruins.setDisposeManner("dsfef");
					ruins.setDescribes(URLDecoder.decode(descs[i],"utf-8"));
					ruins.setDisposeManner(URLDecoder.decode(disposes[i],"utf-8"));
				}
				catch(Exception ex)
				{
					ex.printStackTrace();
				}
				ruins.setPrice(Double.parseDouble(prices[i]));
				System.out.println("ruins:"+ruins.getRuin().getId());
				System.out.println("productid:"+ruins.getProduct().getId());
				flag2=proOrloss.addPorLossInfo(ruins);
				System.out.println("info:"+flag2);
			}
		}
		if(flag&&flag2)
			return true;
		return false;
	}
	
	
	/**
	 * 报损报益综合查询
	 */
	public String query()
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
		String purNo=request.getParameter("porLoassNo");
		if(purNo!=null){
			addhql+=" and ruinNo like '%"+purNo+"%'";
		}
		System.out.println("addhql"+addhql);
		String hql="from Ruin where delflag!=1"+addhql;
		if(id!=null && !"".equals(id)){
			int sid = Integer.parseInt(id);
			hql+=" and id="+sid;
		}
		hql+=" order by id desc";
		System.out.println("hql:"+hql);
		System.out.println("pageNo:"+pageNo);
		Pages pages=proOrloss.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		System.out.println("pages"+pages);
		request.setAttribute("pages", pages);
		return "query";
	}
	
	/**
	 * 详细信息
	 */
	public String detail()
	{
		String id=request.getParameter("cid");
		String dNo=request.getParameter("dNo");
		//获取info
		String info = request.getParameter("info");
		System.out.println("id:"+id+"    No:"+dNo);
		if(id!=null&&id!=""){
			Ruin ruin=(Ruin) proOrloss.somePorLoss(" and id="+Integer.parseInt(id)).get(0);
			System.out.println(ruin);
			request.setAttribute("ruinList", ruin);
		}
		String empid=ck.getCookie(request, "employeeId");
		System.out.println("ck::::"+empid);
		boolean flag=audBussiness.checkemp(dNo, empid);
		System.out.println("saleActionflag:::::"+flag);
		if(flag){
			request.setAttribute("mark", "mark");
		}
		boolean flag1=audBussiness.checkemp1(dNo, empid);
		if(flag1)
		{
			request.setAttribute("quanxian", "quanxian");
		}
		if(null != info && ( info == "info" || info.equals("info"))){
			
			if(dNo!=null){
				String addhql2=" and orderNo='"+dNo+"'";
				
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
		return "info";
	}
	
	/**
	 * 更新显示
	 */
	public String updateShow()
	{
		String id=request.getParameter("cid");
		if(id!=null&&id!="")
		{
			Ruin ruin=(Ruin)proOrloss.somePorLoss(" and id="+id).get(0);
			request.setAttribute("oneRuin", ruin);
		}
		return "newPorLoss";
	}
	
	/**
	 * 修改页面
	 */
	public String edit()
	{
		boolean flag=this.addAndedit("edit");
		try
		{
			if(flag)
				response.getWriter().print("0");
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			logger.error("修改报损报溢时出错",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 删除选中报损报溢单
	 */
	public String del()
	{
		boolean flag=proOrloss.delPorLoss(ids);
		try
		{
			if(flag){
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一些报损单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(StringUtil.arrayToString(ids));
					executerecord.setEntityName("Ruin");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				response.getWriter().print("0");
			}
			else
			{
				response.getWriter().print("1");
			}
		}
		catch(Exception ex)
		{
			logger.error("报损报溢单删除时错误Action！",ex);
			ex.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 审核成功后执行的事件
	 * @return
	 */
	public String auditingPass()
	{
		boolean flag=false;
		String orderNo=request.getParameter("orderNo");
		try
		{
			flag=proOrloss.auditingPass(orderNo);
			if(flag)
				response.getWriter().print("0");
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			try {
				response.getWriter().print("1");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	
	
	

	
}

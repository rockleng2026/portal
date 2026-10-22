package com.fuao.fajxc.action.purchasing;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.finance.ChargeBussiness;
import com.fuao.fajxc.bussiness.purchase.RequisitioningBusssiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StrUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.ApplyBuy;
import com.fuao.fajxc.vo.ApplyBuyinfo;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Model;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 请购单Action
 * 
 * @author 14012
 * 
 */
public class RequisitioningAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private RequisitioningBusssiness requisitioningBusssiness;
	private ChargeBussiness chargeBussiness;
	private AuditingBussiness audBussiness;
	private ExecuteRecordBussiness executeRecordBussiness;
	
	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	Cookies ck = new Cookies();
	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	ApplyBuy applyBuy;

	public ChargeBussiness getChargeBussiness() {
		return chargeBussiness;
	}

	public void setChargeBussiness(ChargeBussiness chargeBussiness) {
		this.chargeBussiness = chargeBussiness;
	}

	public RequisitioningBusssiness getRequisitioningBusssiness() {
		return requisitioningBusssiness;
	}

	public void setRequisitioningBusssiness(
			RequisitioningBusssiness requisitioningBusssiness) {
		this.requisitioningBusssiness = requisitioningBusssiness;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;

	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;

	}

	public ApplyBuy getApplyBuy() {
		return applyBuy;
	}

	public void setApplyBuy(ApplyBuy applyBuy) {
		this.applyBuy = applyBuy;
	}

	public Object getModel() {
		applyBuy = new ApplyBuy();
		return applyBuy;
	}

	/**
	 * 查询请购单信息
	 * 
	 * @return
	 */
	public String get() {
		
		String marker2=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker2);
		request.setAttribute("taskid", taskid);
		
		String hql = "from ApplyBuy where delflag=0 ";
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+id;
		}
		String dpage = request.getParameter("pageNo");
		int pageNo = 1;
		String name = request.getParameter("applyBuyNo");
		if (name != null && !name.equals("")) {
			hql += " and applyBuy like '%" + name + "%'";
		}
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		} else {
			if(null != request.getParameter("order"))
			{
				hql += " order by "+request.getParameter("order")+" desc";
			}else
			{
				hql += " order by id desc";
			}
			request.getSession().setAttribute("hql", hql);
		}
		Map map = (Map)ActionContext.getContext().get("map");
		Pages pages = requisitioningBusssiness.paginationQuery(hql, pageNo, 10,	null);
		request.setAttribute("pages", pages);
		request.getSession().setAttribute("tag", request.getParameter("order"));
		request.getSession().setAttribute("option", map);
		return "success";
	}

	/**
	 * * 跳转到添加请购单 页面
	 * 
	 * @return
	 */
	public String addpage() {

		request.setAttribute("empList", chargeBussiness.getEmp());
		return "add";
	}

	/**
	 * 添加请购单
	 * 
	 * @throws UnsupportedEncodingException
	 * 
	 */
	public String add() throws UnsupportedEncodingException {
		FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,
				"EveryDaySerialNumber.dat");
		
		//判断是否分公司的员工登录获取分公司部门的代号标识
		String fmark=ck.getCookie(request, "filialemark");
		
		String no = serial.getSerialNumber(); // 生成请购单号
		String allmedel = request.getParameter("allmodels"); // 获取请购单商品型号ID集合
		String alltype = request.getParameter("alltypes"); // 获取请购单商品类型Id集合
		String nums = request.getParameter("allnums"); // 获取购买数量集合
		String orderNo="QG" +"-"+ no;
		applyBuy.setApplyBuy(orderNo);
		String empID = request.getParameter("empid");
		Employee emp = (Employee) requisitioningBusssiness.getObj(
				Employee.class, "id", empID);
		applyBuy.setEmployeeByEmployeeId(emp);
		applyBuy.setRemark(URLDecoder.decode(applyBuy.getRemark(), "UTF-8"));
		applyBuy.setDelflag("0");
		
		int id = requisitioningBusssiness.adda(applyBuy);
		String sId = String.valueOf(id);
		
		System.out.println(id);
		if(id>0)
		{
			audBussiness.addAuditingOrder("QG",orderNo,"ApplyBuy",fmark);
		}
		if (id > 0) {

			int strnum = StrUtil.getSubNumber(allmedel, "-");
			if (strnum > 0) {
				String[] model = allmedel.split("-");
				String[] type = alltype.split("-");
				String[] num = nums.split("-");
				ApplyBuy applyBuy = (ApplyBuy) requisitioningBusssiness
						.getApplyBuy(id);
				for (int i = 0; i < model.length; i++) {
					ApplyBuyinfo a = new ApplyBuyinfo();
					a.setApplyBuy(applyBuy);
					a.setCommodityTpye((CommodityTpye) requisitioningBusssiness
							.getObj(CommodityTpye.class, "id", type[i]));
					a.setModel((Model) requisitioningBusssiness.getObj(
							Model.class, "id", model[i]));
					a.setCount(Integer.parseInt(num[i]));
					a.setDel("0");
					requisitioningBusssiness.adda(a);
					
				}
			} else {
				ApplyBuyinfo a = new ApplyBuyinfo();
				a.setApplyBuy(applyBuy);
				a.setCommodityTpye((CommodityTpye) requisitioningBusssiness
						.getObj(CommodityTpye.class, "id", alltype));
				a.setModel((Model) requisitioningBusssiness.getObj(Model.class,
						"id", allmedel));
				a.setCount(Integer.parseInt(nums));
				a.setDel("0");
				requisitioningBusssiness.addApplyBuyInfo(a);

				requisitioningBusssiness.adda(a);
			}
		}
		/*添加动态 author 14015*/
		//拿到登陆员工用户
		Employee loginEmp = (Employee)ServletActionContext.getContext().get("emp");
		//添加记录到动态记录表
		if(loginEmp != null){
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("添加了一个请购单。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(sId);
			executerecord.setEntityName("ApplyBuy");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}

		return "success";
	}

	/**
	 * 根据请购单ID查询请购单详情 进行修改跟详细信息查询
	 */
	public String selectInfo() {
		String id = request.getParameter("applyBuyinId");
		String dpage = request.getParameter("pageNo");
		String trm = request.getParameter("trm");
		
		//获取info
		String info = request.getParameter("info");
		ApplyBuy applybuy = (ApplyBuy) requisitioningBusssiness.getObj(
				ApplyBuy.class, "id", id);
		if (trm == "update" || trm.equals("update")) {
			List list = requisitioningBusssiness.getappluInfo(id);
			
			request.setAttribute("list", list);
			request.setAttribute("applybuy", applybuy);
			return this.addpage();
		}
		int pageNo = 1;
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
		}
		String hql = "from ApplyBuyinfo where del=0 and pplyBuyNo = " + id
				+ "order by id desc";
		Pages pages = requisitioningBusssiness.paginationQuery(hql, pageNo, 10, null);
		
		if(null != info && ( info == "info" || info.equals("info"))){
			String empid=ck.getCookie(request, "employeeId");
			System.out.println("ck::::"+empid);
			boolean flag=audBussiness.checkemp(applybuy.getApplyBuy(), empid);
			System.out.println("saleActionflag:::::"+flag);
			if(flag){
				request.setAttribute("mark", "mark");
			}
			boolean flag1=audBussiness.checkemp1(applybuy.getApplyBuy(), empid);
			if(flag1)
				request.setAttribute("quanxian", "quanxian");
			if(applybuy.getApplyBuy()!=null){
				String addhql2=" and orderNo='"+applybuy.getApplyBuy()+"'";
				
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
		request.setAttribute("applybuy", applybuy);
		request.setAttribute("pages", pages);
		return "info";
	}

	/**
	 * 修改请购单信息
	 * 
	 * @return
	 */
	public String update() {
		String allmedel = request.getParameter("allmodels"); // 获取请购单商品型号ID集合
		String alltype = request.getParameter("alltypes"); // 获取请购单商品类型Id集合
		String nums = request.getParameter("allnums"); // 获取购买数量集合
		String allapplyBuyInfoID = request.getParameter("allapplyBuyInfos"); // 获取请购单购买商品ID集合
		String applyBuyID = request.getParameter("applybuyId");// 获取到请购单ID
		
		String empID = request.getParameter("empid");
		
		Employee emp = (Employee) requisitioningBusssiness.getObj(Employee.class, "id", empID);
		
		ApplyBuy apply = (ApplyBuy) requisitioningBusssiness.getObj(ApplyBuy.class, "id", applyBuyID);
		apply.setEmployeeByEmployeeId(emp);
		apply.setId(Integer.parseInt(applyBuyID));
		boolean boo = false;
		boolean b = requisitioningBusssiness.upApplyBuy(apply);
		if (b) {
			// 判断是否有ID
			int strnum = allapplyBuyInfoID.length();
			//System.out.println(allapplyBuyInfoID.length());
			if (strnum > 0) {
				String[] applyBuyInfoID = allapplyBuyInfoID.split("-");
				String[] model = allmedel.split("-");
				String[] type = alltype.split("-");
				String[] num = nums.split("-");

				String[] strapplyBuyInfoID = new String[model.length];
				if (applyBuyInfoID.length < model.length) {
					for (int i = 0; i < model.length; i++) {
						if (i < applyBuyInfoID.length) {
							strapplyBuyInfoID[i] = applyBuyInfoID[i];
						} else {
							strapplyBuyInfoID[i] = "0";
						}

					}
				}

				for (int i = 0; i < model.length; i++) {
					ApplyBuyinfo a = new ApplyBuyinfo();
					if (strapplyBuyInfoID[i] != "0") {
						a.setId(Integer.parseInt(applyBuyInfoID[i]));
					}
					a.setApplyBuy(apply);
					a.setCommodityTpye((CommodityTpye) requisitioningBusssiness.getObj(CommodityTpye.class, "id", type[i]));
					a.setModel((Model) requisitioningBusssiness.getObj(Model.class, "id", model[i]));
					a.setCount(Integer.parseInt(num[i]));
					a.setDel("0");
					requisitioningBusssiness.upApplyBuyInfo(a);
				}
			} else {
				ApplyBuyinfo a = new ApplyBuyinfo();
				a.setApplyBuy(apply);
				a.setCommodityTpye((CommodityTpye) requisitioningBusssiness
						.getObj(CommodityTpye.class, "id", alltype));
				a.setModel((Model) requisitioningBusssiness.getObj(Model.class,
						"id", allmedel));
				a.setCount(Integer.parseInt(nums));
				a.setDel("0");
				boo = requisitioningBusssiness.addApplyBuyInfo(a);
			}
			if (b && boo) {
				try {
					response.getWriter().print("1");
				} catch (IOException e) {

					e.printStackTrace();
				}
			} else
				try {
					response.getWriter().print("0");
				} catch (IOException e) {

					e.printStackTrace();
				}
				
			/*添加动态 author 14015*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) ServletActionContext.getContext().get("emp");
			//添加记录到动态记录表
			if(loginEmp != null){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("修改了一个请购单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(apply.getId().toString());
				executerecord.setEntityName("ApplyBuy");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
		}

		return null;
	}

	/**
	 * 删除请购单的商品
	 */
	public String delApplyBuyInfo() {
		boolean b = false;
		String id = request.getParameter("id");
		ApplyBuyinfo applyBuyinfo = (ApplyBuyinfo) requisitioningBusssiness
				.getObj(ApplyBuyinfo.class, "id", id);
		if (applyBuyinfo != null) {
			applyBuyinfo.setDel("1");
			b = requisitioningBusssiness.upApplyBuyInfo(applyBuyinfo);
		}
		if (b) {
			try {
				response.getWriter().println("0");
				
			} catch (IOException e) {

				e.printStackTrace();
			}
		}
		return null;
	}

	//删除了请购单
	public void delapplyBuy() throws IOException {
		boolean b = false;
		String id = request.getParameter("id");
		ApplyBuy applyBuy = (ApplyBuy) requisitioningBusssiness.getObj(
				ApplyBuy.class, "id", id);
		if (applyBuy != null) {
			applyBuy.setDelflag("1");
			b = requisitioningBusssiness.upApplyBuy(applyBuy);
		}
		if (b) {
			response.getWriter().println(1);

			/*添加动态 author 14015*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) ServletActionContext.getContext().get("emp");
			//添加记录到动态记录表
			if(loginEmp != null){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("删除了一个请购单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(applyBuy.getId().toString());
				executerecord.setEntityName("ApplyBuy");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
		} else {
			response.getWriter().println(0);
		}

	}

}

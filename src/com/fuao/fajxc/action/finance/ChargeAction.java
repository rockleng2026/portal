package com.fuao.fajxc.action.finance;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.finance.ChargeBussiness;
import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.bussiness.system.DocmentBussiness;
import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.dao.finance.ChargeDao;
import com.fuao.fajxc.dao.finance.FinanceDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.util.paging.Page;
import com.fuao.fajxc.util.paging.Result;
import com.fuao.fajxc.utilinterface.PublicMissionType;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Charge;
import com.fuao.fajxc.vo.CurrencyProcess;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.RechargeLog;
import com.fuao.fajxc.vo.SaleGoods_mids;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Sale_goods;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.SaledFlow;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;
import com.opensymphony.xwork2.ModelDriven;

public class ChargeAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {

	private static Logger logger = Logger.getLogger(ChargeAction.class);
	/**
	 * 
	 * 收款单信息
	 * 
	 * @return
	 */
	private ChargeBussiness chargeBussiness;
	private DocmentBussiness docuBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Charge charge;
	private EmployeeBussiness empbiz;
	private AuditingBussiness audBussiness;
	private SaleorderBussiness sobiz;
	private List orderlist;
	private ChargeDao dao;
	private String getMoneyName;
	private String checkchars;
	private SaleorderBussiness saledBussis;
	//添加动态记录
	private ExecuteRecordBussiness executeRecordBussiness;
	
	
	public SaleorderBussiness getSaledBussis() {
		return saledBussis;
	}

	public void setSaledBussis(SaleorderBussiness saledBussis) {
		this.saledBussis = saledBussis;
	}

	public String getCheckchars() {
		return checkchars;
	}

	public void setCheckchars(String checkchars) {
		this.checkchars = checkchars;
	}

	public DocmentBussiness getDocuBussiness() {
		return docuBussiness;
	}

	public void setDocuBussiness(DocmentBussiness docuBussiness) {
		this.docuBussiness = docuBussiness;
	}

	public String getGetMoneyName() {
		return getMoneyName;
	}

	public void setGetMoneyName(String getMoneyName) {
		this.getMoneyName = getMoneyName;
	}

	public ChargeDao getDao() {
		return dao;
	}

	public void setDao(ChargeDao dao) {
		this.dao = dao;
	}

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	Cookies ck=new Cookies();

	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	public Charge getCharge() {
		return charge;
	}

	public void setCharge(Charge charge) {
		this.charge = charge;
	}

	public Object getModel() {
		charge = new Charge();
		return charge;
	}

	public EmployeeBussiness getEmpbiz() {
		return empbiz;
	}

	public void setEmpbiz(EmployeeBussiness empbiz) {
		this.empbiz = empbiz;
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

	public ChargeBussiness getChargeBussiness() {
		return chargeBussiness;
	}

	public void setChargeBussiness(ChargeBussiness chargeBussiness) {
		this.chargeBussiness = chargeBussiness;
	}

	public SaleorderBussiness getSobiz() {
		return sobiz;
	}

	public void setSobiz(SaleorderBussiness sobiz) {
		this.sobiz = sobiz;
	}

	public List getOrderlist() {
		return orderlist;
	}

	public void setOrderlist(List orderlist) {
		this.orderlist = orderlist;
	}

	/**
	 * 查询收款单
	 * 
	 * @return
	 */
	public String select() {
		String marker2=request.getParameter("marker");
		String taskid=request.getParameter("taskid");
		String id = request.getParameter("id");
		
		request.setAttribute("marker", marker2);
		request.setAttribute("taskid", taskid);
		
		String hql = "from Charge where del = 0 ";
		if(id!=null && !id.equals("")){
			int sid = Integer.parseInt(id);
			hql += " and id="+sid;
		}
		String dpage = request.getParameter("pageNo");
		String name = request.getParameter("name");
		int pageNo = 1;

		if (name != null && !name.equals("")) {
			hql = "and chargeNo like '%" + name + "%'";
		}
		if (dpage != null && !dpage.equals("")) {
			hql = request.getSession().getAttribute("hql").toString();
			pageNo = Integer.parseInt(dpage);
		} else {
			if (null != request.getParameter("order")) {

				hql += " order by " + request.getParameter("order") + " desc";
			} else {
				hql += " order by id desc";
			}
			request.getSession().setAttribute("hql", hql);
		}

		Pages pages = chargeBussiness.paginationQuery(hql, pageNo, 10, null);
		request.setAttribute("pages", pages);
		request.setAttribute("tag", request.getParameter("order"));
		return "success";
	}

	/**
	 * 跳转到添加收款单页面
	 */
	public String addPage() {
		List empList = this.chargeBussiness.getEmp();
		List saleOrderList = this.chargeBussiness.getSaleOrder();
	
		request.setAttribute("saleOrderList", saleOrderList);
		request.setAttribute("empList", empList);
		logger.error("h139:addPage");
		return "add";
	}

	/**
	 * 添加收款单
	 */
	public String add() {
		FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,"EveryDaySerialNumber.dat");
		String no = serial.getSerialNumber();
		String cno = "SK-" + no;
		
		int empId = Integer.parseInt(request.getParameter("empID")); // 获得收款确认员工ID
		String loginName = (String) request.getSession().getAttribute("loginName"); // 获取登录员工的登录名
		int saleOrderId = Integer.parseInt(request.getParameter("saleOrderNoid")); // 获得订单ID
		Sale_orders saleOrder = chargeBussiness.getSaleOrderOnes(saleOrderId); // 根据id查询订单实体
		Employee e1 = (Employee) chargeBussiness.getObj(loginName); // 根据登录名找到用户信息
		Employee e = empbiz.oneEmp(empId); // 根据ID查询工实体
		String sqlm = "from SaleGoods_mids as sm where sm.sale_orders.soId="+saleOrderId;
		SaleGoods_mids goodsMids = (SaleGoods_mids) chargeBussiness.find(sqlm).get(0);
		Employee employee = (Employee) request.getSession().getAttribute("emp");
		Sale_goods goods = goodsMids.getSale_goods();
		
		
		//审核人
		String hqlsg = " update sale_orders ";
//		/查询当前登入人的的部门
		String hql="select e.department from Employee e where e.id="+employee.getId();
		List listdepartment = chargeBussiness.getdepart(employee.getId());
		if(listdepartment != null && listdepartment.size() > 0)
		{
			Department department = (Department) listdepartment.get(0);
//			/如果部门为31的那么就是财务部
			if(department.getId().toString().equals("31"))
			{
				//==31的部门不用审批那么
				charge.setIsAuditing(1);
				if(goods.getSgchecks().equals("0"))
				{
					hqlsg+=" set so_stat =12,meetprice="+charge.getPaymentAmount();
				}
				else
				{
					hqlsg+=" set so_stat =3,meetprice="+charge.getPaymentAmount();
				}
			}else
			{
				//其他的要通过财务部才能审批
				charge.setIsAuditing(0);
				if(goods.getSgchecks().equals("0"))
				{
					hqlsg+=" set so_stat =12";
				}
				else
				{
					hqlsg+=" set so_stat =2";
				}
			}
		}
//		
		charge.setEmployeeByEmployeeId(e1);
		charge.setEmployeeByEmpId(e);
		charge.setOrders(saleOrder);
		charge.setChargeNo(cno);
		charge.setDel("0");
		System.out.println(e1.getId());
		Charge cha = chargeBussiness.addReturnCharge(charge);
		
		//改订单状态
		hqlsg +="  where so_id ="+saleOrderId;
		boolean falg = chargeBussiness.updateSg(hqlsg);
		if(falg ==true)
		{
			logger.info("update stat success 2");
		}
		
		if (null != cha) {
//			audBussiness.addAuditingOrder("SK", charge.getChargeNo(),"Charge",ck.getCookie(request, "filialemark"));
//			response.setCharacterEncoding("GBK");
			
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("添加了一个收款单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(cha.getId().toString());
				executerecord.setEntityName("Charge");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			return "select";
		}
		return "error";
	}

	/**
	 * 根据ID查询到收款单信息 跳转到修改收款单页面
	 */
	public String updatePage() {
		String purNo = request.getParameter("purNo");
		String trim = request.getParameter("trim");
		String id = request.getParameter("id");
		String info = request.getParameter("info");
		String isa=request.getParameter("isa");
		Charge charge = chargeBussiness.getCharge(id);
		request.setAttribute("charge", charge);
		if(null != info && ( info == "info" || info.equals("info")))
		{
			if(charge.getChargeNo()!=null)
			{
				String addhql2=" and orderNo='"+charge.getChargeNo()+"'";
				List audList=audBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if(null != audList && audList.size()>0)
				{
					String depid = ck.getCookie(request, "departmentId");
					for(int i=0; i<audList.size(); i++)
					{
						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
						if(aot.getDepartment().getId() == Integer.parseInt(depid)&& aot.getAuditingFlag() ==0 )
						{
							//表示未审核
							request.setAttribute("flage", 0);
						}else if(aot.getDepartment().getId() == Integer.parseInt(depid)&&
								(aot.getAuditingFlag() ==1 ||aot.getAuditingFlag()==2))
						{
							//表示已经审核
							request.setAttribute("flage", 1);
							request.setAttribute("aot", aot);
						}
					}
				}
				
				String empid=ck.getCookie(request, "employeeId");
//				boolean flag=audBussiness.checkemp(charge.getChargeNo(), empid);
				
				Employee employee = (Employee) request.getSession().getAttribute("emp");
				
//				/查询当前登入人的的部门
				List listdepartment = chargeBussiness.getdepart(employee.getId());
				if(listdepartment != null && listdepartment.size() > 0)
				{
					Department department = (Department) listdepartment.get(0);
//					/如果部门为31的那么就是财务部
					if(department.getId().toString().equals(PublicMissionType.empfinan.toString()) && !charge.getIsAuditing().toString().equals("2") && !charge.getIsAuditing().toString().equals("1"))
					{
						request.setAttribute("mark","mark");
					}
				}
				
//				if(flag){
//					request.setAttribute("mark", "mark");
//				}
//				boolean flag1=audBussiness.checkemp1(charge.getChargeNo(), empid);
//				if(flag1)
//					request.setAttribute("quanxian", "quanxian");
			}
			
			
		}
		if(charge.getIsAuditing() == 8)
		{
			request.removeAttribute("mark");
		}
		if("1".equals(isa)||"2".equals(isa)||"info".equals(info))
			return "ChargeInfo";
		return "up";
	}

	/**
	 * 修改收款单信息
	 */
	public String update() {
		logger.info("comfirm="+getMoneyName);
		logger.info("isAuding="+checkchars);
		int saleOrderId = Integer.parseInt(request.getParameter("saleOrderNo")); // 获得订单ID
		SaleOrder saleOrder = chargeBussiness.getSaleOrderOne(saleOrderId); // 根据id查询订单实体
		if(getMoneyName!="" || !getMoneyName.equals("")){
			charge.setIsAuditing(Integer.parseInt(checkchars));
			Employee ep = (Employee) chargeBussiness.getObj(getMoneyName);
			charge.setEmployeeByEmpId(ep);
			if(charge.getIsAuditing()==1){
				List<RechargeLog>rechList=docuBussiness.selAllKinddatas("from RechargeLog r where r.orderno='"+saleOrder.getSaleOrderNo()+"'  order by id desc");
				for (RechargeLog reLog : rechList) {
					logger.info("id="+reLog.getId());
					Double monyDouble=Double.valueOf(reLog.getBalanc())-charge.getAccountPayable();
					reLog.setBalanc(monyDouble+"");
					docuBussiness.updtRecharge(reLog);
					break;
				}
				SaledFlow sdfw=new SaledFlow();
				sdfw.setDfId(0);
				sdfw.setTsaleorders(saleOrder);
				sdfw.setDfContent("财务已审核，等待按排运维人员上架...");
				sdfw.setDftime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
				saledBussis.saveFlowInfo(sdfw);
				
			}
		}else{
			int empId = Integer.parseInt(request.getParameter("empID")); // 获得收款确认员工ID
			String loginName = (String) request.getSession().getAttribute("loginName"); // 获取登录员工的登录名
			Employee e1 = (Employee) chargeBussiness.getObj(loginName); // 根据登录名找到用户信息
			Employee e = empbiz.oneEmp(empId); // 根据ID查询员工实体
			charge.setEmployeeByEmployeeId(e1);
			charge.setEmployeeByEmpId(e);
		}
		charge.setSaleOrder(saleOrder);
		charge.setDel("0");
		boolean b = chargeBussiness.updateCharge(charge);
		if (b) {
			/*阙超强 14015   添加记录动态信息*/
			//拿到登陆员工用户
			Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
			//添加记录到动态记录表
			if(null != loginEmp){
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("修改了一个收款单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(charge.getId().toString());
				executerecord.setEntityName("Charge");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
			}
			
			return this.select();
		}
		return "error";
	}

	/**
	 * 删除收款单信息
	 */
	public String del() {
		String id = request.getParameter("id");
		boolean b = chargeBussiness.delCharge(id);
		if (b) {
			try {
				/*阙超强 14015   添加记录动态信息*/
				//拿到登陆员工用户
				Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
				//添加记录到动态记录表
				if(null != loginEmp){
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("删除了一个收款单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(id);
					executerecord.setEntityName("Charge");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
				}
				
				response.getWriter().print(1);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		return null;
	}
	/*
	 * 把接收状态改了
	 */
	public String updateAud()
	{
		try {
			String id = request.getParameter("id");
			String sql = "update charge set isAuditing =8 where Id = "+new Integer(id);
			int count = this.chargeBussiness.updateisAu(sql);
			response.setCharacterEncoding("gbk");
			if(count >0)
			{
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("2");
			}
		} catch (Exception e) {
			logger.info("");
		}
		return null;
	}
	/*
	 * 审核状态
	 */
	public String updateAuds()
	{
		try {
			String id = request.getParameter("id");
			String sql = "update charge set isAuditing =2 where Id = "+new Integer(id);
			int count = this.chargeBussiness.updateisAu(sql);
			response.setCharacterEncoding("gbk");
			if(count >0)
			{
				//修改订单状态
				String soid = request.getParameter("soid");
				String chid = request.getParameter("chid");
				String hqlch = " from Charge as c where 1=1 and c.id="+new Integer(chid);
				
				Charge charge = (Charge) chargeBussiness.find(hqlch).get(0);
				
				Sale_orders saleOrder = chargeBussiness.getSaleOrderOnes(new Integer(soid)); // 根据id查询订单实体
				String hqlsg = " update sale_orders set so_stat =3,meetprice="+charge.getPaymentAmount()+" where 1=1 ";
				
				
				
				if(soid != null && !soid.equals(""))
				{
					hqlsg += "  and so_id ="+new Integer(soid);
				}else
				{
					hqlsg += "  and so_id =0";
				}
				boolean falg = chargeBussiness.updateSg(hqlsg);
				
				
				
				//获取时间
				java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
				java.util.Date currentTime = new java.util.Date();//得到当前系统时间 
				String str_date1 = formatter.format(currentTime); //将日期时间格式化 
				//request.setAttribute("sNum",sgorderNum);//这个和sgnum值一样
				//流程通用通用方法(定单状态---生成定单，待付款-定单号，生成时间，
				CurrencyProcess cp=new CurrencyProcess();
				cp.setPname("客户付款待财务审核");//对应流程名字
				cp.setPnum(saleOrder.getSoNums());//对应定单名字
				cp.setPstat(3);//对应定单状态
				cp.setBegintime(str_date1);
				chargeBussiness.save(cp);
				if(falg == true)
				{
					logger.info("update stat success");
				}
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("2");
			}
		} catch (Exception e) {
			logger.info("");
		}
		return null;
	}
	/*
	 * 客户验证码
	 */
	public String selectBycode()
	{
		try {
			//验证码
			String code = request.getParameter("code");
			if(code.equals("123"))
			{
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("2");
			}
		} catch (Exception e) {
			logger.info("");
			return "error";
		}
		return null;
	}
}

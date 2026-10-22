package com.fuao.fajxc.action.contract;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.common.CommonBiz;
import com.fuao.fajxc.bussiness.contract.ContractBiz;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Contract;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class ContractAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {

	private HttpServletResponse response;

	private HttpServletRequest request;

	// 合同实体
	private Contract contract;

	// 合同操作BIZ
	private ContractBiz cbiz;

	// 上传附件通用BIZ
	private CommonBiz commbiz;

	// 定义审核流程操作BIZ
	private AuditingBussiness audBussiness;

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	// 添加动态记录业务类
	private ExecuteRecordBussiness executeRecordBussiness;

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	// 创建Cookies对象 用于获取登录用户信息
	Cookies ck = new Cookies();

	// 返回合同编号到页面
	public String getContractNO() throws IOException {

		FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,
				"EveryDaySerialNumber.dat");

		String no = serial.getSerialNumber();

		response.getWriter().print(no);

		System.out.println(no);

		return null;
	}

	/**
	 * 添加合同 在为合同添加附件
	 * 
	 * @return
	 */
	public String add() {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Employee emp = new Employee();

		Cookies cookie = new Cookies();

		String empId = cookie.getCookie(request, "employeeId");
		System.out.println(empId + "-------");

		if (null != empId && empId != "") {

			emp.setId(Integer.parseInt(empId));

			contract.setEmployeeByRepliedEmp(emp);
		}

		if ("".equals(contract.getContractAccessory())) {
			// 为合同设置唯一识别号
			contract.setContractAccessory(UUID.randomUUID().toString());
		}
		// 初始化合同的审核状态
		contract.setAuditState("0");

		// 初始化合同删除标记
		contract.setDelflag("0");

		// 设置添加时间 取系统当前时间
		contract.setRepliedTime(df.format(new Date()));

		int i = 0;
		String content = "";
		if (contract.getId() != null) {
			i = 1;
			content = "修改了一个合同。";
		} else {
			content = "添加了一个合同。";
		}

		Contract cont = cbiz.addReturn(contract);
		/* 阙超强 14015 添加记录动态信息 */
		// 拿到登陆员工用户

		String loginname = cookie.getCookie(request, "loginname");
		System.out.println(loginname + "111111");

		String hql = "From Employee where empNo='14001'";
		System.out.println(hql);
		// Employee loginEmp =cbiz.getEmployee(hql);
		// System.out.println(loginEmp.getName());

		HttpSession s = request.getSession();

		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		// request.getSession().

		// 添加记录到动态记录表
		if (loginEmp != null) {
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(emp);
			executerecord.setContent(content);
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(cont.getId().toString());
			executerecord.setEntityName("Contract");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}

		if (null != cont && i == 0) {
			String fmark = ck.getCookie(request, "filialemark");

			int marker = audBussiness.addAuditingOrder("HT", contract
					.getContractNo(), "Contract", fmark);
			// 返回0表示没有审核流程。则修改单据的审核状态为已审核
			if (marker == 0) {
				Contract con = cbiz.getOne("from Contract where contractNo ='"
						+ contract.getContractNo() + "'");
				if (null != con) {
					con.setAuditState("1");
					cbiz.addorup(con);
				}

			}

		}
		if (null != cont) {

			// 附加附件
			commbiz.addFJ(contract.getContractAccessory(), "Contract", request);

		}

		return "select";
	}

	/**
	 * 查询合同列表
	 * 
	 * @return
	 */
	public String select() {

		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		// String contractNo = request.getParameter("cname");
		String ss = request.getParameter("ss");
		if (ss != null) {
			String str = request.getParameter("name2");
			System.out.println(str + "+++");
			request.getSession().setAttribute("cname2", str);
		}

		String contractNo = (String) request.getSession()
				.getAttribute("cname2");

		System.out.println(contractNo + "---------------------");

		String hql = " from Contract where 1=1 and delflag ='0' ";

		if (contractNo != null && !contractNo.equals("")) {

			hql += " and contractNo like '%" + contractNo + "%'";
		}

		hql += "order by id desc";

		Pages pages = cbiz.paginationQuery(hql, Integer.parseInt(pageNo), 10,
				null);

		Map map = (Map) ActionContext.getContext().get("map");

		request.getSession().setAttribute("pages", pages);
		request.setAttribute("pages", pages);

		request.getSession().setAttribute("option", map);

		return "list";
	}

	public void selectf() throws IOException {
		String name = (String) request.getSession().getAttribute("cname2");
		System.out.println(name);
		if (name != null) {
			response.getWriter().print(name);
		} else {
			response.getWriter().print("");
		}
	}

	/**
	 * 点击修改时 根据前台传入的ID查询到合同以及合同附件列表 跳转到修改页面
	 * 
	 * @return
	 */
	public String goUpdate() {

		String id = request.getParameter("id");

		Contract contract = cbiz.getOneContract(id);

		String info = request.getParameter("info");

		if (null != contract) {

			List list = commbiz.getForm("CommonScfjb c", " and c.fbsbh ='"
					+ contract.getContractAccessory() + "'");

			request.setAttribute("contract", contract);

			request.setAttribute("fjlb", list);
		}

		// 如果是详细信息则跳转到详细信息页面
		if (null != info && (info == "info" || info.equals("info"))) {

			if (contract.getContractNo() != null) {
				String addhql2 = " and orderNo='" + contract.getContractNo()
						+ "'";

				List audList = audBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if (null != audList && audList.size() > 0) {

					String depid = ck.getCookie(request, "departmentId");

					for (int i = 0; i < audList.size(); i++) {

						AuditingOrderTab aot = (AuditingOrderTab) audList
								.get(i);

						if (aot.getDepartment().getId() == Integer
								.parseInt(depid)
								&& aot.getAuditingFlag() == 0) {

							// 表示未审核
							request.setAttribute("flage", 0);

						} else if (aot.getDepartment().getId() == Integer
								.parseInt(depid)
								&& (aot.getAuditingFlag() == 1 || aot
										.getAuditingFlag() == 2)) {

							// 表示已经审核
							request.setAttribute("flage", 1);

							request.setAttribute("aot", aot);

						}
					}

				}
			}

			String empid = ck.getCookie(request, "employeeId");
			System.out.println("ck::::" + empid);
			boolean flag = audBussiness.checkemp(contract.getContractNo(),
					empid);
			System.out.println("saleActionflag:::::" + flag);
			if (flag)
				request.setAttribute("mark", "mark");

			request.setAttribute("info", info);

			return "info";
		}
		return "add";
	}

	/**
	 * 删除合同
	 * 
	 * @return
	 * @throws IOException
	 */
	public String del() throws IOException {

		String id = request.getParameter("id");

		Contract contract = cbiz.getOneContract(id);

		contract.setDelflag("1");

		cbiz.addorup(contract);

		response.getWriter().print(0);

		/* 阙超强 14015 添加记录动态信息 */
		// 拿到登陆员工用户
		Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
		// 添加记录到动态记录表
		if (loginEmp != null) {
			Executerecord executerecord = new Executerecord();
			executerecord.setEmployee(loginEmp);
			executerecord.setContent("删除了一个合同。");
			executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
			executerecord.setEntityId(id);
			executerecord.setEntityName("Contract");
			executerecord.setSeenEmpId("");
			executeRecordBussiness.addData(executerecord);
		}

		return null;

	}


	// get set方法
	public CommonBiz getCommbiz() {
		return commbiz;
	}

	public void setCommbiz(CommonBiz commbiz) {
		this.commbiz = commbiz;
	}

	public Object getModel() {

		contract = new Contract();

		return contract;
	}

	public void setServletRequest(HttpServletRequest request) {

		this.request = request;

	}

	public void setServletResponse(HttpServletResponse response) {

		this.response = response;

	}

	public ContractBiz getCbiz() {
		return cbiz;
	}

	public void setCbiz(ContractBiz cbiz) {
		this.cbiz = cbiz;
	}

	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

}

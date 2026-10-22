package com.fuao.fajxc.action.customService;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.aspectj.weaver.patterns.IfPointcut.IfFalsePointcut;

import com.fuao.fajxc.bussiness.system.MessageremindBiz;
import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.customService.MalfunctionDeclarBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Email;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.utilinterface.General;
import com.fuao.fajxc.utilinterface.PublicMissionType;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Conkoutask;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Messageremind;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.UpServer;
import com.opensymphony.xwork2.ModelDriven;

/**
 * 故障申报Action
 * 
 * @author 14012
 * 
 */
public class MalfunctionDeclareAction implements ModelDriven,
		ServletRequestAware, ServletResponseAware {

	private MalfunctionDeclarBussiness mdbiz; // 注入BIZ层

	private HttpServletRequest request; // 定义request

	private HttpServletResponse response; // 定义response

	private General general;

	private ConkOut co;

	private CustomerBussiness customerBussiness;

	private MessageremindBiz messager;

	public MessageremindBiz getMessager() {
		return messager;
	}

	public void setMessager(MessageremindBiz messager) {
		this.messager = messager;
	}

	Cookies cookie = new Cookies();
	private static Logger logger = Logger
			.getLogger(MalfunctionDeclareAction.class);
    private String ftime;
	// 获取系统当前时间并格式成为字符串
	Date d = new Date();

	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat(
			"yyyy-MM-dd");

	// 声明置文件工具
	PropertyEditor proEdit = new PropertyEditor();

	public CustomerBussiness getCustomerBussiness() {
		return customerBussiness;
	}

	public void setCustomerBussiness(CustomerBussiness customerBussiness) {
		this.customerBussiness = customerBussiness;
	}

	public MalfunctionDeclarBussiness getMdbiz() {
		return mdbiz;
	}

	public void setMdbiz(MalfunctionDeclarBussiness mdbiz) {
		this.mdbiz = mdbiz;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;

	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;

	}

	public Object getModel() {
		co = new ConkOut();
		return co;
	}

	/**
	 * 客户故障查询
	 */
	public String get() {

		String customerid = cookie.getCookie(request, "customerId");
		if (null == request.getSession().getAttribute("loginName")
				&& request.getSession().getAttribute("loginName").equals("")) {
			return "login";
		}
		String hql = "from ConkOut where delflag=0";

		String dpage = request.getParameter("pageNo");
		String name = request.getParameter("cname");
		int pageNo = 1;
		if (name != null && !name.equals("")) {
			hql += " and customer.customerName like '%" + name + "%'";
		}
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		} else {
			if (null != request.getParameter("order")) {
				hql += " order by " + request.getParameter("order") + " desc";
			} else {

				hql += " order by faultTime desc";
			}
			request.getSession().setAttribute("hql", hql);
		}
		Pages pages = mdbiz.get(hql, pageNo, 10, null);
		request.setAttribute("pages", pages);
		request.setAttribute("tag", request.getParameter("order"));
		request.setAttribute("mark", 10);
		return "myFaultList";
	}

	/**
	 * 跳转到添加故障工单客户页面
	 */
	public String gosubnote() {

		List orderType = mdbiz
				.somelist("from Questioncategory q where q.questioncategory.id=1 ");
		request.setAttribute("orderType", orderType);
		return "gosubnote";
	}

	/**
	 * 跳转到添加故障工单员工页面
	 */
	public String gosubnote2() {

		List orderType = mdbiz
				.somelist("from Questioncategory q where q.questioncategory.id=1 ");
		request.setAttribute("orderType", orderType);
		return "gosubnote2";
	}

	/**
	 * 有问必答添加问题以及故障(客户提交)
	 */
	public String addcon() {

		String scheme = request.getScheme(); // http
		String pid = request.getParameter("pid");
		System.out.println("我得到的ip是--------#E#E#E#E#E#E#E#E#E#E#-----" + pid);
		String servername = request.getServerName(); // ip
		int port = request.getServerPort(); // port
		String name = request.getSession().getServletContext().getRealPath("/"); // tomcat
		// 项目路径
		int i = (name.substring(0, name.length() - 1)).lastIndexOf("/");
		String objectname = name.substring(i + 1, name.length() - 1); // 项目名

		// 调用工具类生成单号
		FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,
				"EveryDaySerialNumber.dat");

		String no = serial.getSerialNumber();

		// 定义客户对象 获取到登录客户
		Customer c = new Customer();

		if (null != request.getSession().getAttribute("customer")) {

			// 从session中取出登录客户
			c = (Customer) request.getSession().getAttribute("customer");

		} else {

			return "error";
		}
		String desc = request.getParameter("descs");

		Conkoutask coa = new Conkoutask();

		co.setDelflag("0");

		co.setCustomer(c);

		co.setConkOutNo(no);

		co.setState("0");
		co.setIp(pid);

		co.setFaultTime(new java.sql.Timestamp(new java.util.Date().getTime()));

		coa.setFaultTime(dateFormat.format(d));

		coa.setDescs(desc);

		coa.setState(0);

		boolean b = mdbiz.addorupdate(co, coa);

		if (b) {
			// 定义邮件要发送的内容
			String urls = scheme + "://" + servername + ":" + port;

			String msg = "客户" + c.getCustomerName()
					+ "现在有故障需要处理(客户填写) 。点击下面的连接登录到系统<br/><A href= " + urls
					+ ">" + urls + "</A>";

			// 获得客服邮箱
			String callcenter = proEdit.getID("email").toString();

			String title = "故障处理";
			// 发送邮件提醒
			general.sendEmail("KHGZSB", title, callcenter, msg);

			String receiver = proEdit.getID("emp").toString();

			String[] receiverId = null;

			receiverId = receiver.split("'");

			// 发送短消息提醒
			general.sendMessage(request, "KHGZSB", "1", "有人需要处理故障(客户填写)",
					"有人需要处理故障了  请处理", receiverId);

			return "selectcom";

		} else {

			return "selectcom";
		}
	}

	/**
	 * 有问必答添加问题以及故障(员工提交)
	 */
	public String add() {
		// 调用工具类生成单号
		// FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,
		// "EveryDaySerialNumber.dat");
		//
		// String no = serial.getSerialNumber();
		// co.setDelflag("0");
		// co.setConkOutNo("GZD"+no);
		// co.setState("0");
		//	
		//
		// co.setFaultTime(new java.sql.Timestamp(new
		// java.util.Date().getTime()));
		// mdbiz.addorupdate(co);
		String string = request.getParameter("faultTime2");
		String scheme = request.getScheme(); // http
		String pid = request.getParameter("pid");
		System.out.println("我得到的ip是--------#E#E#E#E#E#E#E#E#E#E#-----" + pid);
		String servername = request.getServerName(); // ip
		int port = request.getServerPort(); // port
		String name = request.getSession().getServletContext().getRealPath("/"); // tomcat
		// 项目路径
		int i = (name.substring(0, name.length() - 1)).lastIndexOf("/");
		String objectname = name.substring(i + 1, name.length() - 1); // 项目名

		// 调用工具类生成单号
		FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,
				"EveryDaySerialNumber.dat");

		String no = serial.getSerialNumber();

		// 定义客户对象 获取到登录客户
		Customer c = new Customer();
		//
		if (null != co.getCustomer()
				&& co.getCustomer().getCustomerId() != null) {

			// 从session中取出登录客户
			c = (Customer) mdbiz.somelist(
					" From Customer where customerId ="
							+ co.getCustomer().getCustomerId()).get(0);

		} else {

			return "error";
		}

		String desc = request.getParameter("descs");

		Conkoutask coa = new Conkoutask();

		co.setDelflag("0");

		co.setCustomer(c);

		co.setConkOutNo(no);

		co.setState("0");
		co.setIp(pid);
		if (pid != null && !pid.trim().equals("")) {
			if (pid.contains("#")) {
				co.setIp(pid.split("#")[1]);
				if (!pid.startsWith("#")) {
					Product p = new Product();
					p.setId(Integer.parseInt(pid.split("#")[0]));
					co.setProduct(p);
				}
			} else {
				co.setIp(pid);
			}
		}
//		Timestamp t = Timestamp.valueOf(request.getParameter("faultTime"));
//		co.setFaultTime(new java.sql.Timestamp(new java.util.Date().getTime()));
//		co.setFaultTime(t);
		coa.setFaultTime(dateFormat.format(d));

		coa.setDescs(desc);

		coa.setState(0);

		boolean b = mdbiz.addorupdate(co, coa);

		if (b) {
			// 定义邮件要发送的内容
			String urls = scheme + "://" + servername + ":" + port;

			String msg = "客户" + c.getCustomerName()
					+ "现在有故障需要处理(员工填写) 。点击下面的连接登录到系统<br/><A href= " + urls
					+ ">" + urls + "</A>";

			// 获得客服邮箱
			String callcenter = proEdit.getID("email").toString();

			String title = "故障处理";
			// 发送邮件提醒
			general.sendEmail("KHGZSB", title, callcenter, msg);

			String receiver = proEdit.getID("emp").toString();

			String[] receiverId = null;

			receiverId = receiver.split("'");

			// 发送短消息提醒 客户故障申报-KHGZSB 在配置文件中查找
			general.sendMessage(request, "KHGZSB", "1", "有人需要处理故障(员工填写)",
					"有人需要处理故障了  请处理", receiverId);

			return "addsuccess";

		} else {

			return "addsuccess";
		}
	}

	/**
	 * 客户查询故障列表;
	 * 
	 * @return
	 */
	public String selectCom() {

		if (null != request.getSession().getAttribute("customer")) {

			int pageNo = 1;

			String dpage = request.getParameter("pageNo");

			if (dpage != null && dpage != "" && !dpage.equals("")) {

				pageNo = Integer.parseInt(dpage);
			}

			Customer c = (Customer) request.getSession().getAttribute(
					"customer");

			String hql = "";

			String mark = request.getParameter("mark");

			if (null != mark && mark != "" && !mark.equals("")) {

				if (mark == "Processing" || mark.equals("Processing")) // 正在处理
				{
					hql = "from ConkOut c where c.delflag = 0 and c.state between 1 and 3 and c.customer.customerId = "
							+ c.getCustomerId() + " order by id asc";

				} else if (mark == "untreated" || mark.equals("untreated")) {// 未处理

					hql = "from ConkOut c where c.delflag = 0 and c.state =0 and c.customer.customerId = "
							+ c.getCustomerId() + " order by id asc";

				} else if (mark == "ProcessOK" || mark.equals("ProcessOK")) { // 处理完成处理

					hql = "from ConkOut c where c.delflag = 0 and c.state =4 and c.customer.customerId = "
							+ c.getCustomerId() + " order by id asc";

					hql = "from ConkOut c where c.delflag = 0 and (c.state =4 or c.state=5) and c.customer.customerId = "
							+ c.getCustomerId() + " order by id desc";

				}
			} else {

				hql = "from ConkOut c where c.delflag = 0 and c.customer.customerId = "
						+ c.getCustomerId() + " order by id asc";
			}

			Pages pages = mdbiz.get(hql, pageNo, 10, null);

			request.setAttribute("pages", pages);

			return "notelist";
		}

		return null;
	}

	/**
	 * 跳转到问题评价
	 */
	public String issueEvaluation() {

		String id = request.getParameter("id");

		ConkOut co = mdbiz.getConkOut(id);

		request.setAttribute("conkout", co);

		request.setAttribute("pj", request.getParameter("pj"));

		return "issueEvaluate";
	}

	/**
	 * 添加问题评价以及对话
	 * 
	 * @throws IOException
	 */
	public String addEvaluation() throws IOException {

		response.setCharacterEncoding("utf-8");

		// 获取问题id
		String id = request.getParameter("id");

		ConkOut co2 = mdbiz.getConkOut(id);

		Iterator it = co2.getConkoutAsks().iterator();

		for (; it.hasNext();) {

			Conkoutask conk = (Conkoutask) it.next();

			if (conk.getSolveDepict() == null || conk.getSolveDepict() == "") {

				response.getWriter().print(1);
				return null;
			}
		}
		Customer c = new Customer();

		if (null != request.getSession().getAttribute("customer")) {

			// 从session中取出登录客户
			c = (Customer) request.getSession().getAttribute("customer");

		} else {

			return "error";
		}

		// 获取客户提交的内容
		String desc = java.net.URLDecoder.decode(request.getParameter("desc"),
				"UTF-8");

		String pj = request.getParameter("pj");

		String yawp = java.net.URLDecoder.decode(request.getParameter("yawp"),
				"UTF-8");

		ConkOut co = mdbiz.getco(ConkOut.class, id);

		Conkoutask coa = new Conkoutask();

		coa.setConkout(co);

		coa.setDescs(desc);

		coa.setFaultTime(dateFormat.format(d));

		coa.setYawp(yawp);

		coa.setState(0);

		co.setState("0");

		co.setAppraise(pj);

		co.setEmployee(null);

		mdbiz.addorupdate(co);

		mdbiz.addorupdate(coa);

		String uri = request.getContextPath();

		String object = request.getRequestURL().substring(0,
				request.getRequestURL().indexOf(uri));

		String url = object + "/" + uri;

		String scheme = request.getScheme(); // http
		String servername = request.getServerName(); // ip
		int port = request.getServerPort(); // port
		String name = request.getSession().getServletContext().getRealPath("/"); // tomcat
		// 项目路径
		int h = (name.substring(0, name.length() - 1)).lastIndexOf("/");
		String objectname = name.substring(h + 1, name.length() - 1); // 项目名
		String urls = scheme + "://" + servername + ":" + port + "/";

		String msg = "客户" + c.getCustomerName()
				+ "现在有故障需要处理 。点击下面的连接登录到系统<br/><A href= " + urls + ">" + urls
				+ "</A>";

		Email email = new Email();

		// 获得客服邮箱
		String callcenter = proEdit.getID("email").toString();

		email.sendEmail(callcenter, "故障处理", msg);

		String sendhql = "update Sendmessage set state=0 where sendtable='ConkOut' and sendtableId="
				+ id + "";

		int flag = mdbiz.updateConkout(sendhql);

		StringBuffer str = new StringBuffer();

		String hql = "from Conkoutask c where c.conkout.id =" + id
				+ " order by id asc";

		List<Conkoutask> conk = (List<Conkoutask>) mdbiz.somelist(hql);

		String technology = "";

		String evaluate = "";

		String disposeStatu = "";
		if (co.getState() == "0") {
			disposeStatu = "尚未受理";
		} else if (co.getState() == "4" || co.getState() == "5") {
			disposeStatu = "受理成功";
		} else if (co.getState() == "-1") {
			disposeStatu = "受理失败";
		} else if (co.getState() == "1") {
			disposeStatu = "已接受";
		} else {
			disposeStatu = "受理中";

		}

		if (co.getAppraise() == "1") {
			evaluate = "满意";
		} else if (co.getAppraise() == "2") {
			evaluate = "一般";
		} else if (co.getAppraise() == "3") {
			evaluate = "不满意";
		} else {

			evaluate = "未评价";
		}

		for (int i = 0; i < conk.size(); i++) {
			if (null != conk.get(i).getEmployeeByEmpId()) {
				technology = conk.get(i).getEmployeeByEmpId().getName();
			}
		}

		str
				.append("<table border='0' align=center cellpadding='9' cellspacing='1' width='95%' bgcolor='#CCCCCC'>"
						+ "<tr bgcolor='#FFFFFF'>"
						+ "<td bgcolor='#f0f0f0'>&nbsp;技术信息："
						+ " "
						+ technology
						+ "┊ 处理状态：<span style='color:#FF0000'> "
						+ disposeStatu
						+ "</span> ┊ 当前评价：<span style='color:#009F00'>"
						+ evaluate + "</span></td>" + "</tr></table><br>");
		if (null != conk && conk.size() > 0) {

			str
					.append("<table border='0' align=center cellpadding='9' cellspacing='1' width='95%' bgcolor='#CCCCCC'>");
			for (int i = 0; i < conk.size(); i++) {
				if (conk.get(i).getDescs() != null
						&& conk.get(i).getDescs() != "") {
					str.append("<tr bgcolor='#ffffff'>"
							+ "<td colspan='2' bgcolor='#f0f0f0'>&nbsp;问："
							+ conk.get(i).getDescs() + "</td>" + "</tr>");
				}
				if (conk.get(i).getSolveDepict() != null
						&& conk.get(i).getSolveDepict() != ""
						&& (conk.get(i).getIsMain() == "2"
								|| conk.get(i).getIsMain().equals("2")
								|| conk.get(i).getIsMain() == "3" || conk
								.get(i).getIsMain().equals("3"))) {
					str.append("<tr bgcolor='#ffffff'>"
							+ "<td colspan='2' bgcolor='#f0f0f0'>&nbsp;答："
							+ conk.get(i).getSolveDepict() + " </td>" + "</tr>"
							+ " </c:if>");

				}

			}
			str.append("</table>" + " <br /> ");
		}
		response.getWriter().print(str);
		return null;
	}

	/**
	 * 
	 * 查询故障单
	 */
	public String select() {
		String tag = request.getParameter("tag");
		String hql = "";

		// 获得登录员工资料
		String eid = cookie.getCookie(request, "employeeId");
		System.out.println("eid:::" + eid);
		String ename = cookie.getCookie(request, "employeeName");
		System.out.println("ename:::" + ename);
		String dep = cookie.getCookie(request, "departmentId");
		System.out.println("dep:::" + dep);

		System.out.println("tag:::" + tag);
		if (tag != null) {
			if (tag.equals("0"))
				hql = "from ConkOut where delflag = 0 and (state = 0 or state=1 or state=2 or state=3 or state =7 ) and employee.id="
						+ eid + "";
			else
				hql = "from ConkOut where delflag = 0 and  (state=4 or  state=5) and employee.id="
						+ eid + "";
		}

		System.out.println("hql::::" + hql);

		String dpage = request.getParameter("pageNo");
		String name = request.getParameter("cname");
		int pageNo = 1;
		if (name != null && !name.equals("")) {
			hql += " and customer.customerName like '%" + name + "%'";
		}
		// if (dpage != null && !dpage.equals("")) {
		// pageNo = Integer.parseInt(dpage);
		// //hql = request.getSession().getAttribute("hql").toString();
		// }else{
		// hql += " order by id desc";
		// request.getSession().setAttribute("hql", hql);
		// }
		if (tag.equals("0"))
			hql += " order by faultTime desc";
		else
			hql += " order by endTim desc";
		System.out.println(hql);
		Pages pages = mdbiz.get(hql, pageNo, 10, null);
		request.setAttribute("pages", pages);
		request.setAttribute("mark", 9);
		request.setAttribute("tag", tag);
		return "myFaultList";
	}

	/**
	 * 跳转到修改页面
	 * 
	 * @throws IOException
	 */
	public String upPage() throws IOException {

		String id = request.getParameter("id");
		ConkOut cout = mdbiz.getco(ConkOut.class, id);
		request.setAttribute("cout", cout);
		return "success";
	}

	/**
	 * 删除客户故障
	 * 
	 * @throws IOException
	 */
	public String del() throws IOException {
		String id = request.getParameter("id");
		ConkOut cou = mdbiz.getco(ConkOut.class, id);
		cou.setDelflag("1");
		boolean b = mdbiz.addorupdate(cou);
		if (b) {

			response.getWriter().print(1);
		} else

			response.getWriter().print(0);

		return null;
	}

	/**
	 * 跳转到填写处理结果页面
	 */
	public String transactResult() {
		String id = request.getParameter("id");
		ConkOut cout = mdbiz.getco(ConkOut.class, id);
		request.setAttribute("cout", cout);
		return "transactResult";
	}

	/**
	 * 添加故障处理
	 */
	public String addFaultTransact() {
		request.setAttribute("id", 1);
		return "get";
	}

	/**
	 * 处理故障结果
	 */
	public String addResult() {
		String loginName = request.getSession().getAttribute("loginName")
				.toString();
		Employee emp = mdbiz.getEmp(loginName);
		co.setState("1");
		mdbiz.addResult(co);
		String hql = "from ConkOut where delflag = 0 and State = 0";
		String dpage = request.getParameter("pageNo");
		String name = request.getParameter("cname");
		int pageNo = 1;
		if (name != null && !name.equals("")) {
			hql += " and typeName like '%" + name + "%'";
		}
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		} else {
			hql += " order by endTim desc";
			request.getSession().setAttribute("hql", hql);
		}
		Pages pages = mdbiz.get(hql, pageNo, 10, null);
		request.setAttribute("pages", pages);
		return "faultList";
	}

	/**
	 * 故障转接
	 */
	public String commutator() {
		String loginname = "";
		if (null == request.getSession().getAttribute("loginName").toString()
				&& request.getSession().getAttribute("loginName").toString()
						.equals("")) {
			return "login";
		}

		String hql = "from ConkOut where delflag=0 and (state=0 or state=1 or state=3)";
		String dpage = request.getParameter("pageNo");
		String name = request.getParameter("cname");
		int pageNo = 1;
		if (name != null && !name.equals("")) {
			hql += " and customer.customerName like '%" + name + "%'";
		}
		if (dpage != null && !dpage.equals("")) {
			pageNo = Integer.parseInt(dpage);
			hql = request.getSession().getAttribute("hql").toString();
		} else {
			if (null != request.getParameter("order")) {
				hql += " order by " + request.getParameter("order") + " desc";
			} else {
				hql += " order by faultTime desc";
			}
			request.getSession().setAttribute("hql", hql);
		}
		Pages pages = mdbiz.get(hql, pageNo, 10, null);
		request.setAttribute("pages", pages);
		request.setAttribute("tag", request.getParameter("order"));
		request.setAttribute("mark", 8);
		return "myFaultList";
	}

	/**
	 * 故障详细
	 * 
	 * @return
	 */
	public String detail() {
		int departid=PublicMissionType.operationgroup;
		String id = request.getParameter("id");
		if (id != null) {
			ConkOut cout = mdbiz.getco(ConkOut.class, id);
			System.out.println("cout::::" + cout);
			if (cout != null) {
				request.setAttribute("empDetial", cout);
			}
		}
		String hql = "from Missiontype where isflag="+departid;
		String hql2="from Missiontype where isflag="+departid+" and superid="+departid;
		List<Department> dep = mdbiz.somelist(hql);
		List<Department> dep2 = mdbiz.somelist(hql2);
		request.setAttribute("departmentList", dep);
		request.setAttribute("departmentList2", dep2);
		return "fauldetail";
	}
	
	public void getOperationzj2(){
		response.setCharacterEncoding("utf-8");
		int did=Integer.parseInt(request.getParameter("did"));
		String hql="from Missiontype where  superid="+did;
		List<Missiontype> deplist = mdbiz.somelist(hql);
		Missiontype dept=null;
		String data="";
		if(deplist.size()!=0){
		for(int j=0;j<deplist.size();j++){
			dept=(Missiontype)deplist.get(j);
			int deptid=dept.getId();
			String deptname=dept.getName();
			 data+="<option value='"+deptid+"' style='width: 100px'>"+deptname+"</option>";
		}
		}
		try {
			response.getWriter().print(data);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 转接部门处理2
	 * 
	 * @return
	 */
	public String changeover2() {
		System.out.println("11111111111113333");
		String depId = request.getParameter("depid");
		String empid = request.getParameter("empid");
		System.out.println("depId::" + depId);
		String conkOutNo = request.getParameter("conkOutNo");
		String state = request.getParameter("state");
		String handleDetail = request.getParameter("handleDetail");
		// 父id
		String parentid = request.getParameter("parentid");
		String conid = request.getParameter("conid");

		if (handleDetail != null && !handleDetail.equals(null)) {
			try {
				handleDetail = URLDecoder.decode(handleDetail, "utf-8");
				System.out.println("handleDetail:::" + handleDetail);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		System.out.println("handleDetail::::" + handleDetail);

		// 修改主表hql
		String hql = "";
		// 新增附表hql
		String hql1 = "";
		// 返回给用户与退回改变附表state
		String hqlq = "";

		// 存放改变消息提醒的id
		String hql3 = "";

		// 获得当前时间
		Date now = new Date();

		String str3 = dateFormat.format(now);
		System.out.println("nowDate:::" + str3);
		// logger.error("str3:"+str3);
		String nowDate = "";

		// 获得登录用户Id
		String eid = cookie.getCookie(request, "employeeId");
		String did = cookie.getCookie(request, "departmentId");

		// 获得未处理故障
		String hql2 = "from Conkoutask where conkout.conkOutNo='"
				+ conkOutNo
				+ "' and (resolveTime=null or resolveTime='' or conkout.state=3)";
		List<Conkoutask> cl = mdbiz.somelist(hql2);

		if (conkOutNo != null && state != null) {
			if (depId != null && !depId.equals("null") && depId != ""
					&& !depId.equals("")) {
				System.out.println("if......");
				hql = "update ConkOut set state=" + state + ",employee.id="
						+ empid + " where conkOutNo='" + conkOutNo + "'";
				if (cl.size() > 0) {
					Conkoutask ck = cl.get(0);
					if ((state.equals("3") || state == "3")
							&& (ck.getPropellingTime() == null
									|| ck.getPropellingTime().equals(null)
									|| ck.getPropellingTime() == "" || ck
									.getPropellingTime().equals(""))) {
						hql1 = "update Conkoutask set resolveTime='" + str3
								+ "', employeeByEmpId.id=" + eid
								+ ",missiontypeid=" + depId + ", solveDepict='"
								+ handleDetail + "' where id='" + ck.getId()
								+ "'";
					} else if ((state.equals("3") || state == "3")
							&& (ck.getPropellingTime() != null
									&& !ck.getPropellingTime().equals(null)
									&& ck.getPropellingTime() != "" && !ck
									.getPropellingTime().equals(""))) {
						hql1 = "update Conkoutask set resolveTime='" + str3
								+ "', solveDepict='" + handleDetail
								+ "' where id='" + ck.getId() + "'";
					} else {
						hql1 = "update Conkoutask set propellingTime='" + str3
								+ "',missiontypeid=" + depId
								+ ",employeeByEmpId.id=" + empid + " where id="
								+ ck.getId() + "";
					}
				}
			} else if (handleDetail != null && !handleDetail.equals("null")) {
				System.out.println("else if......");

				if (state.equals("4") || state == "4") {
					System.out.println("4444444:::" + handleDetail);
					nowDate = "endTim";
					hql = "update ConkOut set " + nowDate + "='" + str3
							+ "', state=" + state + " where conkOutNo='"
							+ conkOutNo + "'";
					if (cl.size() > 0) {
						Conkoutask ck = cl.get(0);
						hql1 = "update Conkoutask set " + nowDate + "='" + str3
								+ "' where id='" + ck.getId() + "'";
					}

					String hql4 = "from ConkOut where conkOutNo='" + conkOutNo
							+ "'";
					List<ConkOut> co = mdbiz.somelist(hql4);
					if (co.size() > 0) {
						ConkOut conko = co.get(0);
						hql3 = "update Sendmessage set state=1 where sendtableId="
								+ conko.getId() + "";
						int ii = mdbiz.updateConkout(hql3);
						System.out.println("mesgg::" + ii);
					}
				}
				if (state.equals("-1") || state == "-1") {
					nowDate = "endTim";
					hql = "update ConkOut set " + nowDate + "='" + str3
							+ "', state=" + state + " where conkOutNo='"
							+ conkOutNo + "'";
					if (cl.size() > 0) {
						Conkoutask ck = cl.get(0);
						hql1 = "update Conkoutask set resolveTime='" + str3
								+ "', isMain=3, " + nowDate + "='" + str3
								+ "',solveDepict='" + handleDetail
								+ "',employeeByEmpId.id=" + eid
								+ ",missiontypeid=" + did + "  where id='"
								+ ck.getId() + "'";
					}
					String hql4 = "from ConkOut where conkOutNo='" + conkOutNo
							+ "'";
					List<ConkOut> co = mdbiz.somelist(hql4);
					if (co.size() > 0) {
						ConkOut conko = co.get(0);
						hql3 = "update Sendmessage set state=1 where sendtableId="
								+ conko.getId() + "";
						int ii = mdbiz.updateConkout(hql3);
						System.out.println("mesgg::" + ii);
					}
				}
			} else {
				hql = "update ConkOut set state=" + state
						+ " where conkOutNo='" + conkOutNo + "'";
				if (state == "7" || state.equals("7")) {
					if (cl.size() > 0) {
						Conkoutask ck = cl.get(0);
						hql1 = "update Conkoutask set corrincomTime='" + str3
								+ "' where id='" + ck.getId() + "'";
					}
				} else {
					if (cl.size() > 0) {
						Conkoutask ck = cl.get(0);
						hql1 = "update Conkoutask set employeeByEmpTakeId.id="
								+ eid + ", inceptTime='" + str3
								+ "' where id='" + ck.getId() + "'";
					}
				}
			}

			if (state == "-1" || state == "4" || state.equals("-1")
					|| state.equals("4")) {
				// 记录id
				int id = 0;
				String hql9 = "from ConkOut where conkOutNo='" + conkOutNo
						+ "'";
				List<ConkOut> list = mdbiz.somelist(hql9);
				if (list.size() > 0) {
					ConkOut conk = list.get(0);
					id = conk.getId();
				}
				if (id != 0) {
					hqlq = "update Conkoutask set state=1 where conkout.id="
							+ id + "";
				}
				System.out.println("添加客服内容。。。。。");
				// 添加客服内容
				Conkoutask conask = new Conkoutask();
				if (conid != null && empid != null && parentid != null
						&& handleDetail != null) {
					ConkOut conkout = new ConkOut();
					conkout.setId(Integer.parseInt(conid));
					conask.setConkout(conkout);
					Employee emp = new Employee();
					emp.setId(Integer.parseInt(empid));
					conask.setEmployeeByEmpId(emp);
					conask.setResolveTime(str3);
					conask.setIsMain("2");
					conask.setSolveDepict(handleDetail);
					conask.setState(1);
					conask.setParentId(Integer.parseInt(parentid));
					// 添加转接记录
					boolean flag = mdbiz.addorupdate(conask);
					System.out.println("addkefu::::" + flag);
				}
			}

			System.out.println("hqlq::::" + hqlq);
			// logger.error("hql::::"+hql);
			// logger.error("hql1::::"+hql1);
			// logger.error("hqlq::::"+hqlq);
			int i = mdbiz.updateConkout(hql);
			String hl = "from ConkOut where conkOutNo='"+conkOutNo+"'";
			List list = mdbiz.somelist(hl);
			if(list.size()>0){
				ConkOut ck = (ConkOut)list.get(0);
				int upid = ck.getUpserverid();
				if(upid!=0){
					UpServer ups = (UpServer)mdbiz.getObj(UpServer.class, upid);
					System.out.println(ups.getSoOrders().getSoId());
					Sale_orders so = (Sale_orders)mdbiz.getObj(Sale_orders.class, ups.getSoOrders().getSoId());
					so.setSoStat(7);
					mdbiz.updObj(so);
				}
				
			}
			
			int j = 0;
			if (hql1 != "") {
				System.out.println(hql1);
				j = mdbiz.updateConkout(hql1);
			}
			if (hqlq != "")
				mdbiz.updateConkout(hqlq);

			String uri = request.getContextPath();

			String object = request.getRequestURL().substring(0,
					request.getRequestURL().indexOf(uri));

			// 后台登录页面
			String url = object + "/" + uri;

			System.out.println("object::::" + object);
			System.out.println("uri::::::" + uri);
			System.out.println("url:::::::" + url);

			String scheme = request.getScheme(); // http
			String servername = request.getServerName(); // ip
			int port = request.getServerPort(); // port
			String name = request.getSession().getServletContext().getRealPath(
					"/"); // tomcat 项目路径
			int h = (name.substring(0, name.length() - 1)).lastIndexOf("/");
			String objectname = name.substring(h + 1, name.length() - 1); // 项目名
			String urls = scheme + "://" + servername + ":" + port + "/";
			System.out.println("urls" + urls);

			// 客户前台登录页面
			String cusurl = urls + "/customService/customProscenium/login.jsp";

			// 发送
			String hql4 = "from ConkOut where conkOutNo='" + conkOutNo + "'";
			List<ConkOut> co = mdbiz.somelist(hql4);
			if (state == "4" || state.equals("4")) {
				if (co.size() > 0) {
					ConkOut conko = co.get(0);
					System.out.println("conkOutNo" + conkOutNo);
					System.out.println("Time" + conko.getEndTim());
					System.out.println();
					String msg = "尊敬的" + conko.getCustomer().getCustomerName()
							+ "：您的工单：" + conko.getConkOutNo() + "已于" + str3
							+ "处理成功！请登录系统查看工单处理结果，并及时评价<a href='" + cusurl
							+ "'>" + cusurl + "</a>";
					System.out.println("msg::::::::::" + msg);
					Email sendemail = new Email();
					sendemail.sendEmail(conko.getEmail(), "福奥科技客服系统邮件提醒", msg);
				}
			}
			if (state == "-1" || state.equals("-1")) {
				if (co.size() > 0) {
					ConkOut conko = co.get(0);
					System.out.println();
					String msg = "尊敬的" + conko.getCustomer().getCustomerName()
							+ "：您的工单：" + conko.getConkOutNo()
							+ "存在问题！请登录系统及时修正" + "<a href='" + cusurl + "'>"
							+ cusurl + "</a>";
					System.out.println("msg::::::::::" + msg);
					Email sendemail = new Email();
					System.out.println("mesggg" + msg);
					sendemail.sendEmail(conko.getEmail(), "福奥科技客服系统邮件提醒", msg);
					// logger.error("email。。。。。。。。。。。。。");
				}
			}
			System.out.println("empid::::::" + empid);
			// logger.error("empid::::::"+empid);
			List<Employee> emplist = null;
			if (empid != null && !empid.equals("")) {
				// logger.error(1);
				String hql5 = "from Employee where id=" + empid + "";
				emplist = mdbiz.somelist(hql5);
			}

			if (state == "2" || state.equals("2")) {
				// logger.error(2);
				System.out.println("邮箱：：：");

				if (emplist.size() > 0) {
					Employee emp = emplist.get(0);
					String msg = "尊敬的" + emp.getName() + "：您有新的工单，请登录<a href='"
							+ urls + "'>" + urls + "</a>";
					System.out.println("msg::::::::::" + msg);
					Email sendemail = new Email();
					sendemail.sendEmail(emp.getEmail(), "立云客服系统邮件提醒", msg);
				}
			}
			if (state == "3" || state.equals("3")) {
				// logger.error(3);
				String msg = "尊敬的" + proEdit.getID("cname")
						+ "：您收到部门同事已经处理完成返回的单据" + conkOutNo
						+ "，请登录及时处理<a href='" + urls + "'>" + urls + "</a>";
				Email sendemail = new Email();
				// 获得客服邮箱
				String callcenter = proEdit.getID("email").toString();
				System.out.println("mesggg" + msg);
				sendemail.sendEmail(callcenter, "立云客服系统邮件提醒", msg);

			}
			// logger.error("pass");
			try {
				System.out.println("i::::" + i + "j::::::" + j);
				// logger.error("i::::"+i+"j::::::"+j);
				// logger.error("i:::"+i+"j:::"+j);
				if (hql1 != "") {
					if (i > 0 && j > 0) {
						// logger.error(7);
						response.getWriter().print(0);
					} else {
						// logger.error(8);
						response.getWriter().print(1);
					}

				} else {
					// logger.error(9);
					if (i > 0)
						response.getWriter().print(0);
					else
						response.getWriter().print(1);
				}

			} catch (Exception ex) {
				ex.printStackTrace();
				logger.error(ex);
			}
		}
		return null;
	}
	
	

	/**
	 * 转接部门处理
	 * 
	 * @return
	 */
	public String changeover() {
		System.out.println("11111111111113333");
		String depId = request.getParameter("depid");
		String empid = request.getParameter("empid");
		System.out.println("depId::" + depId);
		String conkOutNo = request.getParameter("conkOutNo");
		String state = request.getParameter("state");
		String handleDetail = request.getParameter("handleDetail");
		// 父id
		String parentid = request.getParameter("parentid");
		String conid = request.getParameter("conid");

		if (handleDetail != null && !handleDetail.equals(null)) {
			try {
				handleDetail = URLDecoder.decode(handleDetail, "utf-8");
				System.out.println("handleDetail:::" + handleDetail);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		System.out.println("handleDetail::::" + handleDetail);

		// 修改主表hql
		String hql = "";
		// 新增附表hql
		String hql1 = "";
		// 返回给用户与退回改变附表state
		String hqlq = "";

		// 存放改变消息提醒的id
		String hql3 = "";

		// 获得当前时间
		Date now = new Date();

		String str3 = dateFormat.format(now);
		System.out.println("nowDate:::" + str3);
		// logger.error("str3:"+str3);
		String nowDate = "";

		// 获得登录用户Id
		String eid = cookie.getCookie(request, "employeeId");
		String did = cookie.getCookie(request, "departmentId");

		// 获得未处理故障
		String hql2 = "from Conkoutask where conkout.conkOutNo='"
				+ conkOutNo
				+ "' and (resolveTime=null or resolveTime='' or conkout.state=3)";
		List<Conkoutask> cl = mdbiz.somelist(hql2);

		if (conkOutNo != null && state != null) {
			if (depId != null && !depId.equals("null") && depId != ""
					&& !depId.equals("")) {
				System.out.println("if......");
				hql = "update ConkOut set state=" + state + ",employee.id="
						+ empid + " where conkOutNo='" + conkOutNo + "'";
				if (cl.size() > 0) {
					Conkoutask ck = cl.get(0);
					if ((state.equals("3") || state == "3")
							&& (ck.getPropellingTime() == null
									|| ck.getPropellingTime().equals(null)
									|| ck.getPropellingTime() == "" || ck
									.getPropellingTime().equals(""))) {
						hql1 = "update Conkoutask set resolveTime='" + str3
								+ "', employeeByEmpId.id=" + eid
								+ ",department.id=" + depId + ", solveDepict='"
								+ handleDetail + "' where id='" + ck.getId()
								+ "'";
					} else if ((state.equals("3") || state == "3")
							&& (ck.getPropellingTime() != null
									&& !ck.getPropellingTime().equals(null)
									&& ck.getPropellingTime() != "" && !ck
									.getPropellingTime().equals(""))) {
						hql1 = "update Conkoutask set resolveTime='" + str3
								+ "', solveDepict='" + handleDetail
								+ "' where id='" + ck.getId() + "'";
					} else {
						hql1 = "update Conkoutask set propellingTime='" + str3
								+ "',department.id=" + depId
								+ ",employeeByEmpId.id=" + empid + " where id="
								+ ck.getId() + "";
					}
				}
			} else if (handleDetail != null && !handleDetail.equals("null")) {
				System.out.println("else if......");

				if (state.equals("4") || state == "4") {
					System.out.println("4444444:::" + handleDetail);
					nowDate = "endTim";
					hql = "update ConkOut set " + nowDate + "='" + str3
							+ "', state=" + state + " where conkOutNo='"
							+ conkOutNo + "'";
					if (cl.size() > 0) {
						Conkoutask ck = cl.get(0);
						hql1 = "update Conkoutask set " + nowDate + "='" + str3
								+ "' where id='" + ck.getId() + "'";
					}

					String hql4 = "from ConkOut where conkOutNo='" + conkOutNo
							+ "'";
					List<ConkOut> co = mdbiz.somelist(hql4);
					if (co.size() > 0) {
						ConkOut conko = co.get(0);
						hql3 = "update Sendmessage set state=1 where sendtableId="
								+ conko.getId() + "";
						int ii = mdbiz.updateConkout(hql3);
						System.out.println("mesgg::" + ii);
					}
				}
				if (state.equals("-1") || state == "-1") {
					nowDate = "endTim";
					hql = "update ConkOut set " + nowDate + "='" + str3
							+ "', state=" + state + " where conkOutNo='"
							+ conkOutNo + "'";
					if (cl.size() > 0) {
						Conkoutask ck = cl.get(0);
						hql1 = "update Conkoutask set resolveTime='" + str3
								+ "', isMain=3, " + nowDate + "='" + str3
								+ "',solveDepict='" + handleDetail
								+ "',employeeByEmpId.id=" + eid
								+ ",department.id=" + did + "  where id='"
								+ ck.getId() + "'";
					}
					String hql4 = "from ConkOut where conkOutNo='" + conkOutNo
							+ "'";
					List<ConkOut> co = mdbiz.somelist(hql4);
					if (co.size() > 0) {
						ConkOut conko = co.get(0);
						hql3 = "update Sendmessage set state=1 where sendtableId="
								+ conko.getId() + "";
						int ii = mdbiz.updateConkout(hql3);
						System.out.println("mesgg::" + ii);
					}
				}
			} else {
				Date dt = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String receivetime = sdf.format(dt);
				hql = "update ConkOut set state=" + state
						+ ",receiveTime='"+receivetime+"' where conkOutNo='" + conkOutNo + "' ";
				if (state == "7" || state.equals("7")) {
					if (cl.size() > 0) {
						Conkoutask ck = cl.get(0);
						hql1 = "update Conkoutask set corrincomTime='" + str3
								+ "' where id='" + ck.getId() + "'";
					}
				} else {
					if (cl.size() > 0) {
						Conkoutask ck = cl.get(0);
						hql1 = "update Conkoutask set employeeByEmpTakeId.id="
								+ eid + ", inceptTime='" + str3
								+ "' where id='" + ck.getId() + "'";
					}
				}
			}

			if (state == "-1" || state == "4" || state.equals("-1")
					|| state.equals("4")) {
				// 记录id
				int id = 0;
				String hql9 = "from ConkOut where conkOutNo='" + conkOutNo
						+ "'";
				List<ConkOut> list = mdbiz.somelist(hql9);
				if (list.size() > 0) {
					ConkOut conk = list.get(0);
					id = conk.getId();
				}
				if (id != 0) {
					hqlq = "update Conkoutask set state=1 where conkout.id="
							+ id + "";
				}
				System.out.println("添加客服内容。。。。。");
				// 添加客服内容
				Conkoutask conask = new Conkoutask();
				if (conid != null && empid != null && parentid != null
						&& handleDetail != null) {
					ConkOut conkout = new ConkOut();
					conkout.setId(Integer.parseInt(conid));
					conask.setConkout(conkout);
					Employee emp = new Employee();
					emp.setId(Integer.parseInt(empid));
					conask.setEmployeeByEmpId(emp);
					conask.setResolveTime(str3);
					conask.setIsMain("2");
					conask.setSolveDepict(handleDetail);
					conask.setState(1);
					conask.setParentId(Integer.parseInt(parentid));
					// 添加转接记录
					boolean flag = mdbiz.addorupdate(conask);
					System.out.println("addkefu::::" + flag);
				}
			}

			System.out.println("hqlq::::" + hqlq);
			// logger.error("hql::::"+hql);
			// logger.error("hql1::::"+hql1);
			// logger.error("hqlq::::"+hqlq);
			int i = mdbiz.updateConkout(hql);
			String hl = "from ConkOut where conkOutNo='"+conkOutNo+"'";
			if(state.equals("1") || state=="1"){
				List list = mdbiz.somelist(hl);
				if(list.size()>0){
					ConkOut ck = (ConkOut)list.get(0);
					int upid = ck.getUpserverid();
					if(upid!=0){
						UpServer ups = (UpServer)mdbiz.getObj(UpServer.class, upid);
						System.out.println(ups.getSoOrders().getSoId());
						Sale_orders so = (Sale_orders)mdbiz.getObj(Sale_orders.class, ups.getSoOrders().getSoId());
						so.setSoStat(6);
						mdbiz.updObj(so);
					}
					
				}
			}
			
			if(state.equals("3") || state=="3"){
				List list = mdbiz.somelist(hl);
				if(list.size()>0){
					ConkOut ck = (ConkOut)list.get(0);
					int upid = ck.getUpserverid();
					if(upid!=0){
						UpServer ups = (UpServer)mdbiz.getObj(UpServer.class, upid);
						System.out.println(ups.getSoOrders().getSoId());
						Sale_orders so = (Sale_orders)mdbiz.getObj(Sale_orders.class, ups.getSoOrders().getSoId());
						so.setSoStat(9);
						mdbiz.updObj(so);
					}
					
				}
			}
			
			if(state.equals("4") || state=="4"){
				List list = mdbiz.somelist(hl);
				if(list.size()>0){
					ConkOut ck = (ConkOut)list.get(0);
					int upid = ck.getUpserverid();
					if(upid!=0){
						UpServer ups = (UpServer)mdbiz.getObj(UpServer.class, upid);
						System.out.println(ups.getSoOrders().getSoId());
						Sale_orders so = (Sale_orders)mdbiz.getObj(Sale_orders.class, ups.getSoOrders().getSoId());
						so.setSoStat(10);
						mdbiz.updObj(so);
					}
					
				}
			}
			
			if(state=="7" || state.equals("7")){
				List list = mdbiz.somelist(hl);
				if(list.size()>0){
					ConkOut ck = (ConkOut)list.get(0);
					int upid = ck.getUpserverid();
					if(upid!=0){
						UpServer ups = (UpServer)mdbiz.getObj(UpServer.class, upid);
						System.out.println(ups.getSoOrders().getSoId());
						Sale_orders so = (Sale_orders)mdbiz.getObj(Sale_orders.class, ups.getSoOrders().getSoId());
						so.setSoStat(8);
						mdbiz.updObj(so);
					}
					
				}
			}
			
			int j = 0;
			if (hql1 != "") {
				System.out.println(hql1);
				j = mdbiz.updateConkout(hql1);
			}
			if (hqlq != "")
				mdbiz.updateConkout(hqlq);

			String uri = request.getContextPath();

			String object = request.getRequestURL().substring(0,
					request.getRequestURL().indexOf(uri));

			// 后台登录页面
			String url = object + "/" + uri;

			System.out.println("object::::" + object);
			System.out.println("uri::::::" + uri);
			System.out.println("url:::::::" + url);

			String scheme = request.getScheme(); // http
			String servername = request.getServerName(); // ip
			int port = request.getServerPort(); // port
			String name = request.getSession().getServletContext().getRealPath(
					"/"); // tomcat 项目路径
			int h = (name.substring(0, name.length() - 1)).lastIndexOf("/");
			String objectname = name.substring(h + 1, name.length() - 1); // 项目名
			String urls = scheme + "://" + servername + ":" + port + "/";
			System.out.println("urls" + urls);

			// 客户前台登录页面
			String cusurl = urls + "/customService/customProscenium/login.jsp";

			// 发送
			String hql4 = "from ConkOut where conkOutNo='" + conkOutNo + "'";
			List<ConkOut> co = mdbiz.somelist(hql4);
			if (state == "4" || state.equals("4")) {
				if (co.size() > 0) {
					ConkOut conko = co.get(0);
					System.out.println("conkOutNo" + conkOutNo);
					System.out.println("Time" + conko.getEndTim());
					System.out.println();
					String msg = "尊敬的" + conko.getCustomer().getCustomerName()
							+ "：您的工单：" + conko.getConkOutNo() + "已于" + str3
							+ "处理成功！请登录系统查看工单处理结果，并及时评价<a href='" + cusurl
							+ "'>" + cusurl + "</a>";
					System.out.println("msg::::::::::" + msg);
					Email sendemail = new Email();
					sendemail.sendEmail(conko.getEmail(), "立云客服系统邮件提醒", msg);
				}
			}
			if (state == "-1" || state.equals("-1")) {
				if (co.size() > 0) {
					ConkOut conko = co.get(0);
					System.out.println();
					String msg = "尊敬的" + conko.getCustomer().getCustomerName()
							+ "：您的工单：" + conko.getConkOutNo()
							+ "存在问题！请登录系统及时修正" + "<a href='" + cusurl + "'>"
							+ cusurl + "</a>";
					System.out.println("msg::::::::::" + msg);
					Email sendemail = new Email();
					System.out.println("mesggg" + msg);
					sendemail.sendEmail(conko.getEmail(), "立云客服系统邮件提醒", msg);
					// logger.error("email。。。。。。。。。。。。。");
				}
			}
			System.out.println("empid::::::" + empid);
			// logger.error("empid::::::"+empid);
			List<Employee> emplist = null;
			if (empid != null && !empid.equals("")) {
				// logger.error(1);
				String hql5 = "from Employee where id=" + empid + "";
				emplist = mdbiz.somelist(hql5);
			}

			if (state == "2" || state.equals("2")) {
				// logger.error(2);
				System.out.println("邮箱：：：");

				if (emplist.size() > 0) {
					Employee emp = emplist.get(0);
					String msg = "尊敬的" + emp.getName() + "：您有新的工单，请登录<a href='"
							+ urls + "'>" + urls + "</a>";
					System.out.println("msg::::::::::" + msg);
					Email sendemail = new Email();
					sendemail.sendEmail(emp.getEmail(), "立云客服系统邮件提醒", msg);
				}
			}
			if (state == "3" || state.equals("3")) {
				// logger.error(3);
				String msg = "尊敬的" + proEdit.getID("cname")
						+ "：您收到部门同事已经处理完成返回的单据" + conkOutNo
						+ "，请登录及时处理<a href='" + urls + "'>" + urls + "</a>";
				Email sendemail = new Email();
				// 获得客服邮箱
				String callcenter = proEdit.getID("email").toString();
				System.out.println("mesggg" + msg);
				sendemail.sendEmail(callcenter, "立云客服系统邮件提醒", msg);

			}
			// logger.error("pass");
			try {
				System.out.println("i::::" + i + "j::::::" + j);
				// logger.error("i::::"+i+"j::::::"+j);
				// logger.error("i:::"+i+"j:::"+j);
				if (hql1 != "") {
					if (i > 0 && j > 0) {
						// logger.error(7);
						response.getWriter().print(0);
					} else {
						// logger.error(8);
						response.getWriter().print(1);
					}

				} else {
					// logger.error(9);
					if (i > 0)
						response.getWriter().print(0);
					else
						response.getWriter().print(1);
				}

			} catch (Exception ex) {
				ex.printStackTrace();
				logger.error(ex);
			}
		}
		return null;
	}

	public String estimate() throws UnsupportedEncodingException {
		String id = request.getParameter("id");

		String texts = request.getParameter("texts");

		texts = URLDecoder.decode(texts, "UTF-8");

		String pj = request.getParameter("pj");

		ConkOut cou = mdbiz.getco(ConkOut.class, id);

		cou.setAppraise(pj);

		cou.setLeavess(texts);

		cou.setState("5");

		mdbiz.addorupdate(cou);

		return null;
	}

	/**
	 * 客服转接到下个部门进行操作
	 */
	public String nextdep() {
		String conkOutNo = request.getParameter("conkOutNo");
		String state = request.getParameter("state");
		String empid = request.getParameter("empid");
		String depid = request.getParameter("depid");
		String parentid = request.getParameter("parentid");
		String conid = request.getParameter("conid");

		// 获得当前时间
		Date now = new Date();

		String str3 = dateFormat.format(now);
		logger.error("str3:" + str3);

		// 修改主表状态
		String hql = "update ConkOut set state=" + state + ",employee.id="
				+ empid + " where conkOutNo='" + conkOutNo + "'";
		// 添加新的转接记录
		Conkoutask conask = new Conkoutask();
		if (conid != null && depid != null && empid != null && parentid != null) {
			ConkOut conkout = new ConkOut();
			conkout.setId(Integer.parseInt(conid));
			conask.setConkout(conkout);
			conask.setPropellingTime(str3);
			Department dep = new Department();
			dep.setId(Integer.parseInt(depid));
			conask.setDepartment(dep);
			Employee emp = new Employee();
			emp.setId(Integer.parseInt(empid));
			conask.setEmployeeByEmpId(emp);
			conask.setState(0);
			conask.setParentId(Integer.parseInt(parentid));
		}

		// 修改主表
		int i = mdbiz.updateConkout(hql);
		
		// 添加转接记录
		boolean flag = mdbiz.addorupdate(conask);
		try {
			if (i > 0 && flag)
				response.getWriter().print(0);
			else
				response.getWriter().print(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	public General getGeneral() {
		return general;
	}

	public void setGeneral(General general) {
		this.general = general;
	}
}

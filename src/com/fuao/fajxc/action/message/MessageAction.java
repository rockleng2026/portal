package com.fuao.fajxc.action.message;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.basic.EmployeeBussiness;
import com.fuao.fajxc.bussiness.message.MessageBussiness;
import com.fuao.fajxc.bussiness.message.MessagereceiverBussiness;
import com.fuao.fajxc.bussiness.message.MessagetypeBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Email;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.utilinterface.PublicMissionType;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.HelloBean;
import com.fuao.fajxc.vo.Message;
import com.fuao.fajxc.vo.Messagereceiver;
import com.fuao.fajxc.vo.Messageremind;
import com.fuao.fajxc.vo.Messagetype;
import com.fuao.fajxc.vo.Project;
import com.fuao.fajxc.vo.SaleOrder;
import com.opensymphony.xwork2.ModelDriven;

public class MessageAction implements ModelDriven, ServletRequestAware,
		ServletResponseAware {
	private Logger logger = Logger.getLogger(MessageAction.class);
	private CustomerBussiness customerBussiness;
	private EmployeeBussiness employeeBussiness;
	private MessageBussiness messageBussiness;
	private HttpServletRequest request;
	private HttpServletResponse response;

	private Message message;
	private MessagereceiverBussiness messagereceiverBussiness;// 消息接收者对象
	private MessagetypeBussiness messagetypeBussiness;
	//存放项目的集合List
	private List plist;
	// 要删除的id
	private Object[] ids;
	// 要读取的id
	private Object[] duqu;
	//
	private Messagereceiver receiver;
	
	// 保存消息对象的集合
	List<Message> msglist=new ArrayList<Message>();

	public Messagereceiver getReceiver() {
		return receiver;
	}
	public void setReceiver(Messagereceiver receiver) {
		this.receiver = receiver;
	}
	public List getPlist() {
		return plist;
	}
	public void setPlist(List plist) {
		this.plist = plist;
	}
	public Object[] getIds() {
		return ids;
	}
    
	public Message getMessage() {
		return message;
	}

	public void setMessage(Message message) {
		this.message = message;
	}

	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	public Object[] getDuqu() {
		return duqu;
	}

	public void setDuqu(Object[] duqu) {
		this.duqu = duqu;
	}

	public MessageBussiness getMessageBussiness() {
		return messageBussiness;
	}

	public void setMessageBussiness(MessageBussiness messageBussiness) {
		this.messageBussiness = messageBussiness;
	}

	public Object getModel() {
		message = new Message();
		return message;
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

	public MessagereceiverBussiness getMessagereceiverBussiness() {
		return messagereceiverBussiness;
	}

	public void setMessagereceiverBussiness(
			MessagereceiverBussiness messagereceiverBussiness) {
		this.messagereceiverBussiness = messagereceiverBussiness;
	}

	java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss ");

	// 获得当前时间
	String str3 = "";

	/*
	 * 添加消息信息对象
	 */
	public MessagetypeBussiness getMessagetypeBussiness() {
		return messagetypeBussiness;
	}

	public void setMessagetypeBussiness(
			MessagetypeBussiness messagetypeBussiness) {
		this.messagetypeBussiness = messagetypeBussiness;
	}

	/**
	 * 登录时显示在欢迎页面的公告
	 * 
	 * @author 阙超强 505行 2011-12-18 21:54:54
	 */
	public void showNotice() {
		String hql = "from Message where messagetypeByMessagetype.messagetypeid in(4,9,10,18) "
				+ "and repealfalg=0 and delfalg=0 and draftfalg=0 order by messageid desc";
		// 查询出所有公告
		List<Message> noticeList = messageBussiness.exHql(hql);

		// 查询当前页的所有公告
		Pages pagesNotice = messageBussiness.exHqlPages(hql, 1, 5, null);

		// 查询出所有公告的发送人 ，分两类:员工和客户
		int noticeListSize = noticeList.size();
		if (noticeListSize > 0) {
			String empids = "";
			for (int i = 0; i < noticeListSize; i++) {
				if (!StringUtil.isnull(noticeList.get(i).getSender())) {
					empids += noticeList.get(i).getSender() + ",";
				}
			}
			System.out.println("dssdsdf"
					+ empids.substring(0, empids.length() - 1));
			List<Employee> employeeList = messageBussiness.getObjectList(
					"Employee", " and id in ("
							+ empids.substring(0, empids.length() - 1) + ")");
			List<Customer> customerList = messageBussiness.getObjectList(
					"Customer", " and customerId in ("
							+ empids.substring(0, empids.length() - 1) + ")");
			// //发送给请求
			// request.getSession().removeAttribute("pagesNotice");
			// request.getSession().removeAttribute("employeeList");
			// request.getSession().removeAttribute("customerList");
			ServletActionContext.getContext().getSession()
					.remove("pagesNotice");
			ServletActionContext.getContext().getSession().remove(
					"employeeList");
			ServletActionContext.getContext().getSession().remove(
					"customerList");

			ServletActionContext.getContext().getSession().put("pagesNotice",
					pagesNotice);
			ServletActionContext.getContext().getSession().put("employeeList",
					employeeList);
			ServletActionContext.getContext().getSession().put("customerList",
					customerList);
		}
	}

	/**
	 * 添加发送消息公告等
	 */
	public String add() {
		// 获得当前时间
		Date now = new Date();
		str3 = dateFormat.format(now);
        System.out.println("当前时间："+str3);
		Cookies cookie = new Cookies();
		try {
			// 客户或员工id
			String eocid = cookie.getCookie(request, "employeeId");
			Customer c = (Customer) request.getSession().getAttribute(
					"customer");
			String messtypeid=request.getParameter("messagetypeBySendertype.messagetypeid");
			Messagetype mest = new Messagetype();
			// 判断员工信息还是客户信息
			if(Integer.parseInt(messtypeid)==1)
			{
			if (eocid != null) {
				mest.setMessagetypeid(1);
				message.setMessagetypeBySendertype(mest);
				message.setSender(eocid);
			}
			} else if (Integer.parseInt(messtypeid)==2) {
				mest.setMessagetypeid(2);
				
				message.setMessagetypeBySendertype(mest);
				message.setSender(eocid);
			}

			message.setReleasetime(Timestamp.valueOf(str3));
			message.setDelfalg("0");
			message.setDraftfalg("0");
			message.setRepealfalg("0");
			message.setTmp1("0");

			boolean thing = messageBussiness.addData(message);

			// 获取到所有员工的id字符串
			String alluserids = request.getParameter("users");
			String allcustomers = request.getParameter("customers");
			System.out.println("allcustomers" + allcustomers);
			String newalluserids = "";
			String newacustomers = "";
			String[] allemps = null;
			String[] allcustomer = null;
			if (alluserids != null) {
				newalluserids = alluserids
						.substring(1, alluserids.length() - 1);
				newalluserids = newalluserids.replace("||", ",");
				allemps = newalluserids.split(",");
				// 获取添加员工接收对象id
				for (int i = 0; i < allemps.length; i++) {
					Messagereceiver receiver = new Messagereceiver();
					receiver.setMessage(message);
					// 接收人类型
					receiver.setMessagetype(messagetypeBussiness
							.getMessageTypedata("1"));
					receiver.setDelfalg("0");
					receiver.setReceivetime(Timestamp.valueOf(str3));
					receiver.setReceiverer(allemps[i]);
					receiver.setReadfalg("0");
					receiver.setTmp1("0");
					messagereceiverBussiness.addData(receiver);

				}
			}
			if (allcustomers != null) {
				newacustomers = allcustomers.substring(1,
						allcustomers.length() - 1);
				newacustomers = newacustomers.replace("||", ",");
				allcustomer = newacustomers.split(",");
				// 获取添加客户接受对象
				for (int i = 0; i < allcustomer.length; i++) {
					Messagereceiver receiver = new Messagereceiver();
					receiver.setMessage(message);
					// 接收人类型
					receiver.setMessagetype(messagetypeBussiness
							.getMessageTypedata("2"));
					receiver.setDelfalg("0");
					receiver.setReceiverer(allcustomer[i]);
					receiver.setReceivetime(Timestamp.valueOf(str3));
					receiver.setReadfalg("0");
					receiver.setTmp1("1");
					messagereceiverBussiness.addData(receiver);
				}
			}

			return "req";
		} catch (Exception e) {
			e.printStackTrace();
			return "will";
		}
	}

	/**
	 * 添加发送消息公告 发送客户信息等
	 * 
	 * @throws Exception
	 */
	public String add1() throws Exception {
		Cookies cookie = new Cookies();
		Date now = new Date();
		str3 = dateFormat.format(now);
		try {
			// 客户或员工id
			String eocid = cookie.getCookie(request, "employeeId");

			Messagetype mest = new Messagetype();
			mest.setMessagetypeid(2);
			message.setMessagetypeBySendertype(mest);
			message.setSender(eocid);
			message.setReleasetime(Timestamp.valueOf(str3));
			message.setDelfalg("0");
			message.setDraftfalg("0");
			message.setRepealfalg("0");
			boolean thing = messageBussiness.addData(message);
			// 获取到所有员工的id字符串
			String alluserids = request.getParameter("users");
			String allcustomers = request.getParameter("customers");
			String newalluserids = "";
			String newacustomers = "";
			String[] allemps = null;
			String[] allcustomer = null;
			if (alluserids != null) {
				newalluserids = alluserids
						.substring(1, alluserids.length() - 1);
				newalluserids = newalluserids.replace("||", ",");
				allemps = newalluserids.split(",");
				// 获取添加员工接收对象id
				for (int i = 0; i < allemps.length; i++) {
					Messagereceiver receiver = new Messagereceiver();
					receiver.setMessage(message);
					// 接收人类型
					receiver.setMessagetype(messagetypeBussiness
							.getMessageTypedata("1"));
					receiver.setDelfalg("0");
					receiver.setReceiverer(allemps[i]);
					receiver.setReadfalg("0");
					messagereceiverBussiness.addData(receiver);
				}
			}
			if (allcustomers != null) {
				newacustomers = alluserids.substring(1,
						allcustomers.length() - 1);
				newacustomers = newacustomers.replace("||", ",");
				allcustomer = newacustomers.split(",");
				// 获取添加客户接受对象
				for (int i = 0; i < allcustomer.length; i++) {
					Messagereceiver receiver = new Messagereceiver();
					receiver.setMessage(message);
					// 接收人类型
					receiver.setMessagetype(messagetypeBussiness
							.getMessageTypedata("2"));
					receiver.setDelfalg("0");
					receiver.setReceiverer(allemps[i]);
					receiver.setReadfalg("0");
					messagereceiverBussiness.addData(receiver);
				}
			}

			return "req";
		} catch (Exception e) {
			e.printStackTrace();
			return "will";
		}
	}

	/**
	 * 订单快到期，到期的时候定时发送消息给客户
	 * 
	 * @throws Exception
	 */
	public void addremind() throws Exception {
		// logger.info("定时发送消息提醒客户"+StringUtil.formatDate(new Date()));
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"applicationhelloBean.xml");
		HelloBean helloBean = (HelloBean) context.getBean("helloBean");
		String mark = helloBean.getSaleOrder();
		// String mark = "XSDD";
		java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat(
				"yyyy-MM-dd");
		Date now = new Date();
		String strDate = dateFormat.format(now);// 当前日期
		// 15天后的时间
		String fifteenDate = dateFormat.format(new Date(now.getTime()
				+ (long) 15 * 24 * 60 * 60 * 1000));
		java.util.Date beginDate;// 当前时间
		java.util.Date endDate;// 数据库读出的时间
		java.util.Date fifteen;// 15天后的时间
		List<SaleOrder> saleorder = messageBussiness.getObjectList("SaleOrder",
				"and 1=1");
		// logger.info("1-1定时发送消息提醒客户"+StringUtil.formatDate(new Date()));
		List<Messageremind> messageremind = messageBussiness.getObjectList(
				"Messageremind", "and mark='" + mark + "'");
		// logger.info("1-2定时发送消息提醒客户"+StringUtil.formatDate(new Date()));
		for (int i = 0; i < saleorder.size(); i++) {
			String endtime = saleorder.get(i).getEndTime();
			beginDate = dateFormat.parse(strDate);
			endDate = dateFormat.parse(endtime);
			fifteen = dateFormat.parse(fifteenDate);
			// 当前时间与数据库的到期时间进行比较 到期就发送系统消息提醒
			if (messageremind.size() != 0) {
				if ((beginDate.getTime() > endDate.getTime()) == false
						&& (beginDate.getTime() < endDate.getTime()) == false) {
					Message message = new Message();
					Messagetype messagetype = new Messagetype();
					messagetype.setMessagetypeid(2);

					message.setMessagetypeBySendertype(messagetype);
					message.setSender(saleorder.get(i).getEmployee().getId()
							.toString());
					message.setMessagetypeByMessagetype(messagetype);
					message.setMessagecontent("你的订单"
							+ saleorder.get(i).getSaleOrderNo() + "已到期！！！！！！");
					message.setTitleweb("订单到期提醒");
					message.setRepealfalg("0");
					message.setDelfalg("0");
					message.setDraftfalg("0");
					message.setReleasetime(Timestamp.valueOf(strDate));

					boolean flag = messageBussiness.addData(message);
					if (flag) {
						Messagereceiver messagereceiver = new Messagereceiver();
						messagereceiver.setMessagetype(messagetype);
						messagereceiver.setReceiverer(saleorder.get(i)
								.getCustomer().getCustomerId().toString());
						messagereceiver.setMessage(message);
						messagereceiver.setReadfalg("0");
						messagereceiver.setDelfalg("0");
						boolean flag1 = messagereceiverBussiness
								.addData(messagereceiver);
						if (flag1) {
							Email sendemail = new Email();
							if (saleorder.get(i).getCustomer().getEmail() != null) {
								// 到期的订单发送邮件提醒
								System.out.println(""
										+ saleorder.get(i).getCustomer()
												.getEmail());
								sendemail.sendEmail(saleorder.get(i)
										.getCustomer().getEmail(), "订单信息提醒",
										"你的订单"
												+ saleorder.get(i)
														.getSaleOrderNo()
												+ "已到期");

							}
						}
					}

				}
			}
			// logger.info("2定时发送消息提醒客户"+StringUtil.formatDate(new Date()));
			// 当前时间与数据库的到期时间进行比较 差15天到期就发送系统消息提醒
			if (messageremind.size() != 0) {
				if ((fifteen.getTime() > endDate.getTime()) == false
						&& (fifteen.getTime() < endDate.getTime()) == false) {
					Message message = new Message();
					Messagetype messagetype = new Messagetype();
					messagetype.setMessagetypeid(2);

					message.setMessagetypeBySendertype(messagetype);
					message.setSender(saleorder.get(i).getEmployee().getId()
							.toString());
					message.setMessagetypeByMessagetype(messagetype);
					message.setMessagecontent("你的订单"
							+ saleorder.get(i).getSaleOrderNo()
							+ "还15天到期！！！！！！");
					message.setTitleweb("订单快到期提醒");
					message.setRepealfalg("0");
					message.setDelfalg("0");
					message.setDraftfalg("0");
					message.setReleasetime(Timestamp.valueOf(strDate));

					boolean flag = messageBussiness.addData(message);
					if (flag) {
						Messagereceiver messagereceiver = new Messagereceiver();
						messagereceiver.setMessagetype(messagetype);
						messagereceiver.setReceiverer(saleorder.get(i)
								.getCustomer().getCustomerId().toString());
						messagereceiver.setMessage(message);
						messagereceiver.setReadfalg("0");
						messagereceiver.setDelfalg("0");
						boolean flag1 = messagereceiverBussiness
								.addData(messagereceiver);
						if (flag1) {
							Email sendemail = new Email();
							if (saleorder.get(i).getCustomer().getEmail() != null) {
								// 快到期的订单发送邮件提醒
								sendemail.sendEmail(saleorder.get(i)
										.getCustomer().getEmail(), "订单信息提醒",
										"你的订单"
												+ saleorder.get(i)
														.getSaleOrderNo()
												+ "还15天到期");
							}
						}
					}
				}

			}
			// logger.info("3定时发送消息提醒客户"+StringUtil.formatDate(new Date()));
		}
		logger.info("4定时发送消息提醒客户" + StringUtil.formatDate(new Date()));
	}

	/*
	 * 删除消息信息对象
	 */
	public void del() {
		try {
			String id = request.getParameter("id");
			Message data = messageBussiness.getMessagedata(id);
			data.setDelfalg("1");
			messageBussiness.updateData(data);
			response.getWriter().print(1);
		} catch (Exception e) {
			try {
				response.getWriter().print(0);
			} catch (IOException e1) {

				e1.printStackTrace();
			}
		}
	}

	/*
	 * 更改消息信息对象
	 */
	public String update() {
		try {
			String MessageId = request.getParameter("MessageId");// 消息主键编号
			String id = request.getParameter("id");
			messageBussiness.updateData(message);
			return this.getpage();
		} catch (Exception e) {
			return "sess";
		}
	}

	/*
	 * 更新消息
	 */
	public String update1() {
		String id = request.getParameter("id");

		Message message = messageBussiness.getMessagedata(id);
		request.setAttribute("data", message);

		String hql = "from Messagetype where messagetypeid=2" + " ";
		List meslist = messagetypeBussiness.exHql(hql);
		request.setAttribute("messagetypes", (Messagetype) meslist.get(0));

		return "updateMessage";
	}

	/*
	 * 根据条件进行筛选查询消息信息
	 */
	public String getpage() {
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		String MessageId = request.getParameter("MessageId");// 消息主键编号
		String type = request.getParameter("type");// 消息类型，租用托管，百共等等
		String type2 = request.getParameter("type2");// 消息所属类型，意向，正式
		String name = request.getParameter("name");// 消息名称
		String company = request.getParameter("company");// 消息公司
		String timeb = request.getParameter("timeb");// 消息就建立开始时间
		String timee = request.getParameter("timee");// 消息就建立开始时间
		String hql = "from Message as tb where 1=1 and delfalg!='1'";
		if (MessageId != null && !"".equals(MessageId)) {
			hql += (" and tb.MessageId =" + MessageId);
		}
		if (type != null && !"".equals(type)) {
			hql += " and tb.MessageType like '" + type + "'";
		}
		if (type2 != null && !"".equals(type2)) {
			hql += " and tb.MessageType2 like '%" + type2 + "%'";
		}
		if (name != null && !"".equals(name)) {
			hql += " and tb.MessageName like '%" + name + "%'";
		}
		hql += "order by tb.id desc";
		System.out.println("hql is" + hql);
		Pages pages = messageBussiness.exHqlPages(hql,
				Integer.parseInt(pageNo), 10, null);
		request.setAttribute("pages", pages);
		return "listMessage";
	}

	/*
	 * 获取单个消息信息对象
	 */
	public String get() {
		try {
			String id = request.getParameter("id");
			Message data = messageBussiness.getMessagedata(id);///
			Employee employee = (Employee) messageBussiness.getObject(
					"Employee", " and id = " + data.getSender());
			Customer customer = (Customer) messageBussiness.getObject(
					"Customer", " and customerId = " + data.getSender());

			request.setAttribute("data", data);
			request.setAttribute("employee", employee);
			request.setAttribute("customer", customer);
			return "addMessage";
		} catch (Exception e) {
			return "will";
		}
	}
	/*
	 * 获取单个消息信息对象
	 */
	public String logdetail() {
		try {
			String id = request.getParameter("id");
			Message data = messageBussiness.getMessagedata(id);
			request.setAttribute("data", data);
			return "logdetail";
		} catch (Exception e) {
			return "will";
		}
	}
	public String aaa() {
		String duqu = request.getParameter("duqu");
		System.out.println(duqu);
		return null;
	}

	/**
	 * 获取已读或未读信息
	 * 
	 * @return
	 */
	public String selmessbyreadflag() {
		Cookies cookie = new Cookies();
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		// 标识员工或消息
		String restypeid = request.getParameter("restypeid");
		String readfalg = request.getParameter("readflag");
		if (restypeid != "" && restypeid != null) {
			String receiverer = "";
			if (restypeid.equals("1")) {
				// 客户或员工id
				String eocid = cookie.getCookie(request, "employeeId");
				receiverer = eocid;
			}
			if (restypeid.equals("2")) {
				Customer c = (Customer) request.getSession().getAttribute(
						"customer");
				receiverer = c.getCustomerId() + "";
			}
			// 消息或员工id
			String eocid = cookie.getCookie(request, "employeeId");
			// 是否已读

			if (restypeid != null && readfalg != null) {
				String hql = "from Messagereceiver where messagetype.messagetypeid="
						+ restypeid
						+ " and receiverer="
						+ receiverer
						+ " and readfalg=" + readfalg + " and delfalg=0 ";
				System.out.println("hql : " + hql);
				Pages pages = messageBussiness.exHqlPages(hql, Integer
						.parseInt(pageNo), 10, null);

				request.setAttribute("pages", pages);
				request.setAttribute("mark", readfalg);
				if (restypeid.equals("2")) {
					List<Messagereceiver> list = messageBussiness
							.getObjectList("Messagereceiver",
									" and messagetype.messagetypeid="
											+ restypeid + " and receiverer="
											+ receiverer + " and readfalg="
											+ readfalg + " and delfalg=0 ");
					if (list.size() > 0) {
						String messageids = "";
						for (int i = 0; i < list.size(); i++) {
							messageids += list.get(i).getMessage()
									.getMessageid()
									+ ",";
						}
						List<Message> mlist = messageBussiness.getObjectList(
								"Message", " and messageid in ("
										+ messageids.substring(0, messageids
												.length() - 1) + ")");
						String empids = "";
						for (int i = 0; i < mlist.size(); i++) {
							empids += mlist.get(i).getSender() + ",";
						}
						List<Employee> emplist = messageBussiness
								.getObjectList("Employee", " and id in ("
										+ empids.substring(0,
												empids.length() - 1) + ")");
						System.out.println("size : " + emplist.size());
						request.setAttribute("emplist", emplist);
					}
				}
			}
		}

		if (restypeid.equals("2")) {
			if (readfalg.equals("0")) {
				return "customermessageshow";
			} else {
				return "receivemessageshow";
			}

		}
		return "messshow";
	}

	/**
	 * 客户获取已读或未读信息
	 * 
	 * @return
	 */
	public String selmessbyreadflag1() {
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		String userName = request.getParameter("userName");
		String hql = "";
		String readfalg = request.getParameter("readflag");
		String determine = "";
		// 查询全部列表
		// if(request.getParameter("determine")==null)
		// {
		// determine= request.getSession().getAttribute("determine").toString();
		// }
		if (readfalg == null) {
			readfalg = "";
			// request.getSession().setAttribute("determine", readfalg);
		}

		// 按条件查询determine的值不相等 注入值
		if (readfalg.equals(determine) == false && readfalg != null
				&& readfalg.equals("") == false) {
			request.getSession().removeAttribute("determine");
			request.getSession().setAttribute("determine", readfalg);
		}
		Customer customer = new Customer();

		Customer c = (Customer) request.getSession().getAttribute("customer");
		customer.setCustomerId(c.getCustomerId());
		System.out.println(request.getSession().getAttribute("determine"));
		if ((request.getSession().getAttribute("determine")).equals("0")) {
			hql += "from Messagereceiver where receiverer = '"
					+ customer.getCustomerId()
					+ "' and readfalg=0 and delfalg=0 order by id desc";
		} else if ((request.getSession().getAttribute("determine")).equals("1")) {
			hql += "from Messagereceiver where receiverer = '"
					+ customer.getCustomerId()
					+ "' and readfalg=1 and delfalg=0  order by id desc ";
		} else {
			hql += "from Messagereceiver where receiverer = '"
					+ customer.getCustomerId()
					+ "'  and delfalg=0 order by id desc ";
		}
		System.out.println("hql : " + hql);
		Pages pages = messageBussiness.exHqlPages(hql,
				Integer.parseInt(pageNo), 10, null);
		System.out.println(pages.getAllCount());
		request.setAttribute("pages", pages);
		return "customermessageshow";

	}

	// 发送投诉和建议
	public String addMessByCustomer() throws UnsupportedEncodingException {
		Date now = new Date();
		str3 = dateFormat.format(now);
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"applicationhelloBean.xml");
		HelloBean helloBean = (HelloBean) context.getBean("helloBean");
		System.out.println(helloBean.getHelloWorld());

		boolean flag1 = false;
		Customer c = (Customer) request.getSession().getAttribute("customer");
		System.out.println(message.getTitleweb() + "   ****   "
				+ message.getMessagecontent());
		List<Messagetype> typelist = messageBussiness.getObjectList(
				"Messagetype", " and messagetypeid = 2");

		String title = java.net.URLDecoder.decode(
				request.getParameter("title"), "utf-8");

		Messagetype mess = new Messagetype();
		mess.setMessagetypeid(2);
		String messageaa = java.net.URLDecoder.decode(request
				.getParameter("messagecontent"), "utf-8");

		message.setMessagecontent(messageaa);
		message.setMessagetypeBySendertype(mess);
		message.setSender(c.getCustomerId() + "");
		message.setMessagetypeByMessagetype(typelist.get(0));
		message.setDelfalg(0 + "");
		message.setRepealfalg("0");
		message.setTitleweb(title);
		message.setDraftfalg("0");
		message.setReleasetime(Timestamp.valueOf(str3));

		try {

			boolean flag = messageBussiness.addData(message);

			if (flag) {
				Messagereceiver receiver = new Messagereceiver();
				receiver.setMessage(message);
				// 接收人类型
				receiver.setMessagetype(messagetypeBussiness
						.getMessageTypedata("1"));
				receiver.setDelfalg("0");
				receiver.setReceiverer(helloBean.getHelloWorld());
				receiver.setReadfalg("0");
				flag1 = messagereceiverBussiness.addData(receiver);
			}
			if (flag1) {
				response.getOutputStream().print("0");
			} else {
				response.getOutputStream().print("1");
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 删除信息
	 * 
	 * @return
	 * @throws IOException
	 */
	public String delmesflag() throws IOException {
		System.out.println("delAction");
		System.out.println(ids[0]);
		System.out.println(ids.length);
		boolean flag = messageBussiness.delmessage(ids);
		if (flag) {
			response.getWriter().print("0");
		} else {
			response.getWriter().print("1");
		}
		return null;
	}

	/**
	 * 改变未读状态
	 */
	public String changestate() {

		System.out.println(duqu[0]);
		boolean flag = messageBussiness.duqumessage(duqu);
		try {
			if (flag) {
				response.getWriter().print("0");
			} else {
				response.getWriter().print("1");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	/**
	 * 阅读消息
	 * 
	 * @return
	 */
	public String readMessByCustomer() {
		String rid = request.getParameter("rid");
		String userName = request.getParameter("userName");

		Messagereceiver receiver = (Messagereceiver) messageBussiness
				.getObjectList("Messagereceiver", " and message = " + rid).get(
						0);
		if (receiver != null) {
			System.out.println(receiver.getMessage().getMessageid());
			Message message = (Message) messageBussiness.getObjectList(
					"Message", " and messageid = " + rid).get(0);
			Employee employee = (Employee) messageBussiness.getObjectList(
					"Employee", "and id=" + message.getSender() + "").get(0);
			System.out.println(receiver.getReadfalg());
			if (receiver.getReadfalg().equals("0")) {
				boolean flag = messageBussiness
						.dumessage(Integer.parseInt(rid));
			}

			String employeeName = employee.getName();
			request.setAttribute("receiver", receiver);
			request.setAttribute("customerName", employeeName);
			request.setAttribute("message", message);

		}
		return "readmessageBycustomer";
	}

	public String messend() {
		System.out.println(1111);
		Cookies cookie = new Cookies();
		// 获取登录用户

		String eocid = cookie.getCookie(request, "employeeId");
		System.out.println("eocid" + eocid);
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");

		String hql = "from Message where sender="
				+ eocid
				+ " and repealfalg=0 and delfalg=0 and draftfalg=0 order by messageid desc";

		System.out.println("hql++++++++++++" + hql);

		System.out.println("hql::::::" + hql);
		Pages pages = messageBussiness.exHqlPages(hql,
				Integer.parseInt(pageNo), 10, null);

		System.out.println("pages" + pages);
		System.out.println("pagesssssss");
		request.setAttribute("pages", pages);

		// 14015 2011-12-18 22:03:58
		this.showNotice();
		return "sendshow";
	}

	/**
	 * 删除发送者信息
	 * 
	 * @return
	 */
	public String delsendmes() {
		System.out.println("delAction");
		
		boolean flag = messageBussiness.delsendmes(ids);
		try {
			if (flag) {
				response.getWriter().print("0");
			} else {
				response.getWriter().print("1");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
   /**
    * 读取状态的改变
 * @throws IOException 
    */
	public  String duqu1() throws IOException
	{
		System.out.println("duqu");
		boolean flag=messageBussiness.duqu1message(ids);
		if(flag)
		{
		 response.getWriter().print("0");
		}
		else
		{
			response.getWriter().print("1");
		}
		return null;
	}
	/**
	 * 删除消息
	 */
	public String delMessage() {

		String id = request.getParameter("ids");

		boolean flag = messageBussiness.delMessage(Integer.parseInt(id));

		try {
			if (flag) {
				response.getWriter().print("0");
			} else {
				response.getWriter().print("1");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

	public CustomerBussiness getCustomerBussiness() {
		return customerBussiness;
	}

	public void setCustomerBussiness(CustomerBussiness customerBussiness) {
		this.customerBussiness = customerBussiness;
	}

	public EmployeeBussiness getEmployeeBussiness() {
		return employeeBussiness;
	}

	public void setEmployeeBussiness(EmployeeBussiness employeeBussiness) {
		this.employeeBussiness = employeeBussiness;
	}

	/**
	 * 获得消息类型
	 */
	public String messtype() {
		String hql = "from Messagetype where messagetypeid=1";
		List meslist = messagetypeBussiness.exHql(hql);

		request.setAttribute("messagetypes", (Messagetype) meslist.get(0));

		String hql1 = "from Messagetype where superid=1";
		List meslist1 = messagetypeBussiness.exHql(hql1);
		request.setAttribute("messagetypes1", meslist1);
      
		return "add";

	}

	/**
	 * 获得更新页面消息类型
	 */
	public String updatemesstype() {
		System.out.println("4334443");
		String hql = "from Messagetype where superid=11";
		List<Messagetype> meslist = messagetypeBussiness.exHql(hql);
		request.setAttribute("messagetypes", meslist);

		return "updateMessage";
	}

	/**
	 * 修改消息
	 */
	public void updateMessage() throws IOException {

		String messageid = request.getParameter("messageid"); // 消息Id
		String allType = request.getParameter("allType"); // 类型名称
		System.out.println("allType" + allType);
		String mesty = request.getParameter("mesty"); // 类型对象实体类名称
		System.out.println("mesty" + mesty);
		String messageTitle1 = request.getParameter("messageTitle"); // 消息标题

		String messageContent1 = request.getParameter("messageContent"); // 消息内容

		String messageTitle = URLDecoder.decode(messageTitle1, "UTF-8");
		String messageContent = URLDecoder.decode(messageContent1, "UTF-8");
		String sql = "update message " + "set titleweb='" + messageTitle + "' "
				+ " " + ",messagecontent='" + messageContent + "'" + " "
				+ ",sendertype=" + Integer.parseInt(allType) + " "
				+ ",messagetype=" + Integer.parseInt(mesty) + " "
				+ "where  messageid= " + Integer.parseInt(messageid);
		int num = messageBussiness.exeUpdateSql(sql);
		if (num > 0) {

			response.getWriter().print("0");
		} else {

			response.getWriter().print("1");
		}

	}

	/**
	 * 根据superid查找相应的数据(messagedata.jsp页面所有的方法)
	 */
	public String selbysuperid() {
		response.setContentType("text/html;charset=GBK");

		String superid = request.getParameter("surperid");
		System.out.println(superid);
		// 拼接select
		String str = "";
		if (superid != null) {
			String hql = "from Messagetype where superid=" + superid
					+ " and delflag=0";
			List<Messagetype> meslist = messagetypeBussiness.exHql(hql);
			for (Messagetype mes : meslist) {

				str += "<option value='" + mes.getMessagetypeid() + "'>"
						+ mes.getType() + "</option>";

			}
			try {
				if (str != "")
					response.getWriter().print(str);
				else
					response.getWriter().print(1);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return null;
	}

	/**
	 * 根据superid查找相应的数据(updateMessage.jsp所用的方法)
	 */
	public String selbysuperid1() {
		response.setContentType("text/html;charset=GBK");

		String superid = request.getParameter("surperid");
		System.out.println(superid);
		// 拿出修改页面的元数据Message
		String messageid = request.getParameter("messageid");
		System.out.println("aaaaa" + messageid);
		Message msg = messageBussiness.getMessagedata(messageid);
		// 拼接select
		String str = "";
		if (superid != null) {
			String hql = "from Messagetype where superid=" + 2
					+ " and delflag=0";
			List<Messagetype> meslist = messagetypeBussiness.exHql(hql);
			for (Messagetype mes : meslist) {

				if (msg.getMessagetypeByMessagetype().getMessagetypeid() == mes
						.getMessagetypeid()) {
					str += "<option value='" + mes.getMessagetypeid()
							+ "' selected='selected'>" + mes.getType()
							+ "</option>";
				} else {
					str += "<option value='" + mes.getMessagetypeid() + "'>"
							+ mes.getType() + "</option>";
				}
			}
			try {
				if (str != "")
					response.getWriter().print(str);
				else
					response.getWriter().print(1);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}
		return null;
	}

	/*
	 * 消息列表
	 */
	public String List() {
		Cookies cookie = new Cookies();
		// 获取登录用户
		String eocid = cookie.getCookie(request, "employeeId");
		String hql = "from Message where sender="
				+ eocid
				+ " and repealfalg=0 and delfalg=0 and draftfalg=0 order by messageid desc";
		Pages pages = messageBussiness.exHqlPages(hql, 1, 10, null);
		request.setAttribute("pages", pages);
		return "messageLists";
	}
	
   
	/**
	 * 消息信息
	 * 
	 * @return
	 */
	public String receiveInfo() {
		String typeid = request.getParameter("typeid");
		String messageid = request.getParameter("messageid");
		String hql = " from Messagetype where messagetypeid="
				+ Integer.parseInt(typeid);
		List<Messagetype> messageType = messagetypeBussiness.exHql(hql);
		request.setAttribute("messageType", messageType.get(0));
		String hql2 = " from Messagereceiver where message.messageid="
				+ Integer.parseInt(messageid);
		List<Messagereceiver> messR = messagereceiverBussiness.exHql(hql2);
		request.setAttribute("messR", (Messagereceiver) messR.get(0));

		String hql3 = "";
		List<Employee> empList = new ArrayList<Employee>();
		List<Customer> cusList = new ArrayList<Customer>();
		for (int i = 0; i < messR.size(); i++) {
			if (messR.get(0).getTmp1().equals("0")) {

				hql3 = " from Employee where id = "
						+ Integer.parseInt(messR.get(i).getReceiverer());
				List<Employee> e = employeeBussiness.exHql(hql3);
				System.out.println(e.get(0).getId());
				// System.out.println(e.get(i).getId());

				empList.add(employeeBussiness.exHql(hql3).get(0));

			} else if (messR.get(0).getTmp1().equals("1")) {
				hql3 = " from Customer where customerId = "
						+ Integer.parseInt(messR.get(i).getReceiverer());
				List<Customer> e = customerBussiness.exHql(hql3);
				System.out.println(e.size());
				System.out.println(e.get(0).getCustomerName());
				// System.out.println(e.get(i).getCustomerName());
				cusList.add(customerBussiness.exHql(hql3).get(0));

			}
		}
		System.out.println("hql3====" + hql3);

		if (empList.size() > 0) {
			request.setAttribute("empList", empList);
		} else if (cusList.size() > 0) {
			request.setAttribute("cusList", cusList);
		}

		return "receiveInfo";
	}

	/**
	 * 留言版
	 * 
	 * @return
	 */
	public String boardMessage() {
		//System.out.println("aaaa");

		String hql3 = " from Messagetype where type= '员工反馈  ' or  type='客户反馈'";
		List<Messagetype> messTypeList = messagetypeBussiness.exHql(hql3);
		List<Object> messageList = new ArrayList<Object>();
		String hql2=null;
		Pages pages=null;
		int count=0;
		for (int i = 0; i < messTypeList.size(); i++) {
			System.out.println(messTypeList.get(i).getMessagetypeid());
			hql2 = "from Message where messagetypeByMessagetype.messagetypeid = "
					+ messTypeList.get(i).getMessagetypeid()+" and delfalg='0' order by messageid desc";
			System.out.println(messageBussiness.exHql(hql2).size());
			if (messageBussiness.exHql(hql2).size() > 1) {
				for (int j = 0; j < messageBussiness.exHql(hql2).size(); j++) {

					messageList.add(messageBussiness.exHql(hql2).get(j));
				}
			} else if (messageBussiness.exHql(hql2).size() == 1) {
				messageList.add(messageBussiness.exHql(hql2).get(0));
			}
			if(messageList.size()>0 && messageBussiness.exHql(hql2).size() >= 1){
			 pages=messageBussiness.exHqlPages(hql2, 1, 10, null);
			 
			 count+=pages.getAllCount();
			 pages.setAllCount(count);
			
			
			}
			
		}
		request.setAttribute("pages", pages);
		
		request.setAttribute("messageList", messageList);
		pages.setPageList(messageList);
	
		return "messBoards";
	}
	
	/**
	 * 
	 * @return
	 */
	public String judgeM()
	{
		response.setContentType("text/html;charset=GBK");
		String messJudge=request.getParameter("messJudge");
		String mId=request.getParameter("typeid");
		
		System.out.println(messJudge);
		String str="";
		str+="<option value='-1'>请选择！！</option>";
		if(Integer.parseInt(messJudge)==1)
		{
			 String hql="from Messagetype where superid="+Integer.parseInt(mId);
			 System.out.println(hql);
			 List<Messagetype> mList=messagetypeBussiness.exHql(hql);
			 for (Messagetype messagetype : mList) {
				 
				str+="<option value='"+messagetype.getMessagetypeid()+"'>"+messagetype.getType()+"</option>";
			}
			
		}
		if(Integer.parseInt(messJudge)==0)
		{
			 String hql="from Messagetype where superid="+0;
			 System.out.println(hql);
			 List<Messagetype> mList=messagetypeBussiness.exHql(hql);
			 for (Messagetype messagetype : mList) {
				 
				str+="<option value='"+messagetype.getMessagetypeid()+"'>"+messagetype.getType()+"</option>";
			}
			
		}
		try {
			if(str!=null)
			{
				response.getWriter().print(str);
			}
			else
			{
				response.getWriter().print(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	
	/*
	 * 根据条件进行筛选查询消息信息
	 */
	public String getpages() {

		String MessageId = request.getParameter("MessageId");// 消息主键编号
		String type = request.getParameter("type");// 消息类型，租用托管，百共等等
		String type2 = request.getParameter("type2");// 消息所属类型，意向，正式
		String name = request.getParameter("name");// 消息名称
		String company = request.getParameter("company");// 消息公司
		String timeb = request.getParameter("timeb");// 消息就建立开始时间
		String timee = request.getParameter("timee");// 消息就建立开始时间
		String hql = "from Message as tb where 1=1 and delfalg!='1'";
		if (MessageId != null && !"".equals(MessageId)) {
			hql += (" and tb.MessageId =" + MessageId);
		}
		if (type != null && !"".equals(type)) {
			hql += " and tb.MessageType like '" + type + "'";
		}
		if (type2 != null && !"".equals(type2)) {
			hql += " and tb.MessageType2 like '%" + type2 + "%'";
		}
		if (name != null && !"".equals(name)) {
			hql += " and tb.MessageName like '%" + name + "%'";
		}
		hql += "order by tb.messageid desc";
		System.out.println("hql is" + hql);
		Pages pages = messageBussiness.exHqlPages(hql, 1, 10, null);
		request.setAttribute("pages", pages);
		return "messageLists";
	}

	/**
	 * allNoticeMessage 获得所有的公告列表 author：阙超强 2011-11-21 17:35:26
	 */
	public String allNotice() {
		// 得到分页页码
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		String hql = "from Message where messagetypeByMessagetype.messagetypeid in(4,9,10,18) "
				+ "and repealfalg=0 and delfalg=0 and draftfalg=0 order by messageid desc";

		// 查询出所有公告
		List<Message> noticeList = messageBussiness.exHql(hql);

		// 查询当前页的所有公告
		Pages pagesNotice = messageBussiness.exHqlPages(hql, Integer
				.parseInt(pageNo), 10, null);

		// 查询出所有公告的发送人 ，分两类:员工和客户
		int noticeListSize = noticeList.size();
		if (noticeListSize > 0) {
			String empids = "";
			for (int i = 0; i < noticeListSize; i++) {
				if (!StringUtil.isnull(noticeList.get(i).getSender())) {
					empids += noticeList.get(i).getSender() + ",";
				}
			}
			List<Employee> employeeList = messageBussiness.getObjectList(
					"Employee", " and id in ("
							+ empids.substring(0, empids.length() - 1) + ")");
			List<Customer> customerList = messageBussiness.getObjectList(
					"Customer", " and customerId in ("
							+ empids.substring(0, empids.length() - 1) + ")");
			// 发送给请求
			request.setAttribute("pages", pagesNotice);
			request.setAttribute("employeeList", employeeList);
			request.setAttribute("customerList", customerList);
		}
		return "allNotice";
	}

	public String addCDN() throws UnsupportedEncodingException {

		String charset = "utf-8";
		String yuming = java.net.URLDecoder.decode(request
				.getParameter("yuming"), charset);
		String trueName = java.net.URLDecoder.decode(request
				.getParameter("trueName"), charset);
		String ban = java.net.URLDecoder.decode(request.getParameter("ban"),
				charset);
		String yuanIP = java.net.URLDecoder.decode(request
				.getParameter("yuanIP"), charset);
		String liuliangIP = java.net.URLDecoder.decode(request
				.getParameter("liuliangIP"), charset);
		String pvshu = java.net.URLDecoder.decode(
				request.getParameter("pvshu"), charset);
		String selectpinlv = java.net.URLDecoder.decode(request
				.getParameter("selectpinlv"), charset);
		String customerphone = java.net.URLDecoder.decode(request
				.getParameter("customerphone"), charset);
		String khyx = java.net.URLDecoder.decode(request.getParameter("khyx"),
				charset);
		String toyx = java.net.URLDecoder.decode(request.getParameter("toyx"),
				charset);
		String customerName = java.net.URLDecoder.decode(request
				.getParameter("customerName"), charset);
		String daxiao = java.net.URLDecoder.decode(request
				.getParameter("daxiao"), charset);

		String houzuiming = java.net.URLDecoder.decode(request
				.getParameter("houzuiming"), charset);
		String frequency = "";
		if (selectpinlv.equals("2")) {
			frequency = "10分钟~~30分钟";
		} else if (selectpinlv.equals("3")) {
			frequency = "30分钟~~1小时";
		} else if (selectpinlv.equals("4")) {
			frequency = "1小时~~1天";
		} else if (selectpinlv.equals("5")) {
			frequency = "1天~~1个月";
		} else if (selectpinlv.equals("6")) {
			frequency = "1个月以上";
		}
		Email sendemail = new Email();
		String message = "域名：	" + yuming + "<br />备案号：" + ban + "<br />原IP：	"
				+ yuanIP + "<br />IP流量:" + liuliangIP + "<br />PV数：		" + pvshu
				+ "<br />文件大小：" + daxiao + "<br />文件加速类型：" + houzuiming
				+ "<br />更新频率：	" + frequency + "<br /><br />客户账号："
				+ customerName + "<br />客户姓名：" + trueName + "<br />手机号："
				+ customerphone + "<br />邮箱" + khyx;
		System.out.println(message);
		boolean flag = sendemail.sendEmail(toyx, "申请CDN提醒", message);
		try {
			if (flag) {
				response.getWriter().print("1");
			} else {
				response.getWriter().print("2");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	/**
	 * 页面上选择了项目管理,自动列出所有项目名称
	 * @return
	 */
	public String showPrj(){
		response.setCharacterEncoding("utf-8");
		String hql = "from Project";
		plist = messageBussiness.getProject(hql);
		System.out.println(plist.size());
		System.out.print(plist.get(0).toString());
		
		try {
			
			PrintWriter out = response.getWriter();
			for(int i=0;i<plist.size();i++){
				Project project = (Project)plist.get(i);
				String str = "";
				str+="<option value='"+i+"'>"+project.getPrjname()+"</option>";
				System.out.println(str);
				//处理乱码  转码为utf-8
				String string = URLDecoder.decode(str, "utf-8");
				out.print(string);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*************
	 * 查看所有未读短消息 
	 */
	public String noreadMessage(){
		// 得到分页页码
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		Employee emp = (Employee) request.getSession().getAttribute("emp");
		// 得到当前登录人今天收到的邮件
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String releasetime = sdf.format(now);
		String hql="from Messagereceiver where receiverer="+emp.getId()+" and delfalg=0 and receivetime='"+releasetime+"'";
		List nowemaillist=messageBussiness.exeHql(hql);
		request.setAttribute("nowemaillist", nowemaillist);
		
		String hql2="from Messagereceiver where receiverer="+emp.getId()+" and delfalg=0 and receivetime<'"+releasetime+"'";
		// 得到以前更早的邮件信息
		Pages pages = messageBussiness.exHqlPages(hql2, Integer
				.parseInt(pageNo), 10, null);
	    request.setAttribute("pages",pages);
	    request.setAttribute("messageBussiness", messageBussiness);
		return "noread";
	}
	
	/********
	 * 接收读取消息 状态
	 */
	public String updateMessageState(){
		System.out.println(this.ids);
		if(this.ids.length>0){
			for(int i=0;i<ids.length;i++){
				// 根据ID查找对象并且修改对象
				int receiverId=Integer.parseInt(ids[i]+"");
				Messagereceiver receiver=(Messagereceiver) messageBussiness.getEmp(Messagereceiver.class, receiverId);
				receiver.setReadfalg("1");
				receiver.setDelfalg("1");
				messageBussiness.addReceiver(receiver);
			}
		}
		return "updatestate";
	}
	
	/**********
	 * 添加消息 ，胡宝林写
	 */
	public String add2(){
		String id=request.getParameter("id");
		String logno=request.getParameter("logno");
		// 拿到当前登录员工
		Employee loginEmp = (Employee)request.getSession().getAttribute("emp");
		//发送短消息(对参与人员),先向message表写入数据,messageid有值后再向messagereceiver表写数据
		Messagetype sendertype = (Messagetype)messageBussiness.getEmp(Messagetype.class, 1);  //sendertype员工消息
		Messagetype messagetype = (Messagetype)messageBussiness.getEmp(Messagetype.class, PublicMissionType.plantype); //messagetype 消息类型:日志问询
		
		String sender = loginEmp.getId()+"";
		Message mess = new Message();
		mess.setSender(sender);  //发送人(当前登录人ID)
		mess.setMessagetypeBySendertype(sendertype); //发送类型:员工消息
		mess.setMessagetypeByMessagetype(messagetype);//消息类型:个人公告
		String title = receiver.getMessage().getTitleweb(); //标题
		String messagecontent = receiver.getMessage().getMessagecontent(); //内容
		mess.setTitleweb(title);
		mess.setTmp3("goAddNewReplyWorkLogNewportal.do?logNo="+id+"&id="+logno);
		mess.setMessagecontent(messagecontent);
		mess.setRepealfalg("0"); //是否撤销 0为否 	 1为是
		mess.setDelfalg("0"); //删除标识
		mess.setDraftfalg("0"); //草稿标识
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String releasetime = sdf.format(now);
		mess.setReleasetime(Timestamp.valueOf(releasetime));
		mess.setTmp1("0");
		messageBussiness.addObject(mess);
		//消息表有PK之后,再向接收消息表写入记录
		Messagereceiver rec = new Messagereceiver();
		rec.setMessage(mess);
		rec.setMessagetype(sendertype);
		rec.setReceiverer(receiver.getReceiverer());
		rec.setReceivetime(Timestamp.valueOf(releasetime));
		rec.setReadfalg("0"); //是否读取 未读取0
		rec.setDelfalg("0"); //删除标识 没有0
		rec.setTmp1("0");  //0是员工 1是客户
		//根据日记事取到日志记事对象
		Integer planid=receiver.getPlanid();
		rec.setPlanid(planid);
		messageBussiness.addObject(rec);
		request.setAttribute("id", id);
		request.setAttribute("logno", logno);
		
		return "planmessage";
	}
	/************
	 * 回复消息
	 * @throws IOException 
	 */
	public String reply() throws IOException{
		try {
			// 拿到当前登录员工
			Employee loginEmp = (Employee)request.getSession().getAttribute("emp");
			String content= URLDecoder.decode(request.getParameter("content"),"utf-8");
			Integer receiverid=Integer.parseInt(request.getParameter("id"));
			Messagereceiver rv=(Messagereceiver) messageBussiness.getEmp(Messagereceiver.class, receiverid);
			//先将以前的消息改成已读
			rv.setReadfalg("1");
			messageBussiness.addReceiver(rv); // 修改
			
			Message mg=new Message();
			
			mg.setMessagetypeBySendertype(rv.getMessage().getMessagetypeBySendertype());
			System.out.println(rv.getMessage().getMessagetypeByMessagetype().getMessagetypeid());
			mg.setMessagetypeByMessagetype(rv.getMessage().getMessagetypeByMessagetype());
			mg.setTitleweb(rv.getMessage().getTitleweb());
			mg.setMessagecontent(content);
			System.out.println(rv.getMessage().getMessageid());
			mg.setSuperid(rv.getMessage().getMessageid());
			mg.setSender(loginEmp.getId()+"");
			mg.setRepealfalg("0"); //是否撤销 0为否 	 1为是
			mg.setDelfalg("0"); //删除标识
			mg.setDraftfalg("0"); //草稿标识
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String releasetime = sdf.format(now);
			mg.setReleasetime(Timestamp.valueOf(releasetime));
			mg.setTmp1("0");
			mg.setTmp3(rv.getMessage().getTmp3());			
			messageBussiness.addObject(mg); // 添加消息，将读取后的消息改成已读
			
			//消息表有PK之后,再向接收消息表写入记录
			Messagereceiver rec = new Messagereceiver();
			rec.setMessage(mg);
			rec.setMessagetype(rv.getMessagetype());
			// 接收信息人是发送这个消息的人.
			rec.setReceiverer(rv.getMessage().getSender());
			rec.setReceivetime(Timestamp.valueOf(releasetime));
			rec.setReadfalg("0"); //是否读取 未读取0
			rec.setDelfalg("0"); //删除标识 没有0
			rec.setTmp1("0");  //0是员工 1是客户
			//根据日记事取到日志记事对象
			if(rv.getPlanid()!=null){
				Integer planid=rv.getPlanid();
				rec.setPlanid(planid);
			}
			messageBussiness.addObject(rec);
			response.getWriter().print("0");
		} catch (Exception e) {
			response.getWriter().print("1");
		}
		
		return null;
	}
	
	/**********
	 *  写日志消息
	 */
	public String writelog(){
		String mid=request.getParameter("mid");
		Message message=null;
		if(mid!=null){
			message=(Message)messageBussiness.getEmp(Message.class, Integer.parseInt(mid));
			// 根据message找到所有收件人
			String hql="FROM Messagereceiver WHERE message.messageid="+message.getMessageid();
	        List list=messageBussiness.exeHql(hql);
	        String empstr="";
	        String empstrid="";
	        for(int j=0;j<list.size();j++){
	     	   Messagereceiver receiver=(Messagereceiver)list.get(j);
	     	   int empid=Integer.parseInt(receiver.getReceiverer());
		       Employee emp=(Employee)messageBussiness.getEmp(Employee.class,empid);
		       empstr+=emp.getName()+",";
		       empstrid+=emp.getId()+",";
	        }
			request.setAttribute("empstr", empstr);
			request.setAttribute("empstrid", empstrid);
			request.setAttribute("message", message);
		}
		// 得到所有员工集合
		String hql="FROM Employee WHERE isLeave=1 AND delflag=0";
		List emplist=messageBussiness.exHql(hql);
		// 得到所有部门集合
		String depthql="from Department where delflag=0";
		List deptlist=messageBussiness.exHql(depthql);
		String sq=" SELECT  DISTINCT(superid) id FROM messagetype";
		List li= messageBussiness.exeSql(sq);
		String str="";
		for(int i=0;i<li.size();i++){
			str+=","+li.get(i);
		}
		//得到消息类型
		String hql2="from Messagetype where messagetypeid in (''"+str+")"; 
		List messList= messageBussiness.exHql(hql2);
		request.setAttribute("messlist", messList);
		request.setAttribute("deptlist", deptlist);
		request.setAttribute("emplist", emplist);
		return "writelog";
	}
	/*******
	 * 根据部门编号找到员工
	 */
	public String empBydid(){
		int deptid=Integer.parseInt( request.getParameter("deptid"));
		String hql="from Employee where department.id="+deptid;
		List list=messageBussiness.exHql(hql);
		
		String str="";
		for(int i=0;i<list.size();i++){
			Employee emp=(Employee)list.get(i);
			str+="<tr height='30'>";
			str+="<td><input type='checkbox' id='"+emp.getId()+"' value='"+emp.getName()+"'  onclick='checkEmp(this)' >"+emp.getName()+"</td>";
			str+="</tr>";
		}
		try {
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (Exception e) {
		}
		
		return null;
	}
	
	/**********
	 * 发送消息 
	 */
	public String send(){
		try{
			// 拿到当前登录员工
			Employee loginEmp = (Employee)request.getSession().getAttribute("emp");			
			Message mg=new Message();
			mg.setMessagetypeBySendertype(message.getMessagetypeBySendertype());			
			mg.setMessagetypeByMessagetype(message.getMessagetypeByMessagetype());
			mg.setTitleweb(message.getTitleweb());
			mg.setMessagecontent(message.getMessagecontent());
			mg.setSender(loginEmp.getId()+"");
			mg.setRepealfalg("0"); //是否撤销 0为否 	 1为是
			mg.setDelfalg("0"); //删除标识
			mg.setDraftfalg("0"); 
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String releasetime = sdf.format(now);
			mg.setReleasetime(Timestamp.valueOf(releasetime));
			mg.setTmp1("0");		
			messageBussiness.addObject(mg); // 添加消息，将读取后的消息改成已读		
			// 接收信息人是发送这个消息的人
			String users=request.getParameter("users");
			String[] arremp=users.split(",");
			for(int i=0;i<arremp.length;i++){
				if(arremp[i].trim().length()>0){
					//消息表有PK之后,再向接收消息表写入记录
					Messagereceiver rec = new Messagereceiver();
					rec.setMessage(mg);
					rec.setMessagetype(message.getMessagetypeByMessagetype());
					rec.setReceiverer(arremp[i]);
					rec.setReceivetime(Timestamp.valueOf(releasetime));
					rec.setReadfalg("0"); //是否读取 未读取0
					rec.setDelfalg("0");
					rec.setTmp1("0");  //0是员工 1是客户
					messageBussiness.addObject(rec);
				}
			}
			return "send";
		}catch (Exception e) {
			return "errorPage";
		}
	}
	
	/**********
	 * 保存草稿箱
	 */
	public String caogao(){
		try{
			// 拿到当前登录员工
			Employee loginEmp = (Employee)request.getSession().getAttribute("emp");		
			Integer typeid=Integer.parseInt(request.getParameter("typeid"));
			Integer mesty=Integer.parseInt(request.getParameter("mesty"));
			String titleweb=URLDecoder.decode(request.getParameter("titleweb"),"utf-8");
			String content=URLDecoder.decode(request.getParameter("content"),"utf-8");
			Messagetype sendtype=(Messagetype)messageBussiness.getEmp(Messagetype.class, typeid);
			Messagetype messagetype=(Messagetype)messageBussiness.getEmp(Messagetype.class, mesty);
			String users=request.getParameter("users");
			
			Message mg=new Message();
			mg.setMessagetypeBySendertype(sendtype);			
			mg.setMessagetypeByMessagetype(messagetype);
			mg.setTitleweb(titleweb);
			mg.setMessagecontent(content);
			mg.setSender(loginEmp.getId()+"");
			mg.setRepealfalg("0"); //是否撤销 0为否 	 1为是
			mg.setDelfalg("3"); //删除标识
			mg.setDraftfalg("0"); 
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String releasetime = sdf.format(now);
			mg.setReleasetime(Timestamp.valueOf(releasetime));
			mg.setTmp1("0");		
			messageBussiness.addObject(mg); // 添加消息，将读取后的消息改成已读		
			// 接收信息人是发送这个消息的人
			String[] arremp=users.split(",");
			for(int i=0;i<arremp.length;i++){
				if(arremp[i].trim().length()>0){
					//消息表有PK之后,再向接收消息表写入记录
					Messagereceiver rec = new Messagereceiver();
					rec.setMessage(mg);
					rec.setMessagetype(messagetype);
					rec.setReceiverer(arremp[i]);
					rec.setReceivetime(Timestamp.valueOf(releasetime));
					rec.setReadfalg("0"); //是否读取 未读取0
					rec.setDelfalg("3");
					rec.setTmp1("0");  //0是员工 1是客户
					messageBussiness.addObject(rec);
				}
			}
			response.setCharacterEncoding("utf-8");
			response.getWriter().print("已保存到草稿箱");
		}catch (Exception e) {
			return "errorPage";
		}
		return null;
	}
	
	/*********
	 * 得到消息历史记录
	 */
	public String history(){
		msglist=new ArrayList<Message>();
		
		String messageid=request.getParameter("messageid");
		Message message=(Message)messageBussiness.getEmp(Message.class, Integer.parseInt(messageid));
		request.setAttribute("message", message);
		String hql="from Message where superid="+message.getMessageid();
		List list=messageBussiness.exHql(hql);
		// 往 下找
		for(int i=0;i<list.size();i++){
			Message ms=(Message)list.get(i);
			msglist.add(ms);
			getMsgListById(ms.getMessageid());
		}
		if(message.getSuperid()!=null){
			// 往上找
			String parenthql="from Message where superid="+message.getSuperid();
			List parentlist=messageBussiness.exHql(parenthql);
			for(int i=0;i<parentlist.size();i++){
				Message ms=(Message)list.get(i);
				if(ms.getSuperid()!=null){
					getParentMsgListById(ms.getSuperid());
				}
			}
		}
		request.setAttribute("msglist", msglist);
		request.setAttribute("messageBussiness", messageBussiness);
		return "history";
	}
	// 往下找
	public List getMsgListById(int superid){
		String hql="from Message where superid="+superid;
		List list=messageBussiness.exHql(hql);
		for(int i=0;i<list.size();i++){
			Message ms=(Message)list.get(i);
	        msglist.add(ms);
			if(ms.getSuperid()!=null){
				getMsgListById(ms.getMessageid());
			}
		}
		return list;
	}
	
	// 往上找
	public List getParentMsgListById(int superid){
		Message message=(Message)messageBussiness.getEmp(Message.class, superid);
		msglist.add(message);
		String hql="from Message where superid="+message.getSuperid();
		List list=messageBussiness.exHql(hql);
		for(int i=0;i<list.size();i++){
			Message ms=(Message)list.get(i);
			if(ms.getSuperid()!=null){
				getMsgListById(ms.getSuperid());
			}
		}
		return list;
	}
	
	// 根据消息编号找到消息对象
	public String getReceiverByRid(){
		String tmp=request.getParameter("tmp");
		String rid=request.getParameter("rid");
		if(tmp.equals("message")){
			// 得到了这条消息后就将这条消息标为已读
			Message message=(Message)messageBussiness.getEmp(Message.class, Integer.parseInt(rid));
			// 根据message找到所有收件人
			String hql="FROM Messagereceiver WHERE message.messageid="+message.getMessageid();
	        List list=messageBussiness.exeHql(hql);
	        String empstr="";
	        for(int j=0;j<list.size();j++){
	     	   Messagereceiver receiver=(Messagereceiver)list.get(j);
	     	   int empid=Integer.parseInt(receiver.getReceiverer());
		       Employee emp=(Employee)messageBussiness.getEmp(Employee.class,empid);
		       empstr+=emp.getName()+",";
	        }
	        // 保存发件人
			request.setAttribute("message", message);
			request.setAttribute("empstr", empstr);
			return "messagebymid";
		}
		else{
			// 得到了这条消息后就将这条消息标为已读
			Messagereceiver receiver=(Messagereceiver)messageBussiness.getEmp(Messagereceiver.class, Integer.parseInt(rid));
			receiver.setReadfalg("1");
			messageBussiness.updateObj(receiver);
			request.setAttribute("receiver", receiver);
			request.setAttribute("messageBussiness", messageBussiness);
			return "receiver";
		}
	}
	
	// 得到已删除的邮件信息
	public String delEmail(){
		// 得到分页页码
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		Employee emp = (Employee) request.getSession().getAttribute("emp");
		// 找到我接收的删除消息
		String hql2="from Messagereceiver where receiverer="+emp.getId()+" and delfalg=1";
		// 得到以前更早的邮件信息
		Pages pages = messageBussiness.exHqlPages(hql2, Integer
				.parseInt(pageNo), 10, null);
		
		// 找到我发送的删除消息
		String hql="from Message where sender="+emp.getId()+" and delfalg=1";
		List messagelist=messageBussiness.exeHql(hql);
		for(int i=0;i<messagelist.size();i++){
			Message message=(Message) messagelist.get(i);
			Messagereceiver receiver=new Messagereceiver();
			receiver.setMessage(message);
			receiver.setTmp1("message");
			pages.getPageList().add(receiver);
		}
		pages.setAllCount(pages.getAllCount()+messagelist.size());
	    request.setAttribute("pages",pages);
	    request.setAttribute("messageBussiness", messageBussiness);
		return "delemail";
	}
	
	// 删除邮件
	public String del2(){
		if(this.ids.length>0){
			for(int i=0;i<ids.length;i++){
				// 根据ID查找对象并且修改对象
				String[] arr=ids[i].toString().split("\\|");
				if(arr.length>=2){
					int mid=Integer.parseInt(arr[0]+"");
					Message message=(Message) messageBussiness.getEmp(Message.class, mid);
					message.setDelfalg("2");
					messageBussiness.updateObj(message);
				}else{
					int receiverId=Integer.parseInt(ids[i]+"");
					Messagereceiver receiver=(Messagereceiver) messageBussiness.getEmp(Messagereceiver.class, receiverId);
					receiver.setDelfalg("2");
					messageBussiness.updateObj(receiver);
				}
			}
		}
		return "del2";
	}
	
	// 删除草稿邮件
	public String draft(){
		if(this.ids.length>0){
			for(int i=0;i<ids.length;i++){
				// 根据ID查找对象并且修改对象
				int mid=Integer.parseInt(ids[i]+"");
				Message message=(Message) messageBussiness.getEmp(Message.class, mid);
				message.setDelfalg("2");
				messageBussiness.updateObj(message);
			}
		}
		return "draft";
	}
	
	// 得到我发送的邮件信息
	public String sendEmail(){
		// 得到分页页码
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		Employee emp = (Employee) request.getSession().getAttribute("emp");
		String hql2="from Message where sender="+emp.getId()+" and delfalg=0";
		// 得到以前更早的邮件信息
		Pages pages = messageBussiness.exHqlPages(hql2, Integer
				.parseInt(pageNo), 10, null);
	    request.setAttribute("pages",pages);
	    request.setAttribute("messageBussiness", messageBussiness);
		return "sendEmail";
	}
	
	// 根据消息编号找到消息对象
	public String getMessageByMid(){
		String mid=request.getParameter("mid");
		// 得到了这条消息后就将这条消息标为已读
		Message message=(Message)messageBussiness.getEmp(Message.class, Integer.parseInt(mid));
		// 根据message找到所有收件人
		String hql="FROM Messagereceiver WHERE message.messageid="+message.getMessageid();
        List list=messageBussiness.exeHql(hql);
        String empstr="";
        for(int j=0;j<list.size();j++){
     	   Messagereceiver receiver=(Messagereceiver)list.get(j);
     	   int empid=Integer.parseInt(receiver.getReceiverer());
	       Employee emp=(Employee)messageBussiness.getEmp(Employee.class,empid);
	       empstr+=emp.getName()+",";
        }
        // 保存发件人
		request.setAttribute("message", message);
		request.setAttribute("empstr", empstr);
		return "messagebymid";
	}
	
	// 删除选中的已发送的消息
	public String delSend(){
		if(this.ids.length>0){
			for(int i=0;i<ids.length;i++){
				// 根据ID查找对象并且修改对象
				int mid=Integer.parseInt(ids[i]+"");
				Message message=(Message) messageBussiness.getEmp(Message.class, mid);
				message.setDelfalg("1");
				messageBussiness.updateObj(message);
			}
		}
		return "delSend";
	}
	
	// 查看草稿箱的消息
	public String caogaoEmail(){
		// 得到分页页码
		String pageNo = request.getParameter("pageNo") == null ? "1" : request
				.getParameter("pageNo");
		Employee emp = (Employee) request.getSession().getAttribute("emp");
		String hql="from Message where sender="+emp.getId()+" and delfalg=3";
		// 得到以前更早的邮件信息
		Pages pages = messageBussiness.exHqlPages(hql, Integer
				.parseInt(pageNo), 10, null);
	    request.setAttribute("pages",pages);
	    request.setAttribute("messageBussiness", messageBussiness);
	    
		return "caogaoEmail";
	}
	
	// 根据员工名称找到人员
	public String getEmpByname(){
		String empname=request.getParameter("empname");
		try {
			empname=URLDecoder.decode(empname, "utf-8");
			String hql="from Employee where isLeave=1 and delflag=0 and name like '%"+empname+"%'";
			List emplist= messageBussiness.exeHql(hql);
			String str="<ul>";
			for(int i=0;i<emplist.size();i++){
				Employee emp=(Employee)emplist.get(i);
				// <li><label><input type="checkbox" id="${emp.id }" value="${emp.name }" onclick="checkEmp(this)" />${emp.name }</label></li>
				str+="<li><label><input type='checkbox' id='"+emp.getId()+"' value='"+emp.getName()+"' onclick='checkEmp(this)' />"+emp.getName()+"</label></li>";
			}
			str+="</ul>";
			response.setCharacterEncoding("utf-8");
			response.getWriter().print(str);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
}

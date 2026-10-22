package com.fuao.fajxc.action.server;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;

import sun.security.action.PutAllAction;
import sun.util.logging.resources.logging;

import com.fuao.fajxc.action.system.WorkOrderCfigurAction;
import com.fuao.fajxc.bussiness.commodity.CommodityBussiness;
import com.fuao.fajxc.bussiness.commodity.ProductBussiness;
import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.bussiness.model.ModelBussiness;
import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.bussiness.server.UpserverBussiness;
import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.dao.project.ProjectDao;
import com.fuao.fajxc.serser.dao.SerajaxDao;
import com.fuao.fajxc.serser.service.CabinetContent;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Page;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.util.TimePattern;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Cabinet;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Conkoutask;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.DownServer;
import com.fuao.fajxc.vo.ElectHouse;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Executerecord;
import com.fuao.fajxc.vo.Freeze;
import com.fuao.fajxc.vo.IPConfiguration;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.Operate;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Property;
import com.fuao.fajxc.vo.Questioncategory;
import com.fuao.fajxc.vo.SaleGoods_mids;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.SaledFlow;
import com.fuao.fajxc.vo.UpServer;
import com.fuao.fajxc.vo.WorkLog;
import com.fuao.fajxc.vo.Workorder;
import com.ibm.icu.util.Calendar;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class UpserverAction implements ModelDriven,ServletRequestAware,ServletResponseAware {

	Logger logg=Logger.getLogger(UpServer.class);
	
	private UpserverBussiness upb;
	private UpServer ups;
	private Object ids[];
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Product product; 
	private Cabinet cabinet;
	private Customer customer;
	private CommodityBussiness commbizimpl;// 注入BIZ
	//添加上架单时对IP进行重复验证,先取出已上架的商品,要用List
	private List upserverlist;
	private SerajaxDao serAjax;
	private Logger logs=Logger.getLogger(CabinetContent.class);
	private String ser;
	private Property property;  
	private Operate operate;   //运维单对象
	private Workorder workorder;  //工单
	private Sale_orders saleOrders;
	private int flag=0;
	private int pid;  //商品id,全局变量,用于解除冻结商品
	//动态记录
	public ExecuteRecordBussiness executeRecordBussiness;
	private SaleorderBussiness salsBussines;
	
	public SaleorderBussiness getSalsBussines() {
		return salsBussines;
	}

	public void setSalsBussines(SaleorderBussiness salsBussines) {
		this.salsBussines = salsBussines;
	}

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}
    
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}

	//获得上架单号
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	Cookies ck = new Cookies();
	private AuditingBussiness audBussiness;
	private ProductBussiness productBussiness;
	private ResourceBundle rb = ResourceBundle.getBundle("proper");
	
	private ModelBussiness modelBussiness;

	public ModelBussiness getModelBussiness() {
		return modelBussiness;
	}

	public void setModelBussiness(ModelBussiness modelBussiness) {
		this.modelBussiness = modelBussiness;
	}

	public ProductBussiness getProductBussiness() {
		return productBussiness;
	}

	public void setProductBussiness(ProductBussiness productBussiness) {
		this.productBussiness = productBussiness;
	}

	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	public CommodityBussiness getCommbizimpl() {
		return commbizimpl;
	}

	public void setCommbizimpl(CommodityBussiness commbizimpl) {
		this.commbizimpl = commbizimpl;
	}

	public UpserverBussiness getUpb() {
		return upb;
	}

	public void setUpb(UpserverBussiness upb) {
		this.upb = upb;
	}

	public Object getModel() {
		ups=new UpServer();
		return ups;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub
		this.request=arg0;
	}

	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub
		this.response=arg0;
	}


	public Object[] getIds() {
		return ids;
	}

	public void setIds(Object[] ids) {
		this.ids = ids;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	
	public List getUpserverlist() {
		return upserverlist;
	}

	public void setUpserverlist(List upserverlist) {
		this.upserverlist = upserverlist;
	}

	public UpServer getUps() {
		return ups;
	}

	public void setUps(UpServer ups) {
		this.ups = ups;
	}

	public void setCabinet(Cabinet cabinet) {
		this.cabinet = cabinet;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public SerajaxDao getSerAjax() {
		return serAjax;
	}

	public void setSerAjax(SerajaxDao serAjax) {
		this.serAjax = serAjax;
	}

	public int getIntNum(int mn){
		return (int) Math.round(Math.random()*mn);
	}

	public String getSer() {
		return ser;
	}

	public void setSer(String ser) {
		this.ser = ser;
	}

	public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	public void setOperate(Operate operate) {
		this.operate = operate;
	}

	public Operate getOperate() {
		return operate;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public Sale_orders getSaleOrders() {
		return saleOrders;
	}

	public void setSaleOrders(Sale_orders saleOrders) {
		this.saleOrders = saleOrders;
	}

	/**
	 * 显示上架单
	 * @return
	 */
	public String select()
	{
		try {
			String marker2=request.getParameter("marker");
			String taskid=request.getParameter("taskid");
			String id = request.getParameter("id");
			
			request.setAttribute("marker", marker2);
			request.setAttribute("taskid", taskid);
			//获得权限标识
			Map map = (Map)ActionContext.getContext().get("map");
			//页码
			String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
			String addhql="";
			//模糊查找
			String sjNo=request.getParameter("sjNo");
			
			Cookies cook = new Cookies();
			String employeeId = cook.getCookie(request, "employeeId");
			System.out.println("employeeId : "+employeeId);
			List<Employee> emplist = executeRecordBussiness.exHqls(" from Employee where id = "+employeeId);
			String marker = request.getParameter("marker")==null?"":request.getParameter("marker");
			String state = request.getParameter("state")==null?"1":request.getParameter("state");
			
			String funid = request.getParameter("funid");		//菜单栏id
			String resouceSet = "";
			if(funid!=null&&!funid.equals(""))
			{
				Map resouceMap = (Map)ActionContext.getContext().get("resouceSet");		//组角色访问资源权限列表
				resouceSet = (String)resouceMap.get("resouce");
			}
			
			//待审核的单据
			if(marker!=null&&!marker.equals(""))
			{
				String condition = audBussiness.getOrderNOList("UpServer", employeeId,sjNo,state);
				if(condition!=null&&!condition.equals(""))
				{
					condition = condition.substring(0,condition.length()-1);
				}
				else
				{
					condition = "''";
				}
				addhql += " and upNo in ("+condition+")" ;
				request.setAttribute("tag", marker);
				request.setAttribute("state", state);
			}
			//组角色访问的资源权限   
			else if (resouceSet!=null&&!resouceSet.equals(""))
			{
				//根据单号筛选单据
				if(sjNo!=null&&sjNo!=""){
					addhql+=" and upNo like '%"+sjNo.trim()+"%'";
				}
				if(resouceSet.indexOf(funid)==-1)
				{
				//	addhql +=" and employee.id = '0'";
				}
			}
			//部门权限
			else  //根据员工id查询单据
			{
				if(sjNo!=null&&sjNo!=""){
					addhql+=" and upNo like '%"+sjNo.trim()+"%'";
				}
				if(employeeId !=null &&!employeeId.equals(""))
				{
					if(emplist.size()>0)
					{
						//职位等级小于3的，表明是主管以下的，就查询当前登录的员工id的数据列表
						if(emplist.get(0).getGroups().getGrade()<3)  
						{
							addhql +=" and soOrders.customer.employee.id = '"+employeeId+"'";
						}
						//职位等小于等于4的并且职位大于等3的，表明是经理级 的和主管级的。主管级的看不到经理级的数据
						else if(emplist.get(0).getGroups().getGrade()>=3&&emplist.get(0).getGroups().getGrade()<=4)
						{
							List<Employee> elist = audBussiness.getObjectList("Employee", " and groups.superGroupId = "+emplist.get(0).getGroups().getSuperGroupId()+" and groups.grade <"+emplist.get(0).getGroups().getGrade());
							String empids = "";
							for(Employee e : elist)
							{
								empids += e.getId()+",";
							}
							if(empids!=null&&!empids.equals(""))
							{
								empids = empids+employeeId;		//将自己的也查出来
							//	addhql +=" and saleOrder.employee.id in("+empids+")";  
								addhql +=" and soOrders.customer.employee.id in("+empids+")";
							}
						}
						//职位等级是5的，表明是总经办的或者管理员的。可以看到所有数据
						else
						{
							//可以不用加员工id，进行查询
						}
					}
				}
				ServletActionContext.getRequest().setAttribute("option", map);
			}
			String hql="from UpServer where delflag=0 and upFlag !=4 "+addhql+" order by id desc,upFlag asc";
			System.out.println("hql is ---"+hql);
			Pages pages=upb.exHqlPages(hql, Integer.parseInt(pageNo), 20, null);

			System.out.println("总结记录数=======>"+pages.getAllCount());
			
			
			if(pages.getAllCount()>0)
			{
				for(int i=0;i<pages.getPageList().size();i++)
				{
					UpServer ups=(UpServer)pages.getPageList().get(i);
					System.out.println(ups.getServerIp()); 
					if(((UpServer)pages.getPageList().get(i)).getServerIp()!=null)
					{
						String ip = ((UpServer)pages.getPageList().get(i)).getServerIp().replace("，", ",");
						ip = ip.replace(",", "<br />");
						((UpServer)pages.getPageList().get(i)).setServerIp(ip);
//						String[] serverIP=((UpServer)pages.getPageList().get(i)).getServerIp().split("，");
//						((UpServer)pages.getPageList().get(i)).setServerIp(serverIP[0]);
					}
				}
				for(int i=0;i<pages.getPageList().size();i++)
				{
					if(((UpServer)pages.getPageList().get(i)).getTemp()!=null||((UpServer)pages.getPageList().get(i)).getTemp().equals("")==false)
					{
						String serverIP=((UpServer)pages.getPageList().get(i)).getTemp();
						if(serverIP.length()>6)
						{
						String SIP=serverIP.substring(0, 6)+"...";
						((UpServer)pages.getPageList().get(i)).setTemp(SIP);
						}
					}
				}
			}
			System.out.println("=======>>>>>"+addhql);
			List liss=new ArrayList();
//			for (Iterator iterator = pages.getPageList().iterator(); iterator.hasNext();) {
//				UpServer upss = (UpServer) iterator.next();
//				if(upss!=null && upss.getTupcabs()!=null && upss.getTupcabs().getTelecthouse()!=null && upss.getTupcabs().getTelecthouse().getElectId()!=null){
//					List<ElectHouse> lit=upb.findByIPs("from ElectHouse e where e.electId="+upss.getTupcabs().getTelecthouse().getElectId());
//					for (ElectHouse electHouse : lit) {
//						upss.setServerLocation(electHouse.getElectName());
//						break;
//					}
//					liss.add(upss);
//				}
//			}
//			pages.setPageList(liss);
			for (Iterator iterator = pages.getPageList().iterator(); iterator.hasNext();) {
				UpServer upss = (UpServer) iterator.next();
				if(upss.getTupcabs() != null && upss.getTupcabs().getTelecthouse() != null){
					Integer ids=upss.getTupcabs().getTelecthouse().getElectId();
					List<ElectHouse> lit=upb.findByIPs("from ElectHouse e where e.electId="+ids);
					for (ElectHouse electHouse : lit) {
						String cods=electHouse.getElectCode().substring(0,2);
						List<ElectHouse> lit2=upb.findByIPs("from ElectHouse e where e.electCode='"+cods+"00'");
						for (ElectHouse electHouse2 : lit2) {
							upss.setServerLocation(electHouse2.getElectName());
							break;
						}
						
						break;
					}
				}
				liss.add(upss);
			}
			Employee e  = (Employee)request.getSession().getAttribute("emp");
			int i=0;
			if(e.getDepartment().getId()==244){   //运维组
				i=1;
			}
			if(e.getDepartment().getId()==365){   //客服部
				i=2;
			}
			request.setAttribute("i", i);
			pages.setPageList(liss);
			request.setAttribute("pages", pages);
			request.setAttribute("mark", 0);
			request.setAttribute("e", e);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	/**
	 * 显示上架单
	 * @return
	 */
	public String detailed()
	{
		String id=request.getParameter("cid");
		String upNo=request.getParameter("upNo");
		//获取info的信息
		String info = request.getParameter("info");
		if(id!=null)
		{
			UpServer ups=(UpServer) upb.someupServer(" and id="+id).get(0);
//			String hr = ups.getHousesAndRooms();
//			System.out.println(ups.getHousesAndRooms());
//			List<ElectHouse> hoRom=modelBussiness.someSales("from ElectHouse e where e.electId="+Integer.parseInt(ups.getHousesAndRooms()));
//			StringBuffer sbf=new StringBuffer();
//			for (ElectHouse elet : hoRom) {
//				String cdd=elet.getElectCode().substring(0,2);
//				System.out.println("cdd="+cdd);
//				List<ElectHouse> mlis=modelBussiness.someSales("from ElectHouse e where e.electCode='"+cdd+"00'");
//			    for (ElectHouse ele : mlis) {
//					sbf.append(ele.getElectName());
//				}
//			    sbf.append("&").append(elet.getElectName());
//			}
		//	ups.setHousesAndRoomsID(sbf.toString());
			request.setAttribute("oneUps", ups);
//			List<Cabinet> cbt=modelBussiness.someModel("from Cabinet");
//		   for (Cabinet cabt : cbt) {
//				if(cabt.getCaid()==ups.getTupcabs().getCaid()){
//					request.setAttribute("allcabnt",ups.getTupcabs().getCaname());
//					break;
//				}
//			}
			
//			List sonList=commbizimpl.someCommodity(" and parentId="+ups.getProduct().getId());
//			request.setAttribute("sonList",sonList);
			if(ups.getAudtitingFlag()==0)
			{
				request.setAttribute("mark", "mark");
			}
		}
		String empid=ck.getCookie(request, "employeeId");
		
		boolean flag1=audBussiness.checkemp1(ups.getUpNo(), empid);
		if(flag1)
		{
			request.setAttribute("quanxian", "quanxian");
		}
		if(null != info && ( info == "info" || info.equals("info")))
		{
			if(ups.getUpNo()!=null)
			{
				String addhql2=" and orderNo='"+ups.getUpNo()+"'";
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
			}

			String empid2=ck.getCookie(request, "employeeId");
			// 判断当前登录是部门审核还是员工审核？
			
			boolean flag =	audBussiness.checkemp(upNo, empid2);//aa
			if(flag)
				request.setAttribute("mark", "mark");
			
			boolean flag2=audBussiness.checkemp1(upNo, empid);
			if(flag2){
				request.setAttribute("quanxian", "quanxian");
			}
			if(upNo!=null){
				String addhql2=" and orderNo='"+upNo+"'";
				List audList=audBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
			}
		}
		
		Employee e  = (Employee)request.getSession().getAttribute("emp");
		int i=0;
		if(e.getDepartment().getId()==244){   //运维组
			i=1;
		}
		if(e.getDepartment().getId()==365){   //客服部
			i=2;
		}
		request.setAttribute("i", i);
		return "detail";
	}
	
	
	/**
	 * 添加上架单显示
	 */
	public String addShow()
	{
		//获得上架单号
		String ckNo="SJ-"+serial.getSerialNumber();
		request.setAttribute("SJNo", ckNo);
		//获得所有机房位置
		String slid=rb.getString("serverroom");
		String strHql="  from Product p where p.delflag=0 and p.property.model.commodityTpye.id="+slid;
		List<Product> upserlolist=productBussiness.getProductList(strHql);
		//product.property.model.commodityTpye.id=slid
		request.setAttribute("serverLocation", upserlolist);
		List<Model> mList=modelBussiness.someModel("from Depot d where d.del=0");
		request.setAttribute("serverLocation1", mList);
		return "add";
	}
	
	/**
	 * 添加上架单时IP验证(添加IP时,表中已经有的，且已上架的IP不能重复)
	 */
	public String checkIP(){
		System.out.println("已经进入方法....");
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
	//	String hql = " and upFlag=1";
	//	upserverlist = upb.someupServer(hql);

		//从页面控件取出来的IP
		String ips = ServletActionContext.getRequest().getParameter("serverIp");
		System.out.println("用户输入的IP地址:"+ips);
		String[] str = ips.split(",");
		//System.out.println("数组:"+str);
		String ss="";
		String addhql="";
		for(int i=0;i<str.length;i++){
			System.out.println("_____"+str[i]);
			ss+="'"+","+"'"+str[i];
		}
		addhql = " and upFlag=1 and serverIp in ('"+ss+"')";
	//	System.out.println("addhql="+addhql);
		upserverlist = upb.someupServer(addhql);
	//	System.out.println("====>"+upserverlist.size());
		if(upserverlist.size()>0){ //表示存在相同IP
			try {
				PrintWriter out = response.getWriter();
				out.print("ERROR");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * 添加上架单
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String add()
	{
		//ups.setDelflag(0);
		//ups.setUpFlag(0);
		//String userverip=ups.getServerIp();
		//String uip=userverip.replace(",","，");
		//ups.setServerIp(uip);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date dt1=sdf.parse(ups.getUptimeString());
			Date dt2=sdf.parse(ups.getDowntimeString());
			ups.setUptime(new Timestamp(dt1.getTime()));
			ups.setDowntime(new Timestamp(dt2.getTime()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SaledFlow safw = new  SaledFlow();
		List<SaleOrder> li=modelBussiness.someSales("from SaleOrder s where s.saleOrderNo='"+ups.getSaleOrder().getSaleOrderNo()+"'");
		for (SaleOrder saleOrder : li) {
		  ups.setSaleOrder(saleOrder);
		  safw.setTsaleorders(saleOrder);
		}
		Cabinet cb = new Cabinet();
		cb.setCaid(Integer.parseInt(ups.getJgh()));
		ups.setTupcabs(cb);
		safw.setDfId(0);
		safw.setDfContent("服务器已上架，感谢你的使用...");
        safw.setDftime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
        salsBussines.saveFlowInfo(safw);
		/**
		 * ytl 新增3个属性
		 */
//		String jhjname = ServletActionContext.getRequest().getParameter("jhjname");
//	    String port = ServletActionContext.getRequest().getParameter("port");
//	    String jgh = "no";
//	    System.out.println("交换机、端口、机柜号:"+jhjname+","+port+","+jgh);
//	    ups.setJhjname(jhjname);
//	    ups.setPort(port);
//	    ups.setJgh(jgh);
		
		UpServer result = upb.addReturnUpServer(ups);
		try
		{
			if(null != result){
				int id = result.getId();
				UpServer uServer=new UpServer();
				uServer.setId(id);
				String arr[] = result.getServerIp().split(",");
				for (String string : arr) {
					List list = this.upb.findByIPs("from IPConfiguration p where p.ipcaddress='"+string+"'");
					for (Iterator iterator = list.iterator(); iterator.hasNext();) {
						IPConfiguration ips = (IPConfiguration) iterator.next();
						ips.setUpNo(uServer);
						ips.setIpcstate(1+"");
						upb.updIPs(ips);
					}
				}
				int marker = audBussiness.addAuditingOrder2("SJ",ups.getUpNo(),"UpServer",ck.getCookie(request, "filialemark"));
				if(marker==0){
					response.getWriter().print("0");
				}else if(marker==2){
					/*阙超强 14015   添加记录动态信息*/
					//添加记录到动态记录表
					Employee loginEmp = this.getEmp();
					if(null == loginEmp){
						request.setAttribute("errorMsg", "由于您长时间未活动，请重新登录！");
						return "no";
					}
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("添加了一个服务器上架单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(result.getId().toString());
					executerecord.setEntityName("UpServer");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
					
					response.getWriter().print("2");
				}else{
					response.getWriter().print("1");
				}
			}
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return "addright";
	}
	
	/**
	 * 修改上架单显示
	 * @return
	 */
	public String updateShow()
	{
		String id=request.getParameter("cid");
		if(id!=null){
			UpServer us=(UpServer) upb.someupServer(" and id="+Integer.parseInt(id)).get(0);
			List<ElectHouse> hoRom=modelBussiness.someSales("from ElectHouse e where e.electId="+Integer.parseInt(us.getHousesAndRooms()));
			StringBuffer sbf=new StringBuffer();
			for (ElectHouse elet : hoRom) {
				String cdd=elet.getElectCode().substring(0,2);
				System.out.println("cdd="+cdd);
				List<ElectHouse> mlis=modelBussiness.someSales("from ElectHouse e where e.electCode='"+cdd+"00'");
			    for (ElectHouse ele : mlis) {
					sbf.append(ele.getElectName());
				}
			    sbf.append("&").append(elet.getElectName());
			}
			us.setHousesAndRoomsID(sbf.toString());
			request.setAttribute("upserver", us);
			//获得所有机房位置
			String slid=rb.getString("serverroom");
			String strHql="  from Product p where p.delflag=0 and p.property.model.commodityTpye.id="+slid;
//			List<Product> upserlolist=productBussiness.getProductList(strHql);
//			request.setAttribute("serverLocation", upserlolist);
			List<Depot> mList=modelBussiness.someModel("from Depot");
			request.setAttribute("serverLocation1", mList);
			List<Product> proList=modelBussiness.someModel("from Product p where p.id="+us.getProduct().getId());
			for (Product product : proList) {
				request.setAttribute("fproid", product.getId());
				request.setAttribute("fpname", product.getProperty().getName());
				request.setAttribute("fpbarCode", product.getBarcode());
			}
			List<Cabinet> cbt=modelBussiness.someModel("from Cabinet");
			request.setAttribute("allcabnt",cbt);
			
		}
		return "add";
	}
	
	
	/**
	 * 修改上架单显示2
	 * @return
	 */
	public String updShow(){
		int upid = Integer.parseInt(request.getParameter("cid"));
		UpServer upserver = (UpServer)upb.getObjectById(UpServer.class, upid);
		request.setAttribute("upserver", upserver);
		request.setAttribute("flag", 1);
		return "add2";
	}
	
    /**
     * 修改上架单
     * @return
     */
	public String edit()
	{
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
//		try {
//			Date dt1=sdf.parse(ups.getUptimeString());
//			Date dt2=sdf.parse(ups.getDowntimeString());
//			ups.setUptime(new Timestamp(dt1.getTime()));
//			ups.setDowntime(new Timestamp(dt2.getTime()));
//		} catch (ParseException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		System.out.println(ups.getSoOrders().getSoId());
//		List<Sale_orders> li=modelBussiness.someSales("from Sale_orders s where s.soNums='"+ups.getSoOrders().getSoId()+"'");
//		for (Sale_orders saleOrder : li) {
//		  ups.setSoOrders(saleOrder);
//		}
		
		
//		Cabinet cb = new Cabinet();
//		cb.setCaid(Integer.parseInt(ups.getJgh()));
//		ups.setTupcabs(cb);
//		String saleId=request.getParameter("saleId");
//		if(saleId!=null){
//			SaleOrder saleOrd=(SaleOrder) this.executeRecordBussiness.exHqls("from SaleOrder where id="+Integer.parseInt(saleId)).get(0);
//			ups.setSaleOrder(saleOrd);
//		}
		
		//先去查找服务器是否更换 如果更换了要将这台服务器下架再将选择的服务器上架(改变2台服务器状态) modify by lzy 2012-7-12
//		UpServer us=(UpServer) upb.someupServer(" and id="+ups.getId()).get(0);
//		if(!us.getProduct().getId().equals(ups.getProduct().getId())){//不等-进行处理
//			String hql1=" update Product set usestate=2 , parentId=0  where id="+us.getProduct().getId();
//			String hql2=" update Product set usestate=1 , parentId=0  where id="+ups.getProduct().getId();
//			upb.executeHql(hql1);
//			upb.executeHql(hql2);
//		}
		Sale_orders so = (Sale_orders)upb.getObjectById(Sale_orders.class, ups.getSoOrders().getSoId());
		System.out.println(ups.getId());
		UpServer oldus = (UpServer)upb.getObjectById(UpServer.class, ups.getId());
		oldus.setSoOrders(so);
		oldus.setMaintenancePass(ups.getMaintenancePass());
		oldus.setBandwidthAmount(ups.getBandwidthAmount());
		oldus.setBandwidthThrottling(ups.getBandwidthThrottling());
		oldus.setTemp(ups.getTemp());
		boolean flag = upb.updObject(oldus);
//		boolean flag=upb.editupServer(ups);
		try
		{
			if(flag){
				/*阙超强 14015   添加记录动态信息*/
				//添加记录到动态记录表
				Employee loginEmp = this.getEmp();
				if(null == loginEmp){
					request.setAttribute("errorMsg", "由于您长时间未活动，请重新登录！");
					return "no";
				}
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("修改了一个服务器上架单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(ups.getId().toString());
				executerecord.setEntityName("UpServer");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
				
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
		return "addright";
	}
	
	/**
	 * 删除上架单
	 * @return
	 */
	public String del()
	{
		String a = request.getParameter("ids");
		boolean flag=upb.delupServer(ids);
		try
		{
			if(flag){
				/*阙超强 14015   添加记录动态信息*/
				//添加记录到动态记录表
				Employee loginEmp = this.getEmp();
				if(null == loginEmp){
					request.setAttribute("errorMsg", "由于您长时间未活动，请重新登录！");
					return "no";
				}
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("删除了一些服务器上架单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(StringUtil.arrayToString(ids));
				executerecord.setEntityName("UpServer");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
				
				response.getWriter().print("0");
			}
			else
			{
				response.getWriter().print("1");
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return "addright";
	}
	
	/**
	 * 执行上架
	 * @return
	 */
	public String auditing()
	{
		boolean flag=false;
		String proId=request.getParameter("proId");
		String upId=request.getParameter("upId");
		try
		{
			if(proId!=null&&upId!=null){
				flag=upb.executeUpserver(proId, upId);
			}
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
	
	public String upServerWarn()
	{	
		return null;
	}
	
	/**
	 * 获得当前登录员工信息
	 * @return
	 * @time 2012-01-10 14:14:10
	 */
	public Employee getEmp(){
		Object object = request.getSession().getAttribute("emp");
		Employee loginEmp = null; 
		if(null != object){
			loginEmp = (Employee) object;
		}
		return loginEmp;
	}
	/**
	 * 模糊查询
	 * @throws UnsupportedEncodingException 
	 * @throws IOException 
	 */
	public void selectObscure() throws IOException 
	{
		String employeeByEmpName1=request.getParameter("employeeByEmpName");
		String employeeByEmpName="";
		if(employeeByEmpName1!=null)
		{
			employeeByEmpName=URLDecoder.decode(employeeByEmpName1,"UTF-8");
		}
		String upServerType1=request.getParameter("upServerType");
		String upServerType="";
		if(upServerType1!=null)
		{
			upServerType=URLDecoder.decode(upServerType1,"UTF-8");
		}
		String cusName1=request.getParameter("cusName");
		String cusName="";
		if(cusName1!=null)
		{
			cusName=URLDecoder.decode(cusName1,"UTF-8");
		}
		String time=request.getParameter("time");
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if(null != strPageNo && !"".equals(strPageNo)){
			pageNo = Integer.parseInt(strPageNo);
		}
		String hql="from UpServer where 1=1";
		if(employeeByEmpName.equals("")==false&&employeeByEmpName!=null)//业务员
		{
			hql+=" and saleOrder.employee.name like '%"+employeeByEmpName+"%'";
		}
		if(upServerType.equals("")==false&&upServerType!=null)//上架状态
		{
			if(upServerType.equals("未上架"))
			{
				hql+=" and upFlag=0";
			}
			else
			{
				hql+=" and upFlag in (1,2)";
			}
		}
		if(cusName!=null&&(cusName.equals("")==false))//客户
		{
			hql+=" and customer.realName like '%"+cusName+"%'";
		}
		if(ups.getServerLocation()!=null&&ups.getServerLocation().equals("")==false)//机房地址
		{
			String location = URLDecoder.decode(ups.getServerLocation(),"UTF-8");
			hql+=" and serverLocation like '%"+location+"%'";
		}
		if(ups.getServerIp()!=null&&ups.getServerIp().equals("")==false)//Ip
		{
			hql+=" and serverIp like '%"+ups.getServerIp()+"%'";
		}
		if(ups.getBandwidthAmount()!=null&&ups.getBandwidthAmount()!=0)//宽带数量
		{
//			hql+=" and bandwidthAmount like '%"+ups.getBandwidthAmount()+"%'";
			hql+=" and bandwidthAmount = '"+ups.getBandwidthAmount()+"'";
		}
		if(time!=null&&!time.equals(""))
		{
			hql+=" and downtime like '%"+time+"%'";
		}
		
		hql+=" order by id desc";

		Pages pages = upb.exHqlPages(hql, pageNo, 50, null);
		if(pages.getAllCount()>0)
		{
			for(int i=0;i<pages.getPageList().size();i++)
			{
				if(((UpServer)pages.getPageList().get(i)).getServerIp()!=null||((UpServer)pages.getPageList().get(i)).getServerIp().equals("")==false)
				{
					String ip = ((UpServer)pages.getPageList().get(i)).getServerIp().replace("，", ",");
					ip = ip.replace(",", "<br />");
					((UpServer)pages.getPageList().get(i)).setServerIp(ip);
//					String[] serverIP=((UpServer)pages.getPageList().get(i)).getServerIp().split("，");
//					((UpServer)pages.getPageList().get(i)).setServerIp(serverIP[0]);
				}
			}
			for(int i=0;i<pages.getPageList().size();i++)
			{
				if(((UpServer)pages.getPageList().get(i)).getTemp()!=null||((UpServer)pages.getPageList().get(i)).getTemp().equals("")==false)
				{
					String serverIP=((UpServer)pages.getPageList().get(i)).getTemp();
					if(serverIP.length()>6)
					{
					String SIP=serverIP.substring(0, 6)+"...";
					((UpServer)pages.getPageList().get(i)).setTemp(SIP);
					}
				}
			}
		}
		
		
		PropertyEditor property = new PropertyEditor();
		
		String strr="";
		String str="";
		if(pages!=null && pages.getPageList().size()>0)
		{
			for(int i=0; i<pages.getPageList().size(); i++)
			{
				UpServer upserver=(UpServer) pages.getPageList().get(i);
				str=property.getID("upServer").toString();
				String ip = "";
				if(upserver.getServerIp()!=null && !"".equals(upserver.getServerIp())){
					ip = upserver.getServerIp().replace("，", ",");
					ip = ip.replace(",", "<br />");
					//System.out.println("-------------"+ip);
				}
				str=str.replace("#cusName#", upserver.getCustomer().getRealName()+"");
				str=str.replace("#serverLocation#", upserver.getServerLocation()+"");
				str=str.replace("#serverIp#", ip+"");
				str=str.replace("#bandwidthAmount#", upserver.getBandwidthAmount()+"");
				String typeName="";
				if(upserver.getUpFlag()==0||upserver.getUpFlag()==null)
				{
					typeName="未上架";
				}else
				{
					typeName="已上架";
				}
				str=str.replace("#upServerType#", typeName+"");
				if(upserver.getDowntime()!=null)
				{
					String time1=upserver.getDowntime().toString();
					String t=time1.substring(0, 10);
					str=str.replace("#downtime#", t+"");
				}
				else
				{
					str=str.replace("#downtime#", upserver.getDowntime()+"");
				}
				str=str.replace("#employeeByEmpName#", upserver.getEmployee().getName()+"");
				str=str.replace("#upServerInfo#", "<a href='detailedUpserver.do?cid="+upserver.getId()+"&upNo="+upserver.getUpNo()+"&info=info'>详细情况</a>");
				str=str.replace("#followAuditing#", "<a href='followAuditing.do?orderNo="+upserver.getUpNo()+"'>流程跟踪</a>");
				
				str=str.replace("#temp#", upserver.getTemp()+"");
				str=str.replace("#update#","<a href='updateShowUpserver.do?cid="+upserver.getId()+"'><IMG style='CURSOR: hand' onclick=''hspace=2 src='"+request.getContextPath()+"/images/res.gif' align=absMiddle border=0></a>");
				str=str.replace("#del#", "	<INPUT style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'type=checkbox value="+upserver.getId()+" name=ids>");
				if(upserver.getAudtitingFlag()==1&&upserver.getUpFlag()==0)
				{
					str=str.replace("#up#","<INPUT class=button type='button' value='上架' onclick='executeServer('auditingUpserver.do',"+upserver.getId()+","+upserver.getProduct().getId()+")' >");
				}
				if(upserver.getAudtitingFlag()==0)
				{
					str=str.replace("#up#", "审核未完成");
				}
				if(upserver.getUpFlag()!=0)
				{
					str=str.replace("#up#", "该单据产品已上架完成");
				}
				strr+=str;
			}
			pages.setUrl("selectObscure1Upserver.do");
			strr+="#"+pages.getHtml();
		}
		HttpSession session=request.getSession();
		response.setCharacterEncoding("utf-8");
		response.getWriter().print(strr);
		session.setAttribute("upserverhql", hql);
		
	}
	public String selectObscure1()
	{
		
		String strPageNo = request.getParameter("pageNo");
		int pageNo = 1;
		if(null != strPageNo && !"".equals(strPageNo)){
			pageNo = Integer.parseInt(strPageNo);
		}
		
		HttpSession session=request.getSession();
		String hql=(String) session.getAttribute("upserverhql");
		Pages pages = upb.exHqlPages(hql, pageNo, 50, null);
		request.setAttribute("pages", pages);
		request.setAttribute("mark", 1);
		return "success";
	}
	/**
	 * 
	 */
	public void getServerInfo(){
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		String upNo = request.getParameter("upNo");
		StringBuffer sb = new StringBuffer();
		try {
			if(upNo == null || upNo.equals("")){
				response.getWriter().print(1);
				return ;
			}
			String hql = " and upNo ='"+upNo+"'";
			List list = upb.someupServer(hql);
			if(list !=null && list.size() >0){
				UpServer up = (UpServer)list.get(0);
//				cusname|cuscomp|serverName|serverId|upNo|cus|phone|cardid|cusempname|liip|serverLocation|
				sb.append(charUtil(up.getCustomer().getCustomerId())+"#");
				sb.append(charUtil(up.getCustomer().getCustomerCompany())+"#");
				sb.append(charUtil(up.getProduct().getProperty().getName())+"#");
				sb.append(charUtil(up.getProduct().getId())+"#");
				sb.append(charUtil(up.getUpNo())+"#");
				sb.append(charUtil(up.getCustomer().getRealName())+"#");
				sb.append(charUtil(up.getCustomer().getPhone())+"#");
				sb.append(charUtil(up.getCustomer().getCardid())+"#");
				sb.append(charUtil(up.getEmployee().getName())+"#");
				String ips = up.getServerIp();
				
				if( ips != null || !ips.equals("")){
					ips = ips.replace("，", ",");
					String[] ipli=ips.split(",");
					String ipss="";
					System.out.println(ipli.length);
					for(int i=0;i<ipli.length;i++)
					{
						ipss+="<input type='checkbox' id='serverIp' name='serverIp' checked='checked' value="+ipli[0]+" />"+ipli[0]+"&nbsp;&nbsp;";
					}
					sb.append(ipss+"#");
				}else{
					sb.append(" #");
				}
				sb.append(charUtil(up.getServerLocation()));
				response.getWriter().print(sb.toString());
			}else{
				response.getWriter().print(2);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return ; 
	}
	private Object charUtil(Object str){
		
		if(str == null){
			str = " ";
		}
		return str;
		
	}
	public static void main(String[] args) {
//		String str = "  #123 4# # ";
//		String[] s = str.split("#");
//		for (int i = 0; i < s.length; i++) {
//			System.out.println(i+"--"+s[i]);
//		}	
		
	}
	
	
	/**
	 * 添加上架单显示
	 */
	public String addShow2()
	{
		try {
			//获得上架单号
			String ckNo="SJ-"+serial.getSerialNumber();
			request.setAttribute("SJNo", ckNo);
			//获得所有机房
			List electHouselist = upb.getElectHouse();
			System.out.println(electHouselist.size());
			
			List depotlist = upb.getAll("from Depot");
			//获得所有机房位置
			String ckid = request.getParameter("ckid");
			List<Product> productlist = null;
			if(!"".equals(ckid) && ckid!=null){
				productlist = upb.getServersByDepotid(Integer.parseInt(ckid));
			}
			String slid=rb.getString("serverroom");
			String strHql="  from Product p where p.delflag=0 and p.property.model.commodityTpye.id="+slid;
		//	List<Product> upserlolist=productBussiness.getProductList(strHql);
			//product.property.model.commodityTpye.id=slid
		//	request.setAttribute("serverLocation", upserlolist);
			List<Model> mList=modelBussiness.someModel("from Depot d where d.del=1");
			request.setAttribute("serverLocation1", mList);
			request.setAttribute("electHouselist", electHouselist);
			request.setAttribute("depotlist", depotlist);
			request.setAttribute("productlist", productlist);
			request.setAttribute("flag", 0);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "add2";
	}
	
	//根据仓库得到该仓库下的服务器
	public String getServerByWarehouse() throws Exception{
		response.setCharacterEncoding("utf-8");
		int houseid = Integer.parseInt(request.getParameter("houseid"));
		System.out.println(houseid);
		List<Product> list = upb.getServersByDepotid(houseid);
		PrintWriter out = response.getWriter();
		String str = "";
		if(list.size()>0){
			for(int i=0;i<list.size();i++){
				product = list.get(i);
				str+="<tr><td><input type='checkbox' onclick='onclikserver(this)' id='"+product.getProperty().getId()+"' value='"+product.getProperty().getName()+"'/>"+product.getProperty().getName()+"</td></tr>";
			}
			request.setAttribute("serverlist", list);
			out.print(str);
			str = "";
		}else {
			out.print("ERROR");
		}
		return null;
	}
	
	public String getCabinet() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		//得到机房id
		int cabinetid = Integer.parseInt(request.getParameter("cabinetid"));
		List<Cabinet> list = upb.getCabinetByElecthouse(cabinetid);
		System.out.println("集合大小:"+list.size());
		String str = "";
		if(list.size()>0){
		for(int i=0;i<list.size();i++){
			cabinet = list.get(i);
			str+="<tr><td><input type='checkbox' id='"+cabinet.getCaid()+"' onclick='checkCabinet(this)' value='"+cabinet.getCaname()+"'/>"+cabinet.getCaname()+"</td></tr>";
		  }
		  System.out.println(str);
		  out.print(str);
		}
        if(list.size()<=0){
			out.print(str);
		}
		return null;
	}
	
	//根据机柜查询该机柜的柜号
	public String getGhByCabinet() throws Exception{
		    response.setCharacterEncoding("utf-8");
		    PrintWriter out = response.getWriter();
			//机柜id
			int cabid = Integer.parseInt(request.getParameter("cabid"));
			//销售订单号
			String saleorderNo = request.getParameter("saleorderNo");
			String ps = cabid+","+saleorderNo;
			
			String strin = "";
			int sizes=0;
			String []arrs = ps.split(",");
			int caid = Integer.parseInt(arrs[0]);
			String serids = arrs[1];
			int a=0,b=0,p=0;
			int flag=0;
			List<SaleOrder> lists=this.serAjax.getRoomCode("from SaleOrder s where s.saleOrderNo='"+serids+"'");
			for (SaleOrder sa : lists) {
				sizes = Integer.parseInt(sa.getSpaceSize());
			}
			List<UpServer> list=this.serAjax.getRoomCode("from UpServer u where u.Tupcabs.caid="+caid);
			if(list.size()!=0){
			for (UpServer upServer : list) {//upServer.getTupcabs().getCasz()
				for(int mp=0;mp<100;mp++){
				String []mark = upServer.getMarknum().split(",");
			    for(int i=0;i<100;i++){
				    a=getIntNum(upServer.getTupcabs().getCasz());
				    b=(a+sizes-1);
			    	if(b<upServer.getTupcabs().getCasz()){
			    		logs.info("a="+a);
			    		logs.info("b="+b);
			    		break;
			    	}else{
			    		continue;
			    	}
			    }
			    for (Iterator iterator = list.iterator(); iterator.hasNext();) {
					UpServer ups = (UpServer) iterator.next();
					String []marknums = ups.getMarknum().split(",");
					int nu1=Integer.parseInt(marknums[0]);
					int nu2=Integer.parseInt(marknums[1]);
					if(a<=nu1 && b>=nu1 && b<=nu2){
						flag=0;
						break;
					}else if(a>=nu1 && nu1<=b && b<=nu2){
						flag=0;
						break;
					}else if(a<=nu1 && nu2<=b){
						flag=0;
						break;
			        }else if(a>=nu1 && a<=nu2 && nu2<=b){
			        	flag=0;
						break;
			        }else{
						flag=1;
					}
					}
			       if(flag==1){
					   break;
			       } 
				}
				   if(flag==1){
					   break;
			       } 
				}
			  if(flag==0){
				  strin="未找到合适的柜号建议:更改机柜或房间"+","+"no";
			  }else{
					logs.info("a="+a);
					logs.info("b="+b);
					strin=a+","+b; 
			  }
			}else{
				List<Cabinet> list1=this.serAjax.getRoomCode("from Cabinet c where c.caid="+caid);
				for (Cabinet cabinet : list1) {  
						for(int j=0;j<100;j++){
							a=getIntNum(cabinet.getCasz());
							b=(a+sizes-1);
							if(b<cabinet.getCasz()){
								break;
							}else{
								continue;
							}
				}
				}
				strin=a+","+b; 
			}
			System.out.println(strin);
		out.print(strin);
		return null;
	}
	
	//验证授权码
	public String checkAuthorization(){
		try {
			response.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			String sqm = request.getParameter("sqm");
			System.out.println(sqm);
			List list = upb.getCustomers();
			String flag = "";
			Object object = null;
			if(list.size()>0){
			   for(int i=0;i<list.size();i++){
				   object = list.get(i);
				   customer = (Customer)object;
				   if(sqm.equals(customer.getAuthorization())){
					   flag="1";
				   }
			   }
			   
			}
			out.print(flag);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	/**
	 * 添加上架单
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String add2()
	{
		//ups.setDelflag(0);
		//ups.setUpFlag(0);
		//String userverip=ups.getServerIp();
		//String uip=userverip.replace(",","，");
		//ups.setServerIp(uip);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date dt1=sdf.parse(ups.getUptimeString());
			Date dt2=sdf.parse(ups.getDowntimeString());
			ups.setUptime(new Timestamp(dt1.getTime()));
			ups.setDowntime(new Timestamp(dt2.getTime()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SaledFlow safw = new  SaledFlow();
		List<SaleOrder> li=modelBussiness.someSales("from SaleOrder s where s.saleOrderNo='"+ups.getSaleOrder().getSaleOrderNo()+"'");
		for (SaleOrder saleOrder : li) {
		  ups.setSaleOrder(saleOrder);
		  safw.setTsaleorders(saleOrder);
		}
		Cabinet cb = new Cabinet();
		cb.setCaid(Integer.parseInt(ups.getJgh()));
		ups.setTupcabs(cb);
		safw.setDfId(0);
		safw.setDfContent("服务器已上架，感谢你的使用...");
        safw.setDftime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
        salsBussines.saveFlowInfo(safw);
		
        
        
        
		UpServer result = upb.addReturnUpServer(ups);
		try
		{
			if(null != result){
				int id = result.getId();
				UpServer uServer=new UpServer();
				uServer.setId(id);
				String arr[] = result.getServerIp().split(",");
				for (String string : arr) {
					List list = this.upb.findByIPs("from IPConfiguration p where p.ipcaddress='"+string+"'");
					for (Iterator iterator = list.iterator(); iterator.hasNext();) {
						IPConfiguration ips = (IPConfiguration) iterator.next();
						ips.setUpNo(uServer);
						ips.setIpcstate(1+"");
						upb.updIPs(ips);
					}
				}
				int marker = audBussiness.addAuditingOrder2("SJ",ups.getUpNo(),"UpServer",ck.getCookie(request, "filialemark"));
				if(marker==0){
					response.getWriter().print("0");
				}else if(marker==2){
					/*阙超强 14015   添加记录动态信息*/
					//添加记录到动态记录表
					Employee loginEmp = this.getEmp();
					if(null == loginEmp){
						request.setAttribute("errorMsg", "由于您长时间未活动，请重新登录！");
						return "no";
					}
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("添加了一个服务器上架单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(result.getId().toString());
					executerecord.setEntityName("UpServer");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
					
					response.getWriter().print("2");
				}else{
					response.getWriter().print("1");
				}
			}
			else
				response.getWriter().print("1");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return "addright";
	}
	
	
	/**
	 * 新增上架单2
	 * @return
	 * @throws Exception
	 */
	public String addup() throws Exception{
		try {
			//同时要添加多条数据,所以要先添加基础数据,再把组合数据分解之后,进行修改操作.
			String depotid = request.getParameter("depotid"); // 获取仓库id
			
				UpServer upserver = new UpServer();  //上架单对象
				
				Product p = new Product();
			//	upserver.setProduct(pro);
				upserver.setUpNo(ups.getUpNo());
				//根据销售订单号查询其对象
				int saleorderId = ups.getSoOrders().getSoId();
				Sale_orders sg = (Sale_orders)upb.getObjectById(Sale_orders.class, saleorderId);
				upserver.setSoOrders(sg);
				sg.setSoStat(11);
				upb.updateObj(sg);
				int customerid = ups.getSoOrders().getCustomer().getCustomerId();
				Customer customer = (Customer)upb.getCustomerByPK(Customer.class, customerid);
				upserver.setCustomer(customer);  //设置客户信息
				upserver.setServerLocation(depotid); //设置仓库
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			//	Date dt1 = sdf.parse(ups.getDowntimeString()); //下架时间
			//	Date dt2 = sdf.parse(ups.getUptimeString()); //上架时间
			//	upserver.setUptime(new Timestamp(dt1.getTime())); // 上架时间
			//	upserver.setDowntime(new Timestamp(dt2.getTime())); //下架时间
				upserver.setIpnum(ups.getIpnum()); //ip数量
				upserver.setMaintenancePass(ups.getMaintenancePass()); //维护口令
			//	upserver.setServerIp(ups.getServerIp());
				upserver.setBandwidthAmount(ups.getBandwidthAmount()); //带宽数量
				upserver.setBandwidthThrottling(ups.getBandwidthThrottling()); //带宽限制
				upserver.setDelflag(0); //删除标识
				upserver.setUpFlag(0); //上架标识 4待上架、1上架、2下架
				upserver.setAudtitingFlag(0); //审核状态
				Employee employee = (Employee)request.getSession().getAttribute("emp");
		//		upserver.setEmployee(employee); // 设置上架人员
				upserver.setTemp(ups.getTemp()); // 备注
		//		upserver.setRemarks(0);
				upb.addUpserver(upserver);
				
				//客服中心
//				ConkOut con = new ConkOut();
//				Conkoutask coa = new Conkoutask();
//				String conkOutNo = "KF-"+serial.getSerialNumber();
//				con.setConkOutNo(conkOutNo);  //故障单号
////				Customer customer2 = (Customer)upb.getObjectById(Customer.class, upserver.getSoOrders().getCustomer().getCustomerId());
//				con.setCustomer(customer);
//				
//				con.setState("0");  // 0:客户提交初始状态  1:客服接收 2:提交到运维 3:运维处理完成 4:客户确认,已处理
//				con.setDescs("上架单故障处理");
//				con.setDelflag("0");
//	//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//				Date d = new Date();
//				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//				con.setFaultTime(new java.sql.Timestamp(new java.util.Date().getTime()));
//				Questioncategory q = (Questioncategory)upb.getObjectById(Questioncategory.class,7);
//				Product prop = (Product)upb.getObjectById(Product.class, 6);
//				con.setIssueType(q);
//				con.setIp("no");
//				con.setCustomerphone(upserver.getSoOrders().getCustomer().getPhone());  //电话号码
//				con.setEmail(upserver.getSoOrders().getCustomer().getEmail());  //邮箱
//				con.setProduct(prop);
//		//		con.setWdnr("暂无");
//		//		con.setEmail("暂无");
//				con.setUpserverid(upserver.getId());
//		//		con.setState("100");
//				con.setStatus(0);
//				con.setBzf(0);
//				upb.addUpserver(con);
//				System.out.println(con.getId());
//				upserver.setConkout(con);
//				System.out.println(upserver.getId());
//				upb.updateObj(upserver);
//				
//				Date dt = new Date();
//				SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
//				coa.setDescs(con.getDescs());
//				coa.setFaultTime(sd.format(dt));
//				coa.setState(0);
//				coa.setConkout(con);
//				upb.addUpserver(coa);
//				
//				//工单生成后,需要更改该上架单对应订单的状态:客服待接收
//				Sale_orders so = upserver.getSoOrders();
//				so.setSoStat(5);  //状态为5,客服待接收
//				upb.updateObj(so);		
				
				//审核表
				UpServer result = upb.addReturnUpServer(upserver);
				int marker = audBussiness.addAuditingOrder2("SJ",upserver.getUpNo(),"UpServer",ck.getCookie(request, "filialemark"));
				if(marker==0){
					response.getWriter().print("0");
				}else if(marker==2){
					/*阙超强 14015   添加记录动态信息*/
					//添加记录到动态记录表
					Employee loginEmp = this.getEmp();
					if(null == loginEmp){
						request.setAttribute("errorMsg", "由于您长时间未活动，请重新登录！");
						return "no";
					}
					Executerecord executerecord = new Executerecord();
					executerecord.setEmployee(loginEmp);
					executerecord.setContent("添加了一个服务器上架单。");
					executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
					executerecord.setEntityId(result.getId().toString());
					executerecord.setEntityName("UpServer");
					executerecord.setSeenEmpId("");
					executeRecordBussiness.addData(executerecord);
					
					response.getWriter().print("2");
				}else{
					response.getWriter().print("1");
				}
			
				/////////////完成添加上架单,再生成运维单/////////////////
		    //  根据销售订单号查询其对象
				//获得上架单号
			//	request.setAttribute("ywNo", ywNo);
				ser = request.getParameter("upser");
				String[] str = ser.split("-");
				String box = "";
				int id = 0;
				for(int j=0;j<str.length;j++){
					Operate operate = new Operate();  //运维单对象
					String ywNo="YW-"+serial.getSerialNumber();
					String[] string = str[j].split(",");
					System.out.println(string[0]);
					box = string[0];
					id = Integer.parseInt(box.substring(3, box.length()));
					Product pro = (Product)upb.getObjectById(Product.class, id);
					operate.setProduct(pro);
//					pro.setIsfreeze(0);
//					upb.updateObj(pro);
					operate.setOperateNo(ywNo);
					int sid = ups.getSoOrders().getSoId(); //从页面隐藏域里得到选中的销售订单id
					Sale_orders sgd = (Sale_orders)upb.getObjectById(Sale_orders.class, sid);
					operate.setSaleOrders(sgd);  //设置上架单
					String upNo = ups.getUpNo(); //得到上架单号,根据该单号查询对象
					List<UpServer> uplist = upb.getUpserverByUpNo(upNo);
					if(uplist.size()>0){
					   Object obj = uplist.get(0);
					   UpServer ups = (UpServer)obj;  
					   operate.setUpserver(ups);  //设置上架单
					}
					Object object = upb.getObjectById(Depot.class,Integer.parseInt(depotid));
					Depot depot = (Depot)object;
					operate.setDepot(depot);  //设置仓库
					Employee emp = (Employee)request.getSession().getAttribute("emp");
					operate.setEmployee(emp);  //设置上架人员
					upb.addUpserver(operate);
					
					List lst = upb.getAll("from Freeze where product.id="+pro.getId());
					if(lst.size()>0){
						Freeze freeze = (Freeze)lst.get(0);
						freeze.setFreezeFlag(0);
					}
					pro.setIsfreeze(0);
					upb.updateObj(pro);
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "operate";
	}
	
	/**
	 * 根据上架单id得到运维单
	 * @return
	 */
	public String getOperateOfUps(){
		int upid = Integer.parseInt(request.getParameter("upid"));
		List list = upb.getAll("from Operate where upserver.id="+upid);
		request.setAttribute("oplist", list);
		return "oplist";
	}
	
	/**
	 * 上架单列表
	 * @return
	 */
	public String uplist(){
		String hql = "from UpServer where delflag=0";
		List<UpServer> list = upb.getAll(hql);
		request.setAttribute("list", list);
		return "uplist";
	}
	
	
	/**
	 * 客服人员处理完毕,转交给运维组(修改状态)
	 * @return
	 */
	public String toOperate(){
		try {
			response.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			String pk = request.getParameter("pk");
			String problemtype = request.getParameter("problemtype");
			String probleminfo = request.getParameter("probleminfo");
			String type = URLDecoder.decode(problemtype,"utf-8");
			String info = URLDecoder.decode(probleminfo,"utf-8");
			System.out.println(type);
			System.out.println(info);
			Object object = upb.getObjectById(Workorder.class, Integer.parseInt(pk));
			Workorder wo = (Workorder)object;
			wo.setStatus(2);
			wo.setTemp("运维组接收");
			upb.updateObj(wo);
//			if(wo.getStatus()==2){
//				out.print("转交成功,运维人员已经可以查看该工单!");
//			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public String getOperates(){
		int opid = Integer.parseInt(request.getParameter("opid"));
		Object object = upb.getObjectById(Operate.class, opid);
		List list = upb.getAll("from ElectHouse where 1 = 1");
		Operate operate = (Operate)object;
		request.setAttribute("operate", operate);
		request.setAttribute("houselist", list);
		return "addoperate";
	}
	
	//获取所有机房和房间
	public String getAllHouses() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String hos="";
		List<ElectHouse> list=this.serAjax.findEle();
		for (ElectHouse et: list) {
			String mttString=et.getElectCode().substring(0,2);
			List<ElectHouse> list2 =this.serAjax.IPManage("from ElectHouse e where substring(e.electCode,3,2)<>'00' and  substring(e.electCode,1,2)='"+mttString+"'");
			for (ElectHouse electHouse : list2) {
			//	hos="<option value='"+electHouse.getElectId()+"'>"+et.getElectName()+"&"+electHouse.getElectName()+"</option>"+hos;
				hos+="<tr><td><input type='checkbox' name='chk' id='"+electHouse.getElectId()+"' onclick='checkdata(this)'/>"+et.getElectName()+"/"+electHouse.getElectName()+"</td></tr>";
			}
			
		}
		out.print(hos);
		return null;
	}
	
	//用户选择机房/房间之后,显示出属于这个机房/房间的机柜
	public String showCabinet() throws Exception{
			response.setCharacterEncoding("utf-8");
			PrintWriter out = response.getWriter();
			String electid = request.getParameter("electid");
			System.out.println(electid);
			String[] eid = electid.split(",");
			String str = "";
			for(int i=0;i<eid.length;i++){
				int id = Integer.parseInt(eid[i]);
				List list = upb.getAll("from Cabinet where Telecthouse.electId="+id);
				  for(int j=0;j<list.size();j++){
					Cabinet ca = (Cabinet)list.get(j);
				    str+="<tr><td><input type='checkbox' id='"+ca.getCaid()+"' onclick='checkcab(this)'/>"+ca.getCaname()+"</td></tr>";
				  }
				}
			   System.out.println(str);
			   out.print(str);
		       return null;
			}
	
	//点击页面上的按钮,列出机房/房间
	public String showElectHouseRoom(){
	  //UpServer us=(UpServer) upb.someupServer(" and id=");
		List<ElectHouse> hoRom=upb.getAll("from ElectHouse where 1 = 1");
		StringBuffer sbf=new StringBuffer();
		for (ElectHouse elet : hoRom) {
			String cdd=elet.getElectCode().substring(0,2);
			System.out.println("cdd="+cdd);
			List<ElectHouse> mlis=modelBussiness.someSales("from ElectHouse e where e.electCode='"+cdd+"00'");
		    for (ElectHouse ele : mlis) {
				sbf.append(ele.getElectName());
			}
		    sbf.append("&").append(elet.getElectName());
		}
	///	us.setHousesAndRoomsID(sbf.toString());
	//	request.setAttribute("upserver", us);
		return null;
	}
	
	public String getWorkorderOfUps(){
		int upid = Integer.parseInt(request.getParameter("upid"));
		String hql = "from Workorder where upserver.id="+upid;
		List list = upb.getAll(hql);
		Workorder wo = null;
		if(list.size()>0){
			wo = (Workorder)list.get(0);
		}
		
		int status = 0;
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		if(emp.getDepartment().getId()==244){
			status = 244;
		}
		if(emp.getDepartment().getId()==365){
			status = 365;
		}
		request.setAttribute("status", status);
		request.setAttribute("wo", wo);
		return "wodetail";
	}
	
	/**
	 * 工单列表
	 * @return
	 */
	public String workorderlist(){
		String pageNo = request.getParameter("pageNo");
		if(null == pageNo){
			pageNo="1";
		}
		String hql = "from Workorder where 1 = 1";
		String state = request.getParameter("state");
		if(state!=null && !state.equals("")){
			int sta = Integer.parseInt(state);
			if(sta==1){
				hql += " and status=1";
			}
			if(sta==2){
				hql += " and status=2";
			}
		}
		Pages pages = upb.exHqlPages(hql, Integer.parseInt(pageNo), 20, null);
		List list = upb.getAll(hql);
		request.setAttribute("pages", pages);
		request.setAttribute("list", list);
		return "workorderlist";
	}
	
	//运维单详细页面,点击提交,修改运维单信息(把字段补全)  =======>>>这里是完善运维单,再上架完成之后(最后)完善其数据
	public String updateYw(){
		System.out.println(operate.getUptime());
		System.out.println(operate.getDowntime());
		System.out.println(operate.getIpAddress());
		System.out.println(operate.getHousesAndRooms());
		System.out.println(operate.getJgh());
		System.out.println(operate.getMarkNum());
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		int operateid = operate.getId();
		Operate oldoperate = (Operate)upb.getObjectById(Operate.class, operateid);
		oldoperate.setMarkNum(operate.getMarkNum());
		oldoperate.setHousesAndRooms(operate.getHousesAndRooms());
		oldoperate.setJgh(operate.getJgh());
		oldoperate.setDowntime(operate.getDowntime());
		oldoperate.setIpAddress(operate.getIpAddress());
		oldoperate.setJhj(operate.getJhj());
		oldoperate.setPort(operate.getPort());
		oldoperate.setTemp(operate.getTemp());
		oldoperate.setUptime(operate.getUptime());
	//	oldoperate.getUpserver().setRemarks(1);
		oldoperate.getUpserver().setUpFlag(2);
		oldoperate.getUpserver().setEmployee(employee);  //设置上架员工
		upb.updateObj(oldoperate);
		
//		Sale_orders sr = oldoperate.getUpserver().getSoOrders();
//		sr.setSoStat(4);
//		upb.updateObj(sr);
		return "tolist";
	}
	
	public String showOperate(){
		int opid = Integer.parseInt(request.getParameter("opid"));
		Operate operate = (Operate)upb.getObjectById(Operate.class, opid);
		request.setAttribute("operate", operate);
		return "showoperate";
	}
	
	//选择仓库,列出该仓库下的服务器
	public String getServers() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String ckid = request.getParameter("ckid");
		if(Integer.parseInt(ckid)==-1){
			out.print("ERROR");
		}
		String str = "";
		List<Product> list = upb.getServersByDepotid(Integer.parseInt(ckid));
		for(int i=0;i<list.size();i++){
			Product p = list.get(i);
			str += "<tr><td><input type='checkbox' id='"+p.getProperty().getId()+"'>"+p.getProperty().getName()+"</td></tr>";
		}
		out.print(str);
		request.setAttribute("productlist", list);
	    
		return null;
	}
	
	/**
	 * 冻结商品
	 * @return
	 */
	public String freezeProduct() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String proid = request.getParameter("proid");
		
		String num=request.getParameter("number");
		String upNo = request.getParameter("upNo");
		String[] id = proid.split(",");
		String  nums[]=num.split(",");
		String idlist="";
			for (int i = 0; i < id.length; i++) {//根据商品数量关联相应的商品
				String str = id[i];
				if(num!=null && !num.equals("1")){
					int productid = Integer.parseInt(str.substring(3,str.length()));
					String prohql="from Product as p where 1=1 and p.id="+productid;
					
					List listpro =upb.exeHql(prohql);
					Product pro=new Product();
					pro=(Product)listpro.get(0);//根据商品属性名字查找相同商品
					String prohql2="from Product  as pro where 1=1 and usestate=2 and pro.property.id="+pro.getProperty().getId()+"and depot.id="+pro.getDepot().getId();
					List listpro1 = upb.exeHql(prohql2);	
					List<Product> prolist=listpro1;
					
						for (int j = 0; j <Integer.parseInt(nums[i]); j++) {
							idlist+=prolist.get(j).getId()+",";
					}
					
				}
			}
			if(proid!="" || proid!=null){
				
			
			String ids[]=idlist.split(",");
			for(int i=0;i<ids.length;i++){
				String str = ids[i];
				int productid = Integer.parseInt(str);
				Product product = (Product)upb.getObjectById(Product.class, productid);
				product.setUsestate(1);  //改变商品的状态为1,正在使用中
				product.setIsfreeze(1); //冻结商品,1为冻结,0为取消冻结
				upb.updateObj(product);
				Freeze freeze = new Freeze();
				freeze.setProduct(product);
				freeze.setFreezeFlag(1);
				freeze.setUpNo(upNo);
				upb.addUpserver(freeze);
				out.print("SUCCESS");
			}
		}else {
			out.print("ERROR");
		}
		return null;
	}
	
	/**
	 *  销售订单列表(新)
	 * @return
	 */
	public String orderList(){
		
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String orderid = request.getParameter("saleorderserial")==null?"":request.getParameter("saleorderserial");
		String page = request.getParameter("page");
		String hql = "from Sale_orders where soStat=3";
		if(orderid!=null && !"".equals(orderid)){
			hql += " and soNums like '"+orderid+"'";
		}
		hql += " order by soId desc";
		System.out.println("hql :"+hql);
		Pages pages = upb.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
		request.setAttribute("page", page);
		request.setAttribute("pages", pages);
		return "saleorderlist";
	}
	

	
	/**
	 * 删除上架单
	 * @return
	 */
	public String delUps()
	{
      String a = request.getParameter("ids");
		String[] str = a.split(",");
		boolean flag=upb.delupServer(str);
		try
		{
			if(flag){
				/*阙超强 14015   添加记录动态信息*/
				//添加记录到动态记录表
				Employee loginEmp = this.getEmp();
				if(null == loginEmp){
					request.setAttribute("errorMsg", "由于您长时间未活动，请重新登录！");
					return "no";
				}
				Executerecord executerecord = new Executerecord();
				executerecord.setEmployee(loginEmp);
				executerecord.setContent("删除了一些服务器上架单。");
				executerecord.setExecuteTime(TimePattern.doTimeDf3(new Date()));
				executerecord.setEntityId(StringUtil.arrayToString(ids));
				executerecord.setEntityName("UpServer");
				executerecord.setSeenEmpId("");
				executeRecordBussiness.addData(executerecord);
				
				response.getWriter().print("0");
			}
			else
			{
				response.getWriter().print("1");
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return "operate";
	}
	
	
	public String updConkout(){
			int upid = Integer.parseInt(request.getParameter("upid"));
			UpServer upse = (UpServer)upb.getObjectById(UpServer.class, upid);
			int soid = upse.getSoOrders().getSoId();
			Sale_orders so = (Sale_orders)upb.getObjectById(Sale_orders.class, soid);
			so.setSoStat(5);
			upb.updateObj(so);
			int a = upse.getConkout().getId();
			System.out.println(a);
			Questioncategory qu = (Questioncategory)upb.getObjectById(Questioncategory.class, 7);
			ConkOut oldconk = (ConkOut)upb.getObjectById(ConkOut.class, a);
			oldconk.setStatus(0);
			oldconk.setProudcotType(qu);
//			con.setState("0");  //客户已提交
			upb.updateObj(oldconk);
			
			request.getSession().setAttribute("soid", soid);
			return "operate";
	}
}
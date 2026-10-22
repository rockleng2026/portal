package com.fuao.fajxc.action.customService;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.omg.CORBA.PUBLIC_MEMBER;

import com.fuao.fajxc.bussiness.basic.CustomerBussiness;
import com.fuao.fajxc.bussiness.customService.MalfunctionDeclarBussiness;
import com.fuao.fajxc.bussiness.system.MessageremindBiz;
import com.fuao.fajxc.product_manageAction.NewportalSaleGoodsAction;
import com.fuao.fajxc.product_manageDao.prodect_OrderDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.utilinterface.General;
import com.fuao.fajxc.vo.Cabinet;
import com.fuao.fajxc.vo.CommonScfjb;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Conkoutask;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.ElectHouse;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Missiontype;
import com.fuao.fajxc.vo.Operate;
import com.fuao.fajxc.vo.Operationgroup;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Questioncategory;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.UpServer;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.sun.org.apache.xerces.internal.util.URI;

public class FaultAction extends ActionSupport implements ModelDriven,
ServletRequestAware,ServletResponseAware{
	
	private Logger logger = Logger.getLogger(FaultAction.class);
	private HttpServletRequest request;
	private HttpServletResponse response;
	private MalfunctionDeclarBussiness maldao; // 注入BIZ层
	private prodect_OrderDao pdao;
	private General general;
	private ConkOut co; //故障单对象
	private Operate operate;
	private CustomerBussiness customerBussiness;
	private MessageremindBiz messager;
	private String cusName;
	private String faultNo;
	private String proType;
	private String cusName2;
	private String faultNo2;
	private String proType2;
	
	private String flag;
	
	private String cusname;
	private String customerCompany;
	private String strempname;
	
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



	public General getGeneral() {
		return general;
	}

	public void setGeneral(General general) {
		this.general = general;
	}

	public ConkOut getCo() {
		return co;
	}

	public void setCo(ConkOut co) {
		this.co = co;
	}

	public CustomerBussiness getCustomerBussiness() {
		return customerBussiness;
	}

	public void setCustomerBussiness(CustomerBussiness customerBussiness) {
		this.customerBussiness = customerBussiness;
	}

	public MessageremindBiz getMessager() {
		return messager;
	}

	public void setMessager(MessageremindBiz messager) {
		this.messager = messager;
	}

	public String getCusName() {
		return cusName;
	}

	public void setCusName(String cusName) {
		this.cusName = cusName;
	}

	public String getFaultNo() {
		return faultNo;
	}

	public void setFaultNo(String faultNo) {
		this.faultNo = faultNo;
	}
	public String getProType() {
		return proType;
	}

	public void setProType(String proType) {
		this.proType = proType;
	}
	
	public String getCusName2() {
		return cusName2;
	}

	public void setCusName2(String cusName2) {
		this.cusName2 = cusName2;
	}

	public String getFaultNo2() {
		return faultNo2;
	}

	public void setFaultNo2(String faultNo2) {
		this.faultNo2 = faultNo2;
	}

	public String getProType2() {
		return proType2;
	}

	public void setProType2(String proType2) {
		this.proType2 = proType2;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getCusname() {
		return cusname;
	}

	public void setCusname(String cusname) {
		this.cusname = cusname;
	}

	public String getCustomerCompany() {
		return customerCompany;
	}

	public void setCustomerCompany(String customerCompany) {
		this.customerCompany = customerCompany;
	}

	public String getStrempname() {
		return strempname;
	}

	public void setStrempname(String strempname) {
		this.strempname = strempname;
	}

	public prodect_OrderDao getPdao() {
		return pdao;
	}

	public void setPdao(prodect_OrderDao pdao) {
		this.pdao = pdao;
	}

	public Operate getOperate() {
		return operate;
	}

	public void setOperate(Operate operate) {
		this.operate = operate;
	}

	/**
	 * 准备填写故障单
	 * @return
	 */
	public String goAdd(){
		String hql = "from Questioncategory where superid=1";
		List orderType = maldao.somelist(hql);
		request.setAttribute("orderType", orderType);
		return "gosubnote2";
	}
	
	/**
	 * 根据产品类型得到问题类型
	 * @return
	 */
	public String getQuestion() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String type = request.getParameter("type");
		System.out.println(type);
		int t = Integer.parseInt(type);
		String hql = "from Questioncategory q where q.questioncategory.id = "+t;
		System.out.println(hql);
		List qulist = maldao.somelist(hql);
//		request.setAttribute("qulist", qulist);
		String str = "";
		for(int i=0;i<qulist.size();i++){
			Questioncategory q = (Questioncategory)qulist.get(i);
			str+="<option value='"+q.getId()+"'>"+q.getQuestionName()+"</option>";
		}
		System.out.println(str);
		out.print(str);
		return null;
	}
	
	public String addCon(){
//		// 调用工具类生成单号
		FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5,
				"EveryDaySerialNumber.dat");

		String no = serial.getSerialNumber();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义格式，不显示毫秒
		Timestamp now = new Timestamp(System.currentTimeMillis());//获取系统当前时间
		String str = df.format(now);
		String time = df.format(new Date());
		Timestamp ts = Timestamp.valueOf(time);
		
		String phone = request.getParameter("phone");
		//ip地址
		String ipaddress = request.getParameter("ipCart");
		System.out.println(ipaddress);
		
		String sql = "insert into conkout(customerId,conkOutNo,Descs,State,faultTime,issueType,delflag,customerphone,wdnr,proudcotType,email,ispay,isdeclare,sure,status,ip,bzf)" +
				" values" +
				" ("+co.getCustomer().getCustomerId()+",'"+no+"','"+co.getDescs()+"','0','"+ts+"',"+co.getIssueType().getQuestioncategory().getId()+",'0','"+phone+"','"+co.getWdnr()+"',"+co.getProudcotType().getId()+",'"+co.getEmail()+"',"+co.getIspay()+","+co.getIsdeclare()+","+co.getSure()+",0,'"+ipaddress+"',0)";
		System.out.println(sql);
		maldao.addBySQL(sql);
		
		//取到刚刚写入的最后一条记录
		String hql = "from ConkOut order by id desc";
		List lst = maldao.somelist(hql);
		Object obje = lst.get(0);
		ConkOut cok = (ConkOut)obje;
		
		//向conkoutask表写入数据
		Conkoutask coa = new Conkoutask();
		coa.setConkout(cok);
		coa.setDescs(co.getDescs());
		coa.setState(0);  //状态:0未解决  1已解决
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String times = sdf2.format(new Date());
		coa.setFaultTime(times);  //申报时间
		maldao.addObje(coa);
		
		
		
		
		System.out.println(cok.getId());
		Map zj =(Map) request.getSession().getAttribute("sczj");
		if(null!=zj && zj.size()>0){
		Iterator it = zj.keySet().iterator();
		String keyStr = "";
		String txtName = "";
		while(it.hasNext()){
			Object key = it.next();
			System.out.println("key="+key + ",value=" + zj.get(key));
			Object obj = zj.get(key);
			String name = (String)obj;
			String string = name.replace("/uploads/", "");
			keyStr+=key+",";
			txtName+=string+",";
		}
		System.out.println(txtName);
		
		
		String[] fjs = txtName.split(",");
		String[] mc = keyStr.split(",");
		for(int i=0;i<fjs.length;i++){
			String fjmc = fjs[i];  //附件名称
			String hz = fjmc.substring(fjmc.lastIndexOf(".")+1); //附件的后缀名
			CommonScfjb fj = new CommonScfjb();
			fj.setFjmc(mc[i]);
			fj.setFjhz(hz);
			fj.setFjlj(fjmc);
			fj.setTmp("ConkOut");
			fj.setBuildTime(new Date());
			fj.setTmp1(cok.getId().toString());
			maldao.addObje(fj);
		}
	}
		return "tlist";
	}
	
	/**
	 * 获得IP/账号
	 * @return
	 */
	public String getIp(){
		int cusid = Integer.parseInt(request.getParameter("cusid"));
		int type = Integer.parseInt(request.getParameter("type"));
		System.out.println("客户id:"+cusid+",类型:"+type);
		String hql = "from Sale_orders where customer.id="+cusid+" and allTypeByOrdertype.id="+type;
		List list = maldao.somelist(hql);
		String str = "";
		for(int i=0;i<list.size();i++){
			
			Sale_orders so = (Sale_orders)list.get(i);
			str+="<option value='"+so.getSoId()+"'></option>";
		}
		return null;
	}
	
	/**
	 * 查询待分配的故障单
	 * @return
	 */
	public String conkoutList(){
		String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String flag = request.getParameter("flag");
		String hql = "from ConkOut where delflag = 0 and status in (0,1) order by id desc";
		List<ConkOut> conkoutlist = maldao.somelist(hql);
		Pages pages = maldao.exHqlPages(hql, Integer.parseInt(pageNo), 20, null);
		System.out.println("总记录数:" + pages.getAllCount());
		
		String hql2 = "from Questioncategory q where q.questioncategory.id = 1";
		List questionlist = maldao.somelist(hql2);
		request.setAttribute("pages", pages);
		request.setAttribute("questionlist", questionlist);
		request.setAttribute("flag", flag);
		request.setAttribute("f", 1);
		int zt = Integer.parseInt(request.getParameter("zt")!=null?request.getParameter("zt"):"1");
		request.setAttribute("zt", zt);
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		if(employee==null){
			employee=(Employee) request.getSession().getAttribute("emp");
			
		}
		request.setAttribute("employee", employee);
		return "list";
	}
	
	/**
	 * 查询处理中的故障单
	 * @return
	 */
	public String conkoutList2(){
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String flag = request.getParameter("flag");
		String hql = "from ConkOut where delflag = 0 and status=7 order by id desc";
		Pages pages = maldao.exHqlPages(hql, Integer.parseInt(pageNo), 20, null);
		System.out.print("总记录数:" + pages.getAllCount());
		
		String hql2 = "from Questioncategory q where q.questioncategory.id = 1";
		List questionlist = maldao.somelist(hql2);
		request.setAttribute("pages", pages);
		request.setAttribute("questionlist", questionlist);
		request.setAttribute("flag", flag);
		request.setAttribute("f", 2);
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		request.setAttribute("employee", employee);
		int zt = Integer.parseInt(request.getParameter("zt"));
		request.setAttribute("zt", zt);
		return "list";
	}
	
	/**
	 * 查询待反馈的故障单
	 * @return
	 */
	public String conkoutList3(){
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		String flag = request.getParameter("flag");
		String hql = "from ConkOut where delflag = 0 and status in (4,6) order by id desc";
		Pages pages = maldao.exHqlPages(hql, Integer.parseInt(pageNo), 20, null);
		System.out.println("总记录数:" + pages.getAllCount());
		
		String hql2 = "from Questioncategory q where q.questioncategory.id = 1";
		List questionlist = maldao.somelist(hql2);
		request.setAttribute("questionlist", questionlist);
		request.setAttribute("pages", pages);
		request.setAttribute("flag", flag);
		request.setAttribute("f", 3);
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		request.setAttribute("employee", employee);
		int zt = Integer.parseInt(request.getParameter("zt"));
		request.setAttribute("zt", zt);
		return "list";
	}
	
	/**
	 * 查询已完成的故障单
	 * @return
	 */
	public String conkoutList4(){
		int pageNo = Integer.parseInt(request.getParameter("pageNo")==null?"1":request.getParameter("pageNo"));
		String flag = request.getParameter("flag");
		String hql = "from ConkOut where delflag = 0 and status = 5 order by id desc";
		Pages pages = maldao.exHqlPages(hql, pageNo, 20, null);
		System.out.println("总记录数:" + pages.getAllCount());
		
		String hql2 = "from Questioncategory q where q.questioncategory.id = 1";
		List questionlist = maldao.somelist(hql2);
		request.setAttribute("pages", pages);
		request.setAttribute("questionlist", questionlist);
		request.setAttribute("flag", flag);
		request.setAttribute("f", 4);
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		request.setAttribute("employee", employee);
		int zt = Integer.parseInt(request.getParameter("zt"));
		request.setAttribute("zt", zt);
		return "list";
	}
	
	/**
	 * 模糊查询
	 * @return
	 */
	public String select(){
		String  flag = "5";
		
		int zt = Integer.parseInt(request.getParameter("zt"));
		
		System.out.println(request.getParameter("pageNo"));
		int pageNo=1;
		if(request.getParameter("pageNo")!=null){
			pageNo=Integer.parseInt(request.getParameter("pageNo"));
		}
		//int pageNo = Integer.parseInt(request.getParameter("pageNo")==null?"1":request.getParameter("pageNo"));
		cusName = request.getParameter("realName");
		faultNo = request.getParameter("faultNo");
		proType = request.getParameter("proType");
		System.out.println(cusName + "," + faultNo + ",");
		
		String hql = "from ConkOut where delflag = 0";
		if( cusName!=null && !cusName.equals("")){
			hql += " and customer.realName like '%"+cusName+"%'";
		}
		if(  faultNo!=null && !faultNo.equals("")){
			hql += " and conkOutNo like '%"+faultNo+"%'";
		}
		if(null !=proType && !"".equals(proType) && !"-1".equals(proType)){
			hql += " and proudcotType.id = "+ new Integer(proType);
		}
		if(zt==1){
			hql += " and status in (0,1)";
		}
		if(zt==2){
			hql += " and status=7";
		}
		if(zt==3){
			hql += " and status in (4,6)";
		}
		if(zt==4){
			hql += " and status=5";
		}
		hql += " order by id desc";
		Pages pages = maldao.exHqlPages(hql, pageNo, 20, 20);
		
		String hql2 = "from Questioncategory q where q.questioncategory.id = 1";
		List questionlist = maldao.somelist(hql2);
		request.setAttribute("questionlist", questionlist);
		request.setAttribute("pages", pages);
		request.setAttribute("flag", flag);
		request.setAttribute("cusName", cusName);
		request.setAttribute("faultNo", faultNo);
		request.setAttribute("proType", proType);
		
		Employee employee =(Employee) this.request.getSession().getAttribute("emp");
		request.setAttribute("employee", employee);
		request.setAttribute("zt", zt);
		return "list";
	}
	
	/**
	 * 故障单转接
	 * @return
	 */
	public String zhuanjie(){
		String cid = request.getParameter("cid");
		System.out.println("===" + cid);
		Object obj = maldao.getObj(ConkOut.class, Integer.parseInt(cid));
		ConkOut conkout = (ConkOut)obj;
		//列出所有运维部
		String hql = "from Missiontype where superid = 100";
		List missiontypelist = maldao.somelist(hql);
		request.setAttribute("missiointypelist", missiontypelist);
		request.setAttribute("fault", conkout);
		Employee employee =(Employee) request.getSession().getAttribute("emp");
		request.setAttribute("employee", employee);
		
		String hql2 = "from CommonScfjb where tmp1 = "+conkout.getId()+" and tmp='ConkOut'";
		List fjlist = maldao.somelist(hql2);
		List list = maldao.somelist(hql);
		request.setAttribute("fjlist", fjlist);
		return "tozj";
	}
	
	/**
	 * 查看详情
	 * @return
	 */
	public String detail(){
		String cid = request.getParameter("cid");
		System.out.println("===" + cid);
		Object obj = maldao.getObj(ConkOut.class, Integer.parseInt(cid));
		ConkOut conkout = (ConkOut)obj;
		
		String hql = "from CommonScfjb where tmp1 = "+conkout.getId()+" and tmp='ConkOut'";
		List list = maldao.somelist(hql);
		
		String solvehql = "from Conkoutask where conkout.id="+conkout.getId();
		List solvelist = maldao.somelist(solvehql);
		request.setAttribute("solvelist", solvelist);
		
		//运维单信息
		List oplist = null;
		if(null!=conkout.getUpserverid()){
		   int upid = conkout.getUpserverid();
		   String ophql = "from Operate where upserver.id="+upid;
		   oplist = maldao.somelist(ophql);
		}
		
		request.setAttribute("oplist", oplist);
		request.setAttribute("list", list);
		request.setAttribute("fault", conkout);
		return "kfdetail";
	}
	
	/**
	 * 评分
	 * 
	 * @return
	 */
	public String pingfen(){
		int cid = Integer.parseInt(request.getParameter("cid"));
		ConkOut co = (ConkOut)maldao.getObj(ConkOut.class, cid);
//		co.setAppraise("无");
		co.setGrades(5);
		maldao.updObj(co);
		return "pf";
	}
	
	
	
	/////////////////////运维人员故障单////////////////////////
	
	/**
	 * 运维人员待接收
	 * @return
	 */
	public String toreceive(){
		
		String flag = request.getParameter("flag");
		int zt = Integer.parseInt(request.getParameter("zt")!=null?request.getParameter("zt"):"1");
		int pageNo = Integer.parseInt(request.getParameter("pageNo")==null?"1":request.getParameter("pageNo"));
		String hql = "from ConkOut where delflag = 0 and status = 2 order by id desc";
		Pages pages = maldao.exHqlPages(hql, pageNo, 20, null);
		System.out.println("总记录数:" + pages.getAllCount());
		
		String hql2 = "from Questioncategory q where q.questioncategory.id = 1";
		List questionlist = maldao.somelist(hql2);
		request.setAttribute("questionlist", questionlist);
		request.setAttribute("pages", pages);
		request.setAttribute("flag", flag);
		request.setAttribute("type", 1);
		
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		request.setAttribute("employee", employee);
		request.setAttribute("zt", zt);
		return "ywlist";
	}
	
	/**
	 * 运维人员处理中列表
	 * @return
	 */
	public String ywcl(){
		int zt = Integer.parseInt(request.getParameter("zt"));
		String flag = request.getParameter("flag");
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		int pageNo = Integer.parseInt(request.getParameter("pageNo")==null?"1":request.getParameter("pageNo"));
		String hql = "from ConkOut where delflag = 0 and status=3 and emp.id="+employee.getId()+" order by id desc";
		Pages pages = maldao.exHqlPages(hql, pageNo, 20, null);
		System.out.println("总记录数:" + pages.getAllCount());
		
		String hql2 = "from Questioncategory q where q.questioncategory.id = 1";
		List questionlist = maldao.somelist(hql2);
		request.setAttribute("questionlist", questionlist);
		request.setAttribute("pages", pages);
		request.setAttribute("flag", flag);
		request.setAttribute("zt", zt);
		request.setAttribute("type", 2);
		return "ywlist";
	}
	
	/**
	 * 运维处理完成
	 * @return
	 */
	public String clwc(){
		int zt = Integer.parseInt(request.getParameter("zt"));
		String flag = request.getParameter("flag");
		int pageNo = Integer.parseInt(request.getParameter("pageNo")==null?"1":request.getParameter("pageNo"));
		String hql = "from ConkOut where delflag = 0 and status=5 order by id desc";
		Pages pages = maldao.exHqlPages(hql, pageNo, 20, null);
		System.out.println("总记录数:" + pages.getAllCount());
		
		String hql2 = "from Questioncategory q where q.questioncategory.id = 1";
		List questionlist = maldao.somelist(hql2);
		request.setAttribute("questionlist", questionlist);
		request.setAttribute("pages", pages);
		request.setAttribute("flag", flag);
		request.setAttribute("zt", zt);
		request.setAttribute("type", 3);
 		return "ywlist";
	}
	
	/**
	 * 运维故障单的模糊查询
	 * @return
	 */
	public String ywselect(){
		int zt = Integer.parseInt(request.getParameter("zt"));
		String flag = "5";
		System.out.println(request.getParameter("pageNo"));
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		int pageNo=1;
		if(request.getParameter("pageNo")!=null){
			pageNo=Integer.parseInt(request.getParameter("pageNo"));
		}
		
		//int pageNo = Integer.parseInt(request.getParameter("pageNo")==null?"1":request.getParameter("pageNo"));
		cusName2 = request.getParameter("realName2");
		faultNo2 = request.getParameter("faultNo2");
		proType2 = request.getParameter("proType2");
		System.out.println(cusName + "," + faultNo + ",");
		
		String hql = "from ConkOut where delflag = 0";
		if(cusName2!=null && !cusName2.equals("")){
			hql += " and customer.realName like '%"+cusName2+"%'";
			request.setAttribute("cusName2", cusName2);
		}
		if(faultNo2!=null && !faultNo2.equals("")){
			hql += " and conkOutNo like '%"+faultNo2+"%'";
			request.setAttribute("faultNo2", faultNo2);
		}
		if(null !=proType2 && !"".equals(proType2) && !"-1".equals(proType2)){
			hql += " and proudcotType.id = "+ new Integer(proType2);
		}
		if(zt==1){
			hql += " and status=2";
		}
		if(zt==2){
			hql += " and status=3 and emp.id="+employee.getId();
		}
		if(zt==3){
			hql += " and status=5";
		}
		
		hql += " order by id desc";
		Pages pages = maldao.exHqlPages(hql, pageNo, 20, null);
		String hql2 = "from Questioncategory q where q.questioncategory.id = 1";
		List questionlist = maldao.somelist(hql2);
		
		request.setAttribute("questionlist", questionlist);
		request.setAttribute("pages", pages);
//		request.setAttribute("cusName2", cusName2);
//		request.setAttribute("faultNo2", faultNo2);
		request.setAttribute("flag", flag);
		request.setAttribute("zt", zt);
		return "ywlist";
	}
	
	/**
	 * 根据运维区域得到运维组
	 * @return
	 */
	public void getOperategroup() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String gid = request.getParameter("gid");
		System.out.println(gid);
		String hql = "from Missiontype where superid = "+Integer.parseInt(gid);
		List group = maldao.somelist(hql);
		String str = "<option value='-1'>请选择</option>";
		for(int i=0;i<group.size();i++){
			Missiontype mt = (Missiontype)group.get(i);
			str += "<option value='"+mt.getId()+"'>"+mt.getName()+"</option>";
		}
		System.out.println(str);
		out.print(str);
	}
	
	/**
	 * 提交转接
	 * @return
	 */
	public String zhuanjieSub() throws Exception{
		String conid = request.getParameter("conid");
		String gid = request.getParameter("gid");
		String temp = request.getParameter("temp");
		String temp2 = URLDecoder.decode(temp, "utf-8");
		String hql = "from Operationgroup where missiontype.id="+Integer.parseInt(gid);
		List list = maldao.somelist(hql);
		Operationgroup og = (Operationgroup)list.get(0);
//		Object object = maldao.getObj(Operationgroup.class, Integer.parseInt(gid));//得到选中的运维组
//		Operationgroup og = (Operationgroup)object;
		Object object2 = maldao.getObj(ConkOut.class, Integer.parseInt(conid));
		ConkOut co = (ConkOut)object2;
		int coid = co.getId();
		co.setGroup(og);
		co.setStatus(2);
		co.setTemp(temp2);
		maldao.updObj(co);
		
		//改变工单状态的同时还要改变订单状态
		if(null!=co.getUpserverid()){
			int upserverid = co.getUpserverid();
			UpServer upserver = (UpServer)maldao.getObj(UpServer.class, upserverid);
			Sale_orders so = upserver.getSoOrders();
			so.setSoStat(7); //客服转接后,状态改为待运维接收
			maldao.updObj(so);
		}
		
		
		String hql2 = "from Conkoutask where conkout.id="+coid;
		List coalist = maldao.somelist(hql2);
		if(coalist.size()>0){
			Conkoutask coa = (Conkoutask)coalist.get(0);
			System.out.println(co.getGroup().getId());
			coa.setMissiontypeid(co.getGroup().getId());  //设置运维组
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String time = sdf.format(new Date());
			coa.setPropellingTime(time);  //推送时间
			maldao.updObj(coa);
		}
		return "kfzjsub";
	}
	
	/**
	 * 运维人员接收
	 * @return
	 */
	public String toReceive(){
		String cid = request.getParameter("yid");
		Object object = maldao.getObj(ConkOut.class, Integer.parseInt(cid));
		ConkOut co = (ConkOut)object;
		
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		System.out.println(employee.getId());
		int eid = employee.getId();
		//在点击列表页面接收的时候,判断当前登录人是否是当前故障单对应的运维组的人
		Operationgroup group = co.getGroup();
		String empids = group.getEmpids();
		String[] ids = empids.split(",");
		int flag = 0;
		for(int i=0;i<ids.length;i++){
			if(Integer.parseInt(ids[i])==eid){
				flag = Integer.parseInt(ids[i]);
				break;
			}
		}
		
		List oplist = null;
		if(null!=co.getUpserverid()){
			int upid = co.getUpserverid();
			if(String.valueOf(upid)!=null){
				String hql = "from Operate where upserver.id="+upid;
				oplist = maldao.somelist(hql);
				System.out.println(oplist.size());
			}
		}
		request.setAttribute("oplist", oplist);
		request.setAttribute("flag", flag);
		request.setAttribute("co", co);
		return "receive";
	}
	
	/**
	 * 接收之前的判断(运维接收)
	 * @return
	 * @throws Exception
	 */
	public String sure() throws Exception{
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		int conid = Integer.parseInt(request.getParameter("conid"));
		ConkOut co = (ConkOut)maldao.getObj(ConkOut.class, conid);
		if(co.getBzf()==0){
			out.print("A");
		}
		if(co.getBzf()==1){
			out.print("B");
		}
		return null;
	}
	
	
	/**
	 * 运维点击接收
	 * @return
	 */
	public String jieshouCo(){
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		String coid = request.getParameter("conid");
		Object obj = maldao.getObj(ConkOut.class, Integer.parseInt(coid));
		ConkOut cou = (ConkOut)obj;
		if(cou.getBzf()==1){
			request.setAttribute("bz", "抢单失败");
			return "toywlist";
		}
		
		if(cou.getBzf()==0){
			Employee employee = (Employee)request.getSession().getAttribute("emp");
			Object object = maldao.getObj(ConkOut.class, Integer.parseInt(coid));
			ConkOut co = (ConkOut)object;
			co.setStatus(3);
			co.setEmp(employee);
			co.setBzf(1);
//			co.setHandleemp(employee);
			maldao.updObj(co);
			
			//改变工单状态的同时还要改变订单状态
			if(null!=co.getUpserverid()){
				int upserverid = co.getUpserverid();
				UpServer upserver = (UpServer)maldao.getObj(UpServer.class, upserverid);
				Sale_orders so = upserver.getSoOrders();
				so.setSoStat(8); //运维接收后,状态改为待运维上架
				maldao.updObj(so);
				//运维点击接收,把对应的上架单的上架人员设置为当前登录人
				UpServer us = (UpServer)maldao.getObj(UpServer.class, co.getUpserverid());
				us.setEmployee(emp);
				maldao.updObj(us);
			}
			
			//conkoutask
			String hql = "from Conkoutask where conkout.id="+co.getId();
			List list = maldao.somelist(hql);
			if(list.size()>0){
				Conkoutask coa = (Conkoutask)list.get(0);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				coa.setInceptTime(sdf.format(new Date())); //接收时间
				coa.setEmployeeByEmpTakeId(emp);  //接收员工
				maldao.updObj(coa);
			}
			return "toywlist";
		}
		return null;
	}
	
	/**
	 * 运维接收后--处理
	 * @return
	 */
	public String handleCo(){
		String coid = request.getParameter("coid");
		Object object = maldao.getObj(ConkOut.class, Integer.parseInt(coid));
		ConkOut co = (ConkOut)object;
		
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		int eid = employee.getId();
		int flag = 0;
		Operationgroup group = co.getGroup();
		String[] ids = group.getEmpids().split(",");
		for(int i=0;i<ids.length;i++){
			if(Integer.parseInt(ids[i])==eid){
				flag = Integer.parseInt(ids[i]);
				break;
			}
		}
		
		
		String hql = "from CommonScfjb where tmp1 = "+co.getId()+" and tmp='ConkOut'";
		List list = maldao.somelist(hql);
		
		//得到处理描述的list
		String sovlehql = "from Conkoutask where conkout.id="+co.getId();
		List sovlelist = maldao.somelist(sovlehql);
		
		//得到运维单信息
		List oplist = null;
		if(null!=co.getUpserverid()){
		  String ophql = "from Operate where upserver.id="+co.getUpserverid();
		  oplist = maldao.somelist(ophql);
		}
		
		request.setAttribute("oplist", oplist);
		request.setAttribute("list", list);
		request.setAttribute("sovlelist", sovlelist);
		request.setAttribute("flag", flag);
		request.setAttribute("data", co);
		return "handle";
	}
	
	/**
	 * 客服故障单处理中--查看
	 * @return
	 */
	public String chakan(){
		String cid = request.getParameter("cid");
		ConkOut co = (ConkOut)maldao.getObj(ConkOut.class, Integer.parseInt(cid));
		
		//列出所有运维部
		String hql2 = "from Missiontype where superid = 100";
		List missiontypelist = maldao.somelist(hql2);
		request.setAttribute("missiointypelist", missiontypelist);
		
		String hql = "from CommonScfjb where tmp1 = "+co.getId()+" and tmp='ConkOut'";
		List list = maldao.somelist(hql);
		
		String solvehql = "from Conkoutask where conkout.id="+co.getId();
		List solvelist = maldao.somelist(solvehql);
		
		request.setAttribute("data", co);
		request.setAttribute("solvelist", solvelist);
		request.setAttribute("list", list);
		return "chakan";
	}
	
	/**
	 * 客服查看--转接
	 * @return
	 */
	public String chakanZj(){
		String cid = request.getParameter("cid");
		String gid = request.getParameter("gid");
		String hql = "from Operationgroup where missiontype.id="+Integer.parseInt(gid);
		List list = maldao.somelist(hql);
		Operationgroup og = null;
		if(list.size()>0){
			og = (Operationgroup)list.get(0);
		}
		ConkOut co = (ConkOut)maldao.getObj(ConkOut.class, Integer.parseInt(cid));
		co.setStatus(2);
		co.setGroup(og);
		co.setBzf(0);
		maldao.updObj(co);
		return "zj2";
	}
	
	
	/**
	 * 提交处理
	 * @return
	 */
	public String subHandle() throws Exception{
		String coid = request.getParameter("coid");
		
		ActionContext act = ActionContext.getContext();
		String info = request.getParameter("info");  //处理问题描述
		HttpServletRequest req = (HttpServletRequest)act.get(ServletActionContext.HTTP_REQUEST);
//		String str = new String(req.getParameter("info").getBytes("ISO-8859-1"),"gbk");
		String str = URLDecoder.decode(req.getParameter("info"),"utf-8");
		
		//得到当前登录人
		Employee employee = (Employee)request.getSession().getAttribute("emp");
//		Department dept = employee.getDepartment(); //并得到登录人所在的部门
		
		Object object = maldao.getObj(ConkOut.class, Integer.parseInt(coid));
		ConkOut co = (ConkOut)object;
		co.setStatus(7);
		co.setSolveDepict(str);
		co.setHandleemp(employee);  //设置处理人
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		String d = sdf.format(new Date());
		Timestamp ts = Timestamp.valueOf(d);
		co.setEndTim(ts);
//		co.setEmp(employee);
		maldao.updObj(co);
		
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		
		//conkoutask
		String hql = "from Conkoutask where conkout.id="+co.getId();
		List list = maldao.somelist(hql);
		Conkoutask coa = (Conkoutask)list.get(0);
		
		// 如果处理描述为空,表示运维人员第一次进行处理,属于修改操作
		if("".equals(coa.getSolveDepict()) || null==coa.getSolveDepict()){
			coa.setSolveDepict(str); //处理描述
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
			coa.setResolveTime(sdf2.format(new Date()));
			coa.setEndTim(sdf2.format(new Date()));
			coa.setEmployeeByEmpId(emp);
			maldao.updObj(coa);
			return "ywcl";
		}
		
		// 如果处理描述不为空,表示运维已经返单给客服了,此时再处理,属于添加操作
		if(!coa.getSolveDepict().equals("") && null!=coa.getSolveDepict()){
			//运维人员进行多次回复，看到的却只有最新的一次回复，需要将所有的回复都进行显示
			//因此,此处不再是修改操作,而是添加数据操作
			Conkoutask ca = new Conkoutask();
			ca.setConkout(co);
			ca.setSolveDepict(co.getSolveDepict());
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
			ca.setResolveTime(sdf.format(new Date()));
			ca.setEmployeeByEmpId(emp);
			ca.setDescs(co.getDescs());
			ca.setState(0);
			SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String times = sdf3.format(new Date());
			ca.setEndTim(sdf3.format(new Date()));
			maldao.addObje(ca);
			return "ywcl";
		}
		return null;
	}
	
	/**
	 * 结单
	 * @return
	 */
	public String jiedan() throws Exception{
		String cid = request.getParameter("cid");
		String mess = request.getParameter("mess");
		
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		String str = URLDecoder.decode(request.getParameter("mess"), "utf-8");
		ConkOut co = (ConkOut)maldao.getObj(ConkOut.class, Integer.parseInt(cid));
		co.setSolveDepict(str);
		co.setStatus(6);
		co.setHandleemp(employee);
		maldao.updObj(co);
		
		//改变工单状态的同时还要改变订单状态
		if(null!=co.getUpserverid()){
			int upserverid = co.getUpserverid();
			UpServer upserver = (UpServer)maldao.getObj(UpServer.class, upserverid);
			Sale_orders so = upserver.getSoOrders();
			so.setSoStat(9); //运维点击结单后,状态改为待客服确认
			maldao.updObj(so);
		}
		
		
		Employee emp = (Employee)request.getSession().getAttribute("emp");
		//conkout
		String hql = "from Conkoutask where conkout.id="+co.getId();
		List list = maldao.somelist(hql);
		if(list.size()>0){
			Conkoutask coa = (Conkoutask)list.get(0);
			if("".equals(coa.getSolveDepict()) || null==coa.getSolveDepict()){
				coa.setSolveDepict(str);  //处理意见
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
				coa.setResolveTime(sdf2.format(new Date()));
				coa.setEndTim(sdf2.format(new Date()));
				coa.setEmployeeByEmpId(emp);
				maldao.updObj(coa);
				return "jiedan";
			}
			if(!"".equals(coa.getSolveDepict()) && null!=coa.getSolveDepict()){
				//运维人员进行多次回复，看到的却只有最新的一次回复，需要将所有的回复都进行显示
				//因此,此处不再是修改操作,而是添加数据操作
				Conkoutask ca = new Conkoutask();
				ca.setConkout(co);
				ca.setSolveDepict(co.getSolveDepict());
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
				ca.setResolveTime(sdf2.format(new Date()));
				ca.setEmployeeByEmpId(emp);
				ca.setDescs(co.getDescs());
				ca.setState(0);
				SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String times = sdf3.format(new Date());
				ca.setEndTim(sdf3.format(new Date()));
				maldao.addObje(ca);
				return "jiedan";
			}
		}
		return null;
	}
	
	/**
	 * 运维模块: 处理完成后查看详情
	 * @return
	 */
	public String clxq(){
		String cid = request.getParameter("cid");
		ConkOut co = (ConkOut)maldao.getObj(ConkOut.class, Integer.parseInt(cid));
		
		List oplist = null;
//		String upid = co.getUpserverid().toString();
		if(null!=co.getUpserverid()){
			int upid = co.getUpserverid();
			System.out.println(upid);
			String hqlop = "from Operate where upserver.id="+upid;
			oplist = maldao.somelist(hqlop);
		}
		
		
		String hql = "from CommonScfjb where tmp1 = "+co.getId()+" and tmp='ConkOut'";
		List list = maldao.somelist(hql);

		
		String solvehql = "from Conkoutask where conkout.id="+co.getId();
		List solvelist = maldao.somelist(solvehql);
		request.setAttribute("solvelist", solvelist);
		
		
		
		request.setAttribute("oplist", oplist);
		request.setAttribute("list", list);
		request.setAttribute("co", co);
		return "clxq";
	}
	
	/**
	 * 点击反馈，列出信息
	 * @return
	 */
	public String fankui(){
		String cid = request.getParameter("cid");
		Object object = maldao.getObj(ConkOut.class, Integer.parseInt(cid));
		ConkOut co = (ConkOut)object;
		String hql = "from CommonScfjb where tmp1 = "+co.getId()+" and tmp='ConkOut'";
		List list = maldao.somelist(hql);
		
		String solvehql = "from Conkoutask where conkout.id="+co.getId();
		List solvelist = maldao.somelist(solvehql);

		request.setAttribute("list", list);
		request.setAttribute("solvelist", solvelist);
		request.setAttribute("data", co);
		return "feedback";
	}
	
	/**
	 * 提交反馈
	 * @return
	 */
	public String subFeedback() throws Exception{
		String cid = request.getParameter("cid");
//		String pj = request.getParameter("pj");
		String pj = URLDecoder.decode(request.getParameter("pj"),"utf-8");
		Object object = maldao.getObj(ConkOut.class, Integer.parseInt(cid));
		ConkOut co = (ConkOut)object;
		co.setStatus(5);
		co.setAppraise(pj);
		maldao.updObj(co);
		
		//改变工单状态的同时还要改变订单状态
		if(null!=co.getUpserverid()){
			int upserverid = co.getUpserverid();
			UpServer upserver = (UpServer)maldao.getObj(UpServer.class, upserverid);
			Sale_orders so = upserver.getSoOrders();
			so.setSoStat(10); //运维处理后,状态改为上架单待审核
			maldao.updObj(so);
		}
		
		
		//conkoutask
		String hql = "from Conkoutask where conkout.id="+co.getId();
		List list = maldao.somelist(hql);
		if(list.size()>0){
			Conkoutask coa = (Conkoutask)list.get(0);
			coa.setAppraise(pj); //客户评价
			maldao.updObj(coa);
		}
		return "todfklist";
	}
	
	/**
	 * 全选/删除
	 * @return
	 */
	public String deleteAll(){
		String ids = request.getParameter("ids");
		System.out.println(ids);
		int zt = Integer.parseInt(request.getParameter("zt"));
		String id = ids.substring(0, ids.length()-1);
		System.out.println(id);
		String sql = "update conkout set delflag=1 where id in ("+id+")";
		if(zt==1){
			sql += " and status in (0,1)";
			System.out.println(sql);
			maldao.exeSQL(sql);
			return "del1";
		}
		if(zt==2){
			sql += " and status=7";
			System.out.println(sql);
			maldao.exeSQL(sql);
			return "del2";
		}
		if(zt==3){
			sql += " and status in (4,6)";
			System.out.println(sql);
			maldao.exeSQL(sql);
			return "del3";
		}
		if(zt==4){
			sql += " and status=5";
			System.out.println(sql);
			maldao.exeSQL(sql);
			return "del4";
		}
		return "";
	}
	
	/**
	 * 全选/删除2
	 * @return
	 */
	public String deleteAll2(){
		int zt = Integer.parseInt(request.getParameter("zt"));
		String ids = request.getParameter("ids");
		System.out.println(ids);
		String id = ids.substring(0, ids.length()-1);
		System.out.println(id);
		String sql = "update conkout set delflag=1 where id in ("+id+")";
		if(zt==1){
			sql += " and status=2";
			System.out.println(sql);
			maldao.exeSQL(sql);
			return "dela1";
		}
		if(zt==2){
			sql += " and status=3";
			System.out.println(sql);
			maldao.exeSQL(sql);
			return "dela2";
		}
		if(zt==3){
			sql += " and status=5";
			System.out.println(sql);
			maldao.exeSQL(sql);
			return "dela3";
		}
		return "";
	}
	
	
	/**
	 * 获取IP/账号
	 * @return
	 * @throws IOException
	 */
	public String getorderlist2() throws IOException {
		response.setContentType("text/html");
		String orderType = request.getParameter("orderType");
		String cusid = request.getParameter("cusid");

		Employee emp = (Employee) request.getSession().getAttribute("emp");
		if (null == emp) {
			response.getWriter().print(0);
			return null;
		} else {
			StringBuffer str = new StringBuffer();
			// 根据客户登录名与客户选项的业务类型 查找客户订单列表
	//		List list = csbiz.getorder(typeId, Integer.parseInt(customerId));
			// 订单状态为10和12  表示订单成功
			String hql = "from Sale_orders where customer.customerId="+Integer.parseInt(cusid)+" and allTypeByOrdertype.id="+Integer.parseInt(orderType)+" and soStat in (10,12)";
			
			System.out.println(hql);
		    List list = maldao.somelist(hql);	
		    String str2 = "";
			// 如果订单列表不问NULL
			if (null != list && list.size() > 0) {
				// 循环订单列表
				for (int i = 0; i < list.size(); i++) {
					// 将订单列表转换成订单对象
					Sale_orders so = (Sale_orders) list.get(i);
					// 定义set对象 用于接收订单中的 上架单对象
					Set<UpServer> set = so.getUpserver();
					// 将订单中的上架单对象取出
					// 循环订单中的上架单
					for (UpServer obj : set) {
						if (obj instanceof UpServer) {
							// 转换成上架单对象
							UpServer upServer = obj;
							if(upServer.getUpFlag()==1 || upServer.getUpFlag()==2){
							Set<Operate> set2 = upServer.getOperates();
							for(Operate op : set2){
								if(op instanceof Operate){
									Operate operate = op;
									String ips = operate.getIpAddress();
									System.out.println(ips);
									if(ips != null){
										ips = ips.replace("，", ",");
										String[] ip = ips.split(",");
										for(int j=0;j<ip.length;j++){
											str2+="<option value='"+ip[j]+"'>"+ip[j]+"</option>";
										}
									}
//									else{
//										ips = operate.getIpAddress();
//									}
									
									// 将上架单中的IP号取出组成字符串传到页面
//									if (null != ips && ips != ""
//											&& ips.indexOf(",") > 0) {
//										String[] ip = ips.split(",");
//										for (int j = 0; j < ip.length; j++) {
//											str.append("<option value='" + operate.getId()
//													+ "#" + ip[j] + "'>" + ip[j]
//													+ "</option>");
//										}
//									} else {
//										str.append("<option value='" + operate.getId() + "#"
//												+ ips + "'>" + ips + "</option>");
//									}
								}
							}
							}
							// 将服务器id放到select										// 2012-7-24
//							String ips = upServer.getServerIp();
//							if (ips != null) {
//								ips = ips.replace("，", ",");
//							} else {
//								ips = upServer.getServerIp();
//							}
							
						}
					}
				}
				System.out.println(str2);
				response.getWriter().print(str2);
				return null;
			} else {
				// 如果订单list为NUll返回1
				response.getWriter().print(1);
				return null;
			}
		}
	}
	
	
	public String bzf() throws Exception{
		response.setCharacterEncoding("utf-8");
		int bzf = Integer.parseInt(request.getParameter("bzf"));
		int fg = 0;
		if(bzf==0){
		
		}
		if(bzf==1){
		
		}
		request.getSession().setAttribute("fg", fg);
		PrintWriter out = response.getWriter();
		return null;
	}
	
	
	/*
	 * 查询所有的客户
	 */
	public String selectCus2() {
		try {
//			String demo = request.getParameter("flag");
//			if (null == demo) {
//				demo = "2";
//			}  
//			request.setAttribute("demo", demo);
			String hql = "from Customer as c where 1=1 ";
			// 客户名称
			if (cusname != null && !cusname.equals("")) {
				hql += " and c.customerName like '%" + cusname + "%'";
				request.setAttribute("cusname", cusname);
			}
			// 公司名称
			if (customerCompany != null && !customerCompany.equals("")) {
				hql += " and c.customerCompany like '%" + customerCompany
						+ "%'";
				request.setAttribute("customerCompany", customerCompany);
			}
			// 业务负责人
			if (strempname != null && !strempname.equals("")) {
				String str = URLDecoder.decode(strempname, "utf-8");
				hql += " and c.employee.name like '%" + str + "%'";

				request.setAttribute("strEmp", str);
			}
			hql += " and c.customerType2 =3 order by c.customerId desc";

			String pageNo = request.getParameter("pageNo") == null ? "1"
					: request.getParameter("pageNo");
			Pages page = pdao.paginationQuery(hql, new Integer(pageNo), 10,
					null);
			request.setAttribute("pages", page);

		} catch (Exception e) {
			logger.error("===" + NewportalSaleGoodsAction.class.getName());
			e.printStackTrace();
		}
		return "selectcus2";
	}
	
	/**
	 * 运维组处理故障单,编辑上架单的运维单
	 * @return
	 */
	public String editOperate(){
		int id = Integer.parseInt(request.getParameter("id"));
		Operate operate = (Operate)maldao.getObj(Operate.class, id);
		if(operate.getHousesAndRooms()!=null){
			//机房
			int hr = Integer.parseInt(operate.getHousesAndRooms());
			ElectHouse eh = (ElectHouse)maldao.getObj(ElectHouse.class, hr);
			
			//机柜
			int cb = Integer.parseInt(operate.getJgh());
			Cabinet cab = (Cabinet)maldao.getObj(Cabinet.class, cb);
			request.setAttribute("eh", eh);
			request.setAttribute("cab", cab);
		}
		request.setAttribute("operate", operate);
		return "editOperate";
	}
		
	/**
	 * 运维单详情
	 * @return
	 */
	public String detailOperate(){
		
		int id = Integer.parseInt(request.getParameter("id"));
		Operate operate = (Operate)maldao.getObj(Operate.class, id);
		//机房
		int hr = Integer.parseInt(operate.getHousesAndRooms());
		ElectHouse eh = (ElectHouse)maldao.getObj(ElectHouse.class, hr);
		
		//机柜
		int cb = Integer.parseInt(operate.getJgh());
		Cabinet cab = (Cabinet)maldao.getObj(Cabinet.class, cb);
		
		request.setAttribute("eh", eh);
		request.setAttribute("cab", cab);
		return null;
	}
	
	/**
	 * 点击提交(修改运维单)
	 * @return
	 */
	public String edit(){
		int id = operate.getId();
		System.out.println("运维单ID:"+id);
		System.out.println("机柜号:"+operate.getJgh());
		Operate oldoperate = (Operate)maldao.getObj(Operate.class, id);
		oldoperate.setUptime(operate.getUptime());   //上架时间
		oldoperate.setDowntime(operate.getDowntime());  //下架时间
		oldoperate.setIpAddress(operate.getIpAddress());  //IP地址
		oldoperate.setJhj(operate.getJhj());
		oldoperate.setHousesAndRooms(operate.getHousesAndRooms());  //机房&房间
		oldoperate.setMarkNum(operate.getMarkNum());  //机柜
		oldoperate.setPort(operate.getPort());
		oldoperate.setTemp(operate.getTemp());
		oldoperate.setJgh(operate.getJgh());
		oldoperate.getUpserver().setUpFlag(2);
		maldao.updObj(oldoperate);
		return "edit";
	}
	
	/**
	 * 客户详情
	 * @return
	 */
	public String customerDetail(){
		int cusid = Integer.parseInt(request.getParameter("cusid"));
		int customertypeid = Integer.parseInt(request.getParameter("type"));
		Customer customer = (Customer)maldao.getObj(Customer.class, cusid);
		request.setAttribute("customer", customer);
		request.setAttribute("customertypeid",customertypeid);
		return "customerDetail";
	}

	public MalfunctionDeclarBussiness getMaldao() {
		return maldao;
	}

	public void setMaldao(MalfunctionDeclarBussiness maldao) {
		this.maldao = maldao;
	}
}

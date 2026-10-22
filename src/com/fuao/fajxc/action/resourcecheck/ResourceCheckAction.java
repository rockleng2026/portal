package com.fuao.fajxc.action.resourcecheck;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.system.AuditingBussiness;
import com.fuao.fajxc.dao.resourcecheck.ResourceCheck;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.City;
import com.fuao.fajxc.vo.Depot;
import com.fuao.fajxc.vo.ElectHouse;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.Model;
import com.fuao.fajxc.vo.Product;
import com.fuao.fajxc.vo.Sale_goods;
import com.fuao.fajxc.vo.Tresourcecheck;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/*
 * 资源核实单(action)
 * author：王雄
 * eamil：wangxiong@fuao.com
 */
	

public class ResourceCheckAction  extends ActionSupport implements ServletRequestAware , ServletResponseAware,ModelDriven {

	private ResourceCheck checkdao;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Tresourcecheck tresourcecheck;
	private AuditingBussiness audBussiness;
	
	private String hidename;//申请人
	private String rvid;//资源核实单编号
	
	
	private Logger logger = Logger.getLogger(ResourceCheckAction.class);
	
	
	public AuditingBussiness getAudBussiness() {
		return audBussiness;
	}

	public void setAudBussiness(AuditingBussiness audBussiness) {
		this.audBussiness = audBussiness;
	}

	public ResourceCheck getCheckdao() {
		return checkdao;
	}

	public void setCheckdao(ResourceCheck checkdao) {
		this.checkdao = checkdao;
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

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	public Tresourcecheck getTresourcecheck() {
		return tresourcecheck;
	}

	public void setTresourcecheck(Tresourcecheck tresourcecheck) {
		this.tresourcecheck = tresourcecheck;
	}
	
	
	//添加UI请求
	public String addUI()
	{
		//当前登入人
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		request.setAttribute("emps", employee);
		//随机一个编号
		//随机一个编号
		String rvid = "RC";
		
		SimpleDateFormat sm = new SimpleDateFormat("yyyyMMddHHssdd");
		rvid += sm.format(new Date());
		double num = Math.random()*10000;
		Integer num1 = (int)num;
		rvid+=num1+"";
		logger.info("======="+rvid);
		request.setAttribute("rvid", rvid);
		//得到当前的时间
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String nowTime = dateFormat.format(new Date());
		request.setAttribute("nowTime",nowTime);
		//仓库
		List listelehouse = this.checkdao.find("Depot");
		request.setAttribute("listeleHouce", listelehouse);
		//地区
		List listCity = this.checkdao.find("City");
		request.setAttribute("listCity", listCity);
		//产品
		List listPro = this.checkdao.find("Sale_goods");
		request.setAttribute("listPro", listPro);
		
		logger.info("findByV+++++++++++");
		String marks = (String) request.getSession().getAttribute("marks");
		try {
			String hql = "  from VerifyOrderEmployee v where v.verifyOrder.ordertype.mark='CSDN'";
			List listV = this.checkdao.findByObjhql(hql);
			if(listV.size() <= 0)
			{
				request.setAttribute("message", "no");
			}
		}catch (Exception e) {
			logger.error("加载审批流程...");
		}
		finally
		{
			request.getSession().removeAttribute("marks");
		}
		
		return "addUI";
	}
	
	//添加资源核实单
	public String addResource() throws Exception
	{
		//地区
		String cityid = request.getParameter("citys");
		//机房
		String eleid = request.getParameter("eles");
		//商品
		String pid = request.getParameter("pids");
		//得到当前的登入人
		//参数如果为空
		String strDemo = request.getParameter("str");
		
			//得到city
		City city = new City();
		if(!"".equals(cityid) && !cityid.equals("-1"))
		{
			city.setId(new Integer(cityid));
		}
		this.tresourcecheck.setCity(city);
		//得到机房
		Depot depot = new Depot();
		if(!eleid.equals("") && !eleid.equals("-1"))
		{
			depot.setId(new Integer(eleid));
		}
		this.tresourcecheck.setDepot(depot);
		//先给默认的
		Sale_goods saleGoods = new Sale_goods();
		if(!pid.equals("") && !pid.equals("-1"))
		{
			
			saleGoods.setSgId(new Integer(pid));
		}
		this.tresourcecheck.setSaleGoods(saleGoods);
//		//得到资源类型
//		Model model = new Model();
//		if(!modelid.equals("") && !modelid.equals("-1"))
//		{
//			model.setModel(new Integer(modelid));
//		}
//		this.tresourcecheck.setModel(model);
		
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		this.tresourcecheck.setEmpid(employee);
		
		
		Employee employee3 = null;
		this.tresourcecheck.setEmployee(employee3);
		this.tresourcecheck.setIsstate("0");
		this.tresourcecheck.setAudtitingFlag(0);
		logger.info("_+++++++++:"+tresourcecheck.getAudtitingFlag());
		this.checkdao.add(tresourcecheck);
		//得到单据类型编号
		Object obj = request.getSession().getAttribute("marks");
		String makes = "";
		//添加审批记录
		if(obj !=null)
		{
			makes= obj.toString();
		}
		int marker = audBussiness.addAuditingOrderRC("CSDN", this.tresourcecheck.getRvid(), "Tresourcecheck", "");
//		response.setCharacterEncoding("utf-8");
//		if(marker == 0)
//		{
//			response.getWriter().print("0");
//		}else if (marker ==2)
//		{
//			response.getWriter().print("2");
//		}else
//		{
//			response.getWriter().print("1");
//		}
		//清空缓存
		request.getSession().removeAttribute("marks");
//		
		System.out.println("aaaa");
		return "addsuccess";
	}

	public String findByV()
	{
		logger.info("findByV+++++++++++");
		String strDemo1 = request.getParameter("strDemo1");
		try {
			String andhql = "and verifyOrder.ordertype.mark='"+strDemo1+"'";
			List list = this.audBussiness.someauditingOrder(andhql);
			
			response.setCharacterEncoding("utf-8");
			if(list !=null && list.size()>0)
			{
				response.getWriter().print("2");
			}
			else
			{
				response.getWriter().print("0");
			}
		} catch (Exception e) {
			logger.error("findByV++ResourceCheckAction报错");  
		}
		return null;
	}
	
	/*
	 * 分页查询资源核实单
	 */
	public String select()
	{
		try {
			String hql = "from Tresourcecheck as trc where 1=1 ";
			
//			/核单编号
			if(rvid !=null && !rvid.equals(""))
			{
				hql += " and trc.rvid like '%"+rvid+"%'";
				request.setAttribute("rvid",rvid);
			}
			//申请人
			if(hidename !=null && !hidename.equals(""))
			{
				String str = URLDecoder.decode(hidename, "utf-8");
				hql+=" and trc.empid.name like '%"+str+"%'";
				request.setAttribute("empname", str);
			}
			
			hql += " order by trc.id desc";
			
			//pageNo
			String pageNo=request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
			Pages page = this.checkdao.exHqlPages(hql, new Integer(pageNo), 10, null);
			request.setAttribute("pages", page);
			request.setAttribute("listRC", page.getPageList());
			
			//查询所有的资源类型
			List listModel = this.checkdao.find("Model");
			request.setAttribute("listModel",listModel);
			
		} catch (Exception e) {
			logger.error("ResourceCheckAction++++select");
		}
		
		return "list";
	}
	
	/*
	 * 资源核实单详情 
	 */
	public String detailRC()
	{
		try {
			Employee employee = (Employee) request.getSession().getAttribute("emp");
			String rcid = request.getParameter("rcid");
			Cookies ck = new Cookies();
			String hql = "from Tresourcecheck as trc where 1=1";
			if(!"".equals(rcid))
			{
				hql += " and trc.id ="+new Integer(rcid);
			}
			List listRC = this.checkdao.findByObjhql(hql);
			if(listRC != null && listRC.size()>0)
			{
				Tresourcecheck trc = (Tresourcecheck) listRC.get(0);
				request.setAttribute("trc", trc);
				request.setAttribute("contents",trc.getConent());
				if(trc.getAudtitingFlag() ==0)
				{
					request.setAttribute("mark", "mark");
				}
				String empid=ck.getCookie(request, "employeeId");
				boolean flag = this.audBussiness.checkemp2(trc.getRvid(), empid);
				if(flag == true)
				{
					request.setAttribute("emptrue", "emptrue");
				}
				else{
					request.setAttribute("emptrue", "emptrue1");
				}
				
				String addhql2=" and rvid='"+trc.getRvid()+"'";
				List audList=audBussiness.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
				if(null != audList && audList.size()>0)
				{
					String depid = ck.getCookie(request, "departmentId");
					for(int i=0; i<audList.size(); i++)
					{
						AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
						request.setAttribute("aot", aot);
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
				//查询商品的详细
				Integer sgid = trc.getSaleGoods().getSgId();
				String hqlsg ="from Sale_goods as sg where 1=1 and sg.sgId ="+new Integer(sgid);
				Sale_goods goods =(Sale_goods) checkdao.findByObjhql(hqlsg).get(0);
				request.setAttribute("sg", goods);
			}
			
		} catch (Exception e) {
			logger.error("ResourceCheckAction+++++++++detailRC");
			e.printStackTrace();
		}
		return "detail";
	}
	
	/*
	 * 删除操作
	 */
	public String delRC() throws Exception
	{
		String rcid = request.getParameter("rcid");
		if(null != rcid && !("").equals(rcid))
		{
			String hqlRC = "from Tresourcecheck where id="+new Integer(rcid);
			List listRC = this.checkdao.findByObjhql(hqlRC);
			if(null != listRC && listRC.size()>0)
			{
				Tresourcecheck trc = (Tresourcecheck) listRC.get(0);
				String dela = "delete from AuditingOrderTab where rvid ='"+trc.getRvid()+"'";
				boolean flag1 = this.checkdao.updateOrDeletehql(dela);
			}
			String hql = "delete from Tresourcecheck where id="+new Integer(rcid);
			boolean flag = this.checkdao.updateOrDeletehql(hql);
			response.setCharacterEncoding("utf-8");
			if(flag == true)
			{
				response.getWriter().print("1");
			}
			else
			{
				response.getWriter().print("2");
			}
		}
		return null;
	}
	
	/*
	 * 回复
	 */
	public String resultUIRC()
	{
		try {
			logger.info("+++++++++rssultRC");
			//要回复的对象
			String rcid = request.getParameter("rcid");
			
			String hqlRC = "from Tresourcecheck where id="+new Integer(rcid);
			List listRC = this.checkdao.findByObjhql(hqlRC);
			Tresourcecheck trc = (Tresourcecheck) listRC.get(0);
			request.setAttribute("trc", trc);
			
			//当前登入人
			Employee employee = (Employee)request.getSession().getAttribute("emp");
			request.setAttribute("emps", employee);
			
			//查询商品的详细
			Integer sgid = trc.getSaleGoods().getSgId();
			String hqlsg ="from Sale_goods as sg where 1=1 and sg.sgId ="+new Integer(sgid);
			Sale_goods goods =(Sale_goods) checkdao.findByObjhql(hqlsg).get(0);
			request.setAttribute("sg", goods);
			
		} catch (Exception e) {
			logger.error("resourceAction+++++resultRC");
		}
		return "returnUIRC";
	}
	
	/*
	 * 要回复的内容
	 */
	public String resultRC()
	{
		//得到当前的登入人
		Employee employee = (Employee)request.getSession().getAttribute("emp");
		request.setAttribute("emps", employee);
		
		//得到当前的对象id
		String rcid = request.getParameter("rcid");
		
		//得到内容
		String content = request.getParameter("content");
		String str = "";
		if(null !=content && !"".equals(content))
		{
			try {
				str = URLDecoder.decode(content,"utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		
		boolean flag = this.checkdao.returnupdateRC(employee.getId(), str, new Integer(rcid));
		if(flag ==true)
		{
			logger.info("return success");
			String hqls = "update Tresourcecheck set isstate=2 where id="+rcid+"";
			boolean flag1 = this.checkdao.updateOrDeletehql(hqls);
			if(flag1 ==true)
			{
				logger.info("+++++++++update isstate success ");
			}
		}
		
		return "returnsuccess";
	}
	
	/*
	 * 修改请求
	 */
	public String updateUIRC()
	{
		try {
			logger.info("++++++++++++++++++updateRC"+ResourceCheckAction.class.getName());
			logger.info("+++++++++rssultRC");
			String rcid = request.getParameter("rcid");
			
			String hqlRC = "from Tresourcecheck where id="+new Integer(rcid);
			List listRC = this.checkdao.findByObjhql(hqlRC);
			Tresourcecheck trc = (Tresourcecheck) listRC.get(0);
			request.setAttribute("trc", trc);
			
			//仓库
			List listelehouse = this.checkdao.find("Depot");
			request.setAttribute("listeleHouce", listelehouse);
			//地区
			List listCity = this.checkdao.find("City");
			request.setAttribute("listCity", listCity);
			//产品
			List listPro = this.checkdao.find("Sale_goods");
			request.setAttribute("listPro", listPro);
			//资源类型
			List listModel = this.checkdao.find("Model");
			request.setAttribute("listModel",listModel);
			
		} catch (Exception e) {
			logger.error("resourceAction++++updateRC");
		}
		return "addUI";
	}
	
	/*
	 * 修改请求
	 */
	public String updateRC()
	{
		try {
			logger.info("++++"+ResourceCheckAction.class.getName()+".updateRC");
			String rcid = request.getParameter("rcid");
			String audtitingFlag = request.getParameter("audtitingFlag");
			
			String hqlRC = "from Tresourcecheck where id="+new Integer(rcid);
			List listRC = this.checkdao.findByObjhql(hqlRC);
			Tresourcecheck trc = (Tresourcecheck) listRC.get(0);
			
			//地区
			String cityid = request.getParameter("citys");
			//机房
			String eleid = request.getParameter("eles");
			//产品
			String pid = request.getParameter("pids");
			//申请人
			String empid = request.getParameter("empid");
			
			//地区
			City city = new City();
			if(!"".equals(cityid) && !cityid.equals("-1"))
			{
				city.setId(new Integer(cityid));
			}else
			{
				city.setId(trc.getCity().getId());
			}
			this.tresourcecheck.setCity(city);
			//得到机房
			Depot depot = new Depot();
			if(!eleid.equals("") && !eleid.equals("-1"))
			{
				depot.setId(new Integer(eleid));
			}else
			{
				depot.setId(trc.getDepot().getId());
//				electHouse.setElectId(trc.getElectHouse().getElectId());
			}
			this.tresourcecheck.setDepot(depot);
			
//			Product product = new Product();
			Sale_goods saleGoods = new Sale_goods();
			if(!pid.equals("") && !pid.equals("-1"))
			{
				saleGoods.setSgId(new Integer(pid));
			}
			else
			{
				saleGoods.setSgId(trc.getSaleGoods().getSgId());
//				product.setId(trc.getProduct().getId());
			}
			this.tresourcecheck.setSaleGoods(saleGoods);
			//得到资源类型
			
			
			Employee employee = new Employee();
			employee.setId(new Integer(empid));
			this.tresourcecheck.setEmpid(employee);
			
			//先给默认的
			
			this.tresourcecheck.setId(new Integer(rcid));
			this.tresourcecheck.setAudtitingFlag( new Integer(audtitingFlag));
			this.tresourcecheck.setIsstate("0");
			
			logger.info("+++update");
			//修改
			boolean flag = this.checkdao.updateRC(tresourcecheck);
			
			if(flag == true)
			{
				logger.info("success");
			}
			
			//申请人
			logger.info("+++++++++++update");
		
			
			
		} catch (Exception e) {
			logger.error("++++"+ResourceCheckAction.class.getName()+".updateRC");
		}
		return "updatesuccess";
	}
	
	
	
	
	public String demos()
	{
		
		logger.info(request.getMethod());	
		if("post".equals(request.getMethod()))
		{
			logger.info("this is post submit");
		}
		else
		{
			logger.info("this is url submit");
		}
		return "";
	}
	
	
	public Object getModel() {
		// TODO Auto-generated method stub
		return null;
	}
	
	public static void main(String[] args) {
		
	}
	public String getHidename() {
		return hidename;
	}

	public void setHidename(String hidename) {
		this.hidename = hidename;
	}

	public String getRvid() {
		return rvid;
	}

	public void setRvid(String rvid) {
		this.rvid = rvid;
	}	
}

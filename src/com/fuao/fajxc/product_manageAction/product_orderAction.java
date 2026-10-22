package com.fuao.fajxc.product_manageAction;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import java.util.List;

import javassist.compiler.Javac;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.dialect.function.ClassicCountFunction;

import com.fuao.fajxc.product_manageDao.prodect_OrderDao;
import com.fuao.fajxc.product_manageService.Product_orderService;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.HDThumb;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.util.StrUtil;
import com.fuao.fajxc.util.UtilCommon;
import com.fuao.fajxc.util.generateNo.FileEveryDaySerialNumber;
import com.fuao.fajxc.vo.AuditingOrderTab;
import com.fuao.fajxc.vo.Employee;
import com.fuao.fajxc.vo.GoodsClass_expand;
import com.fuao.fajxc.vo.Goods_dict;
import com.fuao.fajxc.vo.PurOrder;
import com.fuao.fajxc.vo.Sale_goods;
import com.ibm.icu.text.DateFormat;
import com.ibm.icu.text.SimpleDateFormat;
import com.fuao.fajxc.vo.Sale_orders;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

public class product_orderAction extends ActionSupport  implements ModelDriven, ServletRequestAware,
		ServletResponseAware {
	private Logger logger = Logger.getLogger(product_orderAction.class);
	private HttpServletResponse response;
	private HttpServletRequest request;
	private String orderid;
	private Product_orderService product_CommentService;
	private List gods_dtList = new ArrayList();
	private List gods_dtListms = new ArrayList();
	private int parentid1=0;
	private Logger log=Logger.getLogger(ClassManageAction.class);
	FileEveryDaySerialNumber serial = new FileEveryDaySerialNumber(5, "EveryDaySerialNumber.dat");
	
	private  prodect_OrderDao pdao;
	
	private  Sale_goods sa;
	
	private static final long serialVersionUID = 1L;
	private File fileupload; // 和JSP中input标记name同名
	private String imageUrl;
	private String attachmentUrl;
	private String fileRealName;
	private String fileuploadFileName; 
	private String orderId;//定单ID
	private String zt;//状态
	private String pgno;
	private  List< GoodsClass_expand> goods_class_expand ;
	private  List< Goods_dict> goods_dict;
	private String gradeClass="";
	private String valuep= "";
	Cookies ck = new Cookies();
	private String t1;
	private String t2;
	private String cxprice;
	private String sgid;
	
	public List<Goods_dict> getGoods_dict() {
		return goods_dict;
	}
	public void setGoods_dict(List<Goods_dict> goodsDict) {
		goods_dict = goodsDict;
	}
	public List<GoodsClass_expand> getGoods_class_expand() {
		return goods_class_expand;
	}
	public void setGoods_class_expand(List<GoodsClass_expand> goodsClassExpand) {
		goods_class_expand = goodsClassExpand;
	}
	public String getAttachmentUrl() {
		return attachmentUrl;
	}
	public void setAttachmentUrl(String attachmentUrl) {
		this.attachmentUrl = attachmentUrl;
	}
	public String getFileRealName() {
		return fileRealName;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getFileuploadFileName() {
		return fileuploadFileName;
	}
	public void setFileuploadFileName(String fileuploadFileName) {
		this.fileuploadFileName = fileuploadFileName;
	}
	public File getFileupload() {
		return fileupload;
	}
	public void setFileupload(File fileupload) {
		this.fileupload = fileupload;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public Sale_goods getSa() {
		return sa;
	}
	public void setSa(Sale_goods sa) {
		this.sa = sa;
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response=arg0;
	}
	public void setServletRequest(HttpServletRequest arg0) {
		this.request=arg0;
	}
	
	public prodect_OrderDao getPdao() {
		return pdao;
	}

	public void setPdao(prodect_OrderDao pdao) {
		this.pdao = pdao;
	}
	
	public Product_orderService getProduct_CommentService() {
		return product_CommentService;
	}

	public void setProduct_CommentService(
			Product_orderService productCommentService) {
		product_CommentService = productCommentService;
	}




	public Object getModel() {
		return null;
	}

	/**
	 * 得到订单信息---
	 * 
	 * @return
	 */
	
	/*  orderId定单id,zt 状态 
	 *  改变定单的审核状态  14032
	 */
	public String getsale() {
		System.out.println("进入");
		try {
			response.setCharacterEncoding("GBK");
			request.setCharacterEncoding("GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//request.getSession().removeAttribute("pageNo");
		try {
			String 	soNums = request.getParameter("sonums")!=null?new String(request.getParameter("sonums").getBytes(
			"iso-8859-1"), "UTF-8"):"0";
			String	 sgnames = request.getParameter("sgname")!=null?new String(request.getParameter("sgname").getBytes(
			"iso-8859-1"), "GBK"):"0";
			String	sgcode = request.getParameter("Sgcode")!=null?new String(request.getParameter("Sgcode").getBytes(
			"iso-8859-1"), "GBK"):"0";
		

		Integer soStat = request.getParameter("soStat") != null ? Integer
				.parseInt(request.getParameter("soStat")) : -1;
		String 
		stime = request.getParameter("sgtime") != null ? request
				.getParameter("sgtime") : "0";
		String pageNo1 = request.getParameter("pageNo") != null ? request
				.getParameter("pageNo") : "1";

		String hql = "from Sale_orders where 1=1 ";

		if (!soNums.equals("0") && !soNums.equals("")) {
			hql = hql + "and soNums like '%" + soNums + "%'";
			request.setAttribute("soNums", soNums);
		}

		if (soStat != -1) {
			hql = hql + " and soStat=" + soStat;
			request.setAttribute("soStat", soStat);
		}else{
			request.setAttribute("soStat", "-1");
			
		}
		if (!stime.equals("0") && !stime.equals("")) {
			hql = hql + "and soOrderTime like '%" + stime + "%'";
			request.setAttribute("stime", stime);
		}
		int pageNo = Integer.parseInt(pageNo1);
		int pageSize = 4;
		String hql1 = "from SaleGoods_mids where 1=1 ";
		String idhql = "select  sale_orders.soId from SaleGoods_mids where 1=1 ";
		if (!sgnames.equals("0") && !sgnames.equals("")) {
			idhql = idhql + " and sale_goods.sgname like '%" + sgnames + "%'";
			request.setAttribute("sgnames", sgnames);
		}
		if (!sgcode.equals("0") && !sgcode.equals("")) {
			idhql = idhql + " and sale_goods.sgcode like '%" + sgcode + "%'";
			request.setAttribute("sgcode", sgcode);
		} 
		//idhql = idhql+" and sale_goods.sgStat <> '2'";
		List list3 = product_CommentService.selectByall(idhql);
		String idstr = "";
		if (list3.size() != 0) {
			for (int i = 0; i < list3.size(); i++) {
				idstr = idstr + list3.get(i).toString() + ",";
			}
			
		}
		hql = hql + " and soId in(" + idstr + "-1) order by soId desc";
		System.out.println(idhql);
		System.out.println(hql);
		List list1 = product_CommentService.selectByall(hql1);// 订单列表

		Pages pg = product_CommentService.paginationQuery(hql, pageNo,
				pageSize, null);
		List solistList = pg.getPageList();
		List<Sale_orders> solist1 = solistList;
		System.out.println(solist1);
		int pgall = pg.getAllCount();// 总行数
		int gageNoall = pgall / 4;// 总页数
		
		if (pgall % 4 != 0) {
			gageNoall = gageNoall + 1;
		}
		request.setAttribute("pageNo1", pageNo1);
		request.setAttribute("pageNo", pageNo);
		request.getSession().setAttribute("pageNo1", pageNo);
		request.setAttribute("gageNoall", gageNoall);
		request.setAttribute("solist1", solist1);
		request.setAttribute("list1", list1);

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "allsale";

	}

	/*
	 * orderId定单id,zt 状态 改变定单的审核状态 14032
	 */
	public void changezt() {
		String oid = orderId;// 定单id
		int ddzt = zt != null ? Integer.parseInt(zt) : 0;// 定单状态
		String sql = "update SaleGoods_mids set soCheckStat=" + zt
				+ " where sgmId=" + oid + "";
		product_CommentService.updatsql(sql);
		response.setContentType("textml;charset=GBK");
		String sc = (String) request.getSession().getAttribute("pageNo");
		try {
			response.getWriter().print(sc);

		} catch (IOException e) {
			// TODO Auto-generated catch block+
			e.printStackTrace();
		}

	}

	/**
	 * 进入订单详情页面
	 * 
	 * @return
	 */
	public String showorder() {
		Integer id = request.getParameter("orderid") != null ? Integer
				.parseInt(request.getParameter("orderid")) : 0;
		String goodsNo=request.getParameter("soNums");
		String hql2="from Sale_orders ";		
		String hql1 = "from SaleGoods_mids where 1=1";
		List list1 = product_CommentService.selectByall(hql1);//关联表列表
		List list2 = product_CommentService.selectByall(hql2);//订单列表
		String id1=request.getParameter("id");//传过来ID
		String info = request.getParameter("info");//获得info
	
//			String apparray=go.getApplyArray();
//			if(apparray!=null&&apparray!=""){
//				List list1=requisitioningBusssiness.getObjList("from ApplyBuy where id in ("+apparray+")");
//				System.out.println("listSize="+list1.size());
//				request.setAttribute("applyList", list1);
//			}
			
				
				if(goodsNo!=null){
                  String addhql2=" and orderNo='"+goodsNo+"'";
					System.out.println(goodsNo+"====");
					List audList=product_CommentService.someauditingOrder(addhql2);
					
					
					request.setAttribute("auditingList", audList);
					
					if(null != audList && audList.size()>0){
						
						String depid = ck.getCookie(request, "departmentId");
						
						for(int i=0; i<audList.size(); i++){
							
							AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
							
							if(aot.getDepartment().getId() == Integer.parseInt(depid) && aot.getAuditingFlag() ==0 ){
								
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
			
			String empid=ck.getCookie(request, "employeeId");
			
			//确定由谁审核
			boolean flag =	product_CommentService.checkemp(goodsNo, empid);
			if(flag){
				request.setAttribute("mark", "mark");
			}else{
				request.setAttribute("mark", "no");
			}
			boolean flag1=product_CommentService.checkemp1(goodsNo, empid);
			System.out.println(goodsNo+"    "+empid);
			if(flag1){
				request.setAttribute("quanxian", "quanxian");
			}
			if(goodsNo!=null){
				String addhql2=" and orderNo='"+goodsNo+"'";
				List audList=product_CommentService.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
			}
		

		request.setAttribute("list2", list1);
		request.setAttribute("list1", list2);
		request.setAttribute("orderid1", id);
		return "showorder";

	}
	 public String add(){		 
		 Sale_goods sg=new Sale_goods();
		 Goods_dict goods_dict=new Goods_dict();
		 //参数商品类目ID
		 int goods_dictid=Integer.parseInt(request.getParameter("goods_dictid"));
		 goods_dict.setGdId(goods_dictid);
		 //商品编码
			String sgcode  =  request.getParameter("sgcode");
			int sgCheckGoods=0;
			/**添加审核流程*/
			//int marker = product_CommentService.addAuditingOrder2("sp",sgcode,"Sale_goods",ck.getCookie(request, "filialemark"));
			int marker = product_CommentService.addAuditingOrder2("xxttjsp",sgcode,"Goods_dict",ck.getCookie(request, "filialemark"));
			System.out.println(marker+"========");
			//此方法废弃
			//Map map = (Map)ActionContext.getContext().get("map");
			//ServletActionContext.getRequest().setAttribute("option", map);
			
			String   sgname=  request.getParameter("sgname");//商品名称
     		String  sgNorms =  request.getParameter("sgNorms");//商品规格
			String  sgUnit =  request.getParameter("sgUnit");//商品单位
			String  sgUsername =  request.getParameter("sgUsername");//录入人姓名
			int  sgStat =  Integer.parseInt(request.getParameter("sgStat"));//商品初始状态为0 2为已发布
			String  sgtime =  request.getParameter("sgtime");//创建时间
			String sgPuttime=request.getParameter("sgPuttime");//
			String sgDetails =request.getParameter("sgDetails");//商品描述
			Double sgPrice=Double.parseDouble((request.getParameter("sgPrice")));//商品价格
			Integer nums1=Integer.parseInt(request.getParameter("sgnumbers"));//商品总数量
			String sgImg=null;
			String checkStr=null;
			String  img1 = request.getParameter("img1");//图片地址
			String  img2 = request.getParameter("img2");
			String  img3 = request.getParameter("img3");
			String  img4 = request.getParameter("img4");
			String  img5 = request.getParameter("img5");
			String chk1=request.getParameter("sgchecks");
			String chk2=request.getParameter("sgchecks1");
			if(chk1 != null && chk1.equals("1")){
				checkStr=Integer.parseInt(chk1)+","+Integer.parseInt(chk2);
			}else{
				checkStr=chk1;
			}
			if(img1!=null && !img1.equals("")){
			sgImg="|"+img1;
			}
			if(img2!=null && !img2.equals("")){
				sgImg+="|"+img2;
				}
			if(img3!=null && !img3.equals("")){
				sgImg+="|"+img3;
				}
			if(img4!=null && !img4.equals("")){
				sgImg+="|"+img4;
				}
			if(img5!=null && !img5.equals("")){
				sgImg+="|"+img5;
				}
//			商品的特殊属性
			
			String inputvalue=request.getParameter("inputvalue");//文本框字符串
			String selectvalue=request.getParameter("selectvalue");//下拉框字符串
			String radiovalue=request.getParameter("radiovalue");//单选框字符串
			String checkboxvalue=request.getParameter("checkboxvalue");//多选框字符串
			String productgevalue=request.getParameter("productgevalue");//商品规格
			String photo=request.getParameter("erweima");//二维码
			System.out.println(inputvalue+" ");
			System.out.println(selectvalue+" ");
			System.out.println(radiovalue+" ");
			System.out.println(checkboxvalue+" ");
			//组合商品属相用 不同类型用@隔开
			StringBuffer sgAttribute = new StringBuffer();
			if(inputvalue !=null && inputvalue.trim() != "")
			sgAttribute =sgAttribute.append(inputvalue);
			sgAttribute =getStringLink(sgAttribute,selectvalue);
			sgAttribute =getStringLink(sgAttribute,radiovalue);
			sgAttribute =getStringLink(sgAttribute,checkboxvalue);
			String sgAttribute2= sgAttribute.toString();
			//都为空 不考虑  只有一个类型  第一个为空 中间为空 最后一个为空
			//单独select的情况测试通过
//			if(sgAttribute2.endsWith("@"))
//				sgAttribute2= sgAttribute2.substring(0, sgAttribute2.length()-1);
			 sg.setSgAttribute(sgAttribute2);//保存商品属性
			 sg.setSgcode(sgcode);
			 sg.setSgname(sgname);
			 sg.setSgspecifications(productgevalue);
			 sg.setSgNorms(sgNorms);
			 sg.setSgUnit(sgUnit);
			 sg.setSgUsername(sgUsername);
			 sg.setSgStat(sgStat);
			 sg.setSgImg(sgImg);
			 sg.setSgtime(sgtime);
			 sg.setErweima(photo);
			 sg.setSgnumbers(nums1);
			 sg.setSgInventory(nums1);
			 sg.setSgchecks(checkStr);
			 if(sgPuttime!=null){
			 sg.setSgPuttime(sgPuttime);
			 }
			 sg.setSgDetails(sgDetails);
			 sg.setGoods_dict(goods_dict);
			 sg.setSgPrice(sgPrice);
			 //设置促销为默认
			 sg.setIsActivity("0");
			 sg.setActivityPrice(0.0);
			 sg.setActivityStart("");
			 sg.setActivityEnd("");
//			 sg.setSgCheckGoods(sgCheckGoods);
			 
			 if(sgStat==2){
				 sg.setSgPuttime(sgtime); 
			 }else{
				 sg.setSgPuttime(""); 
			 }

				try {
					
				String modify=	request.getParameter("modify");
					if(modify!=null){
						 int id=Integer.parseInt(request.getParameter("sgid"));
							sg.setSgId(id);
						 product_CommentService.update(sg);	//更新
					}
					else{
					product_CommentService.save(sg);
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
/////////////////////////////////////////////
					request.getSession().removeAttribute("sgcode");
					request.getSession().removeAttribute("sgname1");
					request.getSession().removeAttribute("ctime");
					request.getSession().removeAttribute("ftime");

				String pageNo = request.getParameter("pageNo") == null ? "1" : request
						.getParameter("pageNo");
				// String contractNo = request.getParameter("cname");
				String contractNo = (String) request.getSession()
						.getAttribute("cname2");

				System.out.println(contractNo + "---------------------");

				String hql = " from Sale_goods where 1=1  ";

				if (contractNo != null && !contractNo.equals("")) {

					hql += " and contractNo like '%" + contractNo + "%'";
				}
				hql += " and sgStat="+sgStat+" order by id desc";
				Pages pages = product_CommentService.paginationQuery(hql, Integer.parseInt(pageNo), 10,null);
//				Map map = (Map) ActionContext.getContext().get("map");
				request.getSession().setAttribute("pages", pages);
				request.setAttribute("pages", pages);
//				request.getSession().setAttribute("option", map);
				return "reTest";  

  }
	 

	 private StringBuffer getStringLink(StringBuffer sgAttribute, String inputvalue) {
		
		 if(inputvalue == null || (inputvalue.trim()).equals("")){
			 return sgAttribute;
		 }
		 return  sgAttribute.append("@").append(inputvalue);
		
	}
	public void release() throws IOException{
		   int id=Integer.parseInt(request.getParameter("id"));
		   Date date = new Date();
		   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		   String str=  sdf.format(date);
		  int i= product_CommentService.updateUpdate(str,id);
		  if(i==1){
			response.getWriter().print(str);  
		  }
		  
	 } 
	 public  void shenhe() throws IOException{
		 int id=Integer.parseInt(request.getParameter("id"));
		   String str="1"; 
		  int i= product_CommentService.updateUpdate(str,id);
		  if(i==1){
			response.getWriter().print(str);
		  }
		 
	 }
	 
	 public void undercarriage() throws IOException{
		 String number=request.getParameter("seeyou");
		 int id=Integer.parseInt(request.getParameter("id"));
		 int i=0;
		  if(number!=null){
			  i=  product_CommentService.undercarriageup(id);
		  }else{
			  request.getSession().setAttribute("mflag", 0);
			  i=  product_CommentService.undercarriage(id,"xxttjsp","Goods_dict",ck.getCookie(request, "filialemark"));
			  
		  }
    	   if(i==1){
    		   response.getWriter().print(1);
    	   }else{
    		   response.getWriter().print(0);
    	   }
    	  
	 }
//	 
//	 
//
//	public String List() {
//
//		String sgcode=request.getParameter("sgcode");
//		String sgname=request.getParameter("sgname1");
//		String ctime=request.getParameter("ctime");
//		String ftime=request.getParameter("ftime");
//		String s=request.getParameter("s");
//		String v=request.getParameter("v");
//		if(s!=null){
//         request.getSession().setAttribute("sgcode", sgcode);
//         request.getSession().setAttribute("sgname1", sgname);
//         request.getSession().setAttribute("ctime", ctime);
//         request.getSession().setAttribute("ftime", ftime);
//		}
//		if(v!=null){
//			request.getSession().removeAttribute("sgcode");
//			request.getSession().removeAttribute("sgname1");
//			request.getSession().removeAttribute("ctime");
//			request.getSession().removeAttribute("ftime");
//		}
//		System.out.println(sgcode+" 1"+sgname+" 1"+ctime+" 1"+ftime);
//		String pageNo = request.getParameter("pageNo") == null ? "1" : request
//				.getParameter("pageNo");
//		String contractNo = (String) request.getSession()
//				.getAttribute("cname2");
//		String hql = " from Sale_goods where 1=1  ";
//		if (contractNo != null && !contractNo.equals("")) {
//			hql += " and contractNo like '%" + contractNo + "%'";
//		}
//		if(sgcode!=null&&sgcode!=""){
//			hql+="and sgcode like '%"+sgcode+"%'";
//		}
//		if(sgname!=null&&sgname!=""){
//			hql+="and sgname like '%"+sgname+"%'";
//		}
//		if(ctime!=null&&ctime!=""){
//			hql+="and sgtime like '%"+ctime+"%'";
//		}
//		if(ftime!=null&&ftime!=""){
//			hql+="and sgPuttime ='%"+ftime+"%'";	
//		}
//		hql += "and sgStat=2  order by id desc";
//		Pages pages = pdao.paginationQuery(hql, Integer.parseInt(pageNo), 10,null);
//		request.getSession().setAttribute("pages", pages);
//		request.setAttribute("pages", pages);
//		return "list0";
//	}	
	 public String classSelect(){
		 log.info("select...");
		 Map mpMap = new HashMap();
		 StringBuffer sbf = new StringBuffer();
//		 String cont="";
//     	try {
//			cont = java.net.URLDecoder.decode(sa.getSelname(),"utf-8");
//		} catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		 String cont=sa.getSelname();
		 List clist=product_CommentService.selectByall("from Goods_dict");
		 List clt=product_CommentService.selectByall("from Goods_dict where gdnames like '%"+cont+"%'");
		 log.info("clt="+clt.size());
		 for (Iterator iterator = clt.iterator(); iterator.hasNext();){
			 Goods_dict gods_dts = (Goods_dict) iterator.next();
			 if(gods_dts.getGdSuperId()!=null){
				 getSeltClass(gods_dts.getGdSuperId());
				 sbf.append(gradeClass).append(gods_dts.getGdnames());
				 //String []arrs=ppm.split(",");
				 mpMap.put(gods_dts.getGdId(),sbf.toString());
				 log.info("sbf="+sbf.toString());
				 sbf.delete(0,sbf.length());
				 gradeClass="";
			 }else{
			     mpMap.put(gods_dts.getGdId(),gods_dts.getGdnames());
			 }
			 
		}
		 request.setAttribute("gods_dt",mpMap);
		 request.setAttribute("good_list", clist);
		 return "classSelt";
		// return "alter";
	 }
	 public void getSeltClass(int ids){
		 List clt1=product_CommentService.selectByall("from Goods_dict where gdId="+ids);
		 Goods_dict gdts = (Goods_dict)clt1.get(0);
	     gods_dtList.add(gdts.getGdnames());
		 if(gdts.getGdSuperId()!=null){
			 gods_dtListms.add(gdts.getGdId());
			 getSeltClass(gdts.getGdSuperId());//这里不能用return ,不然会返回到这里
		 }else{
			 for (int i=(gods_dtList.size()-1);i>=0;i--) {
				 log.info("i="+gods_dtList.get(i));
				 gradeClass+=gods_dtList.get(i)+"/";
			 }
			 gods_dtList.removeAll(gods_dtList);
			 gods_dtListms.removeAll(gods_dtListms);
		 }
		 log.info("gradeClass="+gradeClass);
	 }
	 public String List1(){
		     log.info("list1..");
			String sgcode=request.getParameter("sgcode");
			String sgname=request.getParameter("sgname1");
			String ctime=request.getParameter("ctime");
			String ftime=request.getParameter("ftime");
			String s=request.getParameter("s");
			String v=request.getParameter("v");
			log.info(sgcode+sgname+ctime+ftime+s+v);
			if(s!=null){
	         request.getSession().setAttribute("sgcode", sgcode);
	         request.getSession().setAttribute("sgname1", sgname);
	         request.getSession().setAttribute("ctime", ctime);
	         request.getSession().setAttribute("ftime", ftime);
			}
			if(v!=null){
				request.getSession().removeAttribute("sgcode");
				request.getSession().removeAttribute("sgname1");
				request.getSession().removeAttribute("ctime");
				request.getSession().removeAttribute("ftime");
			}
			log.info(sgcode+" 1"+sgname+" 1"+ctime+" 1"+ftime);
			String pageNo = request.getParameter("pageNo") == null ? "1" : request
					.getParameter("pageNo");
			String contractNo = (String) request.getSession()
					.getAttribute("cname2");
			log.info("liit1-dd");
			String hql = " from Sale_goods where 1=1  ";
			if (contractNo != null && !contractNo.equals("")) {
				hql += " and contractNo like '%" + contractNo + "%'";
			}
			if(sgcode!=null && !sgcode.equals("")){
				hql+="and sgcode like '%"+sgcode+"%'";
			}
			if(sgname!=null && !sgname.equals("")){
				hql+="and sgname like '%"+sgname+"%'";
			}
			if(ctime!=null && !ctime.equals("")){
				hql+="and sgtime like '%"+ctime+"%'";
			}
			if(ftime!=null && !ftime.equals("")){
				hql+="and sgPuttime like '%"+ftime+"%'";	
			}
			hql += "and sgStat =1   order by id desc";
			log.info("list1-"+hql);
			Pages pages = pdao.paginationQuery(hql, Integer.parseInt(pageNo), 10,null);
			log.info("list1-"+pages);
			request.getSession().setAttribute("pages", pages);
			request.setAttribute("pages", pages);
			  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 

			  java.util.Date currentTime = new java.util.Date();//得到当前系统时间 

			  String date1 = formatter.format(currentTime); //将日期时间格式化 
            request.setAttribute("date1", date1);
			return "list1";
		}	
	 
	 public String List2(){
			String sgcode=request.getParameter("sgcode");
			String sgname=request.getParameter("sgname1");
			String ctime=request.getParameter("ctime");
			String ftime=request.getParameter("ftime");
			String s=request.getParameter("s");
			String v=request.getParameter("v");
			if(s!=null){
	         request.getSession().setAttribute("sgcode", sgcode);
	         request.getSession().setAttribute("sgname1", sgname);
	         request.getSession().setAttribute("ctime", ctime);
	         request.getSession().setAttribute("ftime", ftime);
			}
			if(v!=null){
				request.getSession().removeAttribute("sgcode");
				request.getSession().removeAttribute("sgname1");
				request.getSession().removeAttribute("ctime");
				request.getSession().removeAttribute("ftime");
			}
			System.out.println(sgcode+" 1"+sgname+" 1"+ctime+" 1"+ftime);
			String pageNo = request.getParameter("pageNo") == null ? "1" : request
					.getParameter("pageNo");
			String contractNo = (String) request.getSession()
					.getAttribute("cname2");
			String hql = " from Sale_goods where 1=1  ";
			if (contractNo != null && !contractNo.equals("")) {
				hql += " and contractNo like '%" + contractNo + "%'";
			}
			if(sgcode!=null && !sgcode.equals("")){
				hql+="and sgcode like '%"+sgcode+"%'";
			}
			if(sgname!=null && !sgname.equals("")){
				hql+="and sgname like '%"+sgname+"%'";
			}
			if(ctime!=null && !ctime.equals("")){
				hql+="and sgtime like '%"+ctime+"%'";
			}
			if(ftime!=null && !ftime.equals("")){
				hql+="and sgPuttime ='%"+ftime+"%'";	
			}
			hql += "and sgStat <>1   order by id desc";
			Pages pages = pdao.paginationQuery(hql, Integer.parseInt(pageNo), 10,null);
			request.getSession().setAttribute("pages", pages);
			request.setAttribute("pages", pages);
			return "list2";
		}	
	  
  public String details() throws IOException{
	    String id1=request.getParameter("id");
		int id= Integer.parseInt(id1);
		String goodsNo=request.getParameter("goodsNo");
		String info = request.getParameter("info");//获得info
		if(id1!=null){
			String addhql=" and sgId="+id;
			List list=product_CommentService.selSomeGoods_dict(addhql);
			System.out.println("listSize:"+list.size());
			request.setAttribute("cgoList", list.get(0));
			
			//获得请购单
			Sale_goods go=(Sale_goods) list.get(0);
//			String apparray=go.getApplyArray();
//			if(apparray!=null&&apparray!=""){
//				List list1=requisitioningBusssiness.getObjList("from ApplyBuy where id in ("+apparray+")");
//				System.out.println("listSize="+list1.size());
//				request.setAttribute("applyList", list1);
//			}
			if(null != info && ( info == "info" || info.equals("info"))){
				
				if(goodsNo!=null){
                   String addhql2=" and orderNo='"+goodsNo+"'";
					System.out.println(goodsNo+"====");
					List audList=product_CommentService.someauditingOrder(addhql2);
					
					
					request.setAttribute("auditingList", audList);
					
					if(null != audList && audList.size()>0){
						
						String depid = ck.getCookie(request, "departmentId");
						
						for(int i=0; i<audList.size(); i++){
							
							AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
							
							if(aot.getDepartment().getId() == Integer.parseInt(depid) && aot.getAuditingFlag() ==0 ){
								
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
			String empid=ck.getCookie(request, "employeeId");
			 sa=  (Sale_goods) product_CommentService.saleDoodsById(id);
			//确定由谁审核
			boolean flag =	product_CommentService.checkemp(goodsNo, empid);
			if(flag){
				request.setAttribute("mark", "mark");
			}else{
				request.setAttribute("mark", "no");
			}
			boolean flag1=product_CommentService.checkemp1(goodsNo, empid);
			System.out.println(goodsNo+"    "+empid);
			if(flag1){
				request.setAttribute("quanxian", "quanxian");
			}
			if(goodsNo!=null){
				String addhql2=" and orderNo='"+goodsNo+"'";
				List audList=product_CommentService.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
			}
		}
	   if(sa.getSgchecks().indexOf(",")!=-1){
		   String []strarr=sa.getSgchecks().split(",");
		   sa.setSgchecks1(strarr[0]);
		   sa.setSgchecks2(strarr[1]);
	   }else{
		   sa.setSgchecks1(sa.getSgchecks());
	   }
	   System.out.println("w.......,="+sa.getSgAttribute());
	   String []arrString=sa.getSgAttribute().trim().split("@");
	   Map attributMap=new HashMap();
       for (int j = 0; j < arrString.length; j++) {
			if(!arrString[j].trim().equals("")){
				if(arrString[j].trim().indexOf("&")!=-1){
					String ppString[]=arrString[j].trim().split("&");
					for (int i = 0; i < ppString.length; i++) {
						String mmsString=ppString[i].trim().replace("|", ":");
						String mString[]=mmsString.split(":");
						if(mString.length==4 && !mString[2].trim().equals("undefined") && !mString[3].equals("undefined")){
							attributMap.put(mString[2].trim(),mString[3].trim());
						}else{
						  if(!mString[1].trim().equals("undefined") && !mString[2].equals("undefined")){
						      attributMap.put(mString[1].trim(),mString[2]);
						  }
						}
					}
				}else{
					if(!arrString[j].equals("")){
					String mmsString=arrString[j].trim().replace("|",":");
					String msString[]=mmsString.split(":");
					if(msString.length==3 && !msString[1].trim().equals("undefined") && !msString[2].equals("undefined")){
						attributMap.put(msString[1].trim(),msString[2]);
					}else{
					   if(!msString[2].trim().equals("undefined") && !msString[3].equals("undefined")){

					         attributMap.put(msString[2].trim(),msString[3]);
					   }
					}
					}
				}
			}
	   }
       request.setAttribute("getpropertys",attributMap);
	   return "success";
 }
  public String getcastObj(String arrs){
	  String alls="";
      String []arrs1=arrs.split(";");
      if(arrs1[0].equals("1")){
    	  alls=arrs1[1]+":&nbsp;&nbsp;<input type='text' value='"+arrs1[4]+"'>";
      }
      if(arrs1[0].equals("2")){
    	  String []arrs2=arrs1[4].split("-");
	      alls=arrs1[1]+":&nbsp;&nbsp;<select>";
	      for (String string : arrs2) {
			alls+="<option>"+string+"</option>";
		  }
	      alls+="</select>&nbsp;&nbsp;";
      }
      if(arrs1[0].equals("3")){
    	  String []arrs2=arrs1[4].split("-");
	      alls=arrs1[1]+":&nbsp;&nbsp;";
	      for (String string : arrs2) {
			alls+="<input type='checkbox' value='"+string+"'>";
		  }
      }
      if(arrs1[0].equals("4")){
    	  String []arrs2=arrs1[4].split("-");
	      alls=arrs1[1]+":&nbsp;&nbsp;";
	      for (String string : arrs2) {
			alls+="<input type='radio' value='"+string+"'>";
		  }
      }
	  return alls;
  }
  
  public String alter(){
	  String id1=request.getParameter("id");
		 int id= Integer.parseInt(id1);
		   sa=  (Sale_goods) product_CommentService.saleDoodsById(id);
		   String checkboxval="";
		   String strge=sa.getSgspecifications();
		   if(strge!=null && strge!="" ){
			  String str[]= strge.split("\\|");
			  Integer a=str.length;
			  System.out.println(strge);
			  for (int i = 0; i < str.length; i++) {//获取线路，日期类型
				  if(str[i]!=null && !str[i].equals("")){
					  String list=str[i];
					String lexing[]=list.split(",");
					    for (int j = 0; j < 2; j++) {
					    	 if(lexing[j]!=null && !lexing[j].equals("")){
					    		 
					    		 checkboxval+=lexing[j]+",";
					    	 }
						}
				  }
				
			}
			   
			  request.setAttribute("checkboxval", checkboxval);
			  request.setAttribute("strge", strge);//内容
		   }
		   
		   
		   if(sa.getSgchecks().indexOf(",")!=-1){
			   String []strarr=sa.getSgchecks().split(",");
			   sa.setSgchecks1(strarr[0]);
			   sa.setSgchecks2(strarr[1]);
		   }else{
			   sa.setSgchecks1(sa.getSgchecks());
		   }
		   goods_dict=(List<Goods_dict>) product_CommentService.selectByall("from Goods_dict ");
			  goods_class_expand=(List<GoodsClass_expand>) product_CommentService.selectByall("from GoodsClass_expand");
			  System.out.println(goods_class_expand.size());
			 request.setAttribute("goods_class_expand",goods_class_expand);
			  request.setAttribute("goods_dict", goods_dict);
		   
	  return "alter";
  }
  
  public void checkVal() throws IOException{
	  String sgcode=(String) request.getSession().getAttribute("sgcode");
	  String sgname=(String)request.getSession().getAttribute( "sgname1");
	  String ctime=(String)request.getSession().getAttribute("ctime");
	  String ftime=(String)request.getSession().getAttribute("ftime");
	  if(sgcode==null){
		  sgcode=""; 
	  }
	  if(sgname==null){
		  sgname=""; 
	  }
	  if(ctime==null){
		  ctime=""; 
	  }
	  if(ftime==null){
		  ftime=""; 
	  }
      String str=sgcode+"|"+sgname+"|"+ctime+"|"+ftime;
      System.out.println(str);
      response.setContentType("text/html");
      response.setCharacterEncoding("utf-8");
	 response.getWriter().print(str);
	  
  }    
  public void addgd() throws IOException{
	  response.setCharacterEncoding("utf-8");   
	 List< Goods_dict> goods_dict = new ArrayList< Goods_dict>();
	  String str="";
	  String superid="";
	  goods_dict=(List<Goods_dict>) product_CommentService.selectByall("from Goods_dict  where gdSuperId is null  ");
	  for(int i=0;i<goods_dict.size();i++){
	      str+="|"+goods_dict.get(i).getGdnames();
	  }
	  for(int i=0;i<goods_dict.size();i++){
		  superid+="|"+goods_dict.get(i).getGdId();
	  }
	  
	  String value=str+"&"+superid;
	  response.getWriter().print(value);
  }
  
  public void superId() throws IOException{
	  response.setCharacterEncoding("utf-8");   
		  String str="";
		  valuep="";
//	  int superId=Integer.parseInt(request.getParameter("id"));
		  String id=request.getParameter("id");
		  String flgString=request.getParameter("flags1");
		  System.out.println(id+"-----------"+flgString);
		  String[] values=id.split("&");
		  for (int i = 0; i < values.length; i++) {
			  List<Goods_dict> litsLists=product_CommentService.selectByall("from Goods_dict where gdId="+Integer.parseInt(values[i]));
			  List litsList=product_CommentService.selectByall("from Goods_dict where gdSuperId="+Integer.parseInt(values[i]));
		      if(litsList.size()==0){
		    	  if(litsLists.get(0).getGdSuperId()!=null && flgString.equals("2")){
		    		  sel(litsLists.get(0).getGdSuperId()+"");
		    		  List<Goods_dict> litsLists1=product_CommentService.selectByall("from Goods_dict where gdId="+litsLists.get(0).getGdSuperId());
		    		  if(litsLists1.get(0).getGdSuperId()!=null){
		    			  sel(litsLists1.get(0).getGdSuperId()+"");
		    			  List<Goods_dict> litsLists2=product_CommentService.selectByall("from Goods_dict where gdId="+litsLists1.get(0).getGdSuperId());
		    			  if(litsLists2.get(0).getGdSuperId()!=null){
			    			  sel(litsLists2.get(0).getGdSuperId()+"");
			    			  List<Goods_dict> litsLists3=product_CommentService.selectByall("from Goods_dict where gdId="+litsLists2.get(0).getGdSuperId());
			    			  if(litsLists3.get(0).getGdSuperId()!=null){
				    			  sel(litsLists3.get(0).getGdSuperId()+"");
				    			  List<Goods_dict> litsLists4=product_CommentService.selectByall("from Goods_dict where gdId="+litsLists3.get(0).getGdSuperId());
				    			  if(litsLists4.get(0).getGdSuperId()!=null){
					    			  sel(litsLists4.get(0).getGdSuperId()+"");
					    			  List<Goods_dict> litsLists5=product_CommentService.selectByall("from Goods_dict where gdId="+litsLists4.get(0).getGdSuperId());
					    			  if(litsLists5.get(0).getGdSuperId()!=null){
					    				  sel(litsLists5.get(0).getGdSuperId()+"");
					    			  }
				    			  }
			    			  }
		    			  }
		    		  }
		    		  str+=sel(values[i])+" ";
		    	  }else{
			       str+=sel(values[i])+" ";
		    	  }
		      }else{
		    	  if(litsLists.get(0).getGdWritename().equals("1")){
		    		  sel(values[i]);
				  }
		      }
		  }
		  System.out.println(str+"=============");
		  response.getWriter().print(str);
				
	}
  public String sel(String id){
	  //valuep="";
	  goods_class_expand=(List<GoodsClass_expand>) product_CommentService.selectByall("from GoodsClass_expand where goods_dict.gdId="+Integer.parseInt(id));
		 for (int i = 0; i < goods_class_expand.size(); i++) {
			 if(goods_class_expand.size()>0){
			 valuep+=goods_class_expand.get(i).getGeId()+"&";
		 }
		 }
	  return valuep;
  }

  
  
  public String toaddpage() throws IOException{
	  Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
	  String loginname=loginEmp.getName();
	  String spNum="SP-"+serial.getSerialNumber();
	  System.out.println(spNum+"---");
	  goods_dict=(List<Goods_dict>) product_CommentService.selectByall("from Goods_dict ");
	  goods_class_expand=(List<GoodsClass_expand>) product_CommentService.selectByall("from GoodsClass_expand");
	  sa=  (Sale_goods) product_CommentService.saleDoodsById(6549873);
	  System.out.println(goods_class_expand.size());
	  request.setAttribute("spNum", spNum);
	 request.setAttribute("goods_class_expand",goods_class_expand);
	  request.setAttribute("goods_dict", goods_dict);
	  request.setAttribute("loginname",loginname);
	  return "addpage";
  }
  
  public String toaddpage2() throws IOException{
	  Employee loginEmp = (Employee) request.getSession().getAttribute("emp");
	  String loginname=loginEmp.getName();
	  String spNum="SP-"+serial.getSerialNumber();
	  System.out.println(spNum+"---");
	  goods_dict=(List<Goods_dict>) product_CommentService.selectByall("from Goods_dict gd where gd.gdSuperId is null  ");
//	  goods_class_expand=(List<GoodsClass_expand>) product_CommentService.selectByall("from GoodsClass_expand");
//	  sa=  (Sale_goods) product_CommentService.saleDoodsById(6549873);
	  request.setAttribute("spNum", spNum);
	  request.setAttribute("goods_dict", goods_dict);
	  request.setAttribute("loginname",loginname);
	  return "addpage2";
  }
  /**
   * 参数类目id 得到子类目  组合字符串
   * @throws IOException
   */
  public void getSonDicts() throws IOException{
	  String gdid = request.getParameter("gdid");//商品类目id
	  response.setContentType("text/html;charset=UTF-8");
	  if(gdid == null || gdid.equals("")){
		  response.getWriter().print(0);
		  return ;
	  }
	  try{
		  Integer.parseInt(gdid);
	  }catch ( ClassCastException e) {
		  response.getWriter().print(0);
		  return ;
	}
	  String hql = "from Goods_dict gd where gd.gdSuperId ="+gdid;
	  goods_dict = product_CommentService.selectByall(hql);
	  if(goods_dict.size() == 0){
		  response.getWriter().print("");
		  return;
	  }
	  StringBuffer sb = new StringBuffer();
	  sb.append(goods_dict.size()+";");
	  int i = 0;
	  for (Iterator it = goods_dict.iterator(); it.hasNext();) {
		Goods_dict gd = (Goods_dict) it.next();//
		
		if(gd.getGdSchilds()== null )gd.setGdSchilds(0);//为空都设置为0前端好判别
		sb.append(gd.getGdId()+"*"+gd.getGdnames()+"*"+gd.getGdSchilds()+"*"+i);
		sb.append(",");
		i++;
	  }
	  logger.info(sb.toString());
	  response.getWriter().print(sb.substring(0,sb.length()-1));
	  return ;
	  
  }
  
  /**
   * 根据类目id获取详细属性
   * @throws IOException
   */
  public void getDictAtrr() throws IOException{
	  response.setCharacterEncoding("utf-8");
	  response.setContentType("text/html");
	  
	  String first_spec_str = "";//保存第一规格的属性组合字符串 最后放到requst中去
	  String second_spec_str = "";//保存第二规格的属性组合字符串 最后放到requst中去
	  String id=request.getParameter("gdid");
	  String flgString=request.getParameter("flags");
	  System.out.println(id+"-----------"+flgString);
	  try{
		  Integer.parseInt(id);
	  }catch (ClassCastException e) {
		  response.getWriter().print(0);
	  }
	  List<Goods_dict> litsLists=product_CommentService.selectByall("from Goods_dict where gdId="+id);
	  
	  
	  StringBuffer atrrsb = new StringBuffer();//属性字符串
	  StringBuffer specsb = new StringBuffer();//规格字符串
	  StringBuffer sb = new StringBuffer();//规格字符串
	  
	  StringBuffer html_attr_str =  new StringBuffer();//
	  StringBuffer html_spec_str =  new StringBuffer();//
	  HashMap  cfgmap  = new HashMap();//记录各个标签的<标签类型,(类型-序号-label)的字符串
//	  map.put(1, label+"_1");
	  
	  for (Iterator it = litsLists.iterator(); it.hasNext();) {
		Goods_dict gd = (Goods_dict) it.next();
		Set set = gd.getGoodsClass_expands();
		if(set == null || set.size()== 0) break;//无属性终止退出
		for (Iterator it2 = set.iterator(); it2.hasNext();) {
			GoodsClass_expand gde = (GoodsClass_expand) it2.next();
			//用|分割
			sb.append(gde.getGeTemp1());
			sb.append("|"); 
			sb.append(gde.getGeTemp2());
			sb.append("|");
			sb.append(gde.getGeTemp3());
			sb.append("|");
			sb.append(gde.getGeTemp4());
			sb.append("|");
			sb.append(gde.getGeTemp5());
			sb.append("|");
			sb.append(gde.getGeTemp6());
			sb.append("|");
			sb.append(gde.getGeTemp7());
			sb.append("|");
			sb.append(gde.getGeTemp8());
			sb.append("|");
			sb.append(gde.getGeTemp9());
			sb.append("|");
			sb.append(gde.getGeTemp10());
			sb.append("|");
			sb.append(gde.getGeTemp11());
			sb.append("|");
			sb.append(gde.getGeTemp12());
			sb.append("|");
			sb.append(gde.getGeTemp13());
			sb.append("|");
			sb.append(gde.getGeTemp14());
			sb.append("|");
			sb.append(gde.getGeTemp15());
			break;//只得到第一条数据
		}
		
		String dict_attr_str = sb.toString();
		
		String[] ge_temp = dict_attr_str.split("\\|");
		logger.info("ge_temp.length="+ge_temp.length);
		int specnum = 0;//规格的属性不能超过2 如果超过多个只取前2个
		for(int j=0;j<ge_temp.length;j++){
			if(ge_temp[j] == null || ge_temp[j].trim().equals("") || ge_temp[j].trim().equals("null")){//如果ge_temp[i]为空则不去处理
				logger.info("为空不处理");
			}else{
				//alert("ge_temp["+j+"]="+ge_temp[j]);
				String[] str2 = ge_temp[j].split(";");//第二次分割 0 标签类型 1 label标识名称 2 标识tips 3 key的字符串 4 value的字符串 5 是否规格
				logger.info("str2.length="+str2.length);
				logger.info("str2="+ge_temp[j]);
				if(str2.length != 6){//去掉不规范数据
					logger.info("数据不规范");
				}else{
					
					String tag =str2[0];
					
					String label = str2[1];
					String tips  = str2[2];
					String keystr  = str2[3];
					String valuestr  = str2[4];
					String specflag  = str2[5];
					
					logger.info("第"+j+"轮,tag="+tag);
					//logger.info("第"+j+"轮,label="+label);
					//logger.info("第"+j+"轮,keystr="+keystr);
					//logger.info("第"+j+"轮,valuestr="+valuestr);
					//logger.info("第"+j+"轮,specflag="+specflag);
					String tagid = "";//标签的id值
					String tagname = "";//标签的name值
					if(tag.equals("1")){//文本框
						//文本框
						//var inputstr = "<dl><dt>服务器品牌：</dt><dd><input type='text' value='"福奥春天系列'"/><em>*请选择</em></dd></dl>";
						tagid = "input"+j;
						tagname = "input"+j; 
						//这里keystr 在文本框中默认是1 不需要填入
						String[] str3_value = valuestr.split("-");
						String inputstr = "<dl><dt>"+label+"：</dt><dd><input type='text' id='"+tagid+"' name='"+tagname+"' value='"+ str3_value[0]+"'/><em>*"+tips+"</em></dd></dl>";
						html_attr_str.append(inputstr);
						if(cfgmap.containsKey(1)){
							cfgmap.put(1, cfgmap.get(1)+","+j+"-1-"+label);
						}else{
							cfgmap.put(1, j+"-1-"+label);
						}
						
//						tag_i.push(j);
//						label_i.push(label);
					}else if(tag.equals("2")){//下拉框
						//var selectstr = "<dl><dt>服务器所在地：</dt><dd><select><option>北京xxxxxx</option><option>深圳</option><option>珠海</option></select><em>*请选择</em></dd></dl>";
						//<dl><dt>服务器硬盘容量：</dt><dd><select><option>北京</option><option>深圳</option><option>珠海</option></select><em>*请选择</em></dd></dl>
						tagid = "select"+j;
						tagname = "select"+j;
						String[] str3_key = keystr.split("-");//第三次分割
						String[] str3_value = valuestr.split("-");
						//logger.info(str3_key.length+"----"+str3_value.length);
						if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
							logger.info("下拉框中的选项数据没有或者不匹配");
							continue;//终止本次循环下面的操作
						}
						String selectstr = "<dl><dt>"+label+"：</dt><dd><select id='"+tagid+"' name='"+tagname+"'>";
						for(int i=0;i<str3_key.length;i++){//js中的话 长度要减1  eg 1-2-3-4- js中长度为5  java分割长度为4
						 selectstr += "<option value='"+str3_key[i]+"'>"+str3_value[i]+"</option>";
						}
						selectstr +="</select><em>*"+tips+"</em></dd></dl>";
						logger.info("selectstr="+selectstr);
						html_attr_str.append(selectstr);
						if(cfgmap.containsKey(2)){
							cfgmap.put(2, cfgmap.get(2)+","+j+"-2-"+label);
						}else{
							cfgmap.put(2, j+"-2-"+label);
						}
//						tag_s.push(j);
//						label_s.push(label);
					}else if(tag.equals("3")){//多选框
						//var checkboxstr = "<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>";
						tagid = "checkbox"+j;
						tagname = "checkbox"+j;
						
						String[] str3_key = keystr.split("-");//第三次分割
						String[] str3_value = valuestr.split("-");
						
						if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
							logger.info("多选框的选项数据没有或者不匹配");
							continue;//终止本次循环下面的操作
						}
						
						String checkboxstr = "<dl><dt>"+label+"：</dt><dd>";
						if(specflag.trim().equals("0")){
							for(int i=0;i<str3_key.length;i++){
								checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' value='"+str3_key[i]+"' />"+str3_value[i]+"";
							}
							checkboxstr += "<em>*"+tips+"</em></dd></dl>";
							html_attr_str.append(checkboxstr);
							if(cfgmap.containsKey(3)){
								cfgmap.put(3, cfgmap.get(3)+","+j+"-3-"+label);
							}else{
								cfgmap.put(3, j+"-3-"+label);
							}
//							tag_c.push(j);
//							label_c.push(label);
						}else if(specflag.trim().equals("1")){
							if(specnum == 0){//第一个规格属性
								for(int i=0;i<str3_key.length;i++){
									checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' onclick='jqchk(this.name)' value='"+str3_key[i]+"' />"+str3_value[i]+"";
									first_spec_str += str3_key[i]+"-"+str3_value[i]+"-"+tagname+"-"+",";
								}
								checkboxstr += "<em>*"+tips+"</em></dd></dl>";
								specnum +=1;
								html_spec_str.append(checkboxstr);
							}else if(specnum == 1){//第二个规格属性
								for(int i=0;i<str3_key.length;i++){
									checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' onclick='jqchxl(this.name)' value='"+str3_key[i]+"' />"+str3_value[i]+"";
									second_spec_str +=str3_key[i]+"-"+str3_value[i]+"-"+tagname+",";
								}
								checkboxstr += "<em>*"+tips+"</em></dd></dl>";
								specnum +=1;
								html_spec_str.append(checkboxstr);
							}else if(specnum == 2){//超过2个规格属性
								logger.info("规格属性的数量已经达到2个，只取前2个");
							}else{//规格属性的值混乱 
								logger.info("规格数量标识错误");
							}
							
						}else{//规格鉴别标识错误
							logger.info("标识错误，无法识别出是属性还是规格,默认成属性");
							html_attr_str.append(checkboxstr);
						}
						
					}else if(tag.equals("4")){//单选框
						tagid = "radio"+j;
						tagname = "radio"+j;
						//var radiostr = "<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>";
						String[] str3_key = keystr.split("-");//第三次分割
						String[] str3_value = valuestr.split("-");
						
						if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
							logger.info("多选框的选项数据没有或者不匹配");
							continue;//终止本次循环下面的操作
						}
						String radiostr = "<dl><dt>"+label+"：</dt><dd>";
						for(int i=0;i<str3_key.length;i++){
							radiostr +="<input type='radio' id='"+tagid+"' name='"+tagname+"' value='"+str3_key[i]+"'/>"+str3_value[i]+"";
						}
						radiostr +="<em>*"+tips+"</em></dd></dl>";
						html_attr_str.append(radiostr);
						if(cfgmap.containsKey(4)){
							cfgmap.put(4, cfgmap.get(4)+","+j+"-4-"+label);
						}else{
							cfgmap.put(4, j+"-4-"+label);
						}
//						tag_r.push(j);
//						label_r.push(label);
						
						request.setAttribute("first_spec_str", first_spec_str);
						request.setAttribute("second_spec_str", second_spec_str);
					}else{
						logger.info("文本类型标识解析错误，参数无法判断是哪种标签");
					}
				}
			}
		}
		
		break;//只得到第一条数据
	}
//	logger.info(sb.toString());
	logger.info(html_attr_str.toString());
	logger.info(html_spec_str.toString());
	StringBuffer cfgsb = new StringBuffer();
	StringBuffer  totalsb = new StringBuffer();
	String cfgstr = "";
	for (Iterator it = cfgmap.keySet().iterator(); it.hasNext();) {
		int tag = (Integer) it.next();
		cfgmap.get(tag);
		cfgsb.append(cfgmap.get(tag)+",");
	}
	if(cfgsb.length() == 0){
		cfgstr = "无";
	}else{
		cfgstr = cfgsb.substring(0, cfgsb.length()-1);
	}
	logger.info(cfgstr);
	if(html_attr_str.length()==0){
		totalsb.append("无");
	}else{
		totalsb.append(html_attr_str);
	}
	totalsb.append("@");
	if(html_spec_str.length()==0){
		totalsb.append("无");
	}else{
		totalsb.append(html_spec_str);
	}
	totalsb.append("@");
	totalsb.append(cfgstr);
	
	if(first_spec_str.equals(""))first_spec_str = "无";
	if(second_spec_str.equals(""))second_spec_str = "无";
	totalsb.append("@"+first_spec_str+"@"+second_spec_str);
	
//	response.getWriter().print(sb.toString());
	logger.info(totalsb.toString());
	response.getWriter().print(totalsb.toString());//无@无@无@无@无
	return;
  }
  
	 public String add2(){
		 Sale_goods sg=new Sale_goods();
		 Goods_dict goods_dict=new Goods_dict();
		 //参数商品类目ID
		 int goods_dictid=Integer.parseInt(request.getParameter("goods_dictid"));
		 goods_dict.setGdId(goods_dictid);
		 //商品编码
			String sgcode  =  request.getParameter("sgcode");
			int sgCheckGoods=0;
			/**添加审核流程*/
			//int marker = product_CommentService.addAuditingOrder2("sp",sgcode,"Sale_goods",ck.getCookie(request, "filialemark"));
			int marker = product_CommentService.addAuditingOrder2("xxttjsp",sgcode,"Goods_dict",ck.getCookie(request, "filialemark"));
			System.out.println(marker+"========");
			//此方法废弃
			//Map map = (Map)ActionContext.getContext().get("map");
			//ServletActionContext.getRequest().setAttribute("option", map);
			
			String   sgname=  request.getParameter("sgname");//商品名称
     		String  sgNorms =  request.getParameter("sgNorms");//商品规格
			String  sgUnit =  request.getParameter("sgUnit");//商品单位
			String  sgUsername =  request.getParameter("sgUsername");//录入人姓名
			int  sgStat =  Integer.parseInt(request.getParameter("sgStat"));//商品初始状态为0 2为已发布
			String  sgtime =  request.getParameter("sgtime");//创建时间
			String sgPuttime=request.getParameter("sgPuttime");//
			String sgDetails =request.getParameter("sgDetails");//商品描述
			Double sgPrice=Double.parseDouble((request.getParameter("sgPrice")));//商品价格
			Integer nums1=Integer.parseInt(request.getParameter("sgnumbers"));//商品总数量
			String sgImg=null;
			String sgThumb=null;
			String checkStr=null;
			String  img1 = request.getParameter("img1");//图片地址
			String  img2 = request.getParameter("img2");
			String  img3 = request.getParameter("img3");
			String  img4 = request.getParameter("img4");
			String  img5 = request.getParameter("img5");
			String  img6 = request.getParameter("img6");
			String chk1=request.getParameter("sgchecks");
			String chk2=request.getParameter("sgchecks1");
			
			HDThumb hdt  = new HDThumb();
			  String returnStr = "";
			  System.out.println(returnStr);
//			  if(returnStr.equals("ok"){
//				  
//			  }else{
//				  System.out.println();
//			  }
			
			if(chk1 != null && chk1.equals("1")){
				checkStr=Integer.parseInt(chk1)+","+Integer.parseInt(chk2);
			}else{
				checkStr=chk1;
			}
			String fileName = "";
			String srcPath = "";
			String newPath = "";
			String absFileName = "";
			String basePath = ServletActionContext.getServletContext().getRealPath(""); // 获取项目根路径
			//basePath = basePath.replace("%20", " ");
			logger.info(basePath);
			if(!basePath.endsWith(File.separator)){
				basePath +=File.separator;
			}
			logger.info(File.separator);
			if(img1!=null && !img1.equals("")){
				sgImg="|"+img1;
//				fileName = img1.substring(img1.lastIndexOf("/")+1, img1.length());
//				sgThumb = buildThumb(sgThumb,basePath,img1);
				
			}
			if(img2!=null && !img2.equals("")){
				sgImg+="|"+img2;
//				fileName = img2.substring(img2.lastIndexOf("/")+1, img2.length());
//				sgThumb = buildThumb(sgThumb,basePath,img2);
				
				}
			if(img3!=null && !img3.equals("")){
				sgImg+="|"+img3;
//				fileName = img3.substring(img3.lastIndexOf("/")+1, img3.length());
//				sgThumb = buildThumb(sgThumb,basePath,img3);
				
				}
			if(img4!=null && !img4.equals("")){
				sgImg+="|"+img4;
//				fileName = img4.substring(img4.lastIndexOf("/")+1, img4.length());
//				sgThumb = buildThumb(sgThumb,basePath,img4);
				
				}
			if(img5!=null && !img5.equals("")){
				sgImg+="|"+img5;
//				fileName = img5.substring(img5.lastIndexOf("/")+1, img5.length());
//				sgThumb = buildThumb(sgThumb,basePath,img5);
				
			}
			if(img6!=null && !img6.equals("")){
				sgImg+="|"+img6;
//				fileName = img6.substring(img6.lastIndexOf("/")+1, img6.length());
//				sgThumb = buildThumb(sgThumb,basePath,img6);
				
			}
			sgThumb = sgImg.replace("product_pic", "product_thumb");
//			商品的特殊属性
			
			//String inputvalue=request.getParameter("inputvalue");//文本框字符串
			//String selectvalue=request.getParameter("selectvalue");//下拉框字符串
			//String radiovalue=request.getParameter("radiovalue");//单选框字符串
			//String checkboxvalue=request.getParameter("checkboxvalue");//多选框字符串
			String attrstr=request.getParameter("attrstr");//多选框字符串
			
			String productgevalue=request.getParameter("productgevalue");//商品规格
			String photo=request.getParameter("erweima");//二维码
			//System.out.println(inputvalue+" ");
			//System.out.println(selectvalue+" ");
			//System.out.println(radiovalue+" ");
			//System.out.println(checkboxvalue+" ");
			System.out.println(attrstr+" ");
			//组合商品属相用 不同类型用@隔开
			//都为空 不考虑  只有一个类型  第一个为空 中间为空 最后一个为空
			//单独select的情况测试通过
//			if(sgAttribute2.endsWith("@"))
//				sgAttribute2= sgAttribute2.substring(0, sgAttribute2.length()-1);
			 sg.setSgAttribute(attrstr);//保存商品属性
			 sg.setSgcode(sgcode);
			 sg.setSgname(sgname);
			 sg.setSgspecifications(productgevalue);
			 sg.setSgNorms(sgNorms);
			 sg.setSgUnit(sgUnit);
			 sg.setSgUsername(sgUsername);
			 sg.setSgStat(sgStat);
			 sg.setSgImg(sgImg);
			 sg.setSgThumb(sgThumb);//新增的缩略图
			 sg.setSgtime(sgtime);
			 sg.setErweima(photo);
			 sg.setSgnumbers(nums1);
			 sg.setSgInventory(nums1);
			 sg.setSgchecks(checkStr);
			 if(sgPuttime!=null){
			 sg.setSgPuttime(sgPuttime);
			 }
			 sg.setSgDetails(sgDetails);
			 sg.setGoods_dict(goods_dict);
			 sg.setSgPrice(sgPrice);
			 //设置促销为默认
			 sg.setIsActivity("0");
			 sg.setActivityPrice(0.0);
			 sg.setActivityStart("");
			 sg.setActivityEnd("");
//			 sg.setSgCheckGoods(sgCheckGoods);
			 
			 if(sgStat==2){
				 sg.setSgPuttime(sgtime); 
			 }else{
				 sg.setSgPuttime(""); 
			 }
			 
			 
			 try {
					
					String modify=	request.getParameter("modify");
						if(modify!=null && !modify.equals("")){
							 int id=Integer.parseInt(request.getParameter("sgid"));
								sg.setSgId(id);
							 product_CommentService.update(sg);	//更新
						}
						else{
						product_CommentService.save(sg);
						}
					} catch (Exception e) {
						
						e.printStackTrace();
					}
				
	/////////////////////////////////////////////
						request.getSession().removeAttribute("sgcode");
						request.getSession().removeAttribute("sgname1");
						request.getSession().removeAttribute("ctime");
						request.getSession().removeAttribute("ftime");

					String pageNo = request.getParameter("pageNo") == null ? "1" : request
							.getParameter("pageNo");
					// String contractNo = request.getParameter("cname");
					String contractNo = (String) request.getSession()
							.getAttribute("cname2");

					System.out.println(contractNo + "---------------------");

					String hql = " from Sale_goods where 1=1  ";

					if (contractNo != null && !contractNo.equals("")) {

						hql += " and contractNo like '%" + contractNo + "%'";
					}
					hql += " and sgStat="+sgStat+" order by id desc";
					Pages pages = product_CommentService.paginationQuery(hql, Integer.parseInt(pageNo), 10,null);
//					Map map = (Map) ActionContext.getContext().get("map");
					request.getSession().setAttribute("pages", pages);
					request.setAttribute("pages", pages);
//					request.getSession().setAttribute("option", map);
	
					return "reTest";  

  }
	 private String buildThumb(String sgThumb,String basePath,String img1){
		    String absFileName = img1.substring(0,img1.lastIndexOf("/")+1);
			String fileName = img1.substring(img1.lastIndexOf("/")+1, img1.length());
			String srcPath = basePath +"product_pic"+File.separator+ fileName;
			String newPath = basePath +"product_thumb"+File.separator+ fileName;
			String returnStr = new HDThumb().buildHDThumb(srcPath, newPath, 310);
			if(returnStr.equals("ok")){
				sgThumb="|"+absFileName+fileName;
			}else{
				sgThumb="|-";
			}
			return sgThumb;
	 }
	 
	 private void createThumb(String basePath,String img1){
		    String absFileName = img1.substring(0,img1.lastIndexOf("/")+1);
			String fileName = img1.substring(img1.lastIndexOf("/")+1, img1.length());
			String srcPath = basePath +"product_pic"+File.separator+ fileName;
			String newPath = basePath +"product_thumb"+File.separator+ fileName;
			String returnStr = new HDThumb().buildHDThumb(srcPath, newPath, 310);
			
	 }
	 
	 public String alter2(){
		String id1=request.getParameter("id");
		int id= Integer.parseInt(id1);
		sa=  (Sale_goods) product_CommentService.saleDoodsById(id);
		String checkboxval="";
			   
//		组合属性字符串
		String attrstr = sa.getSgAttribute();
//		组合规格字符串
		String specstr = sa.getSgspecifications();
		String first_spec_str = "";//保存第一规格的属性组合字符串 最后放到requst中去
		String second_spec_str = "";//保存第二规格的属性组合字符串 最后放到requst中去
		
		
//		1|0|IP地址|一个免费IP1;1|2|网卡|双千兆网卡;1|11|IP地址|5350元/月
//		@
//		2|3|服务器所在地|8;2|4|服务器支出CPU个数|9;2|5|服务器所在地|10;2|6|服务器支出CPU个数|7;2|7|服务器CPU类型|7;2|8|服务器硬盘类型|6;2|10|服务器硬盘容量|5;2|12|服务器内存大小|7;2|13|付费方式|5
//		@
//		无
//		@
//		无
//		无@2|2|CPU|2;2|4|disk|2@3|3|内存|1,2@无
		HashMap  cfgmap  = new HashMap();//记录各个标签的<标签类型,(类型-序号-label)的字符串
		HashMap<Integer,String[]> attributMap=new HashMap<Integer,String[]>();
		HashMap<String,String[]> attr_map = new HashMap<String,String[]>();//记录商品属性<label, 标签数组>
		if(attrstr == null || attrstr.trim().equals("")){
			logger.info("组合商品属性：该商品无特殊属性");
		}else{
			String[] str1 = attrstr.split("@");//第一次分割
			if(str1.length != 4){
				logger.error("组合商品属性：商品属性在以@分割成数组时，数组长度不为4");
			}else{
				String  input_str = str1[0];//文本
				String  select_str = str1[1];//下拉
				String  checkbox_str = str1[2];//多选
				String  radio_str = str1[3];//单选
				
				attr_map = buildMap(attr_map,input_str);
				attr_map = buildMap(attr_map,select_str);
				attr_map = buildMap(attr_map,checkbox_str);
				attr_map = buildMap(attr_map,radio_str);
				
				for (Iterator it = attr_map.keySet().iterator(); it
						.hasNext();) {
					String label = (String) it.next();
					logger.info("label="+label);
				}
			}
		}
		
		
		StringBuffer html_attr_str =  new StringBuffer();
		StringBuffer html_spec_str =  new StringBuffer();
		
		StringBuffer sb = new StringBuffer();//类目属性字符串
		 
		Set set = sa.getGoods_dict().getGoodsClass_expands();
		
		if(set == null || set.size()== 0){//无属性
			logger.info("类目编码为"+sa.getGoods_dict().getGdcodes()+"无类目属性");
			html_attr_str.append("无类目属性");
		}else{
			for (Iterator it = set.iterator(); it.hasNext();) {
				GoodsClass_expand gde = (GoodsClass_expand) it.next();
				//用|分割
				sb.append(gde.getGeTemp1());
				sb.append("|");
				sb.append(gde.getGeTemp2());
				sb.append("|");
				sb.append(gde.getGeTemp3());
				sb.append("|");
				sb.append(gde.getGeTemp4());
				sb.append("|");
				sb.append(gde.getGeTemp5());
				sb.append("|");
				sb.append(gde.getGeTemp6());
				sb.append("|");
				sb.append(gde.getGeTemp7());
				sb.append("|");
				sb.append(gde.getGeTemp8());
				sb.append("|");
				sb.append(gde.getGeTemp9());
				sb.append("|");
				sb.append(gde.getGeTemp10());
				sb.append("|");
				sb.append(gde.getGeTemp11());
				sb.append("|");
				sb.append(gde.getGeTemp12());
				sb.append("|");
				sb.append(gde.getGeTemp13());
				sb.append("|");
				sb.append(gde.getGeTemp14());
				sb.append("|");
				sb.append(gde.getGeTemp15());
				break;//只得到第一条数据
			}
			String dict_attr_str = sb.toString();
			
			String[] ge_temp = dict_attr_str.split("\\|");
			logger.info("ge_temp.length="+ge_temp.length);
			int specnum = 0;//规格的属性不能超过2 如果超过多个只取前2个
			for(int j=0;j<ge_temp.length;j++){
				if(ge_temp[j] == null || ge_temp[j].trim().equals("") || ge_temp[j].trim().equals("null")){//如果ge_temp[i]为空则不去处理
					logger.info("为空不处理");
				}else{
					//alert("ge_temp["+j+"]="+ge_temp[j]);
					String[] str2 = ge_temp[j].split(";");//第二次分割 0 标签类型 1 label标识名称 2 标识tips 3 key的字符串 4 value的字符串 5 是否规格
					logger.info("str2.length="+str2.length);
					logger.info("str2="+ge_temp[j]);
					
					if(str2.length != 6){//去掉不规范数据
						logger.info("数据不规范");
					}else{
						
						String tag =str2[0];
						
						String label = str2[1];
						String tips  = str2[2];
						String keystr  = str2[3];
						String valuestr  = str2[4];
						String specflag  = str2[5];
						
						//logger.info("第"+j+"轮,tag="+tag);
						//logger.info("第"+j+"轮,label="+label);
						//logger.info("第"+j+"轮,keystr="+keystr);
						//logger.info("第"+j+"轮,valuestr="+valuestr);
						//logger.info("第"+j+"轮,specflag="+specflag);
						String tagid = "";//标签的id值
						String tagname = "";//标签的name值
						if(tag.equals("1")){//文本框
							//文本框
							//var inputstr = "<dl><dt>服务器品牌：</dt><dd><input type='text' value='"福奥春天系列'"/><em>*请选择</em></dd></dl>";
							tagid = "input"+j;
							tagname = "input"+j; 
							//这里keystr 在文本框中默认是1 不需要填入
							String[] str3_value = valuestr.split("-");
							String inputstr = "";
							if(attr_map.containsKey(label)){
								inputstr = "<dl><dt>"+label+"：</dt><dd><input type='text' id='"+tagid+"' name='"+tagname+"' value='"+ attr_map.get(label)[3]+"'/><em>*"+tips+"</em></dd></dl>";
//								String[]  ss = {label,str3_value[0]};
//								attributMap.put(j,ss );
//								String[] ss =  {"1","2"};
							}else{
								inputstr = "<dl><dt>"+label+"：</dt><dd><input type='text' id='"+tagid+"' name='"+tagname+"' value='"+str3_value[0] +"'/><em>*"+tips+"</em></dd></dl>";
							}
							html_attr_str.append(inputstr);
							if(cfgmap.containsKey(1)){
								cfgmap.put(1, cfgmap.get(1)+","+j+"-1-"+label);
							}else{
								cfgmap.put(1, j+"-1-"+label);
							}
//							tag_i.push(j);
//							label_i.push(label);
						}else if(tag.equals("2")){//下拉框
							//var selectstr = "<dl><dt>服务器所在地：</dt><dd><select><option>北京xxxxxx</option><option>深圳</option><option>珠海</option></select><em>*请选择</em></dd></dl>";
							//<dl><dt>服务器硬盘容量：</dt><dd><select><option>北京</option><option>深圳</option><option>珠海</option></select><em>*请选择</em></dd></dl>
							tagid = "select"+j;
							tagname = "select"+j;
							String[] str3_key = keystr.split("-");//第三次分割
							String[] str3_value = valuestr.split("-");
							//logger.info(str3_key.length+"----"+str3_value.length);
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								logger.info("下拉框中的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							
							String selectstr = "<dl><dt>"+label+"：</dt><dd><select id='"+tagid+"' name='"+tagname+"'>";
							String optkey = "";
							if(attr_map.containsKey(label)){
								optkey = attr_map.get(label)[3];
								for(int i=0;i<str3_key.length;i++){//
//								for(int i=0;i<str3_key.length-1;i++){//js中 1-2-3-4- 用-分割 长度为5  java语法处理 长度为4
									if(optkey.equals(str3_key[i])){
										selectstr += "<option value='"+str3_key[i]+"' selected='selected'>"+str3_value[i]+"</option>";
//										String[]  ss = {label,str3_value[i]};
//										attributMap.put(j,ss );
									}else{
										selectstr += "<option value='"+str3_key[i]+"'>"+str3_value[i]+"</option>";
									}
								}
								
							}else{
								for(int i=0;i<str3_key.length;i++){
									
									selectstr += "<option value='"+str3_key[i]+"'>"+str3_value[i]+"</option>";
								}
							}
							
							selectstr +="</select><em>*"+tips+"</em></dd></dl>";
							
							logger.info("selectstr="+selectstr);
							html_attr_str.append(selectstr);
							if(cfgmap.containsKey(2)){
								cfgmap.put(2, cfgmap.get(2)+","+j+"-2-"+label);
							}else{
								cfgmap.put(2, j+"-2-"+label);
							}
//							tag_s.push(j);
//							label_s.push(label);
						}else if(tag.equals("3")){//多选框
							//var checkboxstr = "<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>";
							tagid = "checkbox"+j;
							tagname = "checkbox"+j;
							
							String[] str3_key = keystr.split("-");//第三次分割
							String[] str3_value = valuestr.split("-");
							
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								logger.info("多选框的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							
							String checkboxstr = "<dl><dt>"+label+"：</dt><dd>";
							
							if(specflag.trim().equals("0")){
								String checkkeys = "";
								if(attr_map.containsKey(label)){
									checkkeys = attr_map.get(label)[3];
									String[] checkkey = checkkeys.split(",");//多选框的话  值有多个用,分隔
									
									for(int i=0;i<str3_key.length;i++){
										String ckstr = "";//定义一个变量 是否选中
										for (int k = 0; k < checkkey.length; k++) {
											if(checkkey[k].equals(str3_key[i])){
												ckstr="checked='checked'";
//												String[]  ss = {label,str3_value[i]};
//												attributMap.put(j,ss );
												break;
											}//满足条件 选中 并推出当前循环
										}
										checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' value='"+str3_key[i]+"' "+ckstr+"/>"+str3_value[i]+"";
									}
								}else{
									for(int i=0;i<str3_key.length;i++){
										checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' value='"+str3_key[i]+"' />"+str3_value[i]+"";
									}
								}
								
								checkboxstr += "<em>*"+tips+"</em></dd></dl>";
								html_attr_str.append(checkboxstr);
								if(cfgmap.containsKey(3)){
									cfgmap.put(3, cfgmap.get(3)+","+j+"-3-"+label);
								}else{
									cfgmap.put(3, j+"-3-"+label);
								}
//								tag_c.push(j);
//								label_c.push(label);
							}else if(specflag.trim().equals("1")){
//								保存的规格字符串
//								1,1,500,6,测试1,1_1|1,3,750,6,测试4,1_3|2,1,400,6,测试2,2_1|2,3,700,6,测试5,2_3|4,1,500,6,测试3,4_1|4,3,750,6,测试6,4_3|
								if(specstr  == null || specstr.trim().equals("")){
									logger.info("商品中未配置规格");
								}else{
									String[] specarra = specstr.split("\\|");
								}
								
								
								if(specnum == 0){//第一个规格属性
									for(int i=0;i<str3_key.length;i++){
										checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' onclick='jqchk(this.name)' value='"+str3_key[i]+"' />"+str3_value[i]+"";
										first_spec_str += str3_key[i]+"-"+str3_value[i]+"-"+tagname+"-"+",";
									}
									if(first_spec_str !="") first_spec_str = first_spec_str.substring(0,first_spec_str.length()-1);//去掉最后一个,
									checkboxstr += "<em>*"+tips+"</em></dd></dl>";
									specnum +=1;
									html_spec_str.append(checkboxstr);
								}else if(specnum == 1){//第二个规格属性
									for(int i=0;i<str3_key.length;i++){
										checkboxstr += "<input type='checkbox' id='"+tagid+"' name='"+tagname+"' onclick='jqchxl(this.name)' value='"+str3_key[i]+"' />"+str3_value[i]+"";
										second_spec_str +=str3_key[i]+"-"+str3_value[i]+"-"+tagname+",";
									}
									
									if(second_spec_str !="") second_spec_str = second_spec_str.substring(0,second_spec_str.length()-1);//去掉最后一个,
									checkboxstr += "<em>*"+tips+"</em></dd></dl>";
									specnum +=1;
									html_spec_str.append(checkboxstr);
								}else if(specnum == 2){//超过2个规格属性
									logger.info("规格属性的数量已经达到2个，只取前2个");
								}else{//规格属性的值混乱 
									logger.info("规格数量标识错误");
								}
								
							}else{//规格鉴别标识错误
								logger.info("标识错误，无法识别出是属性还是规格,默认成属性");
								html_attr_str.append(checkboxstr);
							}
							
						}else if(tag.equals("4")){//单选框
							tagid = "radio"+j;
							tagname = "radio"+j;
							//var radiostr = "<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>";
							String[] str3_key = keystr.split("-");//第三次分割
							String[] str3_value = valuestr.split("-");
							
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								logger.info("多选框的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							String radiostr = "<dl><dt>"+label+"：</dt><dd>";
							String radiokey = "";
							
							if(attr_map.containsKey(label)){
								radiokey = attr_map.get(label)[3];
								for(int i=0;i<str3_key.length;i++){
									String ckstr = "";
									if(radiokey.equals(str3_key[i])){
										ckstr = "checked";
//										String[]  ss = {label,str3_value[i]};
//										attributMap.put(j,ss );
									}
									radiostr +="<input type='radio' id='"+tagid+"' name='"+tagname+"' value='"+str3_key[i]+"' "+ckstr+"/>"+str3_value[i]+"";
								}
							}else{
								for(int i=0;i<str3_key.length;i++){
									radiostr +="<input type='radio' id='"+tagid+"' name='"+tagname+"' value='"+str3_key[i]+"'/>"+str3_value[i]+"";
								}
							}
							
							radiostr +="<em>*"+tips+"</em></dd></dl>";
							html_attr_str.append(radiostr);
							if(cfgmap.containsKey(4)){
								cfgmap.put(4, cfgmap.get(4)+","+j+"-4-"+label);
							}else{
								cfgmap.put(4, j+"-4-"+label);
							}
//							tag_r.push(j);
//							label_r.push(label);
						}else{
							logger.info("标签类型标识解析错误，参数无法判断是哪种标签 只能识别1 2 3 4");
						}
					}
				}
			}
		}
		StringBuffer  cfgsb = new StringBuffer();
		String cfgstr = "";
		for (Iterator it = cfgmap.keySet().iterator(); it.hasNext();) {
			int tag = (Integer) it.next();
			cfgmap.get(tag);
			cfgsb.append(cfgmap.get(tag)+",");
		}
		if(cfgsb.length() == 0){
			cfgstr = "无";
		}else{
			cfgstr = cfgsb.substring(0, cfgsb.length()-1);
		}
		
		request.setAttribute("cfg_str", cfgstr);//记录属性中标签类型 序号 label
		request.setAttribute("html_attr_str", html_attr_str.toString());//属性html格式的字符串
		request.setAttribute("html_spec_str", html_spec_str.toString());//规格html格式的字符串
		request.setAttribute("first_spec_str", first_spec_str);//记录第一规格的key value
		request.setAttribute("second_spec_str", second_spec_str);//记录第二规格的key value
		
		
		
		
		
			   String checkboxval1="";
			   String isstrge="";//是否符合规则
//			   组合规格字符串
			   String strge=sa.getSgspecifications();//字符串类型‘1，2，222，222，22’第一个为行1的checkbox值，第二个为行2的checkbox值
			   if(strge!=null && strge!=""){
				  String str[]= strge.split("\\|");
				  Integer a=str.length;//有多少条数据
				  System.out.println(strge);
				 
				  for (int i = 0; i < str.length; i++) {//获取第一个的checkbox的选中值
					  if(str[i]!=null && !str[i].equals("")){
						  String list=str[i];
						  String lexing[]=list.split(",");
						  	if(lexing.length>2){
							 for (int j = 0; j < 1; j++) {
						    	 if(lexing[0]!=null && !lexing[0].equals("")){
						    		 
						    		 checkboxval+=lexing[0]+",";
						    	 }
							 }
							 	
						  	}else{
						  		
						  		isstrge="no";
						  	}
					  }
					
				}
				  for (int i = 0; i < str.length; i++) {//获取第二个的checkbox选中值
					  if(str[i]!=null && !str[i].equals("")){
						  String list=str[i];
						  String lexing[]=list.split(",");
						  if(lexing.length>2){
							 for (int j = 0; j < 1; j++) {
						    	 if(lexing[1]!=null && !lexing[1].equals("")){
						    		 
						    		 checkboxval1+=lexing[1]+",";
						    	 }
							 }
						  }
						   
					  }
					
				}
				  if(!isstrge.equals("no")){
				  request.setAttribute("checkboxval1", checkboxval1);
				  request.setAttribute("checkboxval", checkboxval);//checkbox
				  request.setAttribute("strge", strge);//内容
				  }
			   }
			   
			   
			   if(sa.getSgchecks().indexOf(",")!=-1){
				   String []strarr=sa.getSgchecks().split(",");
				   sa.setSgchecks1(strarr[0]);
				   sa.setSgchecks2(strarr[1]);
			   }else{
				   sa.setSgchecks1(sa.getSgchecks());
			   }
			   //获得第一级类目属性 
			   goods_dict=(List<Goods_dict>) product_CommentService.selectByall("from Goods_dict gd where gd.gdSuperId is null ");


			   
 
			   
			   
			   request.setAttribute("goods_dict", goods_dict);
			   request.setAttribute("spNum", sa.getSgcode());
//			   生成一个4位随机码
			   Random r = new Random();
			   String randomnum = "";
			   for (int i = 0; i < 4; i++) {
				   randomnum +=r.nextInt(10);
			   }
			   request.setAttribute("modify", randomnum);
			   
			   
			   
			   
		  return "addpage2";
	  }
  private HashMap<String, String[]> buildMap(HashMap<String, String[]> attr_map, String input_str) {
	  if(input_str.equals("无")){
			logger.info("组合商品属性：该商品无文本属性");
		}else{
			String[] str2 = input_str.split(";");//第二次分割 //		2|2|CPU|2;2|4|disk|2
			for (int i = 0; i < str2.length; i++) {
				String  tagstr = str2[i];
				String[] str3 = tagstr.split("\\|");//第三次分割
				if(str3.length !=4){
					logger.error("组合商品属性-数据问题：文本标识数据;分割，数组长度不为4");
				}else{
					String serial = str3[0];//属性序号
					String tagserial = str3[1];//标签序号 1文本 2 下拉 3多选 4单选
					String label = str3[2];//label名称 唯一标识 整体用他来区分每个属性
					String value = str3[3];//显示的值
					
					if(attr_map.containsKey(label)){
						logger.error("label标识有重复的,请核查数据"+label);
					}else{
						attr_map.put(label,str3);
					}
				}
			}
			
		}
	  return attr_map;
	}
  
  public String viewtitlepic() throws IOException{
	  String sgcode = request.getParameter("sgcode");
	  if(sgcode == null || sgcode.trim().equals("")){
		  request.setAttribute("errorMsg", "非法操作！");
		  return "error";
	  }
	  String hql  =  "from Sale_goods  where sgcode = '"+sgcode+"'";
	  List list = product_CommentService.selectByall(hql);
	  if(list == null || list.size() == 0){
		  request.setAttribute("errorMsg", "请求不存在!");  
		  return "error";
	  }
	  if(list.size()>1){
		  
		  request.setAttribute("errorMsg", "数据错误，重复数据!");
		  //发邮件提醒
		  return "error";
		  
	  }
	  Sale_goods  sg = (Sale_goods)list.get(0);
	  request.setAttribute("sg", sg);
	  String thumbstr = sg.getSgThumb();
	  String imgstr = sg.getSgImg();
	  
	  if(imgstr != null && !imgstr.trim().equals("") && thumbstr !=null && !thumbstr.trim().equals("")){
		  
		  if(imgstr.startsWith("|")){
			  imgstr = imgstr.substring(1,imgstr.length());
		  }
		  if(thumbstr.startsWith("|")){
			  thumbstr = thumbstr.substring(1,thumbstr.length());
		  }
		  
		  String[] imgarra = imgstr.split("\\|");
		  
		  String[] thumbarra = thumbstr.split("\\|");
		  
		  if(imgarra.length != thumbarra.length){//原图和缩略数量不等
			  request.setAttribute("errorMsg", "图片显示错误！");
			  return "error";
		  }else{
			  request.setAttribute("imgarra", imgarra);
			  request.setAttribute("thumbarra", thumbarra);
			  String targetstr = "var target = [";
			  int num = imgarra.length;
			  for (int i = 0; i < thumbarra.length; i++) {
				targetstr += "'xixi-0"+(i+1)+"',";
			  }
			  targetstr = targetstr.substring(0,targetstr.length()-1);
			  targetstr += "];";
			  request.setAttribute("num", imgarra.length);
			  request.setAttribute("targetstr", targetstr);
		  }
	  }else{
		  request.setAttribute("errorMsg", "图片读取错误!");
		  return "error";
	  }
	  
	  return "viewtitlepic";
  }
  public String webdetails() throws IOException{
	  
	  	String id1=request.getParameter("id");
		int id= Integer.parseInt(id1);
		String goodsNo=request.getParameter("goodsNo");
		String info = request.getParameter("info");//获得info
		String empid=ck.getCookie(request, "employeeId");
		 sa=  (Sale_goods) product_CommentService.saleDoodsById(id);
		   String attrstr=sa.getSgAttribute().trim();//无@2|2|CPU|2@3|3|内存|1,3,4@无
//			组合规格字符串
			String specstr = sa.getSgspecifications();
			String first_spec_str = "";//保存第一规格的属性组合字符串 最后放到requst中去
			String second_spec_str = "";//保存第二规格的属性组合字符串 最后放到requst中去
			
			// String strge=sa.getSgspecifications();//属性
			 String isstrge="";//是否符合规则
//			   组合规格字符串
			   String strge=sa.getSgspecifications();//字符串类型‘1，2，222，222，22’第一个为行1的checkbox值，第二个为行2的checkbox值
			   if(strge!=null && strge!=""){
				  String str[]= strge.split("\\|");
				  Integer a=str.length;//有多少条数据
				  System.out.println(strge);
				  for (int i = 0; i < str.length; i++) {//获取第一个的checkbox的选中值
					  if(str[i]!=null && !str[i].equals("")){
						  String list=str[i];
						  String lexing[]=list.split(",");
						  	if(lexing.length>2){
							 for (int j = 0; j < 1; j++) {
						    	 if(lexing[0]!=null && !lexing[0].equals("")){
						    	 }
							 }
						  	}else{
						  		isstrge="no";
						  	}
					  }}
				}
				  if(!isstrge.equals("no")){
				
				  request.setAttribute("strge", strge);//内容
				  }
			   
			   
			
//		     得到商品属性
		   HashMap<String,String[]> attr_map=new HashMap<String,String[]>();
		   HashMap<Integer,String[]> attributMap=new HashMap<Integer,String[]>();
//		   attributMap.put(label, value)
		   if(attrstr == null || attrstr.trim().equals("")){
				logger.info("组合商品属性：该商品无特殊属性");
			}else{
				String[] str1 = attrstr.split("@");//第一次分割
				if(str1.length != 4){
					logger.error("组合商品属性：商品属性在以@分割成数组时，数组长度不为4");
				}else{
					String  input_str = str1[0];//文本
					String  select_str = str1[1];//下拉
					String  checkbox_str = str1[2];//多选
					String  radio_str = str1[3];//单选
					
					attr_map = buildMap(attr_map,input_str);
					attr_map = buildMap(attr_map,select_str);
					attr_map = buildMap(attr_map,checkbox_str);
					attr_map = buildMap(attr_map,radio_str);
					
					for (Iterator it = attr_map.keySet().iterator(); it
							.hasNext();) {
						String label = (String) it.next();
						logger.info("label="+label);
					}
				}
			}
		   StringBuffer sb = new StringBuffer();
		   Set set = sa.getGoods_dict().getGoodsClass_expands();
			if(set == null || set.size()== 0){//无属性
				logger.info("类目编码为"+sa.getGoods_dict().getGdcodes()+"无类目属性");
			}else{
				for (Iterator it = set.iterator(); it.hasNext();) {
					GoodsClass_expand gde = (GoodsClass_expand) it.next();
					//用|分割
					sb.append(gde.getGeTemp1());
					sb.append("|");
					sb.append(gde.getGeTemp2());
					sb.append("|");
					sb.append(gde.getGeTemp3());
					sb.append("|");
					sb.append(gde.getGeTemp4());
					sb.append("|");
					sb.append(gde.getGeTemp5());
					sb.append("|");
					sb.append(gde.getGeTemp6());
					sb.append("|");
					sb.append(gde.getGeTemp7());
					sb.append("|");
					sb.append(gde.getGeTemp8());
					sb.append("|");
					sb.append(gde.getGeTemp9());
					sb.append("|");
					sb.append(gde.getGeTemp10());
					sb.append("|");
					sb.append(gde.getGeTemp11());
					sb.append("|");
					sb.append(gde.getGeTemp12());
					sb.append("|");
					sb.append(gde.getGeTemp13());
					sb.append("|");
					sb.append(gde.getGeTemp14());
					sb.append("|");
					sb.append(gde.getGeTemp15());
					break;//只得到第一条数据
				}
				String dict_attr_str = sb.toString();
				
				String[] ge_temp = dict_attr_str.split("\\|");
				logger.info("ge_temp.length="+ge_temp.length);
				int specnum = 0;//规格的属性不能超过2 如果超过多个只取前2个
				for(int j=0;j<ge_temp.length;j++){
					if(ge_temp[j] == null || ge_temp[j].trim().equals("") || ge_temp[j].trim().equals("null")){//如果ge_temp[i]为空则不去处理
						logger.info("为空不处理");
					}else{
						//alert("ge_temp["+j+"]="+ge_temp[j]);
						String[] str2 = ge_temp[j].split(";");//第二次分割 0 标签类型 1 label标识名称 2 标识tips 3 key的字符串 4 value的字符串 5 是否规格
						logger.info("str2.length="+str2.length);
						logger.info("str2="+ge_temp[j]);
						
						if(str2.length != 6){//去掉不规范数据
							logger.info("数据不规范");
						}else{
							
							String tag =str2[0];
							
							String label = str2[1];
							String tips  = str2[2];
							String keystr  = str2[3];
							String valuestr  = str2[4];
							String specflag  = str2[5];
							
							//logger.info("第"+j+"轮,tag="+tag);
							//logger.info("第"+j+"轮,label="+label);
							//logger.info("第"+j+"轮,keystr="+keystr);
							//logger.info("第"+j+"轮,valuestr="+valuestr);
							//logger.info("第"+j+"轮,specflag="+specflag);
							String tagid = "";//标签的id值
							String tagname = "";//标签的name值
							if(tag.equals("1")){//文本框
								//文本框
								//var inputstr = "<dl><dt>服务器品牌：</dt><dd><input type='text' value='"福奥春天系列'"/><em>*请选择</em></dd></dl>";
								tagid = "input"+j;
								tagname = "input"+j; 
								//这里keystr 在文本框中默认是1 不需要填入
								String[] str3_value = valuestr.split("-");
								String inputstr = "";
								if(attr_map.containsKey(label)){
									String[]  ss = {label,attr_map.get(label)[3]};
									attributMap.put(j,ss );
								}
							}else if(tag.equals("2")){//下拉框
								tagid = "select"+j;
								tagname = "select"+j;
								String[] str3_key = keystr.split("-");//第三次分割
								String[] str3_value = valuestr.split("-");
								//logger.info(str3_key.length+"----"+str3_value.length);
								if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
									logger.info("下拉框中的选项数据没有或者不匹配");
									continue;//终止本次循环下面的操作
								}
								
								String optkey = "";
								if(attr_map.containsKey(label)){
									optkey = attr_map.get(label)[3];
									for(int i=0;i<str3_key.length;i++){//
										if(optkey.equals(str3_key[i])){
											String[]  ss = {label,str3_value[i]};
											attributMap.put(j,ss );
										}
									}
									
								}
							}else if(tag.equals("3")){//多选框
								//var checkboxstr = "<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>";
								tagid = "checkbox"+j;
								tagname = "checkbox"+j;
								
								String[] str3_key = keystr.split("-");//第三次分割
								String[] str3_value = valuestr.split("-");
								
								if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
									logger.info("多选框的选项数据没有或者不匹配");
									continue;//终止本次循环下面的操作
								}
								
								if(specflag.trim().equals("0")){
									String checkkeys = "";
									String ckvaluestr = "";
									if(attr_map.containsKey(label)){
										checkkeys = attr_map.get(label)[3];
										String[] checkkey = checkkeys.split(",");//多选框的话  值有多个用,分隔
										
										for(int i=0;i<str3_key.length;i++){
											String ckstr = "";//定义一个变量 是否选中
											for (int k = 0; k < checkkey.length; k++) {
												if(checkkey[k].equals(str3_key[i])){
													ckstr="checked='checked'";
													ckvaluestr += str3_value[i]+",";
													break;
												}//满足条件 选中 并推出当前循环
											}
										}
									}
									if(ckvaluestr.equals("")){
										ckvaluestr = "无";
									}else{
										ckvaluestr = ckvaluestr.substring(0,ckvaluestr.length()-1);
									}
									
									String[]  ss = {label,ckvaluestr};
									attributMap.put(j,ss );
									
								}else if(specflag.trim().equals("1")){
//									保存的规格字符串
//									1,1,500,6,测试1,1_1|1,3,750,6,测试4,1_3|2,1,400,6,测试2,2_1|2,3,700,6,测试5,2_3|4,1,500,6,测试3,4_1|4,3,750,6,测试6,4_3|
									if(specstr  == null || specstr.trim().equals("")){
										logger.info("商品中未配置规格");
									}else{
										String[] specarra = specstr.split("\\|");
									}
									
									
									if(specnum == 0){//第一个规格属性
										for(int i=0;i<str3_key.length;i++){
											first_spec_str += str3_key[i]+"-"+str3_value[i]+"-"+tagname+"-"+",";
										}
										if(first_spec_str !="") first_spec_str = first_spec_str.substring(0,first_spec_str.length()-1);//去掉最后一个,
										specnum +=1;
									}else if(specnum == 1){//第二个规格属性
										for(int i=0;i<str3_key.length;i++){
											second_spec_str +=str3_key[i]+"-"+str3_value[i]+"-"+tagname+",";
										}
										
										if(second_spec_str !="") second_spec_str = second_spec_str.substring(0,second_spec_str.length()-1);//去掉最后一个,
										specnum +=1;
									}else if(specnum == 2){//超过2个规格属性
										logger.info("规格属性的数量已经达到2个，只取前2个");
									}else{//规格属性的值混乱 
										logger.info("规格数量标识错误");
									}
								}else{//规格鉴别标识错误
									logger.info("标识错误，无法识别出是属性还是规格,默认成属性");
								}
							}else if(tag.equals("4")){//单选框
								tagid = "radio"+j;
								tagname = "radio"+j;
								//var radiostr = "<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>";
								String[] str3_key = keystr.split("-");//第三次分割
								String[] str3_value = valuestr.split("-");
								
								if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
									logger.info("多选框的选项数据没有或者不匹配");
									continue;//终止本次循环下面的操作
								}
								
								String radiokey = "";
								
								if(attr_map.containsKey(label)){
									radiokey = attr_map.get(label)[3];
									for(int i=0;i<str3_key.length;i++){
										String ckstr = "";
										if(radiokey.equals(str3_key[i])){
											ckstr = "checked";
											String[]  ss = {label,str3_value[i]};
											attributMap.put(j,ss );
										}
									}
								}
							}else{
								logger.info("标签类型标识解析错误，参数无法判断是哪种标签 只能识别1 2 3 4");
							}
						}
					}
				}
			}
		   
	     request.setAttribute("getpropertys",attributMap);
	     
	     //得到月销量 总销量
	     int saled_month_amount = 100;//月销量
	     int saled_total_amount = 999;//总销量
	     int remaining_amount = 73;//剩余量
	     request.setAttribute("saled_month_amount", saled_month_amount);
	     request.setAttribute("saled_total_amount", saled_total_amount);
	     request.setAttribute("remaining_amount", remaining_amount);
	     request.setAttribute("first_spec_str", first_spec_str);//记录第一规格的key value
		 request.setAttribute("second_spec_str", second_spec_str);//记录第二规格的key value
			
	  return "webdetail";
  }
  public String details2() throws IOException{
	    String id1=request.getParameter("id");
		int id= Integer.parseInt(id1);
		String goodsNo=request.getParameter("goodsNo");
		String info = request.getParameter("info");//获得info
		if(id1!=null){
			String addhql=" and sgId="+id;
			List list=product_CommentService.selSomeGoods_dict(addhql);
			System.out.println("listSize:"+list.size());
			request.setAttribute("cgoList", list.get(0));
			
			//获得请购单
			
			Sale_goods go=(Sale_goods) list.get(0);
//			String apparray=go.getApplyArray();
//			if(apparray!=null&&apparray!=""){
//				List list1=requisitioningBusssiness.getObjList("from ApplyBuy where id in ("+apparray+")");
//				System.out.println("listSize="+list1.size());
//				request.setAttribute("applyList", list1);
//			}
			if(null != info && ( info == "info" || info.equals("info"))){
				
				if(goodsNo!=null){
                 String addhql2=" and orderNo='"+goodsNo+"'";
					System.out.println(goodsNo+"====");
					List audList=product_CommentService.someauditingOrder(addhql2);
					
					
					request.setAttribute("auditingList", audList);
					
					if(null != audList && audList.size()>0){
						
						String depid = ck.getCookie(request, "departmentId");
						
						for(int i=0; i<audList.size(); i++){
							
							AuditingOrderTab aot = (AuditingOrderTab)audList.get(i);
							
							if(aot.getDepartment().getId() == Integer.parseInt(depid) && aot.getAuditingFlag() ==0 ){
								
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
			String empid=ck.getCookie(request, "employeeId");
			 sa=  (Sale_goods) product_CommentService.saleDoodsById(id);
			//确定由谁审核
			boolean flag =	product_CommentService.checkemp(goodsNo, empid);
			if(flag){
				request.setAttribute("mark", "mark");
			}else{
				request.setAttribute("mark", "no");
			}
			boolean flag1=product_CommentService.checkemp1(goodsNo, empid);
			System.out.println(goodsNo+"    "+empid);
			if(flag1){
				request.setAttribute("quanxian", "quanxian");
			}
			if(goodsNo!=null){
				String addhql2=" and orderNo='"+goodsNo+"'";
				List audList=product_CommentService.someauditingOrder(addhql2);
				request.setAttribute("auditingList", audList);
			}
		}
	   if(sa.getSgchecks().indexOf(",")!=-1){
		   String []strarr=sa.getSgchecks().split(",");
		   sa.setSgchecks1(strarr[0]);
		   sa.setSgchecks2(strarr[1]);
	   }else{
		   sa.setSgchecks1(sa.getSgchecks());
	   }
	   System.out.println("w.......,="+sa.getSgAttribute());
	   String attrstr=sa.getSgAttribute().trim();//无@2|2|CPU|2@3|3|内存|1,3,4@无
//	     得到商品属性
	   HashMap<String,String[]> attr_map=new HashMap<String,String[]>();
	   HashMap<Integer,String[]> attributMap=new HashMap<Integer,String[]>();
//	   attributMap.put(label, value)
	   if(attrstr == null || attrstr.trim().equals("")){
			logger.info("组合商品属性：该商品无特殊属性");
		}else{
			String[] str1 = attrstr.split("@");//第一次分割
			if(str1.length != 4){
				logger.error("组合商品属性：商品属性在以@分割成数组时，数组长度不为4");
			}else{
				String  input_str = str1[0];//文本
				String  select_str = str1[1];//下拉
				String  checkbox_str = str1[2];//多选
				String  radio_str = str1[3];//单选
				
				attr_map = buildMap(attr_map,input_str);
				attr_map = buildMap(attr_map,select_str);
				attr_map = buildMap(attr_map,checkbox_str);
				attr_map = buildMap(attr_map,radio_str);
				
				for (Iterator it = attr_map.keySet().iterator(); it
						.hasNext();) {
					String label = (String) it.next();
					logger.info("label="+label);
				}
			}
		}
	   StringBuffer sb = new StringBuffer();
	   Set set = sa.getGoods_dict().getGoodsClass_expands();
		if(set == null || set.size()== 0){//无属性
			logger.info("类目编码为"+sa.getGoods_dict().getGdcodes()+"无类目属性");
		}else{
			for (Iterator it = set.iterator(); it.hasNext();) {
				GoodsClass_expand gde = (GoodsClass_expand) it.next();
				//用|分割
				sb.append(gde.getGeTemp1());
				sb.append("|");
				sb.append(gde.getGeTemp2());
				sb.append("|");
				sb.append(gde.getGeTemp3());
				sb.append("|");
				sb.append(gde.getGeTemp4());
				sb.append("|");
				sb.append(gde.getGeTemp5());
				sb.append("|");
				sb.append(gde.getGeTemp6());
				sb.append("|");
				sb.append(gde.getGeTemp7());
				sb.append("|");
				sb.append(gde.getGeTemp8());
				sb.append("|");
				sb.append(gde.getGeTemp9());
				sb.append("|");
				sb.append(gde.getGeTemp10());
				sb.append("|");
				sb.append(gde.getGeTemp11());
				sb.append("|");
				sb.append(gde.getGeTemp12());
				sb.append("|");
				sb.append(gde.getGeTemp13());
				sb.append("|");
				sb.append(gde.getGeTemp14());
				sb.append("|");
				sb.append(gde.getGeTemp15());
				break;//只得到第一条数据
			}
			String dict_attr_str = sb.toString();
			
			String[] ge_temp = dict_attr_str.split("\\|");
			logger.info("ge_temp.length="+ge_temp.length);
			int specnum = 0;//规格的属性不能超过2 如果超过多个只取前2个
			for(int j=0;j<ge_temp.length;j++){
				if(ge_temp[j] == null || ge_temp[j].trim().equals("") || ge_temp[j].trim().equals("null")){//如果ge_temp[i]为空则不去处理
					logger.info("为空不处理");
				}else{
					//alert("ge_temp["+j+"]="+ge_temp[j]);
					String[] str2 = ge_temp[j].split(";");//第二次分割 0 标签类型 1 label标识名称 2 标识tips 3 key的字符串 4 value的字符串 5 是否规格
					logger.info("str2.length="+str2.length);
					logger.info("str2="+ge_temp[j]);
					
					if(str2.length != 6){//去掉不规范数据
						logger.info("数据不规范");
					}else{
						
						String tag =str2[0];
						
						String label = str2[1];
						String tips  = str2[2];
						String keystr  = str2[3];
						String valuestr  = str2[4];
						String specflag  = str2[5];
						
						//logger.info("第"+j+"轮,tag="+tag);
						//logger.info("第"+j+"轮,label="+label);
						//logger.info("第"+j+"轮,keystr="+keystr);
						//logger.info("第"+j+"轮,valuestr="+valuestr);
						//logger.info("第"+j+"轮,specflag="+specflag);
						String tagid = "";//标签的id值
						String tagname = "";//标签的name值
						if(tag.equals("1")){//文本框
							//文本框
							//var inputstr = "<dl><dt>服务器品牌：</dt><dd><input type='text' value='"福奥春天系列'"/><em>*请选择</em></dd></dl>";
							tagid = "input"+j;
							tagname = "input"+j; 
							//这里keystr 在文本框中默认是1 不需要填入
							String[] str3_value = valuestr.split("-");
							String inputstr = "";
							if(attr_map.containsKey(label)){
								String[]  ss = {label,attr_map.get(label)[3]};
								attributMap.put(j,ss );
							}
						}else if(tag.equals("2")){//下拉框
							tagid = "select"+j;
							tagname = "select"+j;
							String[] str3_key = keystr.split("-");//第三次分割
							String[] str3_value = valuestr.split("-");
							//logger.info(str3_key.length+"----"+str3_value.length);
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								logger.info("下拉框中的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							
							String optkey = "";
							if(attr_map.containsKey(label)){
								optkey = attr_map.get(label)[3];
								for(int i=0;i<str3_key.length;i++){//
									if(optkey.equals(str3_key[i])){
										String[]  ss = {label,str3_value[i]};
										attributMap.put(j,ss );
									}
								}
								
							}
						}else if(tag.equals("3")){//多选框
							//var checkboxstr = "<dl><dt>线路类型：</dt><dd><input type="checkbox" value="1" />双线<input type="checkbox" value="2"/>单线线<input type="checkbox" value="3" />2线<input type="checkbox" value="4"/>BGP双线<em>*请选择</em></dd></dl>";
							tagid = "checkbox"+j;
							tagname = "checkbox"+j;
							
							String[] str3_key = keystr.split("-");//第三次分割
							String[] str3_value = valuestr.split("-");
							
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								logger.info("多选框的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							
							if(specflag.trim().equals("0")){
								String checkkeys = "";
								String ckvaluestr = "";
								if(attr_map.containsKey(label)){
									checkkeys = attr_map.get(label)[3];
									String[] checkkey = checkkeys.split(",");//多选框的话  值有多个用,分隔
									
									for(int i=0;i<str3_key.length;i++){
										String ckstr = "";//定义一个变量 是否选中
										for (int k = 0; k < checkkey.length; k++) {
											if(checkkey[k].equals(str3_key[i])){
												ckstr="checked='checked'";
												ckvaluestr += str3_value[i]+",";
												break;
											}//满足条件 选中 并推出当前循环
										}
									}
								}
								if(ckvaluestr.equals("")){
									ckvaluestr = "无";
								}else{
									ckvaluestr = ckvaluestr.substring(0,ckvaluestr.length()-1);
								}
								
								String[]  ss = {label,ckvaluestr};
								attributMap.put(j,ss );
								
							}else if(specflag.trim().equals("1")){
								
								
							}else{//规格鉴别标识错误
								logger.info("标识错误，无法识别出是属性还是规格,默认成属性");
							}
						}else if(tag.equals("4")){//单选框
							tagid = "radio"+j;
							tagname = "radio"+j;
							//var radiostr = "<dl><dt>付费类型：</dt><dd><input type="radio" value="1"/>月付<input type="radio" value="1"/>季付<input type="radio" value="1"/>半年付<input type="radio" value="1"/>年付<em>*请选择</em></dd></dl>";
							String[] str3_key = keystr.split("-");//第三次分割
							String[] str3_value = valuestr.split("-");
							
							if(str3_key.length == 0 || str3_value.length == 0 || str3_key.length != str3_value.length){//下拉框中的选项数据没有或者不匹配
								logger.info("多选框的选项数据没有或者不匹配");
								continue;//终止本次循环下面的操作
							}
							
							String radiokey = "";
							
							if(attr_map.containsKey(label)){
								radiokey = attr_map.get(label)[3];
								for(int i=0;i<str3_key.length;i++){
									String ckstr = "";
									if(radiokey.equals(str3_key[i])){
										ckstr = "checked";
										String[]  ss = {label,str3_value[i]};
										attributMap.put(j,ss );
									}
								}
							}
						}else{
							logger.info("标签类型标识解析错误，参数无法判断是哪种标签 只能识别1 2 3 4");
						}
					}
				}
			}
		}
	   
     request.setAttribute("getpropertys",attributMap);
     
     //得到月销量 总销量
     int saled_month_amount = 100;//月销量
     int saled_total_amount = 999;//总销量
     int remaining_amount = 73;//剩余量
     request.setAttribute("saled_month_amount", saled_month_amount);
     request.setAttribute("saled_total_amount", saled_total_amount);
     request.setAttribute("remaining_amount", remaining_amount);
	 return "detail";
}
  
public void changes(){
	  
	  String tbg=t1;
	  String tend=t2;
	  String xpirce=cxprice;
	  String sid=sgid;
	  String sql="update Sale_goods set isActivity='1', activityPrice="+xpirce+", activityStart='"+t1+"' ,  activityEnd='"+t2+"' where sgId="+Integer.parseInt(sid);
	  System.out.println(sql);
	  
	  product_CommentService.updatsql(sql);
	  try {
		response.getWriter().print(1);
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	  
	
	  
  }
  public void delcx(){
	  String sid=sgid;
	  String sql="update Sale_goods set isActivity='0' where sgId="+Integer.parseInt(sid);  //, activityPrice="+xpirce+", activityStart='"+t1+"' ,  activityEnd='"+t2+"' ;
	  System.out.println(sql);
	  
	  product_CommentService.updatsql(sql);
	  
	  
  }
 /*
  * 定单流程的读取
  */
 public String getprocess(){
	  String sgnum=request.getParameter("sgnum")!=null?request.getParameter("sgnum"):"";//定单编号 
	  if(sgnum!=""){
	  String sql="from CurrencyProcess where pnum='"+sgnum+"'";
	  List  processlist=product_CommentService.selectByall(sql);
//	  List<CurrencyProcess>  processlist1=processlist;
//	  request.setAttribute("plist",processlist1);
	  String getorder="from Sale_orders WHERE soNums='"+sgnum+"'"; 
	  List order=product_CommentService.selectByall(getorder);
	  Sale_orders sg=(Sale_orders)order.get(0);
	  request.setAttribute("sgnum",sgnum);
	  request.setAttribute("sg",sg);
	  }
	  return "getprocess";
 }
  
public String upload() {
		String extName = ""; // 保存文件拓展名
		String newFileName = ""; // 保存新的文件名
		String nowTimeStr = ""; // 保存当前时间
		PrintWriter out = null;
		SimpleDateFormat sDateFormat;
		Random r = new Random();

		String savePath = ServletActionContext.getServletContext().getRealPath(
				""); // 获取项目根路径
		
		String thumbPath = savePath +File.separator+ "product_thumb"+File.separator;
		savePath = savePath + File.separator+"product_pic"+File.separator;
		response.setContentType("text/html;charset=GBK"); // 务必，防止返回文件名是乱码

		// 生成随机文件名：当前年月日时分秒+五位随机数（为了在实际项目中防止文件同名而进行的处理）
		int rannum = (int) (r.nextDouble() * (99999 - 10000 + 1)) + 10000; // 获取随机数
		sDateFormat = new SimpleDateFormat("yyyyMMddHHmmss"); // 时间格式化的格式
		nowTimeStr = sDateFormat.format(new Date()); // 当前时间
		// 获取拓展名
		if (fileuploadFileName.lastIndexOf(".") >= 0) {
			extName = fileuploadFileName.substring(fileuploadFileName
					.lastIndexOf("."));
		}
		try {
			out = response.getWriter();
			newFileName = nowTimeStr + rannum + extName; // 文件重命名后的名字
			
			String filePath = savePath + newFileName;
			thumbPath = thumbPath + newFileName;
			filePath = filePath.replace("\\", "/");
			thumbPath = thumbPath.replace("\\", "/");
			
			//检查上传的是否是图片
			if (UtilCommon.checkIsImage(extName)) {
				FileUtils.copyFile(fileupload, new File(filePath));
				logger.info(filePath);
				logger.info(thumbPath);
				//生成缩略图
				new HDThumb().buildHDThumb(filePath, thumbPath, 310);
				filePath = StrUtil.getStr(filePath);
				
				out.print("<font color='red'>" + fileuploadFileName
						+ "上传成功!</font>#" + filePath + "#" + fileuploadFileName);

			} else {
				out.print("<font color='red'>上传的文件类型错误，请选择jpg,jpeg,png和gif格式的图片!</font>");
			}
			out.flush();
			out.close();
			log.info("上传end");
			} catch (IOException e) {
			e.printStackTrace();
			out.print("上传失败，出错啦!");
			log.info("上传error");
		}
		return null;
	}
public void setOrderId(String orderId) {
	this.orderId = orderId;
}
public String getOrderId() {
	return orderId;
}
public void setZt(String zt) {
	this.zt = zt;
}
public String getZt() {
	return zt;
}
public void setPgno(String pgno) {
	this.pgno = pgno;
}
public String getPgno() {
	return pgno;
}
public String getT1() {
	return t1;
}
public void setT1(String t1) {
	this.t1 = t1;
}
public String getT2() {
	return t2;
}
public void setT2(String t2) {
	this.t2 = t2;
}
public String getCxprice() {
	return cxprice;
}
public void setCxprice(String cxprice) {
	this.cxprice = cxprice;
}
public String getSgid() {
	return sgid;
}
public void setSgid(String sgid) {
	this.sgid = sgid;
}

}

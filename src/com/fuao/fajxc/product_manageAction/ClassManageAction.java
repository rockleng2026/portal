package com.fuao.fajxc.product_manageAction;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.jar.JarEntry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.hibernate.mapping.Array;
import org.hibernate.mapping.PersistentClass;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.fuao.fajxc.product_manageService.ClassManageService;
import com.fuao.fajxc.util.Page;
import com.fuao.fajxc.util.Pager;
import com.fuao.fajxc.vo.GoodsClass_expand;
import com.fuao.fajxc.vo.Goods_dict;
import com.ibm.icu.text.SimpleDateFormat;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class ClassManageAction extends ActionSupport implements ServletRequestAware,ServletResponseAware{
   
	private static final PersistentClass Object = null;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private ClassManageService classManaServ;
	private String massage="";
	private Goods_dict  goodsdicts;        //类目属性
	private GoodsClass_expand goodClass;   //扩展字段
	private Logger log=Logger.getLogger(ClassManageAction.class);
	private Pager pager;
	private String conditionValues;
	private String strinArrs;
	private String oldid;
	
	public String getOldid() {
		return oldid;
	}
	public void setOldid(String oldid) {
		this.oldid = oldid;
	}
	public String getConditionValues() {
		return conditionValues;
	}
	public void setConditionValues(String conditionValues) {
		this.conditionValues = conditionValues;
	}
	public Pager getPager() {
		return pager;
	}
	public void setPager(Pager pager) {
		this.pager = pager;
	}
	public String getMassage() {
		return massage;
	}
	public void setMassage(String massage) {
		this.massage = massage;
	}
	public ClassManageService getClassManaServ() {
		return classManaServ;
	}
	public void setClassManaServ(ClassManageService classManaServ) {
		this.classManaServ = classManaServ;
	}
	public GoodsClass_expand getGoodClass() {
		return goodClass;
	}
	public void setGoodClass(GoodsClass_expand goodClass) {
		this.goodClass = goodClass;
	}
	public Goods_dict getGoodsdicts() {
		return goodsdicts;
	}
	public void setGoodsdicts(Goods_dict goodsdicts) {
		this.goodsdicts = goodsdicts;
	}
	public void setServletRequest(HttpServletRequest arg0) {
          request=arg0;
	}
	public void setServletResponse(HttpServletResponse arg0) {
          response = arg0;
	}
	//显示列表
	public String showGoodsDictList(){
		return null;
	}
	public void showchilds(){
		String supname="";
		try {
			supname =java.net.URLDecoder.decode(request.getParameter("supnames"),"utf-8");
			String supname1 =new String(request.getParameter("supnames").getBytes("GBK"),"utf-8");
			log.info("supname=="+supname1);
			request.getSession().setAttribute("supnames",supname);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		log.info("supname=="+supname);
		request.getSession().setAttribute("supcodes",request.getParameter("supcode"));
		request.getSession().setAttribute("ids1",Integer.parseInt(request.getParameter("suppids")));	
		request.getSession().setAttribute("classcods",request.getParameter("classcodes"));
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write("1");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	//查询是否存在
	public void selectupId(){
		strinArrs="";
		log.info(oldid);
		int ppid=Integer.parseInt(oldid);
		List<GoodsClass_expand> lt1=classManaServ.selectByall("from GoodsClass_expand g where g.goods_dict.gdId="+ppid);
		if(lt1.size()>0){
			Set st=new HashSet();
			st.add(lt1.get(0));
			getArrString(st);
		}
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(strinArrs);
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//新版增加修改超类。
	public void addSupperorchidFront(){
		log.info("front");
		int saveid=0;
		int savestat=0;
		Goods_dict gDict=new Goods_dict();
		String nameString="";
		try {
			nameString=URLDecoder.decode(request.getParameter("classname"),"utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		};
	    String codeString=request.getParameter("classcode");
        String timeString=request.getParameter("classtime");
        String contentString = request.getParameter("classContent");
    	gDict.setGdnames(nameString);
		gDict.setGdcodes(codeString);
		try {
			gDict.setGdWriteTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(timeString));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		gDict.setGdWritename(contentString);
		//判断是父类还是子类
		if(request.getParameter("surChild").equals("f")){
			if(request.getParameter("nxClass").equals("1")){
			   Goods_dict g_Dict=null;
			try {
				g_Dict = (Goods_dict) classManaServ.save(gDict);
			} catch (Exception e) {
				//e.printStackTrace();
			}
				//保存一端
				if(g_Dict!=null){
					saveid=g_Dict.getGdId();
					savestat=Integer.parseInt(g_Dict.getGdWritename());
					massage="增加超类成功。,"+savestat+","+saveid;
				}else{
					massage="增加超类失败。,";
				}
			}else{
				int mid=Integer.parseInt(request.getParameter("upids"));
				List<Goods_dict> lt=classManaServ.selectByall("from Goods_dict where gdId="+mid);
				Goods_dict gDict2 = lt.get(0);
				gDict.setGdId(gDict2.getGdId());
				Goods_dict g_Dict1=(Goods_dict) classManaServ.update(gDict);
				if(g_Dict1!=null){
					saveid=g_Dict1.getGdId();
					savestat=Integer.parseInt(g_Dict1.getGdWritename());
					massage="修改超类成功。,"+savestat+","+saveid;
				}else{
					massage="修改超类失败,可能是父类编码重复。,";
				}
			}
		}else{//增加子类
			String supercodeString=request.getParameter("superCodes");
			int supid1=Integer.parseInt(request.getParameter("supnid"));
			gDict.setGdSuperId(supid1);
			if(request.getParameter("nxClass").equals("1")){
				   Goods_dict g_Dict=null;
				try {
					g_Dict = (Goods_dict) classManaServ.save(gDict);
				} catch (Exception e) {
					//e.printStackTrace();
				}
				//保存一端
				if(g_Dict!=null){
					saveid=g_Dict.getGdId();
					savestat=Integer.parseInt(g_Dict.getGdWritename());
					massage="增加子类成功。,"+savestat+","+saveid;
				}else{
					massage="增加子类失败。,";
				}
			}else{
				int mid=Integer.parseInt(request.getParameter("upids"));
				List<Goods_dict> lt=classManaServ.selectByall("from Goods_dict where gdId="+mid);
				Goods_dict gDict2 = lt.get(0);
				gDict.setGdId(gDict2.getGdId());
				Goods_dict g_Dict1=(Goods_dict) classManaServ.update(gDict);
				if(g_Dict1!=null){
					saveid=g_Dict1.getGdId();//类目ID
					savestat=Integer.parseInt(g_Dict1.getGdWritename());//是否添加属性 1为添加
					massage="修改子类成功。,"+savestat+","+saveid;
				}else{
					massage="修改子类失败,可能是子类编码重复。,";
				}
			}
		}
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write((massage));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//修改前查询
	public String updFrontSelt(){
		log.info("front select....");
		int selid=Integer.parseInt(request.getParameter("selid"));
		List<Goods_dict> lt=classManaServ.selectByall("from Goods_dict where gdId="+selid);//子类
		Goods_dict gdi=lt.get(0);
		if(gdi.getGdSuperId()!=null){
		request.setAttribute("updateClassProper","修改子类");
		int faid=Integer.parseInt(request.getParameter("fatherID"));
		List<Goods_dict> lt1=classManaServ.selectByall("from Goods_dict where gdId="+faid);
		Goods_dict gdi1=lt1.get(0);
	    String supupdnamestr=("<tr valign='middle'><td align='right'>父类名称:</td><td align='left'><input type='text' id='superNames' readonly='readonly'  value="+gdi1.getGdnames()+"></td></tr>");
	    String supupdCodestr=("<tr valign='middle'><td align='right' width='270'>父类编码:</td><td align='left'><textarea cols='19' rows='1' id='superCodes' readonly='readonly' >"+gdi1.getGdcodes()+"</textarea></td></tr>");
		request.setAttribute("supupdnamestr",supupdnamestr);
		request.setAttribute("supupdCodestr",supupdCodestr);
		request.setAttribute("currentsupperids",gdi.getGdSuperId());
		}else{
			request.setAttribute("updateClassProper","修改父类");
		}
		request.setAttribute("currentCodes",gdi.getGdcodes());
		request.setAttribute("currentnames",gdi.getGdnames());
		request.setAttribute("currentids",gdi.getGdId());
		request.setAttribute("isaddpropertys",gdi.getGdWritename());
		return "showupdates";
	}
	//增加属性时删除
	public void delSupperOrChild(){
		log.info("del="+request.getParameter("condels"));
		String strcondel="";
		strinArrs="";
	    try {
	    	strcondel=URLDecoder.decode(request.getParameter("condels"),"utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		GoodsClass_expand objdel=new GoodsClass_expand();
		Set setdel=new HashSet();
		List<GoodsClass_expand> lt=classManaServ.selectByall("from GoodsClass_expand ");
		 for (Iterator iterator = lt.iterator(); iterator.hasNext();) {
				GoodsClass_expand objs= (GoodsClass_expand) iterator.next();
				if(objs.getGeTemp1()!=null ){
				   if(objs.getGeTemp1().equals(strcondel)){
					  objs.setGeTemp1("");
					  objdel=(GoodsClass_expand) classManaServ.update(objs);
					  setdel.add(objdel);
					  getArrString(setdel);
					  break;
				   }
				}
				if(objs.getGeTemp2()!=null ){
				   if(objs.getGeTemp2().equals(strcondel)){
						  objs.setGeTemp2("");
						  objdel=(GoodsClass_expand) classManaServ.update(objs);
						  setdel.add(objdel);
						  getArrString(setdel);
						  break;
				   } 
				}
				if(objs.getGeTemp3()!=null ){
				   if(objs.getGeTemp3().equals(strcondel)){
						  objs.setGeTemp3("");
						  objdel=(GoodsClass_expand) classManaServ.update(objs);
						  setdel.add(objdel);
						  getArrString(setdel);
						  break;
				    } 
				}
				if(objs.getGeTemp4()!=null ){
				   if(objs.getGeTemp4().equals(strcondel)){
						  objs.setGeTemp4("");
						  objdel=(GoodsClass_expand) classManaServ.update(objs);
						  setdel.add(objdel);
						  getArrString(setdel);  
						  break;
				   }  
				}
				if(objs.getGeTemp5()!=null ){
					if(objs.getGeTemp5().equals(strcondel)){
						  objs.setGeTemp5("");
						  objdel=(GoodsClass_expand) classManaServ.update(objs);
						  setdel.add(objdel);
						  getArrString(setdel);  
						  break;
				    }	
				}
				if(objs.getGeTemp6()!=null ){
				   if(objs.getGeTemp6().equals(strcondel)){
						  objs.setGeTemp6("");
						  objdel=(GoodsClass_expand) classManaServ.update(objs);
						  setdel.add(objdel);
						  getArrString(setdel);  
						  break;
				   }  
				}
				if(objs.getGeTemp7()!=null ){
				   if(objs.getGeTemp7().equals(strcondel)){
						  objs.setGeTemp7("");
						  objdel=(GoodsClass_expand) classManaServ.update(objs);
						  setdel.add(objdel);
						  getArrString(setdel);  
						  break;
				    }  
				}
				if(objs.getGeTemp8()!=null ){
				  if(objs.getGeTemp8().equals(strcondel)){
					  objs.setGeTemp8("");
					  objdel=(GoodsClass_expand) classManaServ.update(objs);
					  setdel.add(objdel);
					  getArrString(setdel);	  
					  break;
				  }   
				}
				if(objs.getGeTemp9()!=null ){
				  if(objs.getGeTemp9().equals(strcondel)){
					  objs.setGeTemp9("");
					  objdel=(GoodsClass_expand) classManaServ.update(objs);
					  setdel.add(objdel);
					  getArrString(setdel);	  
					  break;
				  } 
				}
				if(objs.getGeTemp10()!=null ){
				  if(objs.getGeTemp10().equals(strcondel)){
					  objs.setGeTemp10("");
					  objdel=(GoodsClass_expand) classManaServ.update(objs);
					  setdel.add(objdel);
					  getArrString(setdel);	 
					  break;
				  }  
				}
				if(objs.getGeTemp11()!=null ){
				   if(objs.getGeTemp11().equals(strcondel)){
						  objs.setGeTemp11("");
						  objdel=(GoodsClass_expand) classManaServ.update(objs);
						  setdel.add(objdel);
						  getArrString(setdel); 
						  break;
				   }   
				}
				if(objs.getGeTemp12()!=null ){
				  if(objs.getGeTemp12().equals(strcondel)){
					  objs.setGeTemp12("");
					  objdel=(GoodsClass_expand) classManaServ.update(objs);
					  setdel.add(objdel);
					  getArrString(setdel);	 
					  break;
				  }
				}
				if(objs.getGeTemp13()!=null ){
				  if(objs.getGeTemp13().equals(strcondel)){
					  objs.setGeTemp13("");
					  objdel=(GoodsClass_expand) classManaServ.update(objs);
					  setdel.add(objdel);
					  getArrString(setdel);	 
					  break;
				  }
				}
				if(objs.getGeTemp14()!=null ){
				  if(objs.getGeTemp14().equals(strcondel)){
					  objs.setGeTemp14("");
					  objdel=(GoodsClass_expand) classManaServ.update(objs);
					  setdel.add(objdel);
					  getArrString(setdel);	 
					  break;
				  }	   
				}
				if(objs.getGeTemp15()!=null ){
				  if(objs.getGeTemp15().equals(strcondel)){
					  objs.setGeTemp15("");
					  objdel=(GoodsClass_expand) classManaServ.update(objs);
					  setdel.add(objdel);
					  getArrString(setdel);  
					  break;
				  }	 
				}
			}
		 response.setContentType("text/html;charset=GBK");
		 try {
			response.getWriter().write(("删除成功,"+strinArrs));
		 }catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		 }
	}
	//增加属性
	public void addSupperorchidProperty(){
		log.info("property"+request.getParameter("clasid")+","+request.getParameter("surChild"));
        int cid=Integer.parseInt(request.getParameter("clasid"));
        GoodsClass_expand gExpand = new GoodsClass_expand();
        Goods_dict gDict=new Goods_dict();
		String nameString="";
		String jsonStr = request.getParameter("datas");
		System.out.println(jsonStr);
		List<GoodsClass_expand> lt=classManaServ.selectByall("from GoodsClass_expand g where g.goods_dict.gdId="+cid);
		if(!jsonStr.equals("}]")){
			if(lt.size()==0){
			   gDict.setGdId(cid);
			}else{
				for (GoodsClass_expand goodsClassExpand : lt) {
					classManaServ.delete(goodsClassExpand);
				}
				gDict.setGdId(cid);
			}
			gExpand=classManaServ.comentContent(jsonStr);
			gExpand.setGoods_dict(gDict);
		}
		if(request.getParameter("surChild").equals("f")){
		//更新了。
		if(gExpand!=null){
			if(request.getParameter("upflags").equals("1")){//upflags 是否修改 1新增 2修改
					try {
						GoodsClass_expand ged=(GoodsClass_expand) classManaServ.save(gExpand);
						if(ged!=null){                                         //传属性到前台，还有父类的哦
							massage=superDetail(cid);
						}else{
							massage="保存父类属性失败，请检查。,";
						}
					} catch (Exception e) {
						massage="增加父类属性失败，传过来并没属性，请检查。,";
					}
			}else{
				try {
					GoodsClass_expand ged=null;
					if(request.getParameter("upflags").equals("8")){
						massage=superDetail(cid);
					}else{
					GoodsClass_expand gExpand2=lt.get(0);
					if(jsonStr.equals("}]")){
						ged=(GoodsClass_expand) classManaServ.update(clearDate(gExpand2));
					}else{
						gExpand.setGeId(gExpand2.getGeId());
					    ged=(GoodsClass_expand) classManaServ.update(gExpand);
					}
					if(ged!=null){                                         //传属性到前台，还有父类的哦
						massage=superDetail(cid);
					}else{
						massage="修改父类属性失败，请检查。,";
					}
					}
				} catch (Exception e) {
					massage="修改父类属性失败，传过来并没属性，请检查。,";
				}
			}
		}else{
			massage="属性传递失败，请检查。,";
		}
		}else{//增加子类的属性
			log.info("保存子类");
			if(request.getParameter("upflags").equals("1")){
				try {
					GoodsClass_expand ged=(GoodsClass_expand) classManaServ.save(gExpand);
					if(ged!=null){                                         //传属性到前台，还有父类的哦
						massage=updetail(cid);
					}else{
						massage="保存子类属性失败，请检查。,";
					}
				} catch (Exception e) {
					massage="增加子类属性失败，传过来并没属性，请检查。,";
				}
		}else{
			try {
				GoodsClass_expand ged=null;
				if(request.getParameter("upflags").equals("8")){
					massage=superDetail(cid);
				}else{
					   GoodsClass_expand gExpand2=lt.get(0);
					if(jsonStr.equals("}]")){
						ged=(GoodsClass_expand) classManaServ.update(clearDate(gExpand2));
					}else{
						gExpand.setGeId(gExpand2.getGeId());
					    ged=(GoodsClass_expand) classManaServ.update(gExpand);
					}
					if(ged!=null){                                         //传属性到前台，还有父类的哦
						massage=updetail(cid);
					}else{
						massage="修改子类属性失败，请检查。,";
					}
				}
			} catch (Exception e) {
				massage="修改子类属性失败，传过来并没属性，请检查。,";
			}
		}
			
		}
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write((massage));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public GoodsClass_expand clearDate(GoodsClass_expand expands){
		expands.setGeTemp1("");
		expands.setGeTemp2("");
		expands.setGeTemp3("");
		expands.setGeTemp4("");
		expands.setGeTemp5("");
		expands.setGeTemp6("");
		expands.setGeTemp7("");
		expands.setGeTemp8("");
		expands.setGeTemp9("");
		expands.setGeTemp10("");
		expands.setGeTemp11("");
		expands.setGeTemp12("");
		expands.setGeTemp13("");
		expands.setGeTemp14("");
		expands.setGeTemp15("");
		return expands;
	}
	//增加超类
	public void addSupperGoods(){
		log.info("add supper ...");
		log.info(request.getParameter("datas"));
		int saveid=0;
		GoodsClass_expand gExpand = new GoodsClass_expand();
		Goods_dict gDict=new Goods_dict();
		String jsonStr="";
		String nameString="";
		try {
			jsonStr =request.getParameter("datas");
			nameString=URLDecoder.decode(request.getParameter("classname"),"utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		};
	    String codeString=request.getParameter("classcode");
        String timeString=request.getParameter("classtime");
        String contentString = request.getParameter("classContent");
    	gDict.setGdnames(nameString);
		gDict.setGdcodes(codeString);
		try {
			gDict.setGdWriteTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(timeString));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		gDict.setGdWritename(contentString);
		if(!jsonStr.equals("}]")){
		gExpand=classManaServ.comentContent(jsonStr);
		Set<GoodsClass_expand> set = new HashSet<GoodsClass_expand>();
		gExpand.setGoods_dict(gDict);
		set.add(gExpand);
		gDict.setGoodsClass_expands(set);
		}
		//判断是父类还是子类
		if(request.getParameter("surChild").equals("f")){
		
			Goods_dict g_Dict=null;
			try {
				g_Dict = (Goods_dict) classManaServ.save(gDict);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//保存一端
			if(g_Dict!=null){
				saveid=g_Dict.getGdId();
				massage="增加超类成功。,"+saveid;
			}else{
				massage="增加超类失败。,";
			}
		}else{
			String supCode=request.getParameter("superCodes");
			String supcode1="";
			if(supCode.length()!=8){
			   supcode1=supCode.substring(0,(supCode.length()-4));
		     }else{
		    	 supcode1=supCode;
		     }
			List<Goods_dict> lt=classManaServ.selectByall("from Goods_dict where gdcodes='"+supcode1+"'");
			Goods_dict gdit=lt.get(0);
			gDict.setGdSuperId(gdit.getGdId());
			Goods_dict g_Dict1=null;
			try {
				g_Dict1 = (Goods_dict) classManaServ.save(gDict);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//保存一端
			if(g_Dict1!=null){
				saveid=g_Dict1.getGdId();
//				gdit.setGdcodes(supCode);
//				classManaServ.update(gdit);
				massage="增加子类成功。,"+saveid;
			}else{
				massage="增加子类失败。,";
			}
		}
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write((massage));
		} catch (IOException e) {
			e.printStackTrace();
		}
	
	}
	//显示编码
	public void getSupperOrChildCode(){
		String type=request.getParameter("types");
		String fathar=request.getParameter("tent");
		String pmst="";
		log.info("I come Code="+type);
		pmst=classManaServ.createCodes(type,fathar);
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(pmst);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public String splitpages(){
	    log.info("split....");
		String mts=(String) ActionContext.getContext().getApplication().get("psize");
		int pageNo = 0;
		Page page=null;
		int pagesize=Integer.parseInt(mts);
		if(pager!=null){
			if(pager.getOffset().equals("no")){
				pageNo =0;
			}else{
			   pageNo = Integer.parseInt(pager.getOffset());
			}
		}
		log.info(conditionValues);
		if(conditionValues==null || conditionValues==""){
			 page = this.classManaServ.doSplit(pageNo,pagesize);
		}else{
			page = this.classManaServ.doSplit(pageNo,pagesize,conditionValues);
			//request.setAttribute("convalue",conditionValues);
		}
		List<Goods_dict> palit=page.getPageList();
		List ltList=new ArrayList();
		for (Goods_dict goodsDict1 : palit) {
			if(goodsDict1.getGdSuperId()!=null){
			List<Goods_dict> lt1=classManaServ.selectByall("from Goods_dict where gdId="+goodsDict1.getGdSuperId());
			Goods_dict gdits=lt1.get(0);
			goodsDict1.setFatherName(gdits.getGdnames());
			}
			ltList.add(goodsDict1);
		}
		page.setPageList(ltList);
		request.getSession().setAttribute("page", page);
		return "showClassList";
	}
	public String updetail(int id){
		strinArrs="";
		Goods_dict go6=new Goods_dict();
		List<Goods_dict> lt=this.classManaServ.selectByall("from Goods_dict where gdId="+id);
		Goods_dict gdsdt=lt.get(0);;
		go6.setGdcodes("有父类编码暂不出来");
		go6.setGdnames("有父类名称暂不出来");
		if(Integer.parseInt(gdsdt.getGdWritename())==1){
		    Set set=gdsdt.getGoodsClass_expands();
		    getArrString(set);
	    }
		String allStrings=go6.getGdcodes()+","+go6.getGdnames()+","+gdsdt.getGdcodes()+","+gdsdt.getGdnames()+","+gdsdt.getGdWriteTime()+","+strinArrs;
		return allStrings;
	}
	public void superMenuDetail(){
		log.info("details....");
		strinArrs="";
		int id=Integer.parseInt(request.getParameter("present"));
		goodsdicts=(Goods_dict) this.classManaServ.selectById(id);
		List<Goods_dict> lt=this.classManaServ.selectByall("from Goods_dict where gdId="+goodsdicts.getGdSuperId());
		Goods_dict go6=new Goods_dict();
		if(lt.size()>0){
		go6=lt.get(0);//当前父类的
		getArrString(goodsdicts.getGoodsClass_expands());
		this.checkSupers(goodsdicts.getGdSuperId());
		}else{
			go6.setGdcodes("暂无父类编码");
			go6.setGdnames("暂无父类名称");
			if(Integer.parseInt(goodsdicts.getGdWritename())==1){
				   this.checkSupers(goodsdicts.getGdId());
		    }
		}	
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(go6.getGdcodes()+","+go6.getGdnames()+","+goodsdicts.getGdcodes()+","+goodsdicts.getGdnames()+","+goodsdicts.getGdWriteTime()+","+strinArrs);
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//查看详细   有做修改了
	public String superDetail(int id){
		log.info("details....");
		strinArrs="";
		Goods_dict gdsdt=(Goods_dict) this.classManaServ.selectById(id);
		List<Goods_dict> lt=this.classManaServ.selectByall("from Goods_dict where gdId="+gdsdt.getGdSuperId());
		Goods_dict go6=new Goods_dict();
		if(lt.size()>0){
		go6=lt.get(0);//当前父类的
		getArrString(gdsdt.getGoodsClass_expands());
		//this.checkSupers(gdsdt.getGdSuperId());
		}else{
			go6.setGdcodes("暂无父类编码");
			go6.setGdnames("暂无父类名称");
			if(Integer.parseInt(gdsdt.getGdWritename())==1){
				   this.checkSupers(gdsdt.getGdId());
		    }
		}	
		String allStrings=go6.getGdcodes()+","+go6.getGdnames()+","+gdsdt.getGdcodes()+","+gdsdt.getGdnames()+","+gdsdt.getGdWriteTime()+","+strinArrs;
		return allStrings;
	}
	//判断是否还有父类
	public String checkSupers(Integer ids){
		if(ids!=null){
			List<Goods_dict> lt=this.classManaServ.selectByall("from Goods_dict where gdId="+ids);
			Goods_dict gts=lt.get(0);
		    if(gts.getGdWritename().equals("1")){
		    	Set set=gts.getGoodsClass_expands();
		    	getArrString(set);
		    }
		    checkSupers(gts.getGdSuperId());
		}
		return null;
	}
   @SuppressWarnings("unchecked")
public void getArrString(Set set){
	   for (Iterator iterator = set.iterator(); iterator.hasNext();) {
			GoodsClass_expand objs= (GoodsClass_expand) iterator.next();
			if(objs.getGeTemp1()!=null ){
			   strinArrs+=objs.getGeTemp1()+"^";
			}
			if(objs.getGeTemp2()!=null ){
				   strinArrs+=objs.getGeTemp2()+"^";
			}
			if(objs.getGeTemp3()!=null ){
				   strinArrs+=objs.getGeTemp3()+"^";
			}
			if(objs.getGeTemp4()!=null ){
				   strinArrs+=objs.getGeTemp4()+"^";
				}
			if(objs.getGeTemp5()!=null ){
				   strinArrs+=objs.getGeTemp5()+"^";
			}
			if(objs.getGeTemp6()!=null ){
				   strinArrs+=objs.getGeTemp6()+"^";
			}
			if(objs.getGeTemp7()!=null ){
				   strinArrs+=objs.getGeTemp7()+"^";
				}
			if(objs.getGeTemp8()!=null ){
				   strinArrs+=objs.getGeTemp8()+"^";
				}
			if(objs.getGeTemp9()!=null ){
				   strinArrs+=objs.getGeTemp9()+"^";
				}
			if(objs.getGeTemp10()!=null ){
				   strinArrs+=objs.getGeTemp10()+"^";
				}
			if(objs.getGeTemp11()!=null ){
				   strinArrs+=objs.getGeTemp11()+"^";
				}
			if(objs.getGeTemp12()!=null ){
				   strinArrs+=objs.getGeTemp12()+"^";
				}
			if(objs.getGeTemp13()!=null ){
				   strinArrs+=objs.getGeTemp13()+"^";
				}
			if(objs.getGeTemp14()!=null ){
				   strinArrs+=objs.getGeTemp14()+"^";
				}
			if(objs.getGeTemp15()!=null ){
				   strinArrs+=objs.getGeTemp15()+"^";
				}
		}
   }
   public void  deleteClass(){
	   int id=Integer.parseInt(request.getParameter("dids"));
	   String stg="";
	   if(this.classManaServ.delete(id)){
		   stg="数据删除成功。";
	   }else{
		   stg="数据删除失败,可能有被其它字段引用。";
	   }
	   response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(stg);
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
   }
   public void returnvalues(){
	   int ids=Integer.parseInt(request.getParameter("extid"));
	   strinArrs="";
	   String  value="";
	   List<Goods_dict> ltt=this.classManaServ.selectByall("from Goods_dict where gdId="+ids);
	   Goods_dict ged=ltt.get(0);
	   if(Integer.parseInt(ged.getGdWritename())==1){
	   Set<GoodsClass_expand> gced=ged.getGoodsClass_expands();
	   getArrString(gced);
	   value=strinArrs;
	   }else{
		   value="no";
	   }
	   response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(value);
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
   }
   public void updateDetail(){
	   String jsons=request.getParameter("jsonDate");
	   String name="";
	try {
		name = java.net.URLDecoder.decode(request.getParameter("atent"),"utf-8");
	} catch (UnsupportedEncodingException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
	   String stm="";
	    Date dt=null;
		try {
			dt = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss").parse(request.getParameter("dte"));
		} catch (ParseException e) {
			e.printStackTrace();
		}
	   int id=Integer.parseInt(request.getParameter("cid"));
	   List<Goods_dict> lt=this.classManaServ.selectByall("from Goods_dict where gdId="+id);
	   Goods_dict gDict=lt.get(0);
	   gDict.setGdnames(name);
	   gDict.setGdWriteTime(dt);
	   if(!jsons.equals("}]")){
		    Set se=gDict.getGoodsClass_expands();
		    for (Iterator iterator = se.iterator(); iterator.hasNext();) {
		    	GoodsClass_expand gds = (GoodsClass_expand) iterator.next();
		    	GoodsClass_expand gExpand=classManaServ.comentContent(jsons); 
		    	gExpand.setGeId(gds.getGeId());
				Set<GoodsClass_expand> set = new HashSet<GoodsClass_expand>();
				gExpand.setGoods_dict(gDict);
				set.add(gExpand);
				gDict.setGoodsClass_expands(set);
			}
		
		}
	   if(classManaServ.update(gDict)!=null){
		   stm="修改数据成功。";
	   }else{
		   stm="修改数据失败。"; 
	   }
	   response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(stm);
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
   }

}

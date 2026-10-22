package com.fuao.fajxc.action.cms_loggin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.json.annotations.JSON;


import com.fuao.fajxc.bussiness.cms_loggin.Loginservice;
import com.fuao.fajxc.util.MD5;
import com.fuao.fajxc.vo.Fa_Cms_Admin;
import com.fuao.fajxc.vo.Fa_Cms_AdminModel;
import com.fuao.fajxc.vo.Fa_Cms_AdminRight;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport implements ServletRequestAware,ServletResponseAware{
	private static final long serialVersionUID = 1L;
	private Loginservice loginSer;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private Fa_Cms_Admin admins;
	private List dataTree;
	private String roLiid;
	private String strArr;
	//消息
	private String arrMessager;
	
	public String getArrMessager() {
		return arrMessager;
	}

	public void setArrMessager(String arrMessager) {
		this.arrMessager = arrMessager;
	}

	public String getRoLiid() {
		return roLiid;
	}

	public void setRoLiid(String roLiid) {
		this.roLiid = roLiid;
	}

	public String getStrArr() {
		return strArr;
	}

	public void setStrArr(String strArr) {
		this.strArr = strArr;
	}

	public List getDataTree() {
		return dataTree;
	}

	public void setDataTree(List dataTree) {
		this.dataTree = dataTree;
	}
    @JSON(serialize=false)
	public Fa_Cms_Admin getAdmins() {
		return admins;
	}

	public void setAdmins(Fa_Cms_Admin admins) {
		this.admins = admins;
	}

	public void setLoginSer(Loginservice loginSer) {
		this.loginSer = loginSer;
	}

	public void setServletRequest(HttpServletRequest arg0) {
		
		this.request = arg0;
		
	}
	public void setServletResponse(HttpServletResponse arg0) {

       this.response =  arg0;
		
	}
	


	public String execute() throws Exception {
		System.out.println("我来了...");
		return null;
	}

	public void validate() {
		this.clearFieldErrors();
		this.clearErrors();
		if(this.admins == null){
			return ;
		}
		if(this.admins.getUsername().equals("") || this.admins.getUsername()==null){
		   this.addFieldError("names", "请输入用户名");
		}else if(this.admins.getAdmin_password().equals("") || this.admins.getUsername()==null){
		   this.addFieldError("names", "请输入密码");
		}else if(this.admins.getAdmCode().equals("") || this.admins.getUsername()==null){
		   this.addFieldError("names", "请输入验证码");
		}else{
			
		}
	}
	@SuppressWarnings("unchecked")
	public String LoginEnter(){
			System.out.println("enter loggin on ...");
			int adid=0;
			String meth="";
			MD5 m5 = new MD5();
			if(this.admins == null){
				return "input";
			}
			String md5String=m5.get3DESEncrypt(this.admins.getAdmin_password().trim(),"mima");
	        String sranString=(String) request.getSession().getAttribute("random");
			System.out.println("md5="+md5String+"和="+sranString);
			if(this.admins.getAdmCode().equals(sranString)){
			admins.setAdmin_password(md5String);
			List<Fa_Cms_Admin> lts=this.loginSer.getdateList(admins);
			if(lts.size()>0){
				
			for (Fa_Cms_Admin fam : lts) {
				adid=fam.getUser_id();
				if(fam.getAdmin_status() == 1){
					this.addFieldError("names","该用户处于冻结状态");
					return "input";
				}else{
					request.getSession().setAttribute("adminid",fam);
				}
			    
			}
			List lit=this.loginSer.getAllModels(adid);
			request.getSession().setAttribute("modelist",lit);
			meth="success";
			return "success";
			}else{
			this.addFieldError("names","用户名或密码输入有误");
			meth="input";
			return "input";
			}
		}else{
			this.addFieldError("names","验证码输入有误");
			meth="input";
		}
		return meth;
	}
	public String createTrees(){
		List parentLimit = this.loginSer.getOnTrees();
		System.out.println("parentLimit==="+parentLimit+"adminId="+admins.getUser_id());
		List lst = new ArrayList();
		Iterator iter = parentLimit.iterator();
		while(iter.hasNext()){
			Fa_Cms_AdminModel limit = (Fa_Cms_AdminModel)iter.next();
			Map map = new HashMap();
			String val = limit.getModelico().substring(0, 2);
			map.put("id", limit.getModelid());
			map.put("text", limit.getModelname());
			Map m = new HashMap();
			m.put("licode", limit.getModelico());
			m.put("lipath", limit.getModelurl());
			map.put("attributes", m);
			List child = this.chilonLimit(val);
			if(child.size() != 0){
				map.put("state", "closed");
				map.put("children", this.chilonLimit(val));
			}else{
				if(this.loginSer.getbyObject(admins,limit).size() != 0){
					map.put("checked", true);
				}
			}
			lst.add(map);
		}
		dataTree = lst;
		System.out.println("goOut="+lst);
		return SUCCESS;
	}
	public List chilonLimit(String val){
		List chilLimit = this.loginSer.getToTrees(val);
		List lst = new ArrayList();
		Iterator iter = chilLimit.iterator();
		while(iter.hasNext()){
			Fa_Cms_AdminModel limit = (Fa_Cms_AdminModel)iter.next();
			Map map = new HashMap();
			String tw=limit.getModelico().substring(0,4);
			map.put("id", limit.getModelid());
			map.put("text", limit.getModelname());
			Map m = new HashMap();
			m.put("licode", limit.getModelico());
			m.put("lipath", limit.getModelurl());
			map.put("attributes", m);
			List child = this.chilToLimit(tw);
			if(child.size() != 0){
				map.put("state", "closed");
				map.put("children", this.chilToLimit(tw));
			}else{
				if(this.loginSer.getbyObject(admins,limit).size() != 0){
					map.put("checked", true);
				}
			}
			System.out.println("chilLimit ==="+limit.getModelico());
			lst.add(map);
		}
		return lst;
	}
	public List chilToLimit(String tw){
		List chilLimit = this.loginSer.getthTrees(tw);
		List lst = new ArrayList();
		Iterator iter = chilLimit.iterator();
		while(iter.hasNext()){
			Fa_Cms_AdminModel limit = (Fa_Cms_AdminModel)iter.next();
			Map map = new HashMap();
			map.put("id", limit.getModelid());
			map.put("text", limit.getModelname());
			Map m = new HashMap();
			m.put("licode", limit.getModelico());
			m.put("lipath", limit.getModelurl());
			map.put("attributes", m);
			if(this.loginSer.getbyObject(admins,limit).size() != 0){
				map.put("checked", true);
			}
			System.out.println("chilLimit3 ==="+limit.getModelico());
			lst.add(map);
		}
		return lst;
	}
	public String sRoLimit(){
		int flag=0;
		System.out.println("roliid="+this.roLiid+"@@@strarr="+this.strArr);
		List<Fa_Cms_AdminRight> adminright= this.loginSer.getByModelId(Integer.parseInt(this.roLiid));
		System.out.println("length="+adminright.size());
		if(adminright.size()>0){
			for (Fa_Cms_AdminRight faRight : adminright) {
				  if(this.loginSer.deleteDate(faRight)){
					  flag=1;
				  }else{
					  flag=0;
					  break;
				  }
			}
			if(flag==1){
				  if(CommentDeals()){
					  arrMessager="修改权限成功。";
				  }else{
					  arrMessager="修改权限失败。";
				  }
			}else{
				 arrMessager="修改权限失败。";
			}
		}else{
			 if(CommentDeals()){
				  arrMessager="修改权限成功。";
			  }else{
				  arrMessager="修改权限失败。";
			  }
		}
       return SUCCESS;
	}
	//保存中间表
	public boolean CommentDeals(){
		  int flag=0;
		  String str[]=this.strArr.split(",");
		  Set set = new HashSet();
		  for (int i = 0; i < str.length; i++) {
			 set.add(str[i]);
		  }
		  for(Iterator it = set.iterator();it.hasNext();){
			  String strin=(String) it.next();
			  Fa_Cms_AdminModel cmsmodel = new Fa_Cms_AdminModel();
			  cmsmodel.setModelid(Integer.parseInt(strin));
			  Fa_Cms_AdminRight cmsRight=new Fa_Cms_AdminRight();
			  Fa_Cms_Admin adm = new Fa_Cms_Admin();
			  adm.setUser_id(Integer.parseInt(this.roLiid));
			  cmsRight.setMods(cmsmodel);
			  cmsRight.setAdmins(adm);
			  cmsRight.setEditdate(new Date());
			  if(this.loginSer.saveDate(cmsRight)){
				  flag=1;
			  }else{
				  flag=0;
			  }
		  }
		  if(flag==1){
			  return true;
		  }else{
			  return false;
		  }
	}
}

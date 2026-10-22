package com.fuao.fajxc.bussiness.cms_loggin;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.fuao.fajxc.dao.cms_adminmodel.AdminModelDao;
import com.fuao.fajxc.dao.cms_loggin.LoginDao;
import com.fuao.fajxc.vo.Fa_Cms_Admin;
import com.fuao.fajxc.vo.Fa_Cms_AdminModel;
import com.fuao.fajxc.vo.Fa_Cms_AdminRight;
import com.fuao.fajxc.vo.Fa_Cms_LimitFront;

public class Loginserviceimpl implements Loginservice{
  
	private LoginDao loginDo;
	private AdminModelDao adminMode;
	public AdminModelDao getAdminMode() {
		return adminMode;
	}

	public void setAdminMode(AdminModelDao adminMode) {
		this.adminMode = adminMode;
	}

	public LoginDao getLoginDo() {
		return loginDo;
	}

	public void setLoginDo(LoginDao loginDo) {
		this.loginDo = loginDo;
	}

	public boolean deleteDate(Object obj) {
		
		return this.loginDo.deleteDate(obj);
	}

	public Object getObjDate(int id) {
		return null;
	}

	public List getdateList(Object obj) {
	  return this.loginDo.getdateList(obj);
	}

	public boolean saveDate(Object obj) {	
		return this.loginDo.saveDate(obj);
	}

	public boolean updateDate(Object obj) {
		
		return false;
	}

	public List getAllModels(int m) {
		List list=this.adminMode.getAllModels(m);
		List lit=new ArrayList();
		for(Iterator iter=list.iterator();iter.hasNext();){
			Fa_Cms_AdminRight admd=(Fa_Cms_AdminRight) iter.next();
			Fa_Cms_LimitFront front = new Fa_Cms_LimitFront();
			front.setModelname(admd.getMods().getModelname());
			front.setModelalias(admd.getMods().getModelalias());
			front.setModelurl(admd.getMods().getModelurl());
			front.setModelico(admd.getMods().getModelico());
			lit.add(front);
		}
		System.out.println("admd_lit="+lit.size());
		return lit;
	}

	@SuppressWarnings("unchecked")
	public List getOnTrees() {
		return this.adminMode.getOnTrees();
	}

	@SuppressWarnings("unchecked")
	public List getToTrees(String ca) {
		return this.adminMode.getToTrees(ca);
	}

	@SuppressWarnings("unchecked")
	public List getthTrees(String ca) {
		return this.adminMode.getthTrees(ca);
	}

	@SuppressWarnings("unchecked")
	public Set getbyObject(Object obj, Object ob) {
		List list=this.adminMode.getbyObject(obj,ob);
		Set set = new HashSet();
		for(Iterator ite = list.iterator();ite.hasNext();){
			Fa_Cms_AdminRight admin = (Fa_Cms_AdminRight) ite.next();
			set.add(admin.getMods().getModelid());
		}
		return set;
	}

	public List getByModelId(int id) {
		
		return this.loginDo.getByModelId(id);
	}

	public List getByTwoGrade(Fa_Cms_Admin obj, Fa_Cms_AdminModel ob) {
		
		return this.adminMode.getByTwoGrade(obj, ob);
	}

	

}

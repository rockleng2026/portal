package com.fuao.fajxc.bussiness.cms_loggin;

import java.util.List;
import java.util.Set;

import com.fuao.fajxc.util.IterfaceConmens;
import com.fuao.fajxc.vo.Fa_Cms_Admin;
import com.fuao.fajxc.vo.Fa_Cms_AdminModel;

public interface Loginservice extends IterfaceConmens{
  
	public List getAllModels(int m);
	public List getOnTrees();
	public List getToTrees(String ca);
	public List getthTrees(String ca);
	public Set getbyObject(Object obj,Object ob);
	public List getByModelId(int id);
	public List getByTwoGrade(Fa_Cms_Admin obj,Fa_Cms_AdminModel ob);
}

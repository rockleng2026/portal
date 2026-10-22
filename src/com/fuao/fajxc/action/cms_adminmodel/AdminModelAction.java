package com.fuao.fajxc.action.cms_adminmodel;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import sun.io.CharToByteASCII;

import com.fuao.fajxc.dao.cms_adminmodel.AdminModelDao;
import com.fuao.fajxc.vo.Fa_Cms_AdminModel;
import com.fuao.fajxc.vo.Fa_Cms_News;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * @author 袁天龙 2012.9.3
 *
 */
public class AdminModelAction extends ActionSupport implements ServletRequestAware,ServletResponseAware{
	private AdminModelDao adminmodelDao;
	private List modelList;
	private Fa_Cms_AdminModel model;
	private Logger logs = Logger.getLogger(AdminModelAction.class);
	private int total;
	private int current;
	private int page;
	private int row;
	private String del;
	private String mid;
	private int menu;
	private static int flags;
    private List rows=new ArrayList();
    private HttpServletRequest request;
	private HttpServletResponse response;
	
	public void setAdminmodelDao(AdminModelDao adminmodelDao) {
		this.adminmodelDao = adminmodelDao;
	}
	public List getModelList() {
		return modelList;
	}
	public void setModelList(List modelList) {
		this.modelList = modelList;
	}
	public Fa_Cms_AdminModel getModel() {
		return model;
	}
	public void setModel(Fa_Cms_AdminModel model) {
		this.model = model;
	}	
    public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getCurrent() {
		return (this.page-1)*this.row;
	}
	public void setCurrent(int current) {
		this.current = current;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRow() {
		return row;
	}
	public void setRow(int row) {
		this.row = row;
	}
	public List getRows() {
		return rows;
	}
	public void setRows(List rows) {
		this.rows = rows;
	}

	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public static int getFlags() {
		return flags;
	}
	public static void setFlags(int flags) {
		AdminModelAction.flags = flags;
	}
	
	public int getMenu() {
		return menu;
	}
	public void setMenu(int menu) {
		this.menu = menu;
	}
	/***
	 * 分页显示模块信息
	 * @return
	 */
	public String splitPages(){
	    System.out.println("分页了。。。");
		total=adminmodelDao.countData("select count(*) from Fa_Cms_AdminModel");
		System.out.println("pageCount="+total);
		this.page=Integer.parseInt(request.getParameter("page"));
		//页面大小
		this.row=Integer.parseInt(request.getParameter("rows"));
		System.out.println("page="+page+"##row="+row);
		rows=adminmodelDao.splitPages(this.getCurrent(),this.row,"from Fa_Cms_AdminModel order by modelid desc");
		System.out.println("rows="+this.rows);
	    return "success";	
	}
	
	
	/**
	 * 添加方法
	 */
	public String modelAdd(){
		model.setEditdate(new Date());
		adminmodelDao.addModel(model);
		return "aa";
	}
	
	/**
	 * 添加时,限定菜单和ICO
	 */
	public String checkICO(){
		
		String ico = request.getParameter("menu");
		String icoback=ico;
		// 查出的一级菜单的集合。
		if(ico.equals("010000")){
			ico=ico.substring(1, 2);
			List<Fa_Cms_AdminModel> list=adminmodelDao.getOneMenu("%0000");
			icoback=icoback.replaceAll(ico, (list.size()+1+""));
		}
		try {
			response.getWriter().print(icoback);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 读取一级菜单
	 *
	 */
	public void getoneMenus(){
		String icon="";
		List<Fa_Cms_AdminModel> list=adminmodelDao.modelList("from Fa_Cms_AdminModel f where substring(f.modelico,3,4)='0000'");
	    for (Fa_Cms_AdminModel faCmsAdmin : list) {
			icon+="<option value='"+faCmsAdmin.getModelico()+"'>"+faCmsAdmin.getModelname()+"</option>";
		}
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(icon);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 通过一级读取二级菜单
	 */
	@SuppressWarnings("unchecked")
	public void getoneandTwoMenus(){
		logs.info("two code="+mid);
		String licoString = mid.substring(0,2);
		logs.info("lico="+licoString);
		String lico="";
		List<Fa_Cms_AdminModel> list = adminmodelDao.modelList("from Fa_Cms_AdminModel f where substring(f.modelico,5,2)='00' and substring(f.modelico,1,2)='"+licoString+"'  and substring(f.modelico,3,4)<>'0000'");
		for (Fa_Cms_AdminModel faCmsAd : list) {
				lico+="<option value='"+faCmsAd.getModelico()+"'>"+faCmsAd.getModelname()+"</option>";
		}
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(lico);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 添加二级菜单。
	 */
	public void addTwoMenus(){
		logs.info("two code="+mid);
		String licoString = mid.substring(0,2);
		logs.info("lico="+licoString);
		List<Fa_Cms_AdminModel> list = adminmodelDao.modelList("from Fa_Cms_AdminModel f where substring(f.modelico,5,2)='00' and substring(f.modelico,1,2)='"+licoString+"'");
		StringBuffer str = new StringBuffer();
		if(list.size()<10){
		   str.append(licoString).append("0").append(list.size()).append("00");
		}else{
		   str.append(licoString).append(list.size()).append("00");
		}
		String lico = str.toString();
		logs.info("lico2="+lico);
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(lico);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 添加三级菜单
	 */
	public void addThreeMenus(){
		logs.info("three="+mid);
		String mString = mid.substring(0,4);
		logs.info("mstring"+mString);
		List<Fa_Cms_AdminModel> list = adminmodelDao.modelList("from Fa_Cms_AdminModel f where substring(f.modelico,1,4)='"+mString+"'");
		StringBuffer str = new StringBuffer();
		if(list.size()<10){
		   str.append(mString).append("0").append(list.size());
		}else{
		   str.append(mString).append(list.size());
		}
		String lico = str.toString();
		response.setContentType("text/html;charset=GBK");
		try {
			response.getWriter().write(lico);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 添加模块名称时重复名称验证
	 */
	public String checkName(){
		HttpServletResponse res = ServletActionContext.getResponse();
		res.setContentType("text/html;charset=utf-8");
		String name="";
		try {

			name=URLDecoder.decode(model.getModelname(),"utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		System.out.println(name);
		PrintWriter out = null;
		modelList = adminmodelDao.getObjects("from Fa_Cms_AdminModel a where a.modelname=?",new Object[]{name});
		System.out.println(modelList.size()+modelList.toString());
		try {
			out = res.getWriter();
			if(modelList.size()>0){ //存在同名
				out.print("ERROR");
			}else {
				out.print("SUCCESS");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 准备修改方法
	 * @return
	 */
	public String update(){
		Integer mid = Integer.parseInt(request.getParameter("modelid"));
		System.out.println(mid);
		model = adminmodelDao.getModelById(Fa_Cms_AdminModel.class, mid);
		System.out.println(model.getModelname()+model.getModelalias());
		return "update";
	}
	
	/**
	 * 点击保存  修改数据
	 */
	public String updatemodel(){
		System.out.println(model.getModelname());
		Fa_Cms_AdminModel oldModel = adminmodelDao.getModelById(Fa_Cms_AdminModel.class, model.getModelid());
		System.out.println(oldModel.getModelname());
		oldModel.setModelname(model.getModelname());
		System.out.println(model.getModelname());
		oldModel.setModelalias(model.getModelalias());
		oldModel.setModelico(model.getModelico());
		oldModel.setModelurl(model.getModelurl());
		adminmodelDao.updateModel(oldModel);
		return "aa";
	}
	
	public String del(){
		System.out.println("======>"+mid);
		String str[]=mid.split(",");
		for (int i = 0; i < str.length; i++) {
		int id=Integer.parseInt(str[i]);
		this.model=(Fa_Cms_AdminModel)adminmodelDao.getModelById(Fa_Cms_AdminModel.class, id);
		adminmodelDao.deleteModel(model);
		flags=1;
		}
		if(flags==1){
		   this.del="删除成功！";
		}
		System.out.println(del);
		return SUCCESS;
	}
	
	
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
		
	}
	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;	
	}

}

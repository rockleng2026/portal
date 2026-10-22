package com.fuao.fajxc.action.system;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import com.fuao.fajxc.bussiness.system.WorkOrderCfigurBiz;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Department;
import com.fuao.fajxc.vo.Empassess;
import com.fuao.fajxc.vo.Questioncategory;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class WorkOrderCfigurAction implements ModelDriven,ServletRequestAware,ServletResponseAware{

	private HttpServletRequest request;
	private HttpServletResponse response;
	private WorkOrderCfigurBiz wocbiz;
	private Questioncategory qc;
	
	/**
     * 添加工单配置
     */
	public String addwoc(){
		
		String qid = request.getParameter("questioncategoryid");
		//为Questioncategory设定父ID
		if(qid != null && qid !="" && !qid.equals("")){
			
			Questioncategory question = new Questioncategory();
			
			question.setId(Integer.parseInt(qid));
			
			qc.setQuestioncategory(question);
		}else
		{
			qc.setQuestioncategory(null);
		}
		//如果对象的ID不为null表示是修改。则先删除所以的考核配置在重新添加
		if(qc.getId() != null)
		{
			wocbiz.delempAssess(qc.getId());
		}
		//如果是否考核为Y的时候表示需要考核。则添加考核描述
		if(qc.getIsAssess()=="Y" || qc.getIsAssess().equals("Y")){
			
		String[] assesss = request.getParameterValues("assess");
		
		String[] depIds = request.getParameterValues("depId");
		
		String[] durations = request.getParameterValues("duration");	
		
		List<Empassess> list = new ArrayList();		
				
		if(assesss != null && depIds != null && durations != null &&
				
		   assesss.length>0  && depIds .length>0 && durations .length>0){
			
		for(int i=0; i<depIds.length; i++)
		{
			Department department = new Department();
			
			department.setId(Integer.parseInt(depIds[i]));
			
			Empassess empassess = new Empassess();
									
			empassess.setDepartment(department);
			
			empassess.setAssess(assesss[i]);
			
			empassess.setDuration(Integer.parseInt(durations[i]));
			
			list.add(empassess);		

		}
		wocbiz.addorupdate(qc, list);
		}
		
		}else{
			wocbiz.addorupdate(qc, null);
		}
		return "select";
	}

	
	/**
	 * 查询工单类型信息
	 */
	public String get(){
		String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
		
		String name = request.getParameter("name");
		
		String hql="from Questioncategory as tb where 1=1";
		
		if(name != null && name !="" && !name.equals(""))
		{
			hql += " and tb.questionName like '%"+name+"%'";
		}
		hql+=" order by tb.id desc";
		Pages pages=wocbiz.exHqlObjectPages(hql, Integer.parseInt(pageNo), 15, null);
		request.setAttribute("pages", pages);
        Map map = (Map)ActionContext.getContext().get("map");
		
        ServletActionContext.getRequest().setAttribute("option", map);
		return "list";
	}

/**
 * 跳转到修改页面
 */
    public String updatepage(){
    	
    	String id = request.getParameter("id");
    	
    	if( null != id && !id.equals("")){
    		
    		int wid = Integer.parseInt(id);
    		
    		Questioncategory qt = wocbiz.getqt(wid);
    		
    		request.setAttribute("qt", qt);
    	}
    	
    	return "updatepage";
    }

    /**
     * 删除记录
     * @throws IOException 
     */
    public String del() throws IOException
    {
    	String id = request.getParameter("id");
    	
    	if(null != id && id !="")
    	{
    		wocbiz.delempAssess(Integer.parseInt(id));
    		
    		wocbiz.delqc(Integer.parseInt(id));
    		
    		response.getWriter().print(0);
    	}else{
    		response.getWriter().print(0);
    	}
    	
    	return null;
    }
	public Object getModel() {
		qc = new Questioncategory();
		return qc;
	}
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
		
	}
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
		
	}
	public WorkOrderCfigurBiz getWocbiz() {
		return wocbiz;
	}
	public void setWocbiz(WorkOrderCfigurBiz wocbiz) {
		this.wocbiz = wocbiz;
	}
	
	public String geiTime() throws IOException{
		
	    	
	    	String id = request.getParameter("id");
	    	
	    	if( null != id && !id.equals("")){
	    		
	    		int wid = Integer.parseInt(id);
	    		
	    		Questioncategory qt = wocbiz.getqt(wid);
	    		
	    		response.getWriter().print(qt.getTmp1());
	    		

	    	}else{
	    		response.getWriter().print(0);
	    	}
	    	
	    	return null;
	}

}
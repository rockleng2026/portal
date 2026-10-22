package com.fuao.fajxc.action.executeRecord;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.executeRecord.ExecuteRecordBussiness;
import com.fuao.fajxc.util.Pages;
public class TodoAction implements ServletRequestAware,ServletResponseAware {

	private HttpServletRequest request;
	private HttpServletResponse response;
	
	private ExecuteRecordBussiness executeRecordBussiness;
	public void setServletRequest(HttpServletRequest arg0) {
		this.request = arg0;
		
	}

	public void setServletResponse(HttpServletResponse arg0) {
		this.response = arg0;
		
	}

	public ExecuteRecordBussiness getExecuteRecordBussiness() {
		return executeRecordBussiness;
	}

	public void setExecuteRecordBussiness(
			ExecuteRecordBussiness executeRecordBussiness) {
		this.executeRecordBussiness = executeRecordBussiness;
	}
	/**
	 * 即将到期以及即将过期单据提醒
	 * @return
	 */
	public String select(){
		
		//获取单据即将到期的单据ID集合
		String ids = request.getParameter("ids");
		
		request.setAttribute("ids", ids);
		
		if(ids.indexOf("[")!=-1){
			ids = ids.substring(1,ids.length()-1);
			
		}
		
		//获取单据实体名
		String table = request.getParameter("eitTable");
		
		request.setAttribute("eitTable", table);
		
		String hql = "from "+table+" where id in("+ids+")";
		
		int pageNo = request.getParameter("pageNo")==null?1:Integer.parseInt(request.getParameter("pageNo"));
		
		Pages pages = executeRecordBussiness.exHqlPages(hql, pageNo,50, null);
		
		request.setAttribute("pages", pages);
		
		return table;
	}
/**
 * 功能搜索
 */
	public String getFunctionList(){
		
		
		return "functionlist";
	}
}

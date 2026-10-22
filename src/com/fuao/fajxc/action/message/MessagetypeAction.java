package com.fuao.fajxc.action.message;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.message.MessageBussiness;
import com.fuao.fajxc.bussiness.message.MessagetypeBussiness;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Messagetype;
import com.opensymphony.xwork2.ModelDriven;
public class MessagetypeAction  implements ModelDriven,ServletRequestAware,ServletResponseAware{	
		private MessagetypeBussiness messagetypeBussiness;
		private HttpServletRequest request;
		private HttpServletResponse response;
		private Messagetype Messagetype;
		private MessageBussiness messageBussiness;
		private Object[] ids;

		
		public Object[] getIds() {
			return ids;
		}
		public void setIds(Object[] ids) {
			this.ids = ids;
		}
		public MessageBussiness getMessageBussiness() {
			return messageBussiness;
		}
		public void setMessageBussiness(MessageBussiness messageBussiness) {
			this.messageBussiness = messageBussiness;
		}
		public MessagetypeBussiness getMessagetypeBussiness() {
			return messagetypeBussiness;
		}
		public void setMessagetypeBussiness(MessagetypeBussiness messagetypeBussiness) {
			this.messagetypeBussiness = messagetypeBussiness;
		}
		public Object getModel() {
			Messagetype =new Messagetype();
			return Messagetype;
		}
		/**
		 * 得到request
		 */
		public void setServletRequest(HttpServletRequest arg0) {
			this.request=arg0;
			
		}
		
		/**
		 * 得到response
		 */
		public void setServletResponse(HttpServletResponse arg0) {
			this.response=arg0;
			
		}
		
		/*
		 * 添加或更改
		 */
		public String add(){
			try {
				
				boolean thing= messagetypeBussiness.addData(Messagetype);
			 return	this.getpage();
			} catch (Exception e) {
				e.printStackTrace();
				return "will";
			} 
		}
		
		/*
		 * 删除客户信息对象
		 */
		public String del(){
			try {
				boolean flag=messageBussiness.delmesstype(ids);
				response.getWriter().print(0);
			} catch (Exception e) {
				e.printStackTrace();
				try {
					response.getWriter().print(1);
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			}
			return null;
		}
		
		/*
		 * 更改客户信息对象
		 */
		public String update(){
			try {
				String MessagetypeId=request.getParameter("MessagetypeId");//客户主键编号
				messagetypeBussiness.updateData(Messagetype);
				return this.getpage();
			} catch (Exception e) {
				return "sess"; 
			}
		}
		
		/*
		 * 根据条件进行筛选查询客户信息
		 */
		public String getpage(){
			System.out.println(111111);
			String pageNo = request.getParameter("pageNo")==null?"1":request.getParameter("pageNo");
			String MessagetypeId=request.getParameter("MessagetypeId");//客户主键编号
			String hql="from Messagetype where 1=1 and delflag!=1 and (superid=1 or superid=2) order by messagetypeid desc";
			System.out.println("hql:::"+hql);
			Pages pages=messagetypeBussiness.exHqlPages(hql, Integer.parseInt(pageNo), 10, null);
			request.setAttribute("pages", pages);
			return "listMessagetype";
		}
		
		/*
		 * 获取单个客户信息对象
		 */
		public String get(){
			System.out.println(22222);
			try {
				String id=request.getParameter("id");
				System.out.println("id:::::"+id);
				if(id!=null){
					Messagetype data=messagetypeBussiness.getMessageTypedata(id);
					request.setAttribute("data", data);
				}
				String hql="from Messagetype where superid=11";
				List<Messagetype> meslist=messagetypeBussiness.exHql(hql);
				System.out.println("listsize:::"+meslist.size());
				request.setAttribute("messagetypes", meslist);
				return "messagetype";
			} catch (Exception e) {
				return "will";
			}
		}
		
}

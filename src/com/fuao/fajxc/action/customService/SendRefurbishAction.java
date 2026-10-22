package com.fuao.fajxc.action.customService;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.customService.SendRefurbishBussiness;
import com.fuao.fajxc.bussiness.message.MessageBussiness;
import com.fuao.fajxc.util.Cookies;
import com.fuao.fajxc.util.PropertyEditor;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.Messagereceiver;
import com.fuao.fajxc.vo.Sendmessage;
import com.opensymphony.xwork2.ModelDriven;

public class SendRefurbishAction implements ServletRequestAware,ServletResponseAware {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private SendRefurbishBussiness sendbus;
	Cookies cookie = new Cookies();
	private MessageBussiness messageBussiness;
	
	
	
	
	
	public MessageBussiness getMessageBussiness() {
		return messageBussiness;
	}
	public void setMessageBussiness(MessageBussiness messageBussiness) {
		this.messageBussiness = messageBussiness;
	}
	public void setServletRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		this.request=request;
	}
	public void setServletResponse(HttpServletResponse response) {
		// TODO Auto-generated method stub
		this.response=response;
	}
	public SendRefurbishBussiness getSendbus() {
		return sendbus;
	}
	public void setSendbus(SendRefurbishBussiness sendbus) {
		this.sendbus = sendbus;
	}
	
	public String sendRef()
	{
		String mes="";
		//获得登录用户信息
		String eid=cookie.getCookie(request, "employeeId");
		String depid=cookie.getCookie(request, "departmentId");
		int empid=0;
		if(eid!=null)
			empid=Integer.parseInt(eid);
		
		String hql="from Sendmessage where state=0";
		List<Sendmessage> list=sendbus.someList(hql);
		try{
			if(list.size()>0){
				//用于存放新增客户提醒
				String cusid="";
				//用于存放故障申请提醒
				String conkid="";
				for(int i=0;i<list.size();i++){
					Sendmessage sendmes=list.get(i);
					if(sendmes.getSendtable().equals("Customer"))
						cusid+=sendmes.getSendtableId()+",";
					else if(sendmes.getSendtable().equals("ConkOut"))
						conkid+=sendmes.getSendtableId()+",";
				}
				
					
					if(cusid!="" && !cusid.equals("")){
						cusid=cusid.substring(0,cusid.length()-1);
						String hql1="from Customer where customerId in ("+cusid+")";
						List<Customer> cuslist=sendbus.someList(hql1);
						if(cuslist.size()>0){
							mes+="<td class='bgred'><a style='color:red;' target='right' href='getpageCustomer.do?type2=1&mark1=1&funid=22'>";
							mes+="新增客户：("+cuslist.size()+")</a></td>  ";
						}
					}
					if(conkid!="" && !conkid.equals("")){
						conkid=conkid.substring(0,conkid.length()-1);
						String hql2="from ConkOut where delflag=0 and id in ("+conkid+")";
						List<ConkOut> conklist=sendbus.someList(hql2);
						if(conklist.size()>0){
							int accountzj=0;   //故障转接
							int accountcl=0;   //故障处理
							System.out.println("depId::"+depid);
							
							for(int i=0;i<conklist.size();i++){
								ConkOut cot=conklist.get(i);

								System.out.println("department:::"+cot.getEmployee());

								if(sendbus.selrolufunction(empid)){
									if(cot.getState().equals("0")||cot.getState().equals("1")||cot.getState().equals("3")){
										accountzj+=1;
									}
								}
								
								if(cot.getEmployee()!=null && depid!=null){
									if(cot.getEmployee().getId()==Integer.parseInt(depid) && !cot.getState().equals("3")){

										accountcl+=1;
									}
								}
							}
							if(accountzj!=0){
								mes+="<td class='bgred'><a style='color:red;' target='right' href='commutatorMalfunctionDeclare.do?funid=242'>";
								mes+="故障转接：("+accountzj+")</a></td>  ";
							}
							if(accountcl!=0){
								mes+="<td class='bgred'><a style='color:red;' target='right' href='selectMalfunctionDeclare.do?tag=0&funid=87'>";
								mes+="故障处理：("+accountcl+")</a></td>  ";
							}
						}
					}
					
					
					System.out.println("mes......"+mes);
					
				}
			//查找消息
			List<Messagereceiver> messlist=messageBussiness.someMessageres(1, eid, "0");
			System.out.println("messlistsize:::"+messlist.size());
			if(messlist.size()>0){
				mes+="<td class='bgred'><a style='color:red;' target='right' href='selmessbyreadflagmessage.do?restypeid=1&readflag=0'>";
				mes+="消息盒子：("+messlist.size()+")</a></td>  ";
			}
			
			if(mes!=""){
				response.setCharacterEncoding("UTF-8");
				response.getWriter().print(mes);
			}
			else
				response.getWriter().print(0);
			}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return null;
	}
}

package test;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fuao.fajxc.bussiness.customService.CustomerServiceBussiness;
import com.fuao.fajxc.vo.CommodityTpye;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.HelloBean;
import com.opensymphony.xwork2.ModelDriven;

public class CategoryAction implements ModelDriven,ServletRequestAware, ServletResponseAware ,Serializable{
	private HttpServletResponse response;
	
	private HttpServletRequest request;
	
	private CustomerServiceBussiness impl;
	String strOption = "";
	
	public Object getModel() {
		return null;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
		
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
		
	}
	
	public CustomerServiceBussiness getImpl() {
		return impl;
	}

	public void setImpl(CustomerServiceBussiness impl) {
		this.impl = impl;
	}

	
	
	public String queryChannelList()
	{
		List<CommodityTpye> functionlist = impl.getList("CommodityTpye", " and id != 61");
		List<CommodityTpye> childlist = new ArrayList<CommodityTpye>();
		for(CommodityTpye f : functionlist)
		{
			if(f.getSuperid().getId()==61)
			{
				CommodityTpye type = new CommodityTpye();
				type.setId(f.getId());
				type.setSuperid(f.getSuperid());
				type.setTypeName(f.getTypeName());
				type.setChild(this.buildNode(f.getId(),functionlist));
				childlist.add(type);
			}
		}
		String str = "";
		for(CommodityTpye node : childlist)
		{
//			System.out.println(node.getId()+"   "+node.getSuperid()+"   "+node.getTypeName());
			if(node.getSuperid().getId()==61)
			{
				strOption += "<option value='"+node.getId()+"'>"+node.getTypeName()+"</option>";
				this.bulidNode(1,node.getChild());
			}
		}
		str = strOption;
		return str;
	}
	
	public String getStr(int len , List<CommodityTpye> node)
	{
		String prefix = "|";
		for(int i=0;i<len;i++)
		{
			prefix += "----";
		}
		for(CommodityTpye f : node)
		{
			if(f.getChild().size()>0)
			{
				if(f.getTypeName()!=null)
				{
					System.out.println(prefix+""+f.getTypeName());
					strOption += "<option value='"+f.getId()+"'>"+prefix+f.getTypeName()+"</option>";
					getStr(len+1,f.getChild());
				}
			}
//			else
//			{
//				System.out.println(prefix+" "+f.getTypeName());
//			}
		}
		return strOption;
	}
	
	
	public void bulidNode(int len , List<CommodityTpye> node)
	{
		String prefix = "|";
		for(int i=0;i<len;i++)
		{
			prefix += "----";
		}
		for(CommodityTpye f : node)
		{
			if(f.getChild().size()>0)
			{
				if(f.getTypeName()!=null)
				{
					System.out.println("<option>"+prefix+""+f.getTypeName()+"</option>");
					bulidNode(len+1,f.getChild());
				}
			}
//			else
//			{
//				System.out.println(prefix+" "+f.getTypeName());
//			}
		}
	}
	
	public List<CommodityTpye> buildNode(int parentid ,List<CommodityTpye> function)
	{
		List<CommodityTpye> childlist = new ArrayList<CommodityTpye>();
		for(CommodityTpye f : function)
		{
			CommodityTpye node = new CommodityTpye();
			if(f.getSuperid().getId()!=0&&f.getSuperid().getId()==parentid)
			{
//				System.out.println(f.getSuperId()+"  =  "+parentid);
				node.setId(f.getId());
				node.setTypeName(f.getTypeName());
				List<CommodityTpye> children = buildNode(f.getId(),function);
				if(null!=children && children.size()>0)
				{
					node.setChild(children);
				}
			}
			childlist.add(node);
		}
//		System.out.println(parentid + "  size : " +childlist.size());
		return childlist;
	}
	public static void main(String args[])
	
	{
		String paths[] = {"applicationContext.xml","applicationContext-system.xml","applicationContext-basic.xml","applicationContext-commodity.xml","applicationContext-customService.xml","applicationContext-financial.xml","applicationContext-login.xml","applicationContext-message.xml","applicationContext-purchasing.xml","applicationContext-sale.xml","applicationContext-server.xml","applicationContext-stat.xml","applicationContext-stockpile.xml"};
		ApplicationContext context = new ClassPathXmlApplicationContext(paths);
		CustomerServiceBussiness impl = (CustomerServiceBussiness)context.getBean("customservicebiz");
		CategoryAction action = new CategoryAction();
		List<CommodityTpye> functionlist = impl.getList("CommodityTpye ", " and id != 61");
		List<CommodityTpye> childlist = new ArrayList<CommodityTpye>();
		for(CommodityTpye f : functionlist)
		{
//			System.out.println("111   "   +f.getSuperId());
//			System.out.println(f.getSuperId().equals(0));
			if(f.getSuperid().getId()==61)
			{
				CommodityTpye type = new CommodityTpye();
				type.setId(f.getId());
				type.setSuperid(f.getSuperid());
				type.setTypeName(f.getTypeName());
				type.setChild(action.buildNode(f.getId(),functionlist));
				childlist.add(type);
			}
		}
		
		System.out.println(childlist.size());
		
		
		System.out.println(childlist.size());
		String straction = "";
		for(CommodityTpye node : childlist)
		{
			String str = "";
//			System.out.println(node.getId()+"   "+node.getSuperid()+"   "+node.getTypeName());
			if(node.getSuperid().getId()==61)
			{
				System.out.println("<option>"+node.getTypeName()+"</option>");
				action.bulidNode(1,node.getChild());
//				System.out.println("<option value='"+node.getId()+"'>"+node.getTypeName()+"</option>");
//				str = "<option value='"+node.getId()+"'>"+node.getTypeName()+"</option>";
				str += action.getStr(1, node.getChild());
				System.out.println("begin : "+str);
			}
			straction += str;
			str = "";
		}
		System.out.println("straction:"+straction);
	}
}

package com.fuao.fajxc.action.customService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.fuao.fajxc.bussiness.basic.SupplierBussiness;
import com.fuao.fajxc.vo.Supplier;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 故障处理
 * @author 14012
 *
 */
public class MalfunctionDisposalAction implements ModelDriven,
		ServletRequestAware, ServletResponseAware {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private Supplier supplier;
	private SupplierBussiness supplierBussiness;
	public void setServletRequest(HttpServletRequest arg0) {
		// TODO Auto-generated method stub

	}

	public void setServletResponse(HttpServletResponse arg0) {
		// TODO Auto-generated method stub

	}

	public Object getModel() {
		supplier = new Supplier();
		return supplier;
	}
	/**
	 * 故障处理
	 */
	public String get()
	{
		return "success";
	}

	public String add()
	{
		supplier.setDel("0");
		boolean b= supplierBussiness.addSuplier(supplier);
		if(b){
			response.setCharacterEncoding("GBK");
		return "select";
		}
		return "error";
	}
	public SupplierBussiness getSupplierBussiness() {
		return supplierBussiness;
	}

	public void setSupplierBussiness(SupplierBussiness supplierBussiness) {
		this.supplierBussiness = supplierBussiness;
	}

}

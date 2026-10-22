package com.fuao.fajxc.bussiness.impl.customService;

import java.util.List;

import com.fuao.fajxc.bussiness.customService.CustomerServiceBussiness;
import com.fuao.fajxc.dao.customService.CustomServiceDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.DeliveryAddress;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.Users;

public class CustomerServiceBussinessImpl implements CustomerServiceBussiness{

	CustomServiceDao csdao;
	public Customer customerLogin(String loginId, String password) {
		
		return csdao.customerLogin(loginId, password);
	}

	public List getList(String entityName,String confidion)
	{
		String hql = "from "+entityName+" where 1=1 "+confidion;
		System.out.println("hql: "+hql);
		return csdao.getList(hql);
	}
	
	public Users custrmerRegister(Customer custom) {
		// TODO Auto-generated method stub
		return null;
	}

	public CustomServiceDao getCsdao() {
		return csdao;
	}

	public void setCsdao(CustomServiceDao csdao) {
		this.csdao = csdao;
	}

	public boolean updateUserLoginInfo(Users user) {
		
		return csdao.updateUserLoginInfo(user);
	}

	public Customer getcustomer(int id) {
		
		return csdao.getcustomer(id);
	}

	public List getorder(String orderType, int customerId) {
		
		return csdao.getorder(orderType, customerId);
	}
	/**
	 * 添加客户
	 * @param customer
	 * @return
	 */
	public Customer addCustomer(Customer customer)
	{
		return csdao.addCustomer(customer);
	}
	
	/**
	 * 修改客户
	 * @param customer
	 * @return
	 */
	public boolean updateCustomer(Customer customer)
	{
		return csdao.updateCustomer(customer);
	}
public Pages get(String hql, int pageNo, int pageSize, Object... values) {
		
		return csdao.paginationQuery(hql, pageNo, pageSize, values);
	}



public List selcust(String loginid,String ip) {

	return csdao.selcust(loginid,ip);
}

public String iscustomer(String loginid) {
	
	return csdao.iscustomer(loginid);
}

public List selaudState(String paratid) {
	return csdao.selaudState(paratid);
	// TODO Auto-generated method stub

}

public List selupserver() {
	
	return csdao.selupserver();
}

public void qdorder(String idString) {
	csdao.qdorder(idString);
	
}

public boolean addAddress(DeliveryAddress deliveryAddress) {
	return csdao.saveAddress(deliveryAddress);
}

public boolean checkpassword(String newpass1, String logininame) {
	return csdao.updatePassword(newpass1, logininame);
}

public Customer getCustomid(String loginname) {
	return csdao.getCustomid(loginname);
}

public void qrorder(String idString) {
   csdao.qrorder(idString);
	
}

public List<DeliveryAddress> getAddress(Customer customer) {
	
	return  csdao.getAddress(customer);
}

public DeliveryAddress getDaliver(String id) {
	  
	return csdao.getDaliver(id);
}

public void delAddress(String id) {
	csdao.delAddress(id);
}

public boolean updateAddress(DeliveryAddress deli) {
	return csdao.updateAddress(deli);
}

public void save(Object so) {
	try {
		csdao.add(so);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
}

public void addsql(String sql0) {
	csdao.addsql(sql0);
	
}

public void update(String  sql) {
	try {
		csdao.execSQLUpdate(sql);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
}

public List getSgByCode(String sgcode){
	return csdao.getSgByCode(sgcode);
}


}

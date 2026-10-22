package com.fuao.fajxc.bussiness.customService;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.DeliveryAddress;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.Users;

/**
 * 客服BIZ
 * @author 14012
 *
 */
public interface CustomerServiceBussiness {
	/**
	 * 客户登录
	 */
	public Customer customerLogin(String loginId,String password);
	
	/**
	 * 客户注册
	 */
	public Users custrmerRegister(Customer custom);
	
	/**
	 * 用户登录后修改用户登录信息
	 */
	public boolean updateUserLoginInfo(Users user);
	
	/**
	 * 查询客户信息
	 */
	public Customer getcustomer(int id);
	
	/**
	 * 查询客户产品列表
	 * @param orderType 产品类型ID
	 * @param customerId 客户ID
	 * @return
	 */
	public List getorder(String orderType,int customerId);

	/**
	 * 添加客户
	 * @param customer
	 * @return
	 */
	public Customer addCustomer(Customer customer);
	
	/**
	 * 修改客户
	 * @param customer
	 * @return
	 */
	public boolean updateCustomer(Customer customer);

	/**
	 * 根据实体名，和传入条件，查询对象列表
	 * @param entityName
	 * @param confidion
	 * @return
	 */
	public List getList(String entityName,String confidion);
	
	public Pages get(final String hql, final int pageNo,final int pageSize, final Object... values);
	/**
	 * 根据用户名id插入登录时间和ip。
	 * @param loginid
	 * @param ip 
	 */
	
	public List selcust(String loginid, String ip);
	/**
	 * 是否是正式客户
	 * @param loginid
	 * @return
	 */

	public String iscustomer(String loginid);

	
	/**修改密码*/
	
	public boolean checkpassword(String newpass1,String logininame);
	
	/**添加要求*/
	public boolean  addAddress(DeliveryAddress deliveryAddress);
	
	
	public Customer getCustomid(String loginname);
	


	public List selaudState(String paratid);

	public List selupserver();

	public void qdorder(String idString);

	public void qrorder(String idString);
	
	public List<DeliveryAddress> getAddress(Customer customer);
	
	public DeliveryAddress getDaliver(String id);
	public void delAddress(String id);
	
	public boolean updateAddress(DeliveryAddress deli);

	public void save(Object so);

	public void addsql(String sql0);

	public void update(String sql);
	
	public List getSgByCode(String sgcode);

}

package com.fuao.fajxc.dao.customService;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.ConkOut;
import com.fuao.fajxc.vo.Customer;
import com.fuao.fajxc.vo.DeliveryAddress;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Users;

/**
 * 客服Dao接口
 * @author 14012
 *
 */
public interface CustomServiceDao extends BaseDao {
	
	/**
	 * 客户登录
	 */
	public Customer customerLogin(String loginId,String password);
	
	/**
	 * 客户注册
	 */
	public Users custrmerRegister(Customer custom);

	/**
	 * 用户登录后修改用户的登录信息
	 * 
	 */
	public boolean updateUserLoginInfo(Users user);
	
	/**
	 * 查询客户信息
	 */
	public Customer getcustomer(int id);
	
	/**
	 * 查询用户产品类型
	 * 
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
	 * g根据hql查询对象
	 * @param hql
	 * @return
	 */
	public List getList(String hql);
	
	/**
	 * 根据用户名查询登录时间
	 * @param loginid
	 * @param ip 
	 * @return
	 */
	public List selcust(String loginid, String ip);

	public String iscustomer(String loginid);

	/**修改密码*/
	 
	public boolean updatePassword(String newpass1 ,String logininame);
	
	
	public boolean saveAddress(DeliveryAddress deliveryAddress);
	
	 public Customer getCustomid(String loginname);


	public List selaudState(String paratid);

	public List selupserver();

	public void qdorder(String idString);

	public void qrorder(String idString);
	
	public List<DeliveryAddress> getAddress(Customer customer);
	
	
	public DeliveryAddress getDaliver(String id);
	public void delAddress(String id);
	
	public boolean updateAddress(DeliveryAddress deli);

	public void addsql(String sql0);
	
	public List getSgByCode(String sgcode);
}

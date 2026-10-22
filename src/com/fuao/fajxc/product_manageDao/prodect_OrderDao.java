package com.fuao.fajxc.product_manageDao;

import com.fuao.fajxc.vo.DeliveryAddress;
import com.fuao.fajxc.vo.SaleGoods_mids;
import com.fuao.fajxc.vo.Sale_orders;
import com.fuao.fajxc.vo.UpServer;

public interface prodect_OrderDao extends product_CommentDao{

	void updatsql(String sql);

	
	public int delsg(Object [] ids);
	//ojb
	public Object get(Class clazz,Integer id);
	//添加销售订单aa
	public Sale_orders add(Sale_orders orders);
	//添加中间表
	public void addsm(SaleGoods_mids goodsMids);
	
	public int delRC(Object [] ids);
	
	public boolean updateRC(String sql);
	
	public String exeSql(String sql);
	
	public DeliveryAddress add(DeliveryAddress address);
	
	public boolean update(String cusid,String addressid);
	
	public UpServer add(UpServer server);
}

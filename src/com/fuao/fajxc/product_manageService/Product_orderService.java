package com.fuao.fajxc.product_manageService;

import com.fuao.fajxc.util.Pages;

public interface Product_orderService extends product_CommentService{

	Pages paginationQuery(String hql, int pageNo, int pageSize, final Object... values);
	//É¾³ý²Ù×÷aa
	public int delsg(Object [] ids);
	
	void updatsql(String sql);
	
	public int delRC(Object [] ids);

}

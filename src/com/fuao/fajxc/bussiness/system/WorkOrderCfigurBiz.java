package com.fuao.fajxc.bussiness.system;

import java.util.List;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Empassess;
import com.fuao.fajxc.vo.Questioncategory;

/**
 * 员工处理问题考核
 * @author 14012
 *
 */
public interface WorkOrderCfigurBiz {
	
	/**
	 * 添加问题Empassess
	 *  添加员工处理问题考核标准
	 */
	public boolean addorupdate(Questioncategory question, List<Empassess> list);
	
	public Pages exHqlObjectPages(String hql,int pageNo,int pageSize,
			Object... values) ;
	/**
	 * 根据ID查询对象
	 */
	 public Questioncategory getqt(int id);
	 
	 /**
	  * 删除员工处理工单的考核
	  * 传人工单ID
	  */
	 public void delempAssess(int id);
	 
	 public void delqc(int id);
	 

}

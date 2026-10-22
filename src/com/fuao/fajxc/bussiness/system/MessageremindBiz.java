package com.fuao.fajxc.bussiness.system;

import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Messageremind;
/**
 * 提醒功能业务层
 * @author 14012
 *
 */
public interface MessageremindBiz {

		
		/**
		 * 添加或者修改功能
		 * @param mr
		 * @return
		 */
		public boolean addorupmessageremind(Messageremind mr);
		
		/**
		 * 删除功能提醒
		 */
		public boolean delmessageremin(String id);
		
		/**
		 * 查询功能提醒信息
		 */
		public Pages exHqlObjectPages(String hql,int pageNo,int pageSize,
				Object... values) ;

		/**
		 * 根据ID查询对象
		 * 
		 * 
		 */
		public Messageremind getmessa(String id);
		
		/**
		 * 查询是否提醒
		 */
		public Messageremind getmr(String mark);

}

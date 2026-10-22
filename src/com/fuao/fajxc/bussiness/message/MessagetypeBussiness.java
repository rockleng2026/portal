package com.fuao.fajxc.bussiness.message;
import java.util.List;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Messagetype;

public interface MessagetypeBussiness {
		
		/*
		 * 客户基本资料
		 */
		public boolean addData(Messagetype data)throws Exception;
		
		/*
		 *修改 客户基本资料
		 */
		public boolean updateData(Messagetype data);
		
		
		public Messagetype getMessageTypedata(String id);
		/*
		 *特殊查询客户基本资料
		 */
		public List<Messagetype>  exHql(String hql);
		
		/*
		 *执行分页查询客户基本资料
		 */
		public Pages exHqlPages(String hql,int pageNo,int pageSize,Object... values);
}

package com.fuao.fajxc.bussiness.impl.sale;

import java.util.List;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.bussiness.sale.SaleorderBussiness;
import com.fuao.fajxc.dao.sale.SaleorderDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.RenewLog;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.SaledFlow;

/**
 * 销售订单业务逻辑实现类
 * @author 14012
 *
 */
public class SaleOrderBussinessImpl implements SaleorderBussiness  {
	
	private SaleorderDao sodao;
	public SaleorderDao getSodao() {
		return sodao;
	}

	public void setSodao(SaleorderDao sodao) {
		this.sodao = sodao;
	}

	/**
	 * 添加或者修改订单
	 */
	public boolean addorup(SaleOrder so) {
		
		try {
			sodao.update(so);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 添加或者修改订单
	 * @return SaleOeder
	 */
	public SaleOrder addorupdate(SaleOrder so) {
		
		try {
			SaleOrder saleOrder = sodao.addData(so);
			return saleOrder;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 分页查询订单信息
	 */
	public Pages select(String hql, int pageNo, int pagesize, Object... value) {
		
		return sodao.paginationQuery(hql, pageNo, pagesize, value);
	}

	/**
	 * 标记删除对象
	 */
	public boolean del(SaleOrder so) {
		
		return false;
	}

	/**
	 * 查询对象
	 */
	public Object getobj(String id) {
		
		return null;
	}

	public List getList(String hql) {
		
		return sodao.execHQL(hql);
	}

	public Object getObj(Class cls, String id) {
		if(id == null || id == "")
		{
			return null;
		}
		
		try {
			return sodao.select(cls, Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 订单续费
	 */
	public boolean addrenew(RenewLog rl) {
		try {
			sodao.update(rl);
			return true;
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return false;
	}
	/**
	 * 
	 * 
	 */
	public void updateSaleorder(String  slaeOrderNo) {
		try {
			sodao.updateSaleorder(slaeOrderNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public String exSql(String sql) {
		
		String returnValue="";
		
		List list = sodao.execSQL(sql);
		

        if(list != null && list.size()>0){
      	  
      	  returnValue= list.get(0).toString();
      	  
      	  returnValue = returnValue.substring(1);
        }
        
		return returnValue;
		
	}
public List exbySql(String sql) {
		
		String returnValue="";
		
		List list = sodao.execSQL(sql);
        return list;		
}
	public List getOrderList(String tableName,String hql)
	{
		String sql = "from "+tableName+" where 1=1 "+hql;
		System.out.println("hql : "+sql);
		return sodao.selectOrder(sql);
	}


	@SuppressWarnings("unchecked")
	public List getOrdersDate(String sql) {
		return sodao.selectOrder(sql);
	}

	public void saveFlowInfo(SaledFlow sfd) {
		sodao.saveFlowInfo(sfd);
		
	}

	public void updtFlowInfo(SaledFlow sfd) {
		
		sodao.updtFlowInfo(sfd);
	}

	public void update(String sql) {
		sodao.execSQLUpdate(sql);
		
	}
	

}

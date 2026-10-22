package com.fuao.fajxc.bussiness.impl.finance;

import java.util.List;

import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.bussiness.finance.ChargeBussiness;
import com.fuao.fajxc.dao.finance.ChargeDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Charge;
import com.fuao.fajxc.vo.CurrencyProcess;
import com.fuao.fajxc.vo.SaleOrder;
import com.fuao.fajxc.vo.Sale_goods;
import com.fuao.fajxc.vo.Sale_orders;

public class ChargeBussinessImpl implements ChargeBussiness {

	//收款单信息DAO注入
	private ChargeDao chargeDao;
	public ChargeDao getChargeDao() {
		return chargeDao;
	}
	public void setChargeDao(ChargeDao chargeDao) {
		this.chargeDao = chargeDao;
	}
	/**
	 * 查询所以收款单信息
	 */
	public List<Charge> getCharge() {
		
		return this.chargeDao.getCharge();
	}
	
	/**
	 * 添加收款单信息
	 */
	public boolean addCharge(Charge Charge) {
		
		return chargeDao.addCharge(Charge);
	}
	
	/**
	 * 添加收款单信息
	 * 返回对象
	 */
	public Charge addReturnCharge(Charge charge) {
		
		try {
			charge.setDel("0");
			return (Charge) chargeDao.addReturnObject(charge);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 查询收款单信息
	 * @param id
	 * @return
	 */
	public Charge getCharge(String id) {
		
		return chargeDao.getCharge(id);
	}
	/**
	 * 更改收款单信息
	 */
	public boolean updateCharge(Charge charge) {
		
		return chargeDao.updaCharge(charge);
	}
	public boolean delCharge(String id) {
	
		return chargeDao.delCharge(id);
	}
	/**
	 * 分页查询
	 */
	public Pages paginationQuery(final String hql, final int pageNo,final int pageSize, final Object... values) {

		return chargeDao.paginationQuery(hql, pageNo, pageSize, values) ;
		}

      /**
       * 得到总条数	
       */

	public int getCount() {
		
		return chargeDao.getProductCount();
	}

	/**
	 * 查询员工信息
	 */
	public List getEmp() {
		
		return this.chargeDao.getEmp();
	}
	/**
	 * 查询订单信息
	 */
	public List getSaleOrder() {
		
		return this.chargeDao.getSaleOrder();
	}
	public SaleOrder getSaleOrderOne(int id) {
		
		return this.chargeDao.getSaleOrderOne(id);
	}
	public Object getObj(String loginName) {
		
		return chargeDao.getObj(loginName);
	}
	public List getdepart(Integer id) {
		String hql="select e.department from Employee e where e.id="+id;
		return this.chargeDao.execHQL(hql);
	}
	public int updateisAu(String sql) {
		return this.chargeDao.execSQLUpdate(sql);
	}
	public Sale_orders getSaleOrderOnes(int id) {
		
		return this.chargeDao.getSaleOrderOnes(id);
	}
	public boolean updateSg(String hql) {
		return this.chargeDao.updateSg(hql);
	}
	public List find(String hql) {
		return this.chargeDao.find(hql);
	}
	public void save(CurrencyProcess cp) {
		   try {
			chargeDao.add(cp);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}	
	


}

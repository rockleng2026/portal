package com.fuao.fajxc.dao.impl.finance;

import java.util.List;

import org.hibernate.Session;

import com.fuao.fajxc.dao.finance.FinanceDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;

public class FinanceDaoImpl extends BaseDaoImpl implements FinanceDao{

	public List getObjectsBySQL(String sql) {
		Session session = super.getSession();
		return session.createSQLQuery(sql).list();
	}
	
	public static void main(String[] args) {
		FinanceDao dao = new FinanceDaoImpl();
		String sql = "select * from saleorder";
		List list = dao.getObjectsBySQL(sql);
		System.out.println(list.size());
	}

}

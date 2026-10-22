package com.fuao.fajxc.dao.impl;

import java.util.List;

import org.hibernate.Query;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.dao.FunctionInfoDao;
import com.fuao.fajxc.vo.FunctionInfo;

public class FunctionInfoDaoImpl extends HibernateDaoSupport implements FunctionInfoDao {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public List<FunctionInfo> getFunctionsList() {
		// TODO Auto-generated method stub
		String sql = "from FunctionInfo";
		Query query = this.getSession().createQuery(sql);
		List<FunctionInfo> infolist = query.list();
		if(infolist.size()>0)
		{
			return infolist;
		}
		return null;
	}

	public static void main(String args[])
	{
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		FunctionInfoDaoImpl impl = (FunctionInfoDaoImpl)ac.getBean("FunctionInfoDao");
		List<FunctionInfo> list = impl.getFunctionsList();
		for(int i=0;i<list.size();i++)
		{
			System.out.println(list.get(i).getLinkFunctionName());
		}
		System.out.println(list.size());
	}
}

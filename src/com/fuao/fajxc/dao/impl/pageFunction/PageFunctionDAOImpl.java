package com.fuao.fajxc.dao.impl.pageFunction;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.pageFunction.PageFunctionDAO;
import com.fuao.fajxc.vo.pagefunction;

/*
 *添加页面功能链接
 *author:王雄
 *email:wangxiong@fuao.com
 */
public class PageFunctionDAOImpl extends BaseDaoImpl implements PageFunctionDAO {
	
	Logger logger = Logger.getLogger(PageFunctionDAOImpl.class);
	public boolean addPageFunction(pagefunction pagefunction) {

		boolean flag = false;
		String sql = "insert into pagefunction(name,funcitonid,linkFunctionPage,description,delflag,onlyflag) values('"
				+ pagefunction.getName()
				+ "',"
				+ pagefunction.getFunction().getFunctionId()
				+ ",'"
				+ pagefunction.getLinkFunctionPage()
				+ "','"
				+ pagefunction.getDescription()
				+ "',"
				+ pagefunction.getDelflag()
				+","+pagefunction.getOnlyflag()+")";
		
		Query query = this.getSession().createSQLQuery(sql);
		int count = query.executeUpdate();
		if(count>0)
		{
			logger.info("++add pagefunction sucesss");
			flag = true;
		}
		

		return flag;
	}

	public List find(String tableName, String andhql) {
		return null;
	}

	public boolean delPF(Integer id) {
		boolean flag = false;
		try {
			String sql = "delete from  pagefunction where 1=1 and id ="+id;
			Query query = this.getSession().createSQLQuery(sql);
			int count = query.executeUpdate();
			if(count>0)
			{
				flag = true;
			}
		} catch (Exception e) {
			logger.error("delete pagefunction daoImpl"+PageFunctionDAOImpl.class.getName());
		}
		
		return flag;
	}

}

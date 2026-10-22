/**
 * 
 */
package com.fuao.fajxc.dao.impl.system;

import java.util.ArrayList;

import java.util.List;

import org.apache.commons.io.output.NullWriter;
import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;
import org.hibernate.Query;
import org.hibernate.connection.UserSuppliedConnectionProvider;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.system.FunctionInfoSystemDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.FunctionInfo;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Users;

/**
 * @author 蔡亚俊
 *
 * 2011-7-11
 */
public class FunctionInfoSystemDaoImpl extends BaseDaoImpl implements FunctionInfoSystemDao {

	/**
	 * 获取用户列表
	 * @return
	 */
	public List<Users> getUserList(String mark)
	{
		String sql = "from Users u where u.mark=?";
		Query query = this.getSession().createQuery(sql);
		query.setString(0, mark);
		List<Users> users = query.list();
		if(users.size()>0)
		{
			return users;
		}
		return null ;
	}
	
	/**
	 * 获取所有功能菜单
	 * @return
	 */
	public List<FunctionInfo> getAllFunctions()
	{
		String hql = "from FunctionInfo";
		Query query = this.getSession().createQuery(hql);
		List<FunctionInfo> functionlist = query.list();
		if(functionlist.size()>0)
		{
			return functionlist;
		}
		return null;
	}
	
	/**
	 * 获取superID下功能菜单
	 * @param superId
	 * @return
	 */
	public List<FunctionInfo> getFunctionsBySuperId(int superId)
	{
		String hql = "from FunctionInfo info where info.superId="+superId+" order by delflag";
		System.out.println("sql : "+hql);
		Query query = this.getSession().createQuery(hql);
		List<FunctionInfo> superfunctionlist = query.list();
		return superfunctionlist;
	}
	
	/**
	 * 根据用户Id设置访问权限
	 * @param userid
	 * @return
	 */
	public int setPermission(RoleFunctionInfo info)
	{
		System.out.println(info.getRoleFunctionId()+"   "+info.getUsers().getUserId()+"   "+info.getFunctionIds()+"  update  "+info.getPermissions());
		int result = 0;
		if(info!=null)
		{
			System.out.println("execute dao ....... ");
			System.out.println(getSession());
			System.out.println(getSession()==null);
			getSession().saveOrUpdate(info);
			RoleFunctionInfo rf = this.isExistsPermissionByUserId(info.getUsers().getUserId());
			if(rf.getRoleFunctionId()>0)
			{
				result = rf.getRoleFunctionId();
				return result;
			}
		}
		return 0;
	}
	
	/**
	 * 根据用户id查询该用户是否存在访问权限
	 * @param userid
	 * @return
	 */
	public RoleFunctionInfo isExistsPermissionByUserId(int userid)
	{
		System.out.println("execute isExistsPermissionByUserId........");
		String hql = "from RoleFunctionInfo rff where rff.users.userId=?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, userid);
		List list = query.list();
		System.out.println(list.size());
		
		if(list.size()>0)
		{
			RoleFunctionInfo rff=(RoleFunctionInfo)list.get(0);
			if(rff.getRoleFunctionId()>0)
			{
				return rff;
			}
		}
		
		return null;
	}
	
	/**
	 * 根据用户id查询该用户在roleFunctionInfo表中是否存在
	 * @param userid
	 * @return
	 */
	public boolean isPermissionByUserId(int userid)
	{
		System.out.println("isPermissionByUserId  ....  ");
		boolean flag = false;
		String hql = "from RoleFunctionInfo rff where rff.users.userId=?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, userid);
		if(query.list().size()>0){
			System.out.println("boolean : "+query.list().size());
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 根据用户id查询是否有该用户，有则返回这个对象
	 * @param userid
	 * @return
	 */
	public Users isExistsUsersByUserId(int userid)
	{
		System.out.println("execute isExistsUsersByUserId   userid = "+userid);
		String hql = "from Users u where u.userId=?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, userid);
		Users user = (Users)query.list().get(0);
		if(user!=null)
		{
			return user;
		}
		return null;
	}
	
	/**
	 * 根据用户名和密码获取用户对象
	 * @param loginname
	 * @param password
	 * @return
	 */
	public Users getObject(String loginname,String password)
	{
		Users user = new Users();
		
		user.setLoginName(loginname);
		
		user.setPassword(password);
		String hql="from Users where loginName=? and password=? and delflag=0";
		Query query=this.getSession().createQuery(hql);
		query.setParameter(0, user.getLoginName());
		query.setParameter(1, user.getPassword());		
		if(query.list()!=null && query.list().size()>0)
		{
			Users users = (Users)query.list().get(0);
			return users;
		}
		
		return null;
	}
	/**
	 * 根据functionid获取功能对象
	 * @param functionid
	 * @return
	 */
	public FunctionInfo getFunctionInfoByFunctionId(int functionid)
	{
	
		String hql = "from FunctionInfo  f where f.functionId = ?";
		Query query = this.getSession().createQuery(hql);
		query.setInteger(0, functionid);
		FunctionInfo info = (FunctionInfo)query.list().get(0);
		if(info!=null)
		{
			return info;
		}
		return null;
	}
	
	/**
	 * 根据linkFunctionName获取功能对象
	 * @param linkFunctionName
	 * @return
	 */
	public FunctionInfo getFunctionInfoByLinkFunctionName(String linkFunctionName)
	{
	
		String hql = "from FunctionInfo  f where f.linkFunctionName = ?";
		Query query = this.getSession().createQuery(hql);
		query.setString(0, linkFunctionName);
		FunctionInfo info = new FunctionInfo();
		if(query.list().size()>0)
		{
			info = (FunctionInfo)query.list().get(0);
			return info;
		}
		else {
			info.setFunctionId(0);
		}
		return info;
	}
	
	/**
	 * 添加或更新用户数据
	 * @param user
	 * @return
	 */
	public int saveOrUpdateUsers(Users user)
	{
		int result = 0;
		if(user!=null)
		{
			this.getSession().saveOrUpdate(user);
			Users users = this.isExistsUsersByUserId(user.getUserId());
			if(users.getUserId()>0)
			{
				result = users.getStatus();
			}
		}
		return result ;
	}
	
	/**
	 * 删除用户
	 * @param user
	 * @return
	 */
	public int delUsers(Users user)
	{
		int result = 0;
		if(user!=null)
		{
			this.getSession().delete(user);
			result = 1;
		}
		
		return result ;		
	}
	
	/**
	 * 获取用户和菜单关联列表
	 * @return
	 */
	public List<RoleFunctionInfo> getRoleFunctionInfoList()
	{
		String hql = "from RoleFunctionInfo";
		Query query = this.getSession().createQuery(hql);
		List<RoleFunctionInfo> list = query.list();
		if(list.size()>0)
		{
			return list;
		}
		return null;
	}
	
	/**
	 * f'e
	 * @param hql
	 * @param pageNo
	 * @param pageSize
	 * @param values
	 * @return
	 */
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
			Pages page=null;
		try {
			 page=super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

	public List find(Integer id) {
		String hql = "from pagefunction as pf where 1=1 and pf.function.functionId = "+id;
 		return this.getHibernateTemplate().find(hql);
	}
	
	/********
	 * 根据hql语句查询集合
	 */
	public List exHql(String hql){
		return this.getHibernateTemplate().find(hql);
	}
	
}

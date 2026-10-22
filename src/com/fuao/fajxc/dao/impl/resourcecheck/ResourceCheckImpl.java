package com.fuao.fajxc.dao.impl.resourcecheck;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Query;

import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.dao.resourcecheck.ResourceCheck;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Tresourcecheck;

/*
 * 资源核实单(DAO)
 * author:王雄
 * email:wangxiong@fuao.com
 */
public class ResourceCheckImpl extends BaseDaoImpl implements ResourceCheck {

	private Logger logger = Logger.getLogger(ResourceCheckImpl.class);

	public List find(String tableName) {

		try {
			String hql = "from " + tableName + "";
			return this.getHibernateTemplate().find(hql);
		} catch (Exception e) {
			logger.error("resourcecheckdao查询出错");
		}
		return null;
	}

	// 添加资源核实单
	public void add(Tresourcecheck tresourcecheck) {
		try {
			String hql = "insert into t_resourceCheck(empid,cid,tid,rvid,pid,starttime,isstate,audtitingFlag) values("
					+ tresourcecheck.getEmpid().getId()
					+ ","
					+ tresourcecheck.getCity().getId()
					+ ","
					+ tresourcecheck.getDepot().getId()
					+ ",'"
					+ tresourcecheck.getRvid()
					+ "',"
					+ tresourcecheck.getSaleGoods().getSgId()
					+ ",'"
					+ tresourcecheck.getStarttime()
					+ "','"
					+ tresourcecheck.getIsstate()
					+ "',"
					+ tresourcecheck.getAudtitingFlag() + ")";
			Query query = this.getSession().createSQLQuery(hql);
			int count = query.executeUpdate();
			if (count > 0) {
				logger.info("添加资源核实单成功");
			}
		} catch (Exception e) {
			logger.error("添加资源核实单报错dao");
		}
	}

	// 多用hql查询
	public List findByObjhql(String hql) {
		return this.getHibernateTemplate().find(hql);
	}

	// 多用sql查询
	public List findByObjsql(String sql) {
		Query query = this.getSession().createSQLQuery(sql);
		return query.list();
	}

	// 分页
	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages pages = null;

		try {
			pages = super.paginationQuery(hql, pageNo, pageSize, values);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("分页时出错", e);
		}

		return pages;
	}

	/*
	 * 返回boolean功能hql
	 */
	public boolean updateOrDeletehql(String hql) {
		boolean flag = false;
		try {
			logger.info("++++++++RC");
			Query query = this.getSession().createQuery(hql);
			int count = query.executeUpdate();
			if (count > 0) {
				flag = true;
			}
		} catch (Exception e) {
			logger.error("ResourceCheckImpl_+++++");
		}

		return flag;
	}

	public boolean updateOrDeletesql(String sql) {

		boolean flag = false;
		try {
			logger.info("++++++++RC");
			Query query = this.getSession().createSQLQuery(sql);
			int count = query.executeUpdate();
			if (count > 0) {
				flag = true;
			}
		} catch (Exception e) {
			logger.error("ResourceCheckImpl_+++++");
		}

		return flag;
	}

	public boolean updateRC(Tresourcecheck tresourcecheck) {

		boolean flag = false;

		try {

			String hql = "update t_resourceCheck set empid="
					+ tresourcecheck.getEmpid().getId() + ",cid="
					+ tresourcecheck.getCity().getId() + ",tid="
					+ tresourcecheck.getDepot().getId() + ",rvid='"
					+ tresourcecheck.getRvid() + "',pid="
					+ tresourcecheck.getSaleGoods().getSgId() + ",starttime='"
					+ tresourcecheck.getStarttime() + "',isstate='"
					+ tresourcecheck.getIsstate() + "',audtitingFlag="
					+ tresourcecheck.getAudtitingFlag() + " where 1=1 and id="
					+ tresourcecheck.getId();

			Query query = this.getSession().createSQLQuery(hql);
			int count = query.executeUpdate();
			if(count > 0)
			{
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("修改时出错", e);
		}
		return flag;
	}

	public boolean returnupdateRC(Integer empid, String content, Integer rcid) {
		boolean flag = false;
		try {
			String sql = "update t_resourceCheck set eid=" + empid
					+ ",conent='" + content + "' where id =" + rcid;
			logger.info("+++++" + sql);
			Query query = this.getSession().createSQLQuery(sql);
			int count = query.executeUpdate();
			if (count > 0) {
				flag = true;
			}
		} catch (Exception e) {
			logger.error("resourceCheckDao+++++++");
		}
		return flag;
	}

}

package com.fuao.fajxc.bussiness.impl.cdnSystem;

import java.util.List;

import com.fuao.fajxc.bussiness.cdn.CDNipBussiness;
import com.fuao.fajxc.bussiness.cdnSystem.CdnSystemBussiness;
import com.fuao.fajxc.dao.cdn.RealmTypeDao;
import com.fuao.fajxc.dao.cdnSystem.CdnSystemDao;
import com.fuao.fajxc.util.Pages;

public class CdnSystemBussinessImpl implements CdnSystemBussiness,
		CDNipBussiness {
	private CdnSystemDao cdnSystemDao;

	
	
	
	
	
	
	public CdnSystemDao getCdnSystemDao() {
		return cdnSystemDao;
	}
	public void setCdnSystemDao(CdnSystemDao cdnSystemDao) {
		this.cdnSystemDao = cdnSystemDao;
	}
	//增加
	public Object addObject(Object obj) {
		
		try {
			return cdnSystemDao.addReturnObject(obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//删除
	public int delObject(Object obj) {
		try {
			cdnSystemDao.delete(obj);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	//分页查询
	public Pages exePagesList(String hql, int pageNo, int pageSize,
			Object... values) {
		Pages page = null;
		try {
			 page = cdnSystemDao.paginationQuery(hql, pageNo, pageSize, values);
			 return page;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	//根据表名查找一个实体
	public Object findObjectById(String classtype, Integer id) {
		try {
			String hql=" from "+classtype+" where id="+id;
			List list= cdnSystemDao.execHQL(hql);
			if(list!=null&&list.size()>0)
				return list.get(0);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//根据hql执行查找  返回一个list
	public List findObjectListByHQL(String hql) {
		try {
			return cdnSystemDao.execHQL(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	//修改
	public int updataByHQL(String hql) {
		try {
			return cdnSystemDao.updataObjectByHQL(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	//修改
	public Object updataObject(Object obj) {
		try {
			cdnSystemDao.update(obj);
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}

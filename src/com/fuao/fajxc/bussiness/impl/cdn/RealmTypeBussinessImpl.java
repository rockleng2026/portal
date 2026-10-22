package com.fuao.fajxc.bussiness.impl.cdn;

import java.util.List;

import org.apache.log4j.Logger;

import com.fuao.fajxc.bussiness.cdn.RealmTypeBussiness;
import com.fuao.fajxc.dao.cdn.RealmTypeDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.RealmType;

public class RealmTypeBussinessImpl implements RealmTypeBussiness {
	private static Logger logger = Logger.getLogger(RealmType.class);
	private RealmTypeDao realmtypedao;
	
	
	
	public RealmTypeDao getRealmtypedao() {
		return realmtypedao;
	}

	public void setRealmtypedao(RealmTypeDao realmtypedao) {
		this.realmtypedao = realmtypedao;
	}

	public Object addObject(Object obj) {
		try {
			return realmtypedao.addReturnObject(obj);
			
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}

	public int delObject(Object obj) {
		try {
			realmtypedao.delete(obj);
			return 1;
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return 0;
	}

	public Object findObjectById(String classtype, Integer id) {
		try {
			String hql=" from "+classtype+" where id="+id;
			List list= realmtypedao.execHQL(hql);
			if(list!=null&&list.size()>0)
				return list.get(0);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}

	public List findObjectListByHQL(String hql) {
		try {
			return realmtypedao.execHQL(hql);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}

	public int updataByHQL(String hql) {
		try {
			return realmtypedao.updataObjectByHQL(hql);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return 0;
	}

	public Object updataObject(Object obj) {
		try {
			realmtypedao.update(obj);
			return obj;
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}

	//÷¥––∑÷“≥≤È—Ø
	public Pages exePagesList(String hql, int pageNo, int pageSize, Object... values){
		Pages page = null;
		try {
			 page = realmtypedao.paginationQuery(hql, pageNo, pageSize, values);
			 return page;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}

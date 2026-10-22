package com.fuao.fajxc.bussiness.impl.cdn;

import java.util.List;

import org.apache.log4j.Logger;

import com.fuao.fajxc.bussiness.cdn.TypeBussiness;
import com.fuao.fajxc.dao.cdn.TypeDao;
import com.fuao.fajxc.vo.Type;

public class TypeBussinessImpl implements TypeBussiness {
	private static Logger logger = Logger.getLogger(Type.class);
	private TypeDao typedao;

	public TypeDao getTypedao() {
		return typedao;
	}

	public void setTypedao(TypeDao typedao) {
		this.typedao = typedao;
	}
	
	public Object addObject(Object obj) {
		try {
			return typedao.addReturnObject(obj);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}

	public int delObject(Object obj) {
		try {
			typedao.delete(obj);
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
			List list= typedao.execHQL(hql);
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
			return typedao.execHQL(hql);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}

	public int updataByHQL(String hql) {
		try {
			return typedao.updataObjectByHQL(hql);
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return 0;
	}

	public Object updataObject(Object obj) {
		try {
			typedao.update(obj);
			return obj;
		} catch (Exception e) {
			logger.debug(e);
			e.printStackTrace();
		}
		return null;
	}

}

package com.fuao.fajxc.bussiness.model;

import java.util.ArrayList;
import java.util.List;

import com.fuao.fajxc.dao.model.ModelDao;
import com.fuao.fajxc.vo.Model;

public class ModelBussinessImpl implements ModelBussiness {
   private ModelDao modelDao; //×¢Èëdao
	public ModelDao getModelDao() {
	return modelDao;
}
public void setModelDao(ModelDao modelDao) {
	this.modelDao = modelDao;
}
	public List<Model> someModel(String hql) {
		List<Model> list=new ArrayList<Model>();
		try{
		list=modelDao.execHQL(hql);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return list;
	}
	public List someSales(String hql) {
		return modelDao.execHQL(hql);
	}

}

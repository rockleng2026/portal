package com.fuao.fajxc.serser.service.impl;

import java.util.List;
import com.fuao.fajxc.serser.dao.LoggersDaos;
import com.fuao.fajxc.serser.service.LoggerServices;


public class LoggerServicesImpl implements LoggerServices{
    
	private LoggersDaos cabLogDao;
	
	public LoggersDaos getCabLogDao() {
		return cabLogDao;
	}

	public void setCabLogDao(LoggersDaos cabLogDao) {
		this.cabLogDao = cabLogDao;
	}

	public boolean deleteDate(Object obj) {
		
		return false;
	}

	public Object getObjDate(int id) {
	
		return null;
	}

	public List getdateList(Object obj) {
	
		return null;
	}

	public boolean saveDate(Object obj) {
		
		return this.cabLogDao.saveDate(obj);
	}

	public boolean updateDate(Object obj) {
		
		return false;
	}
     
}

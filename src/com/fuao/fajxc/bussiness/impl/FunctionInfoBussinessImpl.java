package com.fuao.fajxc.bussiness.impl;

import java.util.List;

import com.fuao.fajxc.bussiness.FunctionInfoBussiness;
import com.fuao.fajxc.dao.FunctionInfoDao;
import com.fuao.fajxc.vo.FunctionInfo;

public class FunctionInfoBussinessImpl implements FunctionInfoBussiness {

	private FunctionInfoDao functionInfoDao;
	
	public void setFunctionInfoDao(FunctionInfoDao functionInfoDao) {
		this.functionInfoDao = functionInfoDao;
	}

	public List<FunctionInfo> getFunctionsList() {
		// TODO Auto-generated method stub
		return functionInfoDao.getFunctionsList();
	}

}

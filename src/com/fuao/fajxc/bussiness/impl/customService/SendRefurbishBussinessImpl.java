package com.fuao.fajxc.bussiness.impl.customService;

import java.util.List;

import com.fuao.fajxc.bussiness.customService.SendRefurbishBussiness;
import com.fuao.fajxc.dao.customService.SendRefurbishDao;
import com.fuao.fajxc.vo.RoleFunctionInfo;
import com.fuao.fajxc.vo.Sendmessage;

public class SendRefurbishBussinessImpl implements SendRefurbishBussiness {

	private SendRefurbishDao sendDao;
	
	
	public SendRefurbishDao getSendDao() {
		return sendDao;
	}


	public void setSendDao(SendRefurbishDao sendDao) {
		this.sendDao = sendDao;
	}


	public List someList(String hql) {
		// TODO Auto-generated method stub
		return sendDao.someList(hql);
	}
	
	public boolean selrolufunction(int empId)
	{
		boolean flag=false;
		String hql="from RoleFunctionInfo where mark='employee' and users.customerOrEmployeeId="+empId+"";
		List<RoleFunctionInfo> rolflist=sendDao.someList(hql);
		if(rolflist.size()>0){
			RoleFunctionInfo rfun=rolflist.get(0);
			String funids=rfun.getFunctionIds();
			if(funids!=""){
				String[] fid=funids.split(",");
				for(String j:fid){
					if(j.equals("242")){
						flag=true;
					}
				}
			}
		}
		return flag;
	}
	
	/**
	 * 添加消息
	 * @sendtable  表名
	 * @sendtableId 相应id
	 */
	public boolean addsendmess(String sendtable,int sendtableId){
		boolean flag=false;
		Sendmessage smes=new Sendmessage();
		smes.setSendtable(sendtable);
		smes.setSendtableId(sendtableId);
		flag=sendDao.addsendmess(smes);
		return flag;
	}

}

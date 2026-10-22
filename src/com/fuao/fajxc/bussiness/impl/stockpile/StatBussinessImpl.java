package com.fuao.fajxc.bussiness.impl.stockpile;

import java.util.List;

import com.fuao.fajxc.bussiness.stockpile.StatBussiness;
import com.fuao.fajxc.dao.stockpile.StatDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Stat;
import com.fuao.fajxc.vo.StatInfo;

public class StatBussinessImpl implements StatBussiness {

	private StatDao statdao;
	
	/**
	 * @return the statdao
	 */
	public StatDao getStatdao() {
		return statdao;
	}

	/**
	 * @param statdao the statdao to set
	 */
	public void setStatdao(StatDao statdao) {
		this.statdao = statdao;
	}

	public boolean addStat(Stat stat) {
		return statdao.addStat(stat);
	}

	/**
	 * 添加盘点单
	 * 返回对象
	 */
	public Stat addReturnStat(Stat stat) {
		try {
			return (Stat) statdao.addReturnObject(stat);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean addStatInfo(StatInfo statinfo) {
		// TODO Auto-generated method stub
		return statdao.addStatInfo(statinfo);
	}

	public boolean delStat(Object[] ids) {
		Object[] obj=new Object[ids.length];
		for(int i=0;i<obj.length;i++)
		{
			obj[i]=Integer.parseInt(ids[i].toString());
		}
		return statdao.delStat(obj);
	}

	public boolean delStatInfo(String addhql) {
		// TODO Auto-generated method stub
		return statdao.delStatInfo(addhql);
	}

	public boolean editStat(Stat stat) {
		// TODO Auto-generated method stub
		return statdao.editStat(stat);
	}

	public Pages exHqlPages(String hql, int pageNo, int pageSize,
			Object... values) {
		// TODO Auto-generated method stub
		return statdao.exHqlPages(hql, pageNo, pageSize, values);
	}

	public List someStat(String addhql) {
		// TODO Auto-generated method stub
		return statdao.someStat(addhql);
	}

	public List someStatInfo(String addhql) {
		// TODO Auto-generated method stub
		return statdao.someStatInfo(addhql);
	}

}

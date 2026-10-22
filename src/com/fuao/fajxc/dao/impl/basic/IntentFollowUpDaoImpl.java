package com.fuao.fajxc.dao.impl.basic;

import java.util.List;
import com.fuao.fajxc.dao.basic.IntentFollowUpDao;
import com.fuao.fajxc.dao.impl.BaseDaoImpl;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.IntentFollowUp;

public class IntentFollowUpDaoImpl extends BaseDaoImpl implements IntentFollowUpDao{

	public boolean addData(IntentFollowUp data) throws Exception {
		super.add(data);
		return true;
	}

	public List<IntentFollowUp> exHql(String hql) {
		List<IntentFollowUp> datas=null;
		try {
		datas=super.execHQL(hql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return datas;
	}

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

	public IntentFollowUp getIntentFollowUpdata(String id) {
		try {
			return (IntentFollowUp) super.select(IntentFollowUp.class,Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean updateData(IntentFollowUp data)throws Exception  {
			super.update(data);
			return true;
	}
	
}

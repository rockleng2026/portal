package com.fuao.fajxc.bussiness.system.impl;

import java.util.List;

import com.fuao.fajxc.bussiness.system.WorkOrderCfigurBiz;
import com.fuao.fajxc.dao.system.WorkorderconfigurDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Empassess;
import com.fuao.fajxc.vo.Questioncategory;

public class WorkOrderCfigurBizImpl implements WorkOrderCfigurBiz {
	
	private WorkorderconfigurDao wocdao;

	public WorkorderconfigurDao getWocdao() {
		return wocdao;
	}

	public void setWocdao(WorkorderconfigurDao wocdao) {
		this.wocdao = wocdao;
	}

	public boolean addorupdate(Questioncategory question,
			List<Empassess> list) {
		Questioncategory qu = wocdao.addquestion(question);
		
		if(null != qu && qu.getId() != null && null != list && list.size()>0)
		{
			for(int i=0; i<list.size(); i++){
				Empassess e = list.get(i);
				
				e.setQuestioncategory(qu);
				
				wocdao.addempassess(e);
				
			}
			return true;
		}
		return false;
	}

	public Pages exHqlObjectPages(String hql, int pageNo, int pageSize,
			Object... values) {
		
		return wocdao.paginationQuery(hql, pageNo, pageSize, values);
	}

	public Questioncategory getqt(int id) {
		
		try {
			return (Questioncategory) wocdao.select(Questioncategory.class, id);
		} catch (Exception e) {
			
			e.printStackTrace();
			
			return null;
		}
	}

	public void delempAssess(int id) {
			
		wocdao.delassess(id);	
	}

	public void delqc(int id) {
		
		wocdao.delqc(id);
	}


}

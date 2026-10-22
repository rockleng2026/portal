package com.fuao.fajxc.bussiness.system.impl;

import java.util.List;

import com.fuao.fajxc.bussiness.system.MessageremindBiz;
import com.fuao.fajxc.dao.system.MessageremindDao;
import com.fuao.fajxc.util.Pages;
import com.fuao.fajxc.vo.Messageremind;

public class MessageremindBizImpl implements MessageremindBiz {

	public MessageremindDao md;
	/**
	 * 添加或者更数据
	 */
	public boolean addorupmessageremind(Messageremind mr) {
		try {
			md.addorupmessageremind(mr);
			
			return true;
		} catch (Exception e) {
			
			e.printStackTrace();
			
			return false;
		}
		
	}

	/**
	 * 删除数据
	 */
	public boolean delmessageremin(String id) {
		
		try {
			md.delmessageremin(id);
			
			return true;
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return false;
	}

	/**
	 * 分页查询数据
	 */
	public Pages exHqlObjectPages(String hql, int pageNo, int pageSize,
			Object... values) {
		
		return md.exHqlObjectPages(hql, pageNo, pageSize, values);
	}

	public MessageremindDao getMd() {
		return md;
	}

	public void setMd(MessageremindDao md) {
		this.md = md;
	}

	public Messageremind getmessa(String id) {
		try {
			
			Messageremind m = (Messageremind)md.select(Messageremind.class, Integer.parseInt(id));
			
			return m;
		} catch (NumberFormatException e) {
			
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			
			e.printStackTrace();
			
			return null;
		}
	}

	public Messageremind getmr(String mark) {
		System.out.println(mark);
        
        String hql = "from Messageremind where mark = '"+mark+"'";
		
        List list = md.execHQL(hql);
        
        if(null != list && list.size()>0)
        {
        	return (Messageremind)list.get(0);
        }else       
		return null;
	}
	
}

package com.fuao.fajxc.dao.customService;

import java.util.List;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.Sendmessage;



public interface SendRefurbishDao extends BaseDao {

	/**
	 * 获取相应list
	 * @param hql
	 * @return
	 */
	public List someList(String hql);
	
	/**
	 * 添加消息
	 */
	public boolean addsendmess(Sendmessage senmes);
	
}

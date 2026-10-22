package com.fuao.fajxc.dao.system;

import com.fuao.fajxc.dao.BaseDao;
import com.fuao.fajxc.vo.Empassess;
import com.fuao.fajxc.vo.Questioncategory;

public interface WorkorderconfigurDao extends BaseDao {

	public Empassess addempassess(Empassess empass);
	
	public Questioncategory addquestion(Questioncategory question);
	
	public void delassess(int id);
	public void delqc(int id);
}

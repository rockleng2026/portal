package com.fuao.fajxc.dao.cms_loggin;

import java.util.List;

import com.fuao.fajxc.util.IterfaceConmens;

public interface LoginDao extends IterfaceConmens{

	public List getByModelId(int id);
}

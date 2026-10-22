package com.fuao.fajxc.bussiness.impl.cdn;

import com.fuao.fajxc.bussiness.cdn.CDNipBussiness;
import com.fuao.fajxc.dao.cdn.CDNipDao;

public class CDNipBussinessImpl implements CDNipBussiness {
	private CDNipDao cdnipdao;

	public CDNipDao getCdnipdao() {
		return cdnipdao;
	}

	public void setCdnipdao(CDNipDao cdnipdao) {
		this.cdnipdao = cdnipdao;
	}
	

}

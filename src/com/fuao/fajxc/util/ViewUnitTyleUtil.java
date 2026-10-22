package com.fuao.fajxc.util;

import javax.servlet.http.HttpServletRequest;

public class ViewUnitTyleUtil {

	public static String getArrayInfoByVeiw(HttpServletRequest request,	String prefix) {
		String unit = request.getParameter(prefix + "Unit");
		String legalMen = request.getParameter(prefix + "LegalMan");
		String linkMan = request.getParameter(prefix + "LinkMan");
		String phone = request.getParameter(prefix + "Phone");
		return unit + "," + legalMen + "," + linkMan + "," + phone;
	}
}

/*

	build
	design
	construction
	monitor
	
	Unit
	LegalMan
	LinkMan
	Phone
	
	//建筑单位
	buildUnit
	buildLegalMan
	buildLinkMan
	buildPhone
	
	//设计单位
	designUnit
	designLegalMan
	designLinkMan
	designPhone

	//施工单位
	constructionUnit
	constructionLegalMan
	constructionLinkMan
	constructionPhone
	
	//监理单位
	monitorUnit
	monitorLegalMan
	monitorLinkMan
	monitorPhone

*/
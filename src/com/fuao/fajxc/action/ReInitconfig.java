package com.fuao.fajxc.action;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.jdom.Element;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.fuao.fajxc.bussiness.common.CommonBizImpl;
import com.fuao.fajxc.dao.cms_classesdao.ClassesDaoImpl;
import com.fuao.fajxc.site.EnumStaticPath;
import com.fuao.fajxc.util.ObjXmlBuildParse;
import com.fuao.fajxc.util.StringUtil;
import com.fuao.fajxc.vo.Fa_Cms_Classes;

public class ReInitconfig {
	private static Logger logger = Logger.getLogger(ReInitconfig.class);
	
	public static void doInit(ServletContext scx){
		
		Element e = ObjXmlBuildParse.getRoot(InitContent.class.getResource("/config/tempconfig.xml").getPath());
		List rslist = new ArrayList();
		//得到template-config节点属性
		//图片配置
		Element e2  = e.getChild("pic-config");
		//得到game节点属性
		Element e3 = e2.getChild("titlepic");
		String titlepic  = e3.getValue();
		EnumStaticPath esp =  EnumStaticPath.getInstance();
		esp.setTITLE_PIC(titlepic);
		e3 = e2.getChild("recpic");
		String recpic = e3.getValue();
		esp.setREC_PIC(recpic);
		e3 = e2.getChild("contentpic");
		String contentpic = e3.getValue();
		esp.setCONTENT_PIC(contentpic);
		
		//评论配置
		e2 = e.getChild("comment-config");
		e3 = e2.getChild("ischeck");//是否需要审核
		String ischeck = e3.getValue(); 
		if(StringUtil.isNullStr(ischeck) || ischeck.equals("false") ){//为空或false则不需要审核
			esp.setCOMMENT_ISCHECK("FALSE");
		}else{
			esp.setCOMMENT_ISCHECK("TRUE");
		}
		e2 = e.getChild("rec-config");
		e3 = e2.getChild("sitekey");
		String sitekey = e3.getValue();
		String websitename = e2.getChild("sitename").getValue();
		String siteengname = e2.getChild("engname").getValue();
		String contentcheck = e2.getChild("contentcheck").getValue();//内容是否审核 0关闭 默认审核通过 1开启 需要审核
		
		
		
//		sitekey = StringUtil.parseSitekey(sitekey);
//		sitekey =  StringUtil.buildkey(sitekey);
		
//		type t = tdao.getTypeById(stringUtil.strToInt(sitekey, 0));
//		if( t == null || t.getSuperid() != 0){
//			scx.setAttribute("powerby", "0");
//			return ;
//		}else{
//			scx.setAttribute("powerby", "1");
//		}
//		scx.setAttribute("powerby", "1");//先默认被授权
		scx.setAttribute("siteengname",websitename );
		
		scx.setAttribute("siteengname",siteengname );
		scx.setAttribute("sitekey", sitekey);
		scx.setAttribute("basepath", scx.getContextPath());
		scx.setAttribute("contentcheck", contentcheck);
//		
//		List<RecPart> partList = pdao.getDataByTypeidAndMid(t.getTypeid(),9);//默认9是全局参数
//		for (RecPart recPart : partList) {
//				List templist2 = dao.getRecContents(recPart.getPart_num(),recPart.getPid()," and r.is_img=0 ");	
//				scx.setAttribute(recPart.getEng_name(), templist2);
//				scx.setAttribute(recPart.getEng_name(), templist2);
//				//templist2 = null;
//	08	}
		scx.setAttribute("ESP", esp);
		e = null;
		e2 = null;
		e3 = null;
		//下面我单独写
		//获取
		
		String paths[] = {"applicationContext.xml","applicationContext-cms-classes.xml","applicationContext-cms-news.xml"};
		ApplicationContext ac = new ClassPathXmlApplicationContext(paths);
		ClassesDaoImpl impl = (ClassesDaoImpl)ac.getBean("classesDao");
		String classhql = "from Fa_Cms_Classes as c where c.delflag = 0 and  c.superid = "+sitekey;
		List<Fa_Cms_Classes> list = impl.getObjects(classhql);
		
		for(int i=0;i<list.size();i++)
		{
			System.out.println(list.get(i).getClassname());
		}
		System.out.println(list.size());
//		List second_menu = new ArrayList();
		for (Iterator it = list.iterator(); it.hasNext();) {
			Fa_Cms_Classes c = (Fa_Cms_Classes) it.next();
			String hql2 = "from Fa_Cms_Classes as c where c.delflag = 0 and  c.superid = "+c.getClassid();
			List<Fa_Cms_Classes> list2 = impl.getObjects(hql2);
			logger.info(c.getEngname()+"---"+list2.size());
			scx.setAttribute(c.getEngname(), list2);//将二级菜单放入以父类engname为标识的上下文中 作为全局变量
		}
		
		String sql = "select getChildClassesLst("+  new Integer(sitekey) + ")";
		CommonBizImpl  commonbiz = (CommonBizImpl)ac.getBean("commonbizz");
		String sonIds = commonbiz.executeSql(sql);
		List<Fa_Cms_Classes> cList=commonbiz.getForm("Fa_Cms_Classes", " and delflag = 0 and classid in("+sonIds+" )");
		logger.info("类别列表 ==="+cList.size());
		scx.setAttribute("clist", cList);
		
		
	}
	
	public void doInit(CommonBizImpl commbiz,ServletContext scx){
		
		Element e = ObjXmlBuildParse.getRoot(InitContent.class.getResource("/config/tempconfig.xml").getPath());
		List rslist = new ArrayList();
		//得到template-config节点属性
		//图片配置
		Element e2  = e.getChild("pic-config");
		//得到game节点属性
		Element e3 = e2.getChild("titlepic");
		String titlepic  = e3.getValue();
		EnumStaticPath esp =  EnumStaticPath.getInstance();
		esp.setTITLE_PIC(titlepic);
		e3 = e2.getChild("recpic");
		String recpic = e3.getValue();
		esp.setREC_PIC(recpic);
		e3 = e2.getChild("contentpic");
		String contentpic = e3.getValue();
		esp.setCONTENT_PIC(contentpic);
		
		//评论配置
		e2 = e.getChild("comment-config");
		e3 = e2.getChild("ischeck");//是否需要审核
		String ischeck = e3.getValue(); 
		if(StringUtil.isNullStr(ischeck) || ischeck.equals("false") ){//为空或false则不需要审核
			esp.setCOMMENT_ISCHECK("FALSE");
		}else{
			esp.setCOMMENT_ISCHECK("TRUE");
		}
		e2 = e.getChild("rec-config");
		e3 = e2.getChild("sitekey");
		String sitekey = e3.getValue();
		String websitename = e2.getChild("sitename").getValue();
		String siteengname = e2.getChild("engname").getValue();
		String contentcheck = e2.getChild("contentcheck").getValue();//内容是否审核 0关闭 默认审核通过 1开启 需要审核
		
		
		
//		sitekey = StringUtil.parseSitekey(sitekey);
//		sitekey =  StringUtil.buildkey(sitekey);
		
//		type t = tdao.getTypeById(stringUtil.strToInt(sitekey, 0));
//		if( t == null || t.getSuperid() != 0){
//			scx.setAttribute("powerby", "0");
//			return ;
//		}else{
//			scx.setAttribute("powerby", "1");
//		}
//		scx.setAttribute("powerby", "1");//先默认被授权
		scx.setAttribute("siteengname",websitename );
		
		scx.setAttribute("siteengname",siteengname );
		scx.setAttribute("sitekey", sitekey);
		scx.setAttribute("basepath", scx.getContextPath());
		scx.setAttribute("contentcheck", contentcheck);
		
		
		scx.setAttribute("ESP", esp);
		e = null;
		e2 = null;
		e3 = null;
		//下面我单独写
		//获取
		
		String paths[] = {"applicationContext.xml","applicationContext-cms-classes.xml","applicationContext-cms-news.xml"};
		ApplicationContext ac = new ClassPathXmlApplicationContext(paths);
		ClassesDaoImpl impl = (ClassesDaoImpl)ac.getBean("classesDao");
		String classhql = "from Fa_Cms_Classes as c where c.delflag = 0 and  c.superid = "+sitekey;
		List<Fa_Cms_Classes> list = impl.getObjects(classhql);
		
		for(int i=0;i<list.size();i++)
		{
			System.out.println(list.get(i).getClassname());
		}
		System.out.println(list.size());
//		List second_menu = new ArrayList();
		for (Iterator it = list.iterator(); it.hasNext();) {
			Fa_Cms_Classes c = (Fa_Cms_Classes) it.next();
			String hql2 = "from Fa_Cms_Classes as c where c.delflag = 0 and  c.superid = "+c.getClassid();
			List<Fa_Cms_Classes> list2 = impl.getObjects(hql2);
			logger.info(c.getEngname()+"---"+list2.size());
			scx.setAttribute(c.getEngname(), list2);//将二级菜单放入以父类engname为标识的上下文中 作为全局变量
		}
		
		String sql = "select getChildClassesLst("+  new Integer(sitekey) + ")";
		CommonBizImpl  commonbiz = (CommonBizImpl)ac.getBean("commonbizz");
		String sonIds = commonbiz.executeSql(sql);
		List<Fa_Cms_Classes> cList=commonbiz.getForm("Fa_Cms_Classes", " and delflag = 0 and classid in("+sonIds+" )");
		logger.info("类别列表 ==="+cList.size());
		scx.setAttribute("clist", cList);
		
	}

}

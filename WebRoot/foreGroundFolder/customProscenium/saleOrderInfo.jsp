<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0039)http://www.ebadu.com/manager/Mydata.asp -->
<HTML>
	<HEAD>
		<TITLE>个人资料</TITLE>

		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/doc.css">
		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/base.css" />
		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/nav06.css" />
		<script type="text/javascript"
			src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js">
</script>
		<script type="text/javascript" src="<%=path%>/js/cascadingmenu.js">
</script>

		<META content="text/html; charset=gb2312" http-equiv=Content-Type>
		<META name=description
			content=福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管>
		<META name=keywords
			content="福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管-IDC基础业务品牌运营商 自我完善-不断创新-行业领先-专业服务|游戏服务器|福奥科技网站建设|福奥科技网络公司|福奥科技网络公司|福奥科技网站建设|福奥科技域名注册">
		<META content=IE=EmulateIE7 http-equiv=X-UA-Compatible>
		<LINK rel="shortcut icon" href="../users/ico/zhhzw.ico">
		<NOSCRIPT>
			<META name=GENERATOR content="MSHTML 8.00.6001.19154">
	</HEAD>
	<BODY leftMargin=0 topMargin=0>
		<IFRAME src="subnote_files/sa.htm"></IFRAME>
		</NOSCRIPT>
		<SCRIPT language=javascript>


</SCRIPT>
		<!--[if lte IE 6]>
       <style type="text/css">
       body { behavior:url("csshover.htc"); }
       </style>
       <![endif]-->
		<!--导航代码 -->

		<TABLE style="margin-left: 0px;" border=0 cellSpacing=1 cellPadding=2
			width="800" bgColor=#cccccc align=left>
			<TBODY>
				<TR bgColor=#f0f0f0>
					<TD colspan="5">
						&nbsp;当前操作-》我的资料修改
					</TD>
				</TR>
			</TBODY>
			<FORM onsubmit="return checkreg()" method=post name=regform
				action="editPersionDataCustomerServer.Action">
				<TBODY>
					<TR bgColor=#ffffff align="center">
						<TD width="25%" align="center" colspan="4" >
						<h4>订单详细信息</h4>
						订单编号：${saleorder.saleOrderNo}
						</td>
					</TR>
					
					<TR bgColor=#ffffff>
						<TD width=90 align="right">
							客户：
						</TD>
						<TD width=150>
						${saleorder.customer.realName}
						</TD>
						<TD width=90 align="right">
							销售员工：
						</TD>
						<TD width=150>
							${saleorder.employee.name }
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=90 align="right">
							机柜：
						</TD>
						<TD width=102>
						${saleorder.property.name }
						</TD>
						<TD width=90 align="right">
							审核是否通过：
						</TD>
						<TD width=211>
							<c:if test="${saleorder.auditingState==0||saleorder.auditingState==null}">
													未审核
													</c:if>
													<c:if test="${saleorder.auditingState==1 ||saleorder.auditingState==2}">
													已审核
													</c:if>
													<c:if test="${saleorder.auditingState==8}">审核进行中</c:if>
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=90 align="right">
							机位大小：
						</TD>
						<TD width=102>
						${saleorder.spaceSize }
						</TD>
						<TD width=90 align="right">
							机器数量：
						</TD>
						<TD width=211>
							${saleorder.productNum }
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=90 align="right">
							IP数量：
						</TD>
						<TD width=102>
						${saleorder.ipNum}
						</TD>
						<TD width=90 align="right">
							宽带总数：
						</TD>
						<TD width=211>
							${saleorder.bw}
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=90 align="right">
							订单价格：
						</TD>
						<TD width=150>
						${saleorder.price}
						</TD>
						<TD width=90 align="right">
							订单类型：
						</TD>
						<TD width=150>
							${saleorder.allTypeByOrdertype.questionName}
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=90 align="right">
							付费类型：
						</TD>
						<TD width=102>
						${saleorder.allTypeByPayStyle.typeName }
						</TD>
						<TD width=90 align="right">
							付费状态：
						</TD>
						<TD width=211>
							${ saleorder.allTypeByPayStatus.typeName}
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=90 align="right">
							开始时间：
						</TD>
						<TD width=102>
						${saleorder.beginTime}
						</TD>
						<TD width=90 align="right">
							到期时间：
						</TD>
						<TD width=211>
							${saleorder.endTime}
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=90 align="right">
							服务器描述：
						</TD>
						<TD width=102 colspan="3" >
						<textarea readonly rows="10" cols="100" >${saleorder.serverConfiguration}</textarea>
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD width=90 align="right">
							备注：
						</TD>
						<TD width=102>
						${saleorder.description}
						</TD>
						<TD width=90 align="right">
							经办人：
						</TD>
						<TD width=211>
							${saleorder.inputAdmin }
						</TD>
					</TR>
					</TBODY>
			</FORM>

			<TR>
				<TD bgColor=#f0f0f0 height=1 width="90%" align=middle colspan="5">
					<LI>
						如你在本站系统中有什么还不明白的地方，请使用
						<A href="http://www.ebadu.com/manager/subnote.asp"><FONT
							color=red>帮助留言</FONT>
						</A>功能，我们的技术人员会给你答复。
					</LI>
				</TD>
			</TR>
			</TBODY>
		</TABLE>
		<BR>
		<!--right end-->
		</TR>
		</TBODY>
		</TABLE>
		</TD>
		</TR>
		<!--mid end-->
		</TABLE>
		</TD>
		</TR>
		</TABLE>
		<!--foot-->
	</BODY>
</HTML>
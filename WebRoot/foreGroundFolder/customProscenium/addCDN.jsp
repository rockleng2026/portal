<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0040)http://www.ebadu.com/manager/subnote.asp -->
<HTML>
	<HEAD>
		<TITLE>提交问题-福奥科技</TITLE>
		<META content="text/html; charset=gb2312" http-equiv=Content-Type>
		<META name=description
			content=福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管>
		<META name=keywords
			content="福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管-IDC基础业务品牌运营商 自我完善-不断创新-行业领先-专业服务|游戏服务器|福奥科技网站建设|福奥科技网络公司|福奥科技网络公司|福奥科技网站建设|福奥科技域名注册">
		<META content=IE=EmulateIE7 http-equiv=X-UA-Compatible>
		<LINK rel="shortcut icon" href="../users/ico/zhhzw.ico">

		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/doc.css">
		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/base.css" />
		<LINK rel=stylesheet type=text/css
			href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/nav06.css" />
		<META name=GENERATOR content="MSHTML 8.00.6001.19154">
	</HEAD>
	<BODY leftMargin=0 topMargin=0>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js">
</script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/handlejson.js">
</script>

		<STYLE type=text/css>
.STYLE1 {
	COLOR: #ff0000
}
</STYLE>

		<
		<TABLE style="MARGIN-TOP: 3px" border=0 cellSpacing=1 cellPadding=2
			width="95%" bgColor=#cccccc align=center>
			<TBODY>
				<TR>
					<TD bgColor=#f0f0f0 height=23 width="19%" colSpan=2 align=left>
						&nbsp;
						<SPAN style="COLOR: #666666; FONT-SIZE: 13px; FONT-WEIGHT: bold">&nbsp;<IMG
								hspace=0 align=absMiddle src="subnote_files/tips.png" width=17
								height=20>&nbsp;新增CDN<FONT color=#ff0000>&nbsp;&nbsp;(带*号为必填项)</FONT><A
							id=top name=top></A>
						</SPAN>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		
		<form onsubmit="return checkstr();" method=post name=form1
			action="addconMalfunctionDeclare.Action">
			<TABLE style="MARGIN-TOP: 3px" border=0 cellSpacing=1 cellPadding=2
				width="95%" bgColor=#cccccc align="center">

				<TBODY>
					<TR bgColor=#ffffff>
						<TD bgColor=#f0f0f0 align=right width="20%">
							&nbsp;域名
							<FONT color=#ff0000>*</FONT>
						</TD>
						<td bgcolor=#f0f0f0><input id="yuming" name="yuming" type="text"/></td>
					</TR>
					<TR bgColor=#ffffff>
						<TD bgColor=#f0f0f0 align=right>
							源站IP
							<FONT color=#ff0000>*</FONT>
						</TD>
						<TD id=chattext bgColor=#f0f0f0>
							<input id="yuanIP" name="yuanIP" type="text"/>
							<FONT color=#ff0000>如果是多个IP就用","区分</FONT>
						</TD>
					</TR>
					
					<TR bgColor=#ffffff>
						<TD bgColor=#f0f0f0  align=right>
							&nbsp;日IP区间数
							<FONT color=#ff0000>*</FONT><FONT color=#ff0000>&nbsp;</FONT>
						</TD>
						<TD bgColor=#f0f0f0 colSpan=2>
							<input id="liuliangIP" name="liuliangName" type="text"/>
							<FONT color=#ff0000>比如：1万~~2万</FONT>
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD bgColor=#f0f0f0  align=right>
							&nbsp;日PV区间数
							<FONT color=#ff0000>&nbsp;*</FONT>
						</TD>
						<TD bgColor=#f0f0f0 colSpan=2>
							<input id="pvshu" name="pvshu" type="text"/>
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD bgColor=#f0f0f0 align=right>
							&nbsp;文件大小
							<FONT color=#ff0000>*</FONT>
						</TD>
						<TD bgColor=#f0f0f0 colSpan=2>
							<input id="daxiao" name="daxiao" type="text"/>
							<FONT color=#ff0000>如果是下载或大附件类型，请填写平均文件大小区间及最大文件区间</FONT>
						</TD>
					</TR>
					
					<TR bgColor=#ffffff>
						<TD bgColor=#f0f0f0 align=right>
							&nbsp;文件加速类型
							<FONT color=#ff0000>*</FONT>
						</TD>
						<TD bgColor=#f0f0f0 colSpan=2>
							<input id="houzuiming"  type="text"/>
							<FONT color=#ff0000>文件的后缀名</FONT>
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD bgColor=#f0f0f0 align=right>
							&nbsp;更新频率
							<FONT color=#ff0000>*</FONT>
						</TD>
						<TD bgColor=#f0f0f0 colSpan=2>
							<select id="selectpinlv">
							<option selected="selected" value="1">请选择</option>
							<option value="2">10分钟~~30分钟</option>
							<option value="3">30分钟~~1小时</option>
							<option value="4">1小时~~1天</option>
							<option value="5">1天~~1个月</option>
							<option value="6">1个月以上</option>
							</select>
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD bgColor=#f0f0f0  align=right>
							&nbsp;手机号码
							<FONT color=#ff0000>*</FONT>
						</TD>
						<TD bgColor=#f0f0f0 colSpan=2>
							<INPUT id="customerphone_ok1" value=1 type=checkbox
								name="customerphone_ok">
							<SPAN class=STYLE1>确认手机号码，方便及时给您短信回复！</SPAN>
							<LABEL>
								<INPUT id=customerphone value="${customer.mobilePhone}"
									name="customerphone">
								<SPAN class=STYLE1>*</SPAN>
							</LABEL>
						</TD>
					</TR>
					<TR bgColor=#ffffff>
						<TD bgColor=#f0f0f0 align=right>
							&nbsp;邮箱号码
							<FONT color=#ff0000>*</FONT>
						</TD>
						<TD bgColor=#f0f0f0 colSpan=2>
							<INPUT id="customerphone_ok2" value=1 type=checkbox
								name=customerphone_ok>
							<SPAN class=STYLE1>确认邮箱，方便及时给您短信回复！</SPAN>
							<LABEL>
								<INPUT id=yx value="${customer.email }" name="email">
								<SPAN class=STYLE1>*</SPAN>
							</LABEL>
						</TD>
					</TR>
					<tr>
						<td bgcolor="#ffffff" colspan="2" align="center"> 
						<input type="button" value="提交" onclick="increase()"/>
						<input type="hidden" value="${customer.realName}"  id="userName"/>
						</td>
					</tr>
					
				</TBODY>
			</TABLE>
		</form>
		<!--right end-->
	</BODY>

</HTML>
<<script type="text/javascript">
function increase()
{
	
	var yuming=document.getElementById("yuming").value;
	var yuanIP=document.getElementById("yuanIP").value;
	var liuliangIP=document.getElementById("liuliangIP").value;
	var pvshu=document.getElementById("pvshu").value;
	var daxiao=encodeURI(document.getElementById("daxiao").value);
	var houzuiming=encodeURI(document.getElementById("houzuiming").value);
	var selectpinlv=document.getElementById("selectpinlv").value;
	var customerphone=document.getElementById("customerphone").value;
	var yx=document.getElementById("yx").value;
	var userName = encodeURI(document.getElementById("userName").value)
	
	if(yuming==null||yuming=="")
	{
		alert("域名不能为空！！！");
		return false;
	}
	if(yuanIP==null || yuanIP=="")
	{
		alert("原IP不能为空！！！");
		return false;
	}
	if(liuliangIP==null || liuliangIP=="")
	{
		alert("IP流量不能为空！！！");
		return false;
	}
	if(pvshu==null || pvshu=="")
	{
		alert("PV数不能为空！！！");
		return false;
	}
	if(daxiao==null || daxiao=="")
	{
		alert("文件大小不能为空！！！");
		return false;
	}
	
	if(houzuiming==null||houzuiming=="")
	{
		alert("文件加速类型（后缀名）不能为空！！！");
		return false;
	}
	if(selectpinlv==1)
	{
		alert("请选更新频率！！！");
		return false;
	}
	if(customerphone==null||customerphone=="")
	{
		alert("手机号不能为空");
		return false;
	}
	if(yx==null||yx=="")
	{
		alert("邮箱号不能为空");
		return false;
	}
	if(document.getElementById("customerphone_ok1").checked==false)
	{
		alert("请确认手机号");
		return false;
	}
	if(document.getElementById("customerphone_ok2").checked==false)
	{
		alert("请确认邮箱号");
		return false;
	}
	var url = "addCDNmessage.Action";
	$.post(url,
		{
			yuming:yuming,
			yuanIP:yuanIP,
			liuliangIP:liuliangIP,
			pvshu:pvshu,
			daxiao:daxiao,
			houzuiming:houzuiming,
			selectpinlv:selectpinlv,
			customerphone:customerphone,
			yx:yx,
			userName:userName
		},function(data){
		if(data=="1")
		{
			alert("添加成功！！！ 谢谢你对本公司的支持！！！o(∩_∩)o ")
		}
		else
		{
			alert("添加失败！！！！");
		}
	});
}
</script>

	 

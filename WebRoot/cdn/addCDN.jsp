<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0040)http://www.ebadu.com/manager/subnote.asp -->
<HTML>
	<HEAD>
		<TITLE>提交CDN申请配置111</TITLE>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />  
		<META content="text/html; charset=gb2312" http-equiv=Content-Type>
		<META name=description
			>
		<META name=keywords
			content="福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管-IDC基础业务品牌运营商 自我完善-不断创新-行业领先-专业服务|游戏服务器|福奥科技网站建设|福奥科技网络公司|福奥科技网络公司|福奥科技网站建设|福奥科技域名注册">
		<META content=IE=EmulateIE7 http-equiv=X-UA-Compatible>
		<LINK rel="shortcut icon" href="../users/ico/zhhzw.ico">
		<LINK rel=stylesheet type=text/css href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/doc.css">
		<LINK rel=stylesheet type=text/css href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/base.css" />
		<LINK rel=stylesheet type=text/css href="<%=path%>/foreGroundFolder/customProscenium/subnote_files/nav06.css" />
		<META name=GENERATOR content="MSHTML 8.00.6001.19154">
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript" 	src="<%=request.getContextPath()%>/js/handlejson.js"></script>
		<script type="text/javascript" 	src="<%=request.getContextPath()%>/js/cascadingmenu.js"></script>
<style type="text/css">
body {
    font: normal 12px auto sans-serif;
    color: #4f6b72;
    background: #E6EAE9;
}
a {
    color: #c75f3e;
}
#cdntable {
    width: 800px;
    padding: 0;
    margin: 0;
	
}
caption {
    padding: 0 0 5px 0;
    width: 800px;
    text-align: right;
}
th {
    color: #4f6b72;
    border-right: 1px solid #C1DAD7;
    border-bottom: 1px solid #C1DAD7;
    border-top: 1px solid #C1DAD7;
    letter-spacing: 2px;
    text-transform: uppercase;
    text-align: left;
    padding: 6px 6px 6px 12px;
    background: #CAE8EA;
}
th.nobg {
    border-top: 0;
    border-left: 0;
    border-right: 1px solid #C1DAD7;
    background: none;
}
td {
    border-right: 1px solid #C1DAD7;
    border-bottom: 1px solid #C1DAD7;
    background: #fff;
    font-size:12px;
    padding: 6px 6px 6px 12px;
    color: #4f6b72;
}
td.alt {
    background: #F5FAFA;
    color: #797268;
}
th.spec {
    border-left: 1px solid #C1DAD7;
    border-top: 0;
    background: #fff;
}
th.specalt {
    border-left: 1px solid #C1DAD7;
    border-top: 0;
    background: #f5fafa;
    color: #797268;
}
/*---------for IE 5.x bug*/
html>body td{ font-size:12px;}

.cdnTitle {
font-weight:bold;
font-size: 16px;
font-family:"MicroSoft Yahei;黑体;"
}
.cdninput{
border-right-width: 0px;
padding-left: 3px;
width: 498px;
height: 26px;
font-family: arial;
float: left;
border-top-width: 0px;
border-bottom-width: 0px;
color: #cccccc;
margin-left: 4px;
font-size: 12px;
vertical-align: middle;
border-left-width: 0px;
margin-right: 3px;
}
.cdntextinput{
border-right-width: 0px;
padding-left: 3px;
width: 198px;
height: 26px;
font-family: arial;
float: left;
border-top-width: 0px;
border-bottom-width: 0px;
color: #cccccc;
margin-left: 4px;
font-size: 12px;
vertical-align: middle;
border-left-width: 0px;
margin-right: 3px;
}

.cdntimeinput{
border-right-width: 0px;
padding-left: 3px;
width: 66px;
height: 26px;
font-family: arial;
float: left;
border-top-width: 0px;
border-bottom-width: 0px;
color: #cccccc;
margin-left: 4px;
font-size: 12px;
vertical-align: middle;
border-left-width: 0px;
margin-right: 3px;
}
.cdnopinput{
border-right-width: 0px;
padding-left: 3px;
width: 66px;
height: 26px;
font-family: arial;
float: left;
border-top-width: 0px;
border-bottom-width: 0px;
color: #c0c0c0;
margin-left: 4px;
font-size: 12px;
vertical-align: middle;
border-left-width: 0px;
margin-right: 3px;
}
.tab_cdn{
border-bottom: #cccccc 1px solid;
border-left: #cccccc 1px solid;
width: 810px;
border-top: #cccccc 1px solid;
border-right: #cccccc 1px solid;
}
.cdnaction{
width: 21px;
float: left;
height: 17px;
}
    ul#tabNav
    {
     width:802px;
     list-style:none;
     border-bottom:solid 1px green;
     margin:0;
     padding-left:0;
     padding-bottom:26px;//google浏览器上测试能正常显示，可是IE7不行，所以有下面这句
     *padding-bottom:0;//IE7支持
    }
    ul#tabNav li
    {
     float:left;
     height:28px;
     margin:0 10px -2px 0;//关键地方
     background-color:Green;
     color:black;
     border:solid 1px Green;
     border-bottom:0;
     padding:0;
    }
    ul#tabNav a:link,ul#tabNav a:visited
    {
     display:block;
     text-decoration:none;
     padding:5px 10px 3px 10px;
    }
    #tabContent
    {
      width:802px;
      height:400px;
       border:solid 1px green;
       border-top-width:0;
    }
   #tabNav li.tabSelected
    {
       border-bottom:solid 1px white; //关键地方
       background-color:White;
       color:Black;
    }

    </style>
    
    <script type="text/javascript">
    function showContent(index)
    {
       var e = document.getElementById("content"+index);
       e.style.display = "";
       
       for(var i=1; i<6; i++)
       {
        if(i != index)
        {
            var e2 = document.getElementById("content"+i);
            e2.style.display = "none";
            document.getElementById("tab"+i).className="";
         }
         else
         {
            document.getElementById("tab"+i).className="tabSelected";
         }
       }
    }
    </script>

	</HEAD>
	<BODY leftMargin=0 topMargin=0 >&nbsp; 
	<TABLE id="cdntable" cellspacing="0">
			<TBODY align="left">
			<tr align="center">
				<td><a href="<%=path%>/showcdnlistCDNsaleOrderAction.Action"><h3>查看CDN业务列表</h3></a></td>
			</tr>
				<TR>
					<TD bgColor=#f0f0f0 >&nbsp;
						<SPAN style="COLOR: #666666; FONT-SIZE: 13px; FONT-WEIGHT: bold">&nbsp;
							&nbsp;
							新增CDN加速配置<FONT color=#ff0000>&nbsp;&nbsp;(带*号为必填项)</FONT>
							<A id=top name=top></A>
						</SPAN>
					</TD>
				</TR>
			</TBODY>
		</TABLE>

		
<ul id="tabNav">
<li  onmouseover="showContent(1)" id='tab1' class="tabSelected"><a href='#'>基本配置</a></li>
<li  onmouseover="showContent(2)" id='tab2' class="""><a href='#'>缓存配置(可选)</a></li>
<li  onmouseover="showContent(3)" id='tab3' class=""><a href='#'>回源配置(可选)</a></li>
<li  onmouseover="showContent(4)" id='tab4' class=""><a href='#'>细节功能(可选)</a></li>
<li  onmouseover="showContent(5)" id='tab5' class=""><a href='#'>防盗链配置(可选)</a></li>
</ul>
<div id="tabContent">
<form method=post  action="" >
<div id="content1" >
<table id="cdntable" cellspacing="0">
				<tr>
					<td width="15%" align="right">
						源站域名：
					</td>
					<td width="35%" align="left">
						<input id="cuRealmName" name="cuRealmName" type="text" onblur="determine()"/>
					</td>
					<td width="10%" align="right">CDN服务开启状态： 
					</td>
					<td width="40%" align="left">
						<select id="switch" name="" value="this.value">
							<option value="0">请选择！！！</option>
							<option value="1" selected="selected">开启</option>
							<option value="2">关闭</option>
						</select>
					</td>
				</tr>

				<tr id="addaddress1">
					<td width="15%" align="left" colspan="4">
						请输入源站IP：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input id="IP1" name="" type="text" onblur="Ipaddress(1)" />
						端口：
						<input id="duankou1" name="" type="text"  value="80"/>
						<FONT color=#ff0000>(有多个IP请点击后面增加按钮)</FONT>
						<input id="" name="" type="button" value="增加" onclick="add()" />
						<input id="" name="" type="button" value="减少" onclick="jianshaoIP()"/>
						<br />
						源站服务器机房位置：
						<input id="IPaddress1" name="" type="text" disabled="disabled" />
						<FONT color=#ff0000>(地址有误请右边选择修正)</FONT>
						<select id="yunyingshang1" name="" value="this.value">
							<option value="0">运营商</option>
							<option value="华数">华数</option>
							<option value="电信">电信</option>
							<option value="单线">单线</option>
							<option value="联通">联通</option>
							<option value="教育网">教育网</option>
							<option value="移动">移动</option>
							<option value="铁通">铁通</option>
							<option value="网通">网通</option>
							<option value="搜索引擎">搜索引擎</option>
							<option value="分省">分省</option>
							<option value="分大洲">分大洲</option>
							<option value="长城宽带">长城宽带</option>
							<option value="其他">其他</option>
							
						</select>
						<div  style="display:block">
						<select  id="national1" name="tzfxx[0].tzfgj"
							style="width: 70px;">
							<option>
								国家
							</option>
						</select>
						<select id="national2" name="tzfxx[0].tzfsf"
							style="width: 80px;">
							<option>
								省份、州
							</option>
						</select>
						<select id="national3" name="tzfxx[0].tzfgj"
							style="width: 85px;">
							<option>
								市(区县)
							</option>
						</select>
						</div>
				</td>
				</tr>
				
				<tr>

					<td width="15%" align="right" >
						月均IP区间数：
					</td>
					<td width="30%" align="left">

						<input id="IPqujian"  name="" type="text" class="cdntextinput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-如：1-1.5万-';" onfocus="if(this.value=='-如：1-1.5万-')value='';" value="-如：1-1.5万" />

						

					</td>
					<td width="15%" align="right">
						月均PV区间数：
					</td>
					<td width="30%" align="left">

						<input id="PVqujian"  name="" type="text" class="cdntextinput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-如：1-1.5万-';" onfocus="if(this.value=='-如：1-1.5万-')value='';" value="-如：1-1.5万" />
					</td>

				

				</tr>
				<tr>
					<td width="15%" align="right">
						附件大小(可选)：
					</td>
					<td width="30%" align="left" >
						<input id="fujiandaxiao"  name="" type="text" class="cdntextinput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-如：1-4M,5-20M等,论坛博客-';" onfocus="if(this.value=='-如：1-4M,5-20M等论坛博客-')value='';" value="如：1-4M,5-20M等论坛博客" />
					</td>
					<td width="15%" align="right">
						文件大小(可选)：
					</td>
					<td width="30%" align="left">
						<input id="wenjiandaxiao"  name="" type="text" class="cdntextinput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-如：1-4M,5-20M等,下载类-';" onfocus="if(this.value=='-如：1-4M,5-20M等,下载类-')value='';" value="如：1-4M,5-20M等,下载类" />
					</td>
				</tr>
				<tr>
					<td width="15%" align="right">
						加速地区：
					</td>
					<td width="30%" align="left">
						<select id="address" name="">
							<option value="国内加速">国内加速　</option>
							<option value="国外加速">国外加速　</option>
						</select>
					</td>
					<td width="15%" align="right">
						备案号：
					</td>
					<td width="30%" align="left">
						<input id="beianhao" name="" type="text" />
						<FONT color=#ff0000>国内请输入备案号</FONT>
					</td>
				</tr>
				<tr>
					<td width="15%" align="right">
						CDN加速需求类型：
					</td>
					<td width="30%" align="left">

						<s:select onchange="xuanze()" id="yumingleixing" name="realmtypeid" cssClass="category" 
					  	 list="#request.realmtypelist" listKey="id" listValue="name" headerKey="0" headerValue="请选择！！"  
					  	 value="%{'',#request.realmtype.name}">
						</s:select>
                      <FONT color=#ff0000>仅“纯静态”类型可选“免费”套餐。</FONT>
					</td>
					<td width="15%" align="right">
						套餐选择：
					</td>
					<td width="30%" align="left">

						<select id="taocanleixing" name="" value="this.value" onchange="xuanze()">

							<option value="4">请选择！！</option>
							<option value="0" >免费</option>
							<option value="1">赠送</option>
							<option value="2">预费</option>
							<option value="3">后费</option>
						</select>
					</td>
				</tr>
				
			</table>
			<table class="cdntable" id="taocan" cellspacing="0">
     		<tr align="center">
					<TD width="10%" height=30 class=category>
						套餐名称
					</TD>
					<TD width="10%" class=category>
						加速类型
					</TD>
					<TD width="10%" class=category>
						开始时间
					</TD>
					<TD width="10%" class=category>
						结束时间
					</TD>
					<td width="25%" class=category>
						套餐描述
					</td>
					<TD width="10%" class=category>
						套餐时长
					</TD>
					<TD width="10%" class=category>
						实际价格
					</TD>
					<TD width="10%" class=category>
						原价
					</TD>
					<TD width="5%" class=category>
						选择
					</TD>
				</tr>	
			</table>
</div>
<div id="content2" style="display:none">
<br /><br /><span class="cdnTitle">以下输入缓存规则，(如果不懂操作可以不填写,让我司技术人员为你后台分析填写)</span>

			<table id="cdntable" cellspacing="0">
			    <tr>
				<td colspan=3>请填写缓存规则：
				<FONT color=#ff0000>操作说明：按照是否缓存——缓存内容(URL/目录/文件类型等)——缓
				<br />存时间顺序输入;如果有很多具体需求，请点击“增加一行”功能添加：</FONT></td>
				<td>				
				 <input id="" name="" type="button" value="增加一行"  onclick="inserttr()"/>
				<input id="" name="" type="button" value="减少一行" onclick="jianshao()"/></td>
				</tr>
			    <tr >

				<td>
				     <select id="huancun1" name="" value="this.value" onblur="shifou(this.value,1)">
							<option value="0">是否缓存</option>
							<option value="1" >缓存</option>
							<option value="2">不缓存</option>
						</select>
						</td>
						<td>
						&nbsp;&nbsp;
						<input id="test1" name="" type="text" title="CDNrefresh" class="cdninput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-输入缓存规则,如目录：/html/[任意字符];文件类型：[任意字符].(bmp|jpg|png|gif|css|js);网页类型:[任意字符].(htm|html|xml|shtml)-';" onfocus="if(this.value=='-输入缓存规则,如目录：/html/[任意字符];文件类型：[任意字符].(bmp|jpg|png|gif|css|js);网页类型:[任意字符].(htm|html|xml|shtml)-')value='';" value="-输入缓存规则,如目录：/html/[任意字符];文件类型：[任意字符].(bmp|jpg|png|gif|css|js);网页类型:[任意字符].(htm|html|xml|shtml)-" />
						</td>
						<td>
						&nbsp;&nbsp;
						<input id="time1" name="" type="text" class="cdntimeinput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-输入数字-';" onfocus="if(this.value=='-输入数字-')value='';" value="-输入数字-"  />
						</td>
						<td>
						&nbsp;&nbsp;
							<select id="timedanwei1" name="" value="this.value" class="cdnopinput" >
							<option value="0">时间单位</option>
							<option value="h">小时</option>
							<option value="d">天</option>
							<option value="m">月</option>
						</select>
					</td>
				</tr>
				
				<tr>
				<td>
				     <select id="huancun2" name="" value="this.value" onblur="shifou(this.value,2)">
							<option value="0">是否缓存</option>
							<option value="1" >缓存</option>
							<option value="2">不缓存</option>
						</select>
						</td>
						<td>
						&nbsp;&nbsp;
						<input id="test2" name="" type="text" title="CDNrefresh" class="cdninput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-输入缓存规则,文件类型：[任意字符].(bmp|jpg|png|gif|css|js)-';" onfocus="if(this.value=='-输入缓存规则,文件类型：[任意字符].(bmp|jpg|png|gif|css|js)-')value='';" value="-输入缓存规则,文件类型：[任意字符].(bmp|jpg|png|gif|css|js)-" />
						</td>
						<td>
						&nbsp;&nbsp;
						<input id="time2" name="" type="text" class="cdntimeinput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-输入数字-';" onfocus="if(this.value=='-输入数字-')value='';" value="-输入数字-"  />
						</td>
						<td>
						&nbsp;&nbsp;
							<select id="timedanwei2" name="" value="this.value" class="cdnopinput" >
							<option value="0">时间单位</option>
							<option value="h">小时</option>
							<option value="d">天</option>
							<option value="m">月</option>
						</select>
					</td>
				</tr>
				<tr>
				<td>
				     <select id="huancun3" name="" value="this.value" onblur="shifou(this.value,3)">
							<option value="0">是否缓存</option>
							<option value="1" >缓存</option>
							<option value="2">不缓存</option>
						</select>
						</td>
						<td>
						&nbsp;&nbsp;
						<input id="test3" name="" type="text" title="CDNrefresh" class="cdninput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-输入缓存规则,网页类型:[任意字符].(htm|html|xml|shtml)-';" onfocus="if(this.value=='-输入缓存规则,网页类型:[任意字符].(htm|html|xml|shtml)-')value='';" value="-输入缓存规则,网页类型:[任意字符].(htm|html|xml|shtml)-" />
						</td>
						<td>
						&nbsp;&nbsp;
						<input id="time3" name="" type="text" class="cdntimeinput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-输入数字-';" onfocus="if(this.value=='-输入数字-')value='';" value="-输入数字-"  />
						</td>
						<td>
						&nbsp;&nbsp;
							<select id="timedanwei3" name="" value="this.value" class="cdnopinput" >
							<option value="0">时间单位</option>
							<option value="h">小时</option>
							<option value="d">天</option>
							<option value="m">月</option>
						</select>
					</td>
				</tr>
				<tr>
				<td>
				     <select id="huancun4" name="" value="this.value" onblur="shifou(this.value,4)">
							<option value="0">是否缓存</option>
							<option value="1" >缓存</option>
							<option value="2">不缓存</option>
						</select>
						</td>
						<td>
						&nbsp;&nbsp;
						<input id="test4" name="" type="text" title="CDNrefresh" class="cdninput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-输入缓存规则,如缓存目录：/tag/[任意字符]-';" onfocus="if(this.value=='-输入缓存规则,如缓存目录：/tag/[任意字符]-')value='';" value="-输入缓存规则,如缓存目录：/tag/[任意字符]-" />
						</td>
						<td>
						&nbsp;&nbsp;
						<input id="time4" name="" type="text" class="cdntimeinput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-输入数字-';" onfocus="if(this.value=='-输入数字-')value='';" value="-输入数字-"  />
						</td>
						<td>
						&nbsp;&nbsp;
							<select id="timedanwei4" name="" value="this.value" class="cdnopinput" >
							<option value="0">时间单位</option>
							<option value="h">小时</option>
							<option value="d">天</option>
							<option value="m">月</option>
						</select>
					</td>
				</tr>
				<tr>
				<td>
				     <select id="huancun5" name="" value="this.value" onblur="shifou(this.value,5)">
							<option value="0">是否缓存</option>
							<option value="1" >缓存</option>
							<option value="2">不缓存</option>
						</select>
						</td>
						<td>
						&nbsp;&nbsp;
						<input id="test5" name="" type="text" title="CDNrefresh" class="cdninput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-输入缓存规则,如缓存目录：/tag/[任意字符]-';" onfocus="if(this.value=='-输入缓存规则,如缓存目录：/tag/[任意字符]-')value='';" value="-输入缓存规则,如缓存目录：/tag/[任意字符]-" />
						</td>
						<td>
						&nbsp;&nbsp;
						<input id="time5" name="" type="text" class="cdntimeinput" onkeydown="if (event.keyCode==13) {}" onblur="if(this.value=='')value='-输入数字-';" onfocus="if(this.value=='-输入数字-')value='';" value="-输入数字-"  />
						</td>
						<td>
						&nbsp;&nbsp;
							<select id="timedanwei5" name="" value="this.value" class="cdnopinput" >
							<option value="0">时间单位</option>
							<option value="h">小时</option>
							<option value="d">天</option>
							<option value="m">月</option>
						</select>
					</td>
				</tr>
				<tr id="intr">
				</tr>
			</table>
</div>
<div id="content3"  style="display:none">
<table id="cdntable" cellspacing="0">
				<tr>
					<br/>
					请选择地区:<FONT color=#ff0000>(按照运营商,大地区,回源Ip顺序输入)</FONT>
					<input id="" name="" type="button" value="增加一行"  onclick="insert1()"/>
					<input id="" name="" type="button" value="减少一行" onclick="jianshao1()"/>
					<FONT color=#ff0000>(可选输入)</FONT>
					<td>
						<select id="operator1" name="" value="this.value">
							<option value="0">请选择运营商！</option>
							<option value="华数">华数</option>
							<option value="电信">电信</option>
							<option value="单线">单线</option>
							<option value="联通">联通</option>
							<option value="教育网">教育网</option>
							<option value="移动">移动</option>
							<option value="铁通">铁通</option>
							<option value="网通">网通</option>
							<option value="搜索引擎">搜索引擎</option>
							<option value="分省">分省</option>
							<option value="分大洲">分大洲</option>
							<option value="长城宽带">长城宽带</option>
							
						</select>
					</td>
					<td>				
						<select id="daaddress1" name="" >
							<option value="0">请选择地区！</option>
							<c:forEach items="${disname}" var="dislist">
								<option value="${dislist }">${dislist }</option>
							</c:forEach>
						</select>
					</td>
					
					<td>
					<input id="huiyuan1" name="" type="text" />
					<FONT color=#ff0000>回源IP(多个IP请用/分割)</FONT>
					</td>
				</tr>
				<tr id="huiyuan">
				</tr>
			</table>
</div>
<div id="content4"  style="display:none">
功能测试中,商业用户请直接提交客服后台配置；
</div>

<div id="content5"  style="display:none">
功能测试中,商业用户请直接提交客服后台配置；
</div>

			<table width=100%>
				<tr>
					
					<td  width=50% align="right">
						<input id="" name="" type="button" value="提交"  onclick="tijiao()"/>
					</td>
					<td align="left">
						<input id="" name="" type="reset" value="重置" />
					</td>
				</tr>
			</table>
		</form>
</div>


		<!--right end-->
	</BODY>

</HTML>
<script type="text/javascript">
var count=6;
var count1=2;
var count2=2;
function tijiao()
{	


	var cuRealmName=document.getElementById("cuRealmName").value;
    if(cuRealmName==null||cuRealmName=="")
	{
		alert("请输入域名！！！");
		$("#cuRealmName").focus();
		return false;
	}
	var switchOpen=document.getElementById("switch").value;
	if(switchOpen==null||switchOpen==""||switchOpen=="0")
	{
		alert("请选择服务开启状态！！！");
					$("#switch").focus();
		return false;	
	}

	var IP="";
	var yunyingshang="";
	var IPaddress="";
	var duank="";
	for(var i=1;i<count2;i++)
	{
		var ipaa=document.getElementById("IP"+i+"").value;
		if(ipaa==null||ipaa=="")
		{
			alert("请输入IP！！！！");
			$("#IP"+i+"").focus();
			return false;
		}
		
	   var ss = ipaa.split(".");
	   if(ss.length != 4)
	   {
		   alert("输入IP有误！！！！");
		   $("#IP"+i+"").focus();
	      return false;
	   }
	   var ic=0;
	   for(ic=0;ic<ss.length;ic++)
	   {
	      if ( (/^\d+$/.test(ss[ic])==false) || parseInt(ss[ic]) < 0 || parseInt(ss[ic])>255)
	      {
	    	  	alert("输入的IP有误！！！！");
	    	  	$("#IP"+i+"").focus();
	        	return false;
	      }
	   }
	  var national1=document.getElementById("national1").value;
		var national2=document.getElementById("national2").value;
		var national3=document.getElementById("national3").value;
		if(i==(count2-1))
		{
			IP+=ipaa;
			var yyy=document.getElementById("yunyingshang"+i+"").value;
				if(yyy==null||yyy=="")
					{
						alert("请选择运营商！！！");
						$("yunyingshang"+i+"").focus();
						return false;
					}
					yunyingshang +=yyy;
			duank+=document.getElementById("duankou"+i+"").value;
			if(national1=="国家")
					{	
					var ipar=document.getElementById("IPaddress"+i+"").value;
						
						IPaddress+=ipar;
					}
				else
					{
						IPaddress+=national1+"　"+national2+"省(州)"+national3+"市(县)";
					
					}
		}
		else{
			IP+=ipaa+"/";
			var yyy=document.getElementById("yunyingshang"+i+"").value;
				if(yyy==null||yyy=="")
					{
						alert("请选择运营商！！！");
						$("yunyingshang"+i+"").focus();
						return false;
					}
					yunyingshang +=yyy+",";
			duank+=document.getElementById("duankou"+i+"").value+"/";
			if(national1=="国家")
					{
					var ipar=document.getElementById("IPaddress"+i+"").value;
					
						IPaddress+=ipar+"/";
					}
				else
					{
						IPaddress+=national1+"　"+national2+"省(州)"+national3+"市(县)"+"/";
					
					}
		}
	}

	
	
	var IPqujian1=document.getElementById("IPqujian").value;
	var PVqujian1=document.getElementById("PVqujian").value;
	var fujiandaxiao1=document.getElementById("fujiandaxiao").value;
	var wenjiandaxiao1=document.getElementById("wenjiandaxiao").value;
	
	var wenjiandaxiao=encodeURI(wenjiandaxiao1);
	var IPqujian=encodeURI(IPqujian1);
	var fujiandaxiao=encodeURI(fujiandaxiao1);
	var PVqujian=encodeURI(PVqujian1);
	
	
	var address=document.getElementById("address").value;
	var beianhao=document.getElementById("beianhao").value;
	if(address=="国内加速")
	{
		if(beianhao==null||beianhao=="")
			{
				alert("请输入备案号！！！");
				$("#beianhao").focus();
				return false;
			}
	}
	else
		{
			beianhao="";
		}
	var yumingleixing=document.getElementById("yumingleixing").value;
	if(yumingleixing==null||yumingleixing=="" ||yumingleixing=="0")
	{
		alert("请选择域名类型 ！！！！！！");
		$("#yumingleixing").focus();
		return false;
	}
	var taocanleixing=document.getElementById("taocanleixing").value;
	
	if(taocanleixing==null||taocanleixing==""||taocanleixing=="4")
	{
		alert("请选择套餐！！！！");
		$("#taocanleixing").focus();
		return false;
	}
	var taocanId="";
	var rd=document.getElementsByName("a");
	
		 for ( var i = 0; i < rd.length; i++) {
			if (rd[i].checked == true) {
		
				taocanId=rd[i].value;
		}
	}
	if(taocanId==null||taocanId=="")
		{
			alert("请选择套餐！！！！");
			return false;
		}
	var huancun="";
	var test="";
	var time="";
	var timedanwei="";
	for(var i=1;i<count;i++)
	{
		var hc=document.getElementById("huancun"+i+"").value;//是否缓存
		
		if(hc!=null&&hc!=""&&hc!="0")
		{
				if(i==(count-1))
					huancun+=hc;
				else
					huancun+=hc+",";
			var tt=document.getElementById("test"+i+"").value;//缓存内容
			if(tt==null||tt=="")
			{
				alert("请输入缓存内容！！！！");
				$("#test"+i+"").focus();
				return false;
			}
				if(i==(count-1))
					test+=tt;
				else
					test+=tt+",";
			var t=document.getElementById("time"+i+"").value;//缓存时间
			if(t==null||t=="")
			{
			
				alert("请输入缓存时间！！！！");
				$("#time"+i+"").focus();
				return false;
			}
				if(i==(count-1))
					time+=t;
				else
					time+=t+",";
			var tdw=document.getElementById("timedanwei"+i+"").value;//缓存时间单位
			
			if(tdw==null||tdw==""||tdw=="0")
			{
				alert("请选择缓存时间单位！！！！");
				$("#timedanwei"+i+"").focus();
				return false;
			}
				if(i==(count-1))
					timedanwei+=tdw;
				else
					timedanwei+=tdw+",";
		}
	}
	var operator="";
	var daaddress="";
	var huiyuan="";
	for(var i=1;i<count1;i++)
	{
		var o=document.getElementById("operator"+i+"").value;
		if(o!=null&&o!=""&&o!="0")
		{
				if(i==(count1-1))
					operator+=o;
				else
					operator+=o+",";
			var da=document.getElementById("daaddress"+i+"").value;
			if(da==null||da==""||da=="0")
			{
				alert("请选择打地区！！！！");
				$("#daaddress"+i+"").focus();
				return false;
			}
				if(i==(count1-1))
					daaddress+=da;
				else
					daaddress+=da+",";
			
			var hy=document.getElementById("huiyuan"+i+"").value;
			if(hy==null||hy=="")
			{
				alert("请输入回源IP！！！");
				$("#huiyuan"+i+"").focus();
				return false;
			}
				if(i==(count1-1))
					huiyuan+=hy;
				else
					huiyuan+=hy+",";
		}
	}
	t=encodeURI(test);
	var daa=encodeURI(daaddress);
	var op=encodeURI(operator);
	

	
	var IPaddress1=encodeURI(IPaddress);
	var address1=encodeURI(address);
    var	beianhao1=encodeURI(beianhao);
	var wenjiandaxiao=encodeURI(wenjiandaxiao1);
	var IPqujian=encodeURI(IPqujian1);
	var fujiandaxiao=encodeURI(fujiandaxiao1);
	var PVqujian=encodeURI(PVqujian1);
	
	var yys=encodeURI(yunyingshang);
	var IPadd=encodeURI(IPaddress);
	var url="addtaocanCDNsaleOrderAction.Action";
	$.post(url,{
		cuRealmName:cuRealmName,//域名
		taocanId:taocanId,//套餐ID
		switchOpen:switchOpen,//是否开启
		huancun:huancun,//是否缓存
		test:t,//缓存内容
		time:time,//缓存时间
		timedanwei:timedanwei,//缓存时间的单位
		operator:op,//运营商
		daaddress:daa,//大地址
		huiyuan:huiyuan,//回源IP
		IP:IP,//IP
		yunyingshang:yys,//运营商
		IPaddress:IPadd,//Ip地址
		duankou:duank,//端口
		address:address1,//国内或者国外加速
		beianhao:beianhao1,//备案号
		IPqujian:IPqujian,//IP区间数
		PVqujian:PVqujian,//PV区间数
		fujiandaxiao:fujiandaxiao,//附件大小
		wenjiandaxiao:wenjiandaxiao//多数文件大小
	},function(data){
		if(data=="1")
		{
			alert("添加成功！！！！");
			window.location.href='<%=path%>/showcdnlistCDNsaleOrderAction.Action';
		}
		else if(data=="3")
		{
			alert("添加失败 免费套餐也被使用！！！！");
		}
		else if(data=="0")
		{
			alert("域名已被使用！！！！");
		}
		else if(data=="4")
		{
			alert("添加失败 赠送套餐也被使用！！！！");
		}
		else{
			alert("添加失败！！！！");
		}
	});
}
function xuanze()
{
	var taocanleixing=document.getElementById("taocanleixing").value;
	
	var yumingleixing=document.getElementById("yumingleixing").value;
	if(yumingleixing==null||yumingleixing=="")
	{
		alert("请选择域名类型 ！！！！！！");
		return false;
	}
		var rd=document.getElementsByName("a");
		if(rd.length==0)
			{
				$("#taocanNo").remove();
			}
		var rdl=rd.length;
		 for ( var i = 0; i < rdl; i++) {
				$("#tr"+rd[0].value+"").remove();
			}
	
	url="taocanCDNsaleOrderAction.Action";
	$.post(url,{taocan:taocanleixing,yuming:yumingleixing},function(data){
		$("#taocan").append(data);
	});

}	
//增加缓存规则
function inserttr()
{
	var aa="<tr id='tr"+count+"'><td><select id='huancun"+count+"' name='' value='this.value' onblur=shifou(this.value,'"+count+"') ><option value='0'>请选择！</option><option value='1'>缓存</option><option value='2'>不缓存</option></select></td>";
	aa+="<td><input id='test"+count+"' name='' type='text' title='CDNrefresh' class='cdninput' /></td>";
	aa+="<td><input id='time"+count+"' name='' type='text' class='cdntimeinput' /></td>";
	aa+="<td><select id='timedanwei"+count+"' name='' value='this.value' onchange='xuanze()'' class='cdnopinput'><option value='0'>请选择！</option><option value='h'>小时</option><option value='d'>天</option><option value='m'>月</option></select></td><tr>";
	$("#intr").append(aa);
	count++;
}
//减少缓存规则
function jianshao()
{
	var conn=count-1;
	$("#tr"+conn+"").remove();
	count--;
}
//增加回源
function insert1()
{
	
	var aa="<tr id='tr1"+count1+"'><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id='operator"+count1+"' name='' value='this.value'><option value='0'>请选择运营商！</option><option value='华数'>华数</option><option value='电信'>电信</option><option value='单线'>单线</option><option value='联通'>联通</option><option value='教育网'>教育网</option><option value='网通'>移动</option><option value='铁通'>铁通</option><option value='网通'>网通</option><option value='搜索引擎'>搜索引擎</option><option value='分省'>分省</option><option value='分大洲'>分大洲</option><option value='长城宽带'>长城宽带</option></td>";
	//aa+="<td><select id='daaddress"+count1+"' name='' value='this.value'><option value='0'>请选择地区！</option><option value='1'>aaaa</option><option value='2'>bbbb</option></td>";
	aa+="<td><select id='daaddress"+count1+"' );'><option value='0'>请选择地区！</option><c:forEach items='${disname}' var='dislist'><option value='${dislist }'>${dislist }</option></c:forEach></select></td>";
	//aa+="<td><select id='xiaoaddress"+count1+"' name='' value='this.value'><option value='0'>请选择地区！</option><option value='1'>江西</option><option value='2'>北京</option></td>";
	aa+="<td><input id='huiyuan"+count1+"' name='' type='text'/><FONT color=#ff0000>回源IP</FONT></td>";					
	$("#huiyuan").append(aa);
	count1++;
}
//减少回源
function jianshao1()
{
	var conn1=count1-1;
	$("#tr1"+conn1+"").remove();
	count1--;
}

function shifou(aa,i)
{
	
	if(aa==2)
		{
			document.getElementById("time"+i+"").value="0";
			document.getElementById("timedanwei"+i+"").value="h";
		}
}
function Ipaddress(zhi)
{
	var ip=document.getElementById("IP"+zhi+"").value;
	if(ip==null||ip=="")
		{
			alert("请输入IP！！！！");
			return false;
		}
		
	   var ss = ip.split(".");
	   if(ss.length != 4)
	   {
		   alert("输入IP有误！！！！");
	      return false;
	   }
	   var i=0;
	   for(i=0;i<ss.length;i++)
	   {
	      if ( (/^\d+$/.test(ss[i])==false) || parseInt(ss[i]) < 0 || parseInt(ss[i])>255)
	      {
	    	  	alert("输入的IP有误！！！！");
	        	return false;
	      }
	   }
	url="ipselectCDNsaleOrderAction.Action";
	$.post(url,{ip:ip},function(data){
		var at=data.split(",");
		document.getElementById("yunyingshang"+zhi+"").value=at[0];
		document.getElementById("IPaddress"+zhi+"").value=at[1];
	});
}
window.onload = function()
	{
		setup();
	}
function determine()
{
	var cuRealmName=document.getElementById("cuRealmName").value;
	if(cuRealmName==""||cuRealmName==null)
		{
			alert("请输入域名！！！");
			return false;
		}
	
	var url="yumingCDNsaleOrderAction.Action";
	$.post(url,{cuRealmName:cuRealmName},function(data){
		if(data==0)
			{
				alert("域名也被占用！！！！！");
				return false;
			}
			
	});
}

function add(){
	var aa="<tr id='addaddress"+count2+"'><td width='15%' align='left' colspan='4'>请输入源站IP：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	aa+="  <input id='IP"+count2+"' name='' type='text' onblur='Ipaddress("+count2+")'' /> 端口：<input id='duankou"+count2+"' name='' type='text' value='80' />";
	aa+="<br />源站服务器机房位置：<input id='IPaddress"+count2+"' name='' type='text' disabled='disabled' /><FONT color=#ff0000>(地址有误请右边选择修正)</FONT>";			
	aa+="<select id='yunyingshang"+count2+"' name='' value='this.value'><option value='0'>运营商</option><option value='华数'>华数</option><option value='电信'>电信</option><option value='单线'>单线</option><option value='联通'>联通</option><option value='教育网'>教育网</option><option value='网通'>移动</option><option value='铁通'>铁通</option><option value='中国'>中国</option><option value='搜索引擎'>搜索引擎</option><option value='分省'>分省</option><option value='分大洲'>分大洲</option><option value='长城宽带'>长城宽带</option><option value='其他'>其他</option></select>";
	aa+="<div  style='display:none'><select id='national1' name='tzfxx[0].tzfgj' style='width: 70px;'><option>国家</option></select>";
	aa+="<select id='national2' name='tzfxx[0].tzfsf' style='width: 80px;'><option>省份、州</option></select>";
	aa+="<select id='national3' name='tzfxx[0].tzfgj' style='width: 85px;'><option>市(区县)</option></select><div></td></tr>";
						
	$("#addaddress"+(count2-1)+"").append(aa);
	
	count2++;
}
function jianshaoIP()
{
	if(count2==2)
	{
		alert("必须有一个IP地址！！");
	}
	else
	{
		$("#addaddress"+(count2-1)+"").remove();
		count2--;
	}
}
</script>

	 

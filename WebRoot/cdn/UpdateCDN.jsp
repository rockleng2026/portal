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
		<TITLE>提交CDN申请配置</TITLE>

		<META content="text/html; charset=gb2312" http-equiv=Content-Type>
		<META name=description
			content=福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管、福奥科技自助建站、福奥科技论坛空间、福奥科技主页空间、福奥科技ASP空间、福奥科技企业邮局、福奥科技ASP空间、福奥科技主页空间、福奥科技论坛空间、福奥科技自助建站、福奥科技企业邮局、福奥科技网站建设、福奥科技网页设计、福奥科技网站推广、福奥科技虚拟主机、福奥科技域名注册、福奥科技主机托管、福奥科技主机租用、福奥科技主机、福奥科技服务器租用、福奥科技服务器托管>
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
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		 <script src="<%=request.getContextPath() %>/cdn/js/jquery.form.js" type="text/javascript"></script>
<style type="text/css">
body { font: normal 12px auto sans-serif; color: #4f6b72; background: #E6EAE9;}
a {   color: #c75f3e;}
#cdntable {   width: 800px;   padding: 0;  margin: 0;}
caption { padding: 0 0 5px 0;  width: 800px; text-align: right;}
th { color: #4f6b72; border-right: 1px solid #C1DAD7; border-bottom: 1px solid #C1DAD7; border-top: 1px solid #C1DAD7;
    letter-spacing: 2px; text-transform: uppercase; text-align: left; padding: 6px 6px 6px 12px; background: #CAE8EA;}
th.nobg { border-top: 0;  border-left: 0; border-right: 1px solid #C1DAD7; background: none;}
td { border-right: 1px solid #C1DAD7;  border-bottom: 1px solid #C1DAD7;  background: #fff; font-size:12px;
    padding: 6px 6px 6px 12px; color: #4f6b72;}
td.alt {   background: #F5FAFA;    color: #797268;}
th.spec {    border-left: 1px solid #C1DAD7;    border-top: 0;    background: #fff;}
th.specalt {    border-left: 1px solid #C1DAD7;    border-top: 0;    background: #f5fafa;    color: #797268;}
/*---------for IE 5.x bug*/
html>body td{ font-size:12px;}

.cdnTitle {font-weight:bold;font-size: 16px;font-family:"MicroSoft Yahei;黑体;"}
.cdninput{border-right-width: 0px;padding-left: 3px;width: 498px;height: 26px;font-family: arial;float: left;
border-top-width: 0px;border-bottom-width: 0px;margin-left: 4px;font-size: 12px;
vertical-align: middle;border-left-width: 0px;margin-right: 3px;}
.cdntextinput{border-right-width: 0px;padding-left: 3px;width: 198px;height: 26px;font-family: arial;
float: left;border-top-width: 0px;border-bottom-width: 0px;margin-left: 4px;
font-size: 12px;vertical-align: middle;border-left-width: 0px;margin-right: 3px;}

.cdntimeinput{border-right-width: 0px;padding-left: 3px;width: 66px;height: 26px;font-family: arial;
float: left;border-top-width: 0px;border-bottom-width: 0px;margin-left: 4px;
font-size: 12px;vertical-align: middle;border-left-width: 0px;margin-right: 3px;}
.cdnopinput{border-right-width: 0px;padding-left: 3px;width: 66px;height: 26px;font-family: arial;float: left;
border-top-width: 0px;border-bottom-width: 0px;color: #c0c0c0;margin-left: 4px;font-size: 12px;vertical-align: middle;
border-left-width: 0px;margin-right: 3px;}
.tab_cdn{border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid;width: 810px;
border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;}
.cdnaction{width: 21px;float: left;height: 17px;}
    ul#tabNav
    { width:802px; list-style:none; border-bottom:solid 1px green;margin:0;   padding-left:0;
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
	<BODY leftMargin=0 topMargin=0  >&nbsp; 
	<TABLE id="cdntable" cellspacing="0">
			<TBODY align="left">
			<tr align="center">
				<td><a href="<%=path%>/showcdnlist1CDNsaleOrderAction.do"><h3>查看CDN业务列表</h3></a></td>
			</tr>
				<TR>
					<TD bgColor=#f0f0f0 >&nbsp;
						<SPAN style="COLOR: #666666; FONT-SIZE: 13px; FONT-WEIGHT: bold">&nbsp;
							&nbsp;
							修改CDN加速配置<FONT color=#ff0000>&nbsp;&nbsp;(带*号为必填项)</FONT>
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
<form method=post  action="" id="cdnform" >
<div id="content1" >
<input type="hidden" id="iplistsize" name="iplistsize" value="${iplistsize }"/>
<input type="hidden" id="cachelistsize" name="cachelistsize" value="${cachelistsize }"/>
<input type="hidden" id="districtlistsize" name="districtlistsize" value="${districtlistsize }"/>
<table id="cdntable" cellspacing="0">
				<tr>
					<td width="15%" align="right">
						源站域名：
					</td>
					<td width="35%" align="left">
						<input id="cuRealmName" name="cuRealmName" type="text" onblur="determine()"  value="${cdnsale.cuRealmName}" />
						<input id="CDNid" name="CDNid"  type="hidden" value="${cdnsale.id}" />
					</td>
					<td width="15%" align="right">
						CDN服务开启状态： 
					</td>
					<td width="35%" align="left">
						<select id="switch" name="switch" value="this.value"  >
							<option value="0">请选择！！！</option>
							<option value="1" <c:if test="${cdnsale.serverFlag==1}">selected="selected" </c:if> >开启</option>
							<option value="2" <c:if test="${cdnsale.serverFlag==2}">selected="selected" </c:if> >关闭</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="15%" align="right">
						系统域名：
					</td>
					<td colspan="3" align="left">
						<input id="syRealmName" name="syRealmName" type="text"   value="${cdnsale.syRealmName}" />
					</td>
				</tr>
				<tr>
					<td width="15%" align="right">
						开始运行时间：
					</td>
					<td width="35%" align="left">
						<input id="starttime" name="starttime" type="text"  value="${cdnsale.starttime}" onclick="WdatePicker()" />
					</td>
					<td width="15%" align="right">
						结束运行时间： 
					</td>
					<td width="35%" align="left">
						<input id="endtime" name="endtime" type="text"   value="${cdnsale.endtime}" onclick="WdatePicker()" />
					</td>
				</tr>

				<tr id="addaddress0">
				</tr>
				<c:forEach items="${iplist}" var="dataip" varStatus="ipin">
				<tr id="addaddress1">
					<td width="15%" align="left" colspan="4">
						请输入源站IP：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input id="IP${ipin.index+1 }" name="ip${ipin.index+1 }" type="text" onblur="Ipaddress(${ipin.index })"  value="${dataip.ip }"  />
						端口：
						<input id="duankou${ipin.index+1 }" name="port${ipin.index+1 }" type="text"  value="${dataip.port }"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input id="" name="" type="button" value="增加IP" onclick="add()" />
						<input id="" name="" type="button" value="减少IP" onclick="jianshaoIP()"/>
						<br />
						源站服务器机房位置：
						<input id="IPaddress${ipin.index+1 }" name="ipaddress${ipin.index+1 }" type="text"  value="${dataip.address }" />
						<FONT color=#ff0000>(地址有误请右边选择修正)</FONT>
						运营商:<select id="yunyingshang${ipin.index+1 }" name="iptmoblie${ipin.index+1 }" value="this.value">
							<option value="0">运营商</option>
							<option value="华数"     <c:if test="${dataip.tmoblie=='华数'}">selected="selected" </c:if>   >华数</option>
							<option value="电信"     <c:if test="${dataip.tmoblie=='电信'}">selected="selected" </c:if>   >电信</option>
							<option value="单线"     <c:if test="${dataip.tmoblie=='单线'}">selected="selected" </c:if>   >单线</option>
							<option value="联通"     <c:if test="${dataip.tmoblie=='联通'}">selected="selected" </c:if>   >联通</option>
							<option value="教育网"   <c:if test="${dataip.tmoblie=='教育网'}">selected="selected" </c:if> >教育网</option>
							<option value="网通"     <c:if test="${dataip.tmoblie=='移动'}">selected="selected" </c:if>   >移动</option>
							<option value="铁通"     <c:if test="${dataip.tmoblie=='铁通'}">selected="selected" </c:if>   >铁通</option>
							<option value="中国"     <c:if test="${dataip.tmoblie=='中国'}">selected="selected" </c:if>   >中国</option>
							<option value="搜索引擎" <c:if test="${dataip.tmoblie=='搜索引擎'}">selected="selected" </c:if>>搜索引擎</option>
							<option value="分省"     <c:if test="${dataip.tmoblie=='分省'}">selected="selected" </c:if>    >分省</option>
							<option value="分大洲"   <c:if test="${dataip.tmoblie=='分大洲'}">selected="selected" </c:if>  >分大洲</option>
							<option value="长城宽带" <c:if test="${dataip.tmoblie=='长城宽带'}">selected="selected" </c:if>>长城宽带</option>
							<option value="其他"     <c:if test="${dataip.tmoblie=='其他'}">selected="selected" </c:if>    >其他</option>
						</select>
					</td>
				</tr>
				</c:forEach>
				<tr>
					<td width="15%" align="right" >
						月均IP区间数：
					</td>
					<td width="30%" align="left">
						<input id="IPqujian"  name="IPinterval" type="text"   value="${cdnsale.IPinterval}" />
					</td>
					<td width="15%" align="right">
						月均PV区间数：
					</td>
					<td width="30%" align="left">
						<input id="PVqujian"  name="PVinterval" type="text"    value="${cdnsale.PVinterval}" />
					</td>
				</tr>
				<tr>
					<td width="15%" align="right">
						附件大小(可选)：
					</td>
					<td width="30%" align="left" >
						<input id="fujiandaxiao"  name="accessoryfile" type="text"   value="${cdnsale.accessoryfile}" />
					</td>
					<td width="15%" align="right">
						文件大小(可选)：
					</td>
					<td width="30%" align="left">
						<input id="wenjiandaxiao"  name="mostfile" type="text"  value="${cdnsale.mostfile}" />
					</td>
				</tr>
				<tr>
					<td width="15%" align="right">
						加速地区：
					</td>
					<td width="30%" align="left">
						<select id="address" name="quickenaddress">
							<option <c:if test="${jiasu=='国外加速'}">selected="selected"</c:if>  value="国外加速">国外加速</option>
							<option <c:if test="${jiasu=='国内加速'}">selected="selected"</c:if>  value="国内加速">国内加速</option>
						</select>
					</td>
					<td width="15%" align="right">
						备案号：
					</td>
					<td width="30%" align="left">
						<input id="beianhao" name="recordsNo" type="text"  value="${cdnsale.recordsNO}"/>
						<FONT color=#ff0000>国内请输入备案号</FONT>
					</td>
				</tr>
				<tr>
					<td width="15%" align="right">
						CDN加速需求类型：
					</td>
					<td width="30%" align="left">						
						<select  onchange="xuanze()" id="yumingleixing" name="realmtypeid" cssClass="category" >
							<option value="0">请选择！！</option>
							<c:forEach items="${realmtypelist }" var="redata">
							<option value="${redata.id }" <c:if test="${redata.id==cdnsale.setmeal.realmtype.id }">selected="selected"</c:if> >${redata.name }</option>
							</c:forEach>
						</select>
                      <FONT color=#ff0000>仅“纯静态”类型可选“免费”套餐。</FONT>
					</td>
					<td width="15%" align="right">
						套餐选择：
					</td>
					<td width="30%" align="left">
						<select id="taocanleixing" name="taocanleixing" value="this.value" onchange="xuanze()">
							<option value="4">请选择！！</option>
							<option value="0" <c:if test="${cdnsale.setmeal.chargeType=='0' }">selected="selected"</c:if> >免费</option>
							<option value="1" <c:if test="${cdnsale.setmeal.chargeType=='1' }">selected="selected"</c:if> >赠送</option>
							<option value="2" <c:if test="${cdnsale.setmeal.chargeType=='2' }">selected="selected"</c:if> >预费</option>
							<option value="3" <c:if test="${cdnsale.setmeal.chargeType=='3' }">selected="selected"</c:if> >后费</option>
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
				${cdnsetmeal }
			</table>
</div>
<div id="content2" style="display:none">
<br /><br /><span class="cdnTitle">以下输入缓存规则，(如果不懂操作可以不填写,让我司技术人员为你后台分析填写)</span>
	<table id="cdntable" cellspacing="0">
		<tr>
			<td colspan=3>请填写缓存规则：
				<FONT color=#ff0000>操作说明：按照是否缓存——缓存内容(URL/目录/文件类型等)——缓
				<br />存时间顺序输入;如果有很多具体需求，请点击“增加一行”功能添加：</FONT>
			</td>
			<td>				
				 <input id="" name="" type="button" value="增加一行"  onclick="inserttr()"/>
				<input id="" name="" type="button" value="减少一行" onclick="jianshao()"/>
			</td>
		</tr>
		<c:forEach items="${cachelist}" var="dddd" varStatus="states">
	    <tr id='tr${states.index+1 }'>
			<td>
		     	<select id="huancun${states.index+1 }" name="huancun${states.index+1 }" value="this.value" onblur="shifou(this.value,1)">
		     		<option value="0">是否缓存</option>
					<option value="1"  <c:if test="${dddd.cacheflag==1}">selected="selected" </c:if> >缓存</option>
					<option value="2" <c:if test="${dddd.cacheflag==2}">selected="selected" </c:if>>不缓存</option>
				</select>
			</td>
			<td>
				&nbsp;&nbsp;
				<input id="test${states.index+1 }" name="test${states.index+1 }" type="text" title="CDNrefresh" class="cdninput"  value="${dddd.cachecontent}" />
			</td>
			<td>
				&nbsp;&nbsp;
				<input id="time${states.index+1 }" name="time${states.index+1 }" type="text" class="cdntimeinput"  value="${tianshu[states.index]}"  />
			</td>
			<td>
				&nbsp;&nbsp;
				<select id="timedanwei${states.index+1}" name="timedanwei${states.index+1}" value="this.value">
					<option value="1" <c:if test="${danwei[states.index]=='h'}">selected="selected" </c:if> >小时</option>
					<option value="2" <c:if test="${danwei[states.index]=='d'}">selected="selected" </c:if> >天</option>
					<option value="3" <c:if test="${danwei[states.index]=='m'}">selected="selected" </c:if> >月</option>
				</select>
			</td>
		</tr>
		</c:forEach>
	
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
				</tr>
				<c:forEach items="${districtlist}" var="datadis" varStatus="dt">
				<tr  id='tr1${dt.index+1}'>	
					<td>
						<select id="operator${dt.index+1}" name="tmoblie${dt.index+1}" value="this.value">
							<option value="0">请选择运营商！</option>
							<option value="华数" <c:if test="${datadis.tmoblie =='华数'}">selected="selected" </c:if>>华数</option>
							<option value="电信" <c:if test="${datadis.tmoblie =='电信'}">selected="selected" </c:if>>电信</option>
							<option value="单线"  <c:if test="${datadis.tmoblie =='单线'}">selected="selected" </c:if>>单线</option>
							<option value="联通" <c:if test="${datadis.tmoblie =='联通'}">selected="selected" </c:if>>联通</option>
							<option value="教育网" <c:if test="${datadis.tmoblie =='教育网'}">selected="selected" </c:if>>教育网</option>
							<option value="网通" <c:if test="${datadis.tmoblie =='网通'}">selected="selected" </c:if>>移动</option>
							<option value="铁通" <c:if test="${datadis.tmoblie =='铁通'}">selected="selected" </c:if>>铁通</option>
							<option value="中国" <c:if test="${datadis.tmoblie =='中国'}">selected="selected" </c:if>>中国</option>
							<option value="搜索引擎" <c:if test="${datadis.tmoblie =='搜索引擎'}">selected="selected" </c:if>>搜索引擎</option>
							<option value="分省" <c:if test="${datadis.tmoblie =='分省'}">selected="selected" </c:if>>分省</option>
							<option value="分大洲" <c:if test="${datadis.tmoblie =='分大洲'}">selected="selected" </c:if>>分大洲</option>
							<option value="长城宽带" <c:if test="${datadis.tmoblie =='长城宽带'}">selected="selected" </c:if>>长城宽带</option>
						</select>
					</td>
					<td>				
						<select id="daaddress${dt.index+1}" name="daaddress${dt.index+1}">
							<option value="0">请选择地区！</option>
							<c:forEach items="${disname}" var="dislist">
								<option value="${dislist }" <c:if test="${datadis.districtName==dislist }">selected="selected"</c:if>>${dislist }</option>
							</c:forEach>
						</select>
					</td>
					
					<td>
					<input id="huiyuan${dt.index+1}" name="huiyuan${dt.index+1}" type="text" value="${datadis.ip }" />
					<FONT color=#ff0000>回源IP(多个IP请用/分割)</FONT>
					</td>
				</tr>
				</c:forEach>
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
var count=document.getElementById("cachelistsize").value;
if(count==null||count=="")count=1;
var count1=document.getElementById("districtlistsize").value;
if(count1==null||count1=="")count1=1;
var count2=document.getElementById("iplistsize").value;
if(count2==null||count2=="")count2=1;
function tijiao()
{	
	var cuRealmName=document.getElementById("cuRealmName").value;
	if(cuRealmName==null||cuRealmName=="")
	{
		alert("请输入域名！！！");
		return false;
	}
	var switchOpen=document.getElementById("switch").value;
	if(switchOpen==null||switchOpen==""||switchOpen=="0")
	{
		alert("请选择服务开启状态！！！");
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
			return false;
		}
	   var ss = ipaa.split(".");
	   if(ss.length != 4)
	   {
		   alert("输入IP有误！！！！");
	      return false;
	   }
	   var ic=0;
	   for(ic=0;ic<ss.length;ic++)
	   {
	      if ( (/^\d+$/.test(ss[ic])==false) || parseInt(ss[ic]) < 0 || parseInt(ss[ic])>255)
	      {
	    	  	alert("输入的IP有误！！！！");
	        	return false;
	      }
	   }
//	  var national1=document.getElementById("national1").value;
//		var national2=document.getElementById("national2").value;
//		var national3=document.getElementById("national3").value;
//		if(i==(count2-1))
//		{
//			IP+=ipaa;
//			yunyingshang+=document.getElementById("yunyingshang"+i+"").value;
//			duank+=document.getElementById("duankou"+i+"").value;
//			if(national1=="国家")
//					{
//						IPaddress+=document.getElementById("IPaddress"+i+"").value;
//					}
//				else
//					{
//						IPaddress+=national1+"　"+national2+"省(州)"+national3+"市(县)";
//					}
//		}
//		else{
//			IP+=ipaa+"/";
//			yunyingshang +=(document.getElementById("yunyingshang"+i+"").value)+",";
//			duank+=document.getElementById("duankou"+i+"").value+"/";
//			if(national1=="国家")
//					{
//						IPaddress+=document.getElementById("IPaddress"+i+"").value+"/";
//					}
//				else
//					{
//						IPaddress+=national1+"　"+national2+"省(州)"+national3+"市(县)"+"/";
//					}
//		}
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
		return false;
	}
	var taocanleixing=document.getElementById("taocanleixing").value;
	if(taocanleixing==null||taocanleixing==""||taocanleixing=="4")
	{
		alert("请选择套餐！！！！");
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
	
	var url="update1CDNsaleOrderAction.do";
	var querystr=$('#cdnform').formSerialize();
	querystr=encodeURI(querystr);
	$.post(url,querystr,function(data){
		if(data=="1")
		{
			alert("修改成功！！！！");
			window.location.href="<%=path%>/showcdnlist1CDNsaleOrderAction.do";
		}
		else if(data=="3")
		{
			alert("添加失败 免费套餐也被使用！！！！");
		}
		else if(data=="0")
		{
			alert("修改失败！！！！");
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
	url="taocanCDNsaleOrderAction.do";
	$.post(url,{taocan:taocanleixing,yuming:yumingleixing},function(data){
		$("#taocan").append(data);
	});
}	
//增加缓存规则
function inserttr()
{
	var aa="<tr id='tr"+count+"'><td><select id='huancun"+count+"' name='huancun"+count+"' value='this.value' onblur=shifou(this.value,'"+count+"') ><option value='0'>请选择！</option><option value='1'>缓存</option><option value='2'>不缓存</option></select></td>";
	aa+="<td><input id='test"+count+"' name='test"+count+"' type='text' title='CDNrefresh' class='cdninput' /></td>";
	aa+="<td><input id='time"+count+"' name='time"+count+"' type='text' class='cdntimeinput' /></td>";
	aa+="<td><select id='timedanwei"+count+"' name='timedanwei"+count+"' value='this.value'  class='cdnopinput'><option value='0'>请选择！</option><option value='h'>小时</option><option value='d'>天</option><option value='m'>月</option></select></td><tr>";
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
	var aa="<tr id='tr1"+count1+"'><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select id='operator"+count1+"' name='tmoblie"+count1+"' value='this.value'><option value='0'>请选择运营商！</option><option value='华数'>华数</option><option value='电信'>电信</option><option value='单线'>单线</option><option value='联通'>联通</option><option value='教育网'>教育网</option><option value='网通'>移动</option><option value='铁通'>铁通</option><option value='中国'>中国</option><option value='搜索引擎'>搜索引擎</option><option value='分省'>分省</option><option value='分大洲'>分大洲</option><option value='长城宽带'>长城宽带</option></td>";
	//aa+="<td><select id='daaddress"+count1+"' name='' value='this.value'><option value='0'>请选择地区！</option><option value='1'>aaaa</option><option value='2'>bbbb</option></td>";
	aa+="<td><select id='daaddress"+count1+"' name='daaddress"+count1+"' );'><option value='0'>请选择地区！</option><c:forEach items='${disname}' var='dislist'><option value='${dislist }'>${dislist }</option></c:forEach></select></td>";
	//aa+="<td><select id='xiaoaddress"+count1+"' name='' value='this.value'><option value='0'>请选择地区！</option><option value='1'>江西</option><option value='2'>北京</option></td>";
	aa+="<td><input id='huiyuan"+count1+"' name='huiyuan"+count1+"' type='text'/><FONT color=#ff0000>回源IP</FONT></td>";					
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
	url="ipselectCDNsaleOrderAction.do";
	$.post(url,{ip:ip},function(data){
		var at=data.split(",");
//		document.getElementById("yunyingshang"+zhi+"").value=at[0];
		document.getElementById("IPaddress"+zhi+"").value=at[1];
	});
}
window.onload = function()
	{
	//	setup();
	}
function determine()
{
	var cuRealmName=document.getElementById("cuRealmName").value;
	if(cuRealmName==""||cuRealmName==null)
		{
			alert("请输入域名！！！");
			return false;
		}
	var url="yumingCDNsaleOrderAction.do";
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
	aa+="  <input id='IP"+count2+"' name='' type='text' onblur='Ipaddress("+count2+")'' /> 端口：<input id='duankou"+count2+"' name='' type='text' value='8080' />";
	aa+="<br />源站服务器机房位置：<input id='IPaddress"+count2+"' name='' type='text'  /><FONT color=#ff0000>(地址有误请右边选择修正)</FONT>";			
	aa+="<select id='yunyingshang"+count2+"' name='' value='this.value'><option value='0'>运营商</option><option value='华数'>华数</option><option value='电信'>电信</option><option value='单线'>单线</option><option value='联通'>联通</option><option value='教育网'>教育网</option><option value='网通'>移动</option><option value='铁通'>铁通</option><option value='中国'>中国</option><option value='搜索引擎'>搜索引擎</option><option value='分省'>分省</option><option value='分大洲'>分大洲</option><option value='长城宽带'>长城宽带</option><option value='其他'>其他</option></select>";

//	aa+="<select id='national1' name='tzfxx[0].tzfgj' style='width: 70px;'><option>国家</option></select>";
//	aa+="<select id='national2' name='tzfxx[0].tzfsf' style='width: 80px;'><option>省份、州</option></select>";
//	aa+="<select id='national3' name='tzfxx[0].tzfgj' style='width: 85px;'><option>市(区县)</option></select></td></tr>";
						
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
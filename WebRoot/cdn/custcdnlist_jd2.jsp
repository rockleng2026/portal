<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>用户CDN节点配置列表</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
		
  <script type="text/javascript">
            function fs(aa){
	 document.getElementById(aa).className="kaili"
	 }
	  function lk(aa){
	 document.getElementById(aa).className="likai"	 
	 }
	 
	 function fsq(bb){
	 document.getElementById(bb).className="kailil"
	 }
	  function lkl(bb){
	 document.getElementById(bb).className="likai"	 
	 }
	   function showAndHide(obj,types){
    var Layer=window.document.getElementById(obj);
    switch(types){
  case "show":
    Layer.style.display="block";
  break;
  case "hide":
    Layer.style.display="none";
  break;
}
  }
  function getValue(obj,str){
    var input=window.document.getElementById(obj);
input.value=str;
  }
 function showjd()
 {
 	document.getElementById("addjd").style.display="";	
 
 }

function addIPtijiao()
{
	var ip=document.getElementById("ip").value;
	var typeName=document.getElementById("typeName").value;
	var exp=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
var reg = ip.match(exp);
if(reg==null)
{
alert("IP地址不合法！");
return false;
}
if(typeName==0)
{
	alert("请选择线路");
	return false;
}
	
}
function selectJieDian()
{
		var typeNameId=document.getElementById("typeName1").value;
		$.post("selectLikexianluIpCDNsaleOrderAction.do",{id:typeNameId},function(data){
			document.getElementById("addjiedian").innerHTML=data;
		});
	
}
 function suspendIP(id)
{
if(confirm("确定要暂停该记录吗？")==true){
	$.post("zhantingjiedianxianluCDNsaleOrderAction.do",{id:id},function(data){
		if(data==0)
		{
			alert("暂停节点成功");
			location.reload();
		}
		else
		{
			alert("暂停节点失败");
			location.reload();
		}
	
	});
	}

} 
function resumeIP(id)
{
if(confirm("确定要恢复该记录吗？")==true){
	$.post("huifujiedianxianluCDNsaleOrderAction.do",{id:id},function(data){
		if(data==0)
		{
			alert("恢复节点成功");
			location.reload();
		}
		else
		{
			alert("恢复节点失败");
			location.reload();
		}
	
	});
	}

}
function delIP(id)
{
if(confirm("确定要删除该记录吗？")==true){
	$.post("deljidianxianluCDNsaleOrderAction.do",{id:id},function(data){
		if(data==1)
		{
			alert("删除节点成功");
			location.reload();
		}
		else
		{
			alert("删除节点失败");
			location.reload();
		}
	
	});
	}

}
        </script> 
		
		<link type="text/css" rel="stylesheet"	href="<%=basePath%>/Css/missionuse.css" />
	</head>
	<body>
		<div id="append_parent"></div>
		<div id="ajaxwaitid"></div>
		<div class="container" id="cpcontainer">
			<div class="itemtitle">
            <hr style="width:300px; float:left; height:1px; position:absolute; margin-top:32px;" size="3" color="#20a3f6" />
             <span><img src="<%=basePath%>/images/home.png" width="30" height="30"></span>
				<h3 style="line-height:35px;">
					CDN节点管理                    
				</h3>
               
			</div>
			<table class="tb tb2 " id="tips">
				<tr style="border-bottom:dashed 1px #deeffb;" >
					<th class="partition">
						<span><img src="<%=basePath%>/images/idea_group.png" width="20" height="20" ></span>技巧提示
					</th>
					<th class="partition"style="text-align:right;">
						<a href="javascript:void();" onClick="showjd()" title="添加加速节点">新增加速</a>&nbsp;&nbsp;&nbsp;<a href="showcdnlist1CDNsaleOrderAction.do">返回CDN订单信息列表</a>
					</th>
				</tr>
				<tr>
					<td class="tipsblock" s="1">
						<ol id="tipslis">
							<li>
								XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
							</li>
							<li>
								XXXXXXXXXX，XXXXXXXXXXXXXXXXXX，XXXXXXXXXXXXXXXXXX，XXXXXXXXXXXXXXXXXX，XXXXXXXX
							</li>
							<li>
								XXXXXXXXXX，XXXXXXXX
							</li>
							<li>
								XXXXXXXXXX，XXXXXXXX
							</li>
						</ol>
					</td>
				</tr>
			</table>
			<div class="itemtitle">
				
               
                
				<h3 class="partition"  style="border-bottom:dashed 1px #deeffb; width:100%; padding-bottom:5px;">
				<span><img src="<%=basePath%>/images/notes.png" width="20" height="20" /></span> <p style="float:left; margin-right:50px; line-height:22px;">	FUAO2008.COM</p>  <input type="submit" value="显示类型" class="xslx" >
                    <input type="submit" value="线路类型显示"  onclick=location.href='selectIpdiyuCDNsaleOrderAction.do' class="xllx" >
                <input type="submit" value="节点类型显示"  onclick=location.href='selectIpAreaTypeCDNsaleOrderAction.do' class="jdlx" >
				</h3>
				
			</div>
			<div class="itemtitle">
			  <p class="search" align="right"><input type="image" src="images/search.png" width="23" height="23" style="border:none;float:right;" onclick="selectJieDian()" >
			  <SELECT name="typeName1" id="typeName1" onchange="selectIP()" id="typeName" >
					<option value="0">请选择</option>
							<c:forEach items="${cdnType}" var="ca1">
								<option value="${ca1.id }">${ca1.typeName }</option>
							</c:forEach>
						</SELECT> </p>	
			  <input type="submit" value="节点列表" class="sub_a" />
              			
			</div>
			
				<input type="hidden" name="struts.token.name" value="register0" />
<input type="hidden" name="register0" value="A7WCUM9ZT0RB0RN0BGAYZ6AJTBMP2ESE" />
				<input type="hidden" id="mark" name="mark" value="new" />
				<table align="center" border="0" width="100%" class="tb tb2">
					<tr align="left">
                      <th width="5%"></th>
						<th width="20%">
							<b>加速线路</b>
						</th>
						
						<th width="20%">
							<b>加速节点</b>
						</th>
						<th width="25%">
							<b>状态</b>
						</th>
						
						<th align="center" style="text-align:center;" width="30%">
							<b>操&nbsp;&nbsp;作</b>
						</th>
					</tr>
                   
					
						<tr>
							<td colspan="6" width="100%" id="addjiedian">
							<table width="100%" >
								
							
					
					<c:forEach items="${cdp}"  var="data" varStatus="sid" >	
					<tr id="czl_tr${ sid.index}" onmouseover="fs('czl_tr${ sid.index}');" onmouseout="lk('czl_tr${ sid.index}');" class="likai">
                    <td width="5%"> </td>
							<td style="font: 10pt;"  width="20%">
								${data.typeName }
							</td>
							
							<td style="font: 10pt;"  width="20%">
							<c:if test="${data.ip==null||data.ip=='' }">该线路没有覆盖节点</c:if>
							<c:if test="${data.ip!=null&&data.ip!='' }">${data.ip}</c:if>
								

							</td>
							<td style="font: 10pt;"  width="25%">
							红色该节点暂停<br />绿色该节点正在使用
							</td>
							<td style="font: 10pt; text-align:center;"  width="30%">
							<c:if test="${data.id==null||data.id==''}">没有覆盖的节点</c:if>
							<c:if test="${data.id!=null&&data.id!=''}">
							
							<a class="faq" title="停止该IP加速" href="javascript:void(0)" onclick="suspendIP('${data.id }')">暂停</a>&nbsp;&nbsp;
							<a class="faq" title="恢复该IP加速" href="javascript:coid(0)" onclick="resumeIP('${data.id }')">恢复</a>&nbsp;&nbsp;
							<a class="faq" title="去掉该加速节点IP" onclick="delIP('${data.id}')">删除</a>
							
							</c:if>
							</td>
						</tr>
						</c:forEach>
						</table>
							</td>
						</tr>
					
                        	 <tr><td colspan="6" style="border:none; text-align:right;" class="yema">
                     			<p:pages url="selectIpdiyuCDNsaleOrderAction.do"/>
                      </td>	</tr>
						
				</table>
		<div>
		<div id="addjd" style="display: none">
		<form action="addIpAreaType1CDNsaleOrderAction.do" method="post" id="form1"
				name="form1" onsubmit="return addIPtijiao()">
		<table border="0" width="440px;"  class="tb tb2">
				<th colspan="5" style="border:none;">
						<h3 class="partition"  style="border-bottom:dashed 1px #deeffb; width:100%; padding-bottom:5px;">
				<span><img src="<%=basePath%>/images/add_user.png" width="20" height="20" /></span>	添加节点
				</h3>
				</th>
				<tr style="line-height:40px; height:40px;">
                <th width="20%">
							<b>加速节点</b>
						</th>
               
					<th width="15%" >
						<b>选择区域</b>
					</th>
					<th width="15%"  >
						<b>选择线路</b>
					</th >
                    <th width="20%"  >
						<b>机房位置</b>
					</th >
					 <th width="10%"  >
						<b>端口</b>
					</th >
					
					<th align="center" style="text-align:center;" width="20%" ><b>操作</b></th>
					<td></td>
				</tr>
				<tr  id="dd1" onmouseover="fsq('dd1');" onmouseout="lkl('dd1');" class="likai">
                	<td colspan="1" id="addIPs" style="overflow:hidden;">
					  <input type="text" name="ip" id="ip" value=""  >
         
					</td>
					<td colspan="1">
					<SELECT id="province" name="province" value="this.value">
							<c:forEach items="${cdnArea}" var="ca">
								<option value="${ca.id }">${ca.province }</option>
							</c:forEach>
						</SELECT>
					</td>
					<td colspan="1">
						<SELECT name="typeName" id="typeName" onchange="selectIP()" id="typeName">
						
					<option value="0">请选择</option>
							<c:forEach items="${cdnType}" var="ca1">
								<option value="${ca1.id }">${ca1.typeName }</option>
							</c:forEach>
						</SELECT>
					</td>
                    <td>
                      <input type="text" name="address" id="address" value=""  >
         
                    </td>
                     <td>
                      <input type="text" name="duankou" id="duankou" value="8080"  >
         
                    </td>
				
					<Td colspan="1" align="center">
						<span style="text-align: center"><input id="button1"
								name="button1" value="提交" class="button_tj" type="submit" />&nbsp;
						</span>
					</td>
					<td></td>
				</tr>
				
			</table>
			</form>
		</div>
		</div>
		</div>

</body>
</html>
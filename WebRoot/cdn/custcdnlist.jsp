<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
        request.setCharacterEncoding("UTF-8");
%>
        
<html>
	<head>
		<base href="<%=basePath%>">
		<title>用户CDN节点配置列表</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<meta http-equiv="x-ua-compatible" content="ie=7" />
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.7.2.min.js"></script>
		
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
	 
        </script>
		
		
		<link type="text/css" rel="stylesheet"	href="<%=basePath%>Css/missionuse.css" />
	</head>
	<body>
		<div id="append_parent"></div>
		<div id="ajaxwaitid"></div>
		<div class="container" id="cpcontainer">
			<div class="itemtitle">
				<hr style="width:300px; float:left; height:1px; position:absolute; margin-top:32px;" size="3" color="#20a3f6" />
             <span><img src="<%=basePath %>images/home.png" width="30" height="30"></span>
				<h3 style="line-height:35px;">
					CDN节点管理                    
				</h3>
			</div>
			<table class="tb tb2 " id="tips">
				<tr style="border-bottom:dashed 1px #deeffb;">
					<th class="partition">
						<span><img src="<%=basePath %>images/idea_group.png" width="20" height="20" ></span>技巧提示
					</th>
					<th class="partition"style="text-align:right;">
						<a href="javascript:void();" onclick="showjd()" style="color: red" title="添加加速节点">新增加速</a>&nbsp;&nbsp;&nbsp;<a href="showcdnlist1CDNsaleOrderAction.do">返回CDN订单信息列表</a>
					</th>
				</tr>
				<tr>
					<td class="tipsblock" s="1">
						<ul id="tipslis">
							<li>
								列表显示：加速节点 → 节点的区域、线路 → 机房位置 → 使用状态  → 操作
							</li>
							<li>
								节点查询：输入节点去模糊查询，如果要精确查询输入完整的节点就可以查询出来
							</li>
							<li>
								增加节点加速：点击右上边的"<font color="red">新增加速</font>"后再最下面弹出资料填写
							</li>
							<li>
								列表切换：点击中间的显示类型进行切换
							</li>
						</ul>
					</td>
				</tr>
			</table>
			<div class="itemtitle">
                
				<h3 class="partition"  style="border-bottom:dashed 1px #deeffb; width:100%; padding-bottom:5px;">
				<span><img src="<%=basePath %>images/notes.png" width="20" height="20" /></span> 
				<p style="float:left; margin-right:50px; line-height:22px;">	FUAO2008.COM</p>  
				<input type="submit" value="显示类型：" style="background-color:#666;color:#fff;" class="xslx" >
                <input type="submit" value="线路类型显示" class="xllx" 
                onclick=location.href='cdnRealmNameIP_2CDNsaleOrderAction.do?cusid=${cusid}&realmName=${realmName }' />
                
                <input type="submit" value="节点类型显示" class="jdlx" style="background:#363636;" onclick="Dialog()" />
				</h3>
				
			</div>
			<div class="itemtitle" >
				
				<a href="javascript:void(0)" style="float:left;margin-right:10px;background-image:url(images/IP_01.png); display: block;width: 84px;height: 31px;text-decoration:none;text-align:center;line-height:30px;">
				<span  style="color:#fff;font-size:12px;margin-left:16px;">批量处理</span></a>
				
				<a onclick="suspendBatchIP()" style="background-image:url(images/IP_05.png); display: block;width: 60px;font-size:12px; color:#333; font-family:'宋体'; height: 31px;float:left;text-align:center;line-height:30px;">
				<span  style="font-size:12px;margin-left:16px;">批量暂停</span></a>
				<a onclick="resumeBatchIP()" style="background-image:url(images/IP_05.png); display: block;width: 60px;font-size:12px; color:#333; font-family:'宋体'; height: 31px;float:left;text-align:center;line-height:30px;">
				<span  style="font-size:12px;margin-left:16px;">批量恢复</span></a>
				<a onclick="delBatchIP()" style="background-image:url(images/IP_05.png); display: block;width: 60px; font-size:12px; color:#333; font-family:'宋体'; height: 31px;float:left;text-align:center;line-height:30px;">
				<span  style="font-size:12px;margin-left:16px;">批量删除</span></a>
				
				<input style="float:left;margin-left:100px;" id="dimIP" onkeyup="dimSelectIP()" />

						

			</div>
			<form action="addoreditWorkPosition.do" method="post" id="form0"
				name="form0">
				<s:token name="register0"></s:token>
				<input type="hidden" id="mark" name="mark" value="new" />
				<table align="center" border="0" width="440px;" class="tb tb2">
						<tr align="left">
						<th width="20%">
							<b>加速节点</b>
						</th>
						
						<th width="20%">
							<b>加速区域</b>
						</th>
						<th width="20%">
							<b>域名地址</b>
						</th>
						<th width="20%">
							<b>状态</b>
						</th>
						<th align="center" style="text-align:center;" width="20%">
							<b>操&nbsp;&nbsp;作</b>
						</th>
					</tr>
                   

						<tr>
							<td colspan="5" width="100%" id="addtrIP">
							<table  border="0" width="440px;" class="tb tb2" id="">
							<c:forEach items="${crni}" var="p">
								<tr align="left">
							<td style="font: 10pt;" width="20%">
								<input type="checkbox" name="batchIP" value="${p.id }" />
								<a style="text-decoration:none;" href="javascript:void(0)" title="${p.cdnPanelPointID.address }" >${p.cdnPanelPointID.panelPointIp}</a>
							</td>
							
							<td style="font: 10pt;" width="20%">
								${p.cdnPanelPointID.cdnAreaID.province }&nbsp;&nbsp;&nbsp;&nbsp;${p.cdnPanelPointID.cdnTypeID.typeName }
							</td>
							<td style="font: 10pt;" width="20%">
								${p.cuRealmName }
							</td>
							<td  width="20%">
								<b><c:if test="${p.mark==0 }">正常使用</c:if>
									<c:if test="${p.mark==1 }">损坏</c:if>
									<c:if test="${p.mark==2 }">暂停</c:if>
								</b>
							</td>
							<td style="font: 10pt;text-align: center;" width="20%">
							<c:if test="${p.mark==0}"><a class="faq" title="暂停该IP加速"
									onclick="suspendIP(${p.id })">暂停</a>&nbsp;&nbsp; </c:if>
								<c:if test="${p.mark==2}"><a class="faq" title="恢复该IP加速"
									onclick="resumeIP(${p.id })">恢复</a>&nbsp;&nbsp;</c:if>
								<a class="faq" title="去掉该加速节点IP"
									onclick="delIP(${p.id})">删除</a>
							</td>
						</tr>
						</c:forEach>
							</table>
							</td>
						</tr>
				</table>
			</form>
		<div>
		<div id="addjd" style="display: none">
		<form action="" method="post" id="form1"
				name="form1">
		<table border="0" width="440px;"  class="tb tb2">
				<th colspan="5">
					<h3>
					<span><img src="images/add_user.png" width="20" height="20" /></span>	添加节点
					</h3>
				</th>
				<tr>
					<td colspan="1">
						选择区域
						<input type="hidden" id="cusID" value="${cusid}" />
						<input type="hidden" id="cuRealmName" value="${realmName }" />
					</td>
					<td colspan="1">
						选择线路
					</td>
					<td colspan="2">加速节点</td>
					
					<td colspan="1">操作</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="1">
					<SELECT id="province" value="this.value">
					<option value="0">请选择</option>
							<c:forEach items="${cdnArea}" var="ca">
								<option value="${ca.id }">${ca.province }</option>
							</c:forEach>
						</SELECT>
					</td>
					<td colspan="1">
						<SELECT id="typeName" onchange="selectIP()" id="typeName">
						<option value="0">请选择</option>
							<c:forEach items="${cdnType}" var="ca1">
								<option value="${ca1.id }">${ca1.typeName }</option>
							</c:forEach>
						</SELECT>
					</td>
					<td colspan="2" id="addIPs">
										
					</td>
					<Td colspan="1" align="center">
						<span style="text-align: center"><input id="button1"
								name="button1" value="提交" class="button_tj" onClick="addIPtijiao()" type="button" />&nbsp;
						</span>
					</td>
					<td></td>
				</tr>
			</table>
			</form>
		</div>
		</div>
<script type="text/javascript">

function showjd(){
    $('#addjd').show();
}
function checkbutton(){
  alert('check');
}
function selectIP()
{
	var province=document.getElementById("province").value;
	var typeName=document.getElementById("typeName").value;
 var cuRealmName=document.getElementById("cuRealmName").value;
	$.post("selectIPCDNsaleOrderAction.do",{province:province,typeName:typeName,cuRealmName:cuRealmName},function(data){
		document.getElementById("addIPs").innerHTML=data;
	});
	
}
function addIPtijiao()
{
 var cusID=document.getElementById("cusID").value;
 var cuRealmName=document.getElementById("cuRealmName").value;
 var box = document.getElementsByName("IP");//将这个复选框声明成一个对象
        var country = box.length; //得到checkbox个数
        if(country==0)
        {
        	alert("请选择IP");
        	return ;
        }
        var love =""; //new Array();
        var love1 =""; //new Array();
        for(var i=0;i<country;i++){    
        if(box[i].checked==true){
	         
	        love+=box[i].value+",";
        }
        else
        {
	        love1+=box[i].value+",";
        }
        }
        $.post("addIPCDNsaleOrderAction.do",{cusID:cusID,cuRealmName:cuRealmName,love:love,love1:love1},function(data){
        	if(data==0)
        	{
        		alert("添加成功");
        		location.reload();
        	}
        	else if(data==3)
        	{
				alert("数据没有改变");
				location.reload();
            	}		
        	else
        	{
        		alert("添加失败");
        		location.reload();
        	}
        
        });
}
function delIP(id)
{
	if(confirm("确定要删除记录吗？")==true)
	{
		$.post("delIPCDNsaleOrderAction.do",{id:id},function(data){
			if(data==0)
			{
				alert("删除成功");
				location.reload();
			}
			else
			{
				alert("删除失败");
				location.reload();
			}
		
		});
	
	}

}
function suspendIP(id)
{
	if(confirm("确定要暂停该记录吗？")==true)
	{
		$.post("suspendIPCDNsaleOrderAction.do",{id:id},function(data){
			if(data==0)
			{
				alert("暂停成功");
				location.reload();
			}
			else
			{
				alert("暂停失败");
				location.reload();
			}
		
		});
	
	}

}
function resumeIP(id)
{
	if(confirm("确定要恢复该记录吗？")==true)
	{
		$.post("resumeIPCDNsaleOrderAction.do",{id:id},function(data){
			if(data==0)
			{
				alert("恢复成功");
				location.reload();
			}
			else
			{
				alert("恢复失败");
				location.reload();
			}
		});
	}
}

function suspendBatchIP()
{
if(confirm("确定要批量暂停选中的记录吗？")==true){
	 var box = document.getElementsByName("batchIP");//将这个复选框声明成一个对象
        var country = box.length; //得到checkbox个数
        if(country==0)
        {
        	alert("请选择IP");
        	return;
        }
        var love="";
        for(var i=0;i<country;i++){    
        if(box[i].checked==true){
        	love+=box[i].value+",";
        	}
        }
        $.post("suspendBatchIPCDNsaleOrderAction.do",{id:love},function(data){
			if(data==0)
			{
				alert("暂停成功");
				location.reload();
			}
			else
			{
				alert("暂停失败");
				location.reload();
			}
		
		});
        
   }
}
function resumeBatchIP()
{
if(confirm("确定要批量恢复选中的记录吗？")==true){
	 var box = document.getElementsByName("batchIP");//将这个复选框声明成一个对象
        var country = box.length; //得到checkbox个数
        if(country==0)
        {
        	alert("请选择IP");
        	return;
        }
        var love="";
        for(var i=0;i<country;i++){    
        if(box[i].checked==true){
        	love+=box[i].value+",";
        	}
        }
        
        $.post("resumeBatchIPCDNsaleOrderAction.do",{id:love},function(data){
			if(data==0)
			{
				alert("恢复成功");
				location.reload();
			}
			else
			{
				alert("恢复失败");
				location.reload();
			}
		
		});
        
   }
}
function delBatchIP()
{
if(confirm("确定要批量删除选中的记录吗？")==true){
	 var box = document.getElementsByName("batchIP");//将这个复选框声明成一个对象
        var country = box.length; //得到checkbox个数
        if(country==0)
        {
        	alert("请选择IP");
        	return;
        }
        var love="";
        for(var i=0;i<country;i++){    
        if(box[i].checked==true){
        	love+=box[i].value+",";
        	}
        }
        
        $.post("delBatchIPCDNsaleOrderAction.do",{id:love},function(data){
			if(data==0)
			{
				alert("删除成功");
				location.reload();
			}
			else
			{
				alert("删除失败");
				location.reload();
			}
		
		});
        
   }
}
//搜索框的Javascript
function showDiv()
{
	var div = document.getElementById('sel');
	div.style.visibility = "visible";
}

function hideDiv()
{
	var div = document.getElementById('sel');
	div.style.visibility = "hidden";
}

function getValue(targetObj,sourceObj)
{
	document.getElementById(targetObj).value = sourceObj;
	hideDiv();
}


function dimSelectIP()
{
	if(event.keyCode==13)
	{
		var dimIP=document.getElementById("dimIP").value;
		var cusID=document.getElementById("cusID").value;
		var cuRealmName=document.getElementById("cuRealmName").value;
		$.post("dimSelectIPCDNsaleOrderAction.do",{dimIP:dimIP,cusID:cusID,cuRealmName:cuRealmName},function(data){
			document.getElementById("addtrIP").innerHTML=data;
		});
	}

}
//弹出提示对话框
function Dialog()
{
	alert("请勿重复点击，谢谢");
}
</script>
	</body>

</html>
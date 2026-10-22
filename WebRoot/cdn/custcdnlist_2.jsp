<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>用户CDN节点配置列表</title>
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
             <span><img src="images/home.png" width="30" height="30"></span>
				<h3 style="line-height:35px;">
					CDN节点管理                    
				</h3>
			</div>
			<table class="tb tb2" id="tips">
				<tr>
					<th class="partition">
						<span><img src="images/idea_group.png" width="20" height="20" ></span>技巧提示
					</th>
					<th class="partition"style="text-align:right;">
						<a href="showcdnlist1CDNsaleOrderAction.do">返回CDN订单信息列表</a>
					</th>
				</tr>
				<tr>
					<td class="tipsblock" s="1">
						<ul id="tipslis">
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
						</ul>
					</td>
				</tr>
			</table>
			<div class="itemtitle">
				
				<h3 class="partition"  style="border-bottom:dashed 1px #deeffb; width:100%; padding-bottom:5px;">
					<span><img src="images/notes.png" width="20" height="20" /></span> <p style="float:left; margin-right:50px; line-height:22px;">	FUAO2008.COM</p>  
					<input type="submit" value="显示类型：" style="background-color:#666;color:#fff;" class="xslx" >
	                <input type="submit" value="线路类型显示" style="background:#363636;" class="xllx" >
	                <input type="submit" value="节点类型显示" class="jdlx" 
	                onclick=location.href='cdnRealmNameIPCDNsaleOrderAction.do?cusid=${cusid}&realmName=${realmName }'
	                >
				</h3>
			</div>
			<div class="itemtitle">
			   <!-- <p class="search"><input type="image" src="images/search.png" width="23" height="23" style="border:none;float:right;" ><input type="text" value="请输入关键字" onFocus="this.value=''" onBlur="if(!value){value=defaultValue;}" class="ttext" > </p> --> 	
			<input type="button" value="添加记录" class="sub_a" onclick="showjd();" />
			  
               <!-- <input type="submit" value="批量删除" class="sub_a" onclick="delBatchIP()" /> -->
			</div>
			<form action="addoreditWorkPosition.do" method="post" id="form0"
				name="form0">
				<s:token name="register0"></s:token>
				<input type="hidden" id="mark" name="mark" value="new" />
				<input type="hidden" name="register0" value="A7WCUM9ZT0RB0RN0BGAYZ6AJTBMP2ESE" />
				<input type="hidden" id="mark" name="mark" value="new" />
				
				<table align="center" border="0" width="440px;" class="tb tb2">
					<tr align="left">
					
						<th width="20%">
							<b>加速区域</b>
						</th>
						
						<th width="20%">
							<b>加速节点</b>
						</th>
						
						<th width="25%">
							<b>域名地址</b>
						</th>
						
						<th align="center" style="text-align:center;" width="35%">
							<b>操&nbsp;&nbsp;作</b>
						</th>
					</tr>
                   
                   
					<c:forEach items="${cdp}" var="p">
						<tr>
							<td style="font: 10pt;">
								${p.typeName}
							</td>	
							<!-- 加速节点 -->
							<td style="font: 10pt;">
								<input type="hidden" id="batchIP" value="${p.id }" />
								${p.ip }&nbsp;&nbsp;&nbsp;
								<input type="hidden" id="ipCheckBox" value="${p.ip }"/>
								<input type="hidden" value="${p.mark}" />
								 
							</td>
							
							<!-- 域名地址 -->
							<td style="font: 10pt;">
								${p.yuming }
							</td>
							
							<td style="font: 10pt;text-align: center;" width="20%">
							 
							<a class="faq" title="暂停该加速区域"
									onclick="suspendBatchIP()">批量暂停</a>&nbsp;&nbsp;
							<a class="faq" title="删除该加速区域"
									onclick="delBatchIP()">批量删除</a> 
							<a class="faq" title="恢复该加速区域"
									onclick="resumeBatchIP()">批量恢复</a>&nbsp;&nbsp;
							</td>
						</tr>
						</c:forEach>
				</table>
			</form>
		<div>
		<!-- 管理节点 -->
		<div id="addjd" style="display: none">
		<form action="" method="post" id="form1"
				name="form1">
		<table border="0" width="440px;"  class="tb tb2">
				<th colspan="5">
					<h3>
					添加节点
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
								<option value="${ca.id }">${ca.province }省</option>
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
	$.post("selectIPCDNsaleOrderAction.do",{province:province,typeName:typeName},function(data){
		document.getElementById("addIPs").innerHTML=data;
	});
	
}
//添加_2
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
        alert("cusID"+cusID);
        alert("cuRealmName"+cuRealmName);
        alert("love"+love);
        alert("love1"+love1);
        $.post("addIPCDNsaleOrderAction.do",{cusID:cusID,cuRealmName:cuRealmName,love:love,love1:love1},function(data){
        	if(data==0)
        	{
        		alert("添加成功");
        		location.reload();
        	}
        	else if(data==3)
        	{
				alert("失败！请勿提交重复数据");
				location.reload();
            	}	
        	else
        	{
        		alert("添加失败");
        		location.reload();
        	}
        
        });
}
//分割取出来的ip---暂时没用到
function alertDialog(){
	var aa = document.getElementById("ipCheckBox").value;
	var yy = doucment.getElementById("addIPs").value;
	var array = aa.split(",");
	var nums = [];
	for(var i = 0;i<array.length;i++)
	{
		document.getElementById("").innerHTML="";
		alert("数组"+array[i]);
		
		//if(array[i]==)
	}
	
}

//批量暂停_2
function suspendBatchIP()
{
if(confirm("确定批量暂停该加速区域的所有节点?")==true){
	 var box = document.getElementById("batchIP").value;//将这个复选框声明成一个对象
	 alert(box);
        $.post("suspendBatchIPCDNsaleOrderAction.do",{id:box},function(data){
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

//批量删除_2
function delBatchIP()
{
	if(confirm("确定要批量删除选中的记录吗？")==true){
		 var box = document.getElementById("batchIP").value;//将这个复选框声明成一个对象
	        $.post("delBatchIPCDNsaleOrderAction.do",{id:box},function(data){
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
//批量恢复_2
function resumeBatchIP()
{
if(confirm("启用该加速区域的节点？")==true){
	 var box = document.getElementById("batchIP").value;//将这个复选框声明成一个对象
	 alert(box);
        $.post("resumeBatchIPCDNsaleOrderAction.do",{id:box},function(data){
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
</script>
	</body>

</html>
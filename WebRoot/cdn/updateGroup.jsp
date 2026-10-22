<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
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
		function selectIP()
{
	var province=document.getElementById("province").value;
	var typeName=document.getElementById("typeName").value;
		var id=document.getElementById("groupNameId").value;
 var cuRealmName="";
 	$.post("selectIP1CDNsaleOrderAction.do",{province:province,typeName:typeName,cuRealmName:cuRealmName,id:id},function(data){
		document.getElementById("addIPs").innerHTML=data;
	});
 
	
	
}
function addgroup()
{
	var groupName1=document.getElementById("groupName").value;
	var id=document.getElementById("groupNameId").value;
	var groupName=encodeURI(groupName1);
	if(groupName==""||groupName==null)
	{
		alert("请输入组名");
		return ;
	}
	 var box = document.getElementsByName("IP");//将这个复选框声明成一个对象
        var country = box.length; //得到checkbox个数
        if(country==0)
        {
        	alert("请选择IP");
        	return ;
        }
        var love =""; //new Array();
        for(var i=0;i<country;i++){    
        if(box[i].checked==true){
	         
	        love+=box[i].value+",";
        }
		}
		if(love=="")
		{
			alert("请选择IP");
			return ;
		}
			$.post("addgroupJieDianCDNsaleOrderAction.do",{id:id,love:love},function(data){
        	if(data==0)
        	{
        		alert("添加失败");
        	}
        	else
        	{
        		window.location.href="addSelectGroup1CDNsaleOrderAction.do?id="+data;
        	}
        });
}
function delIP()
{
		if(confirm("确定要删除记录吗？")==true)
		{
		var id=document.getElementById("groupNameId").value;
	 var box = document.getElementsByName("groupIP");//将这个复选框声明成一个对象
        var country = box.length; //得到checkbox个数
        if(country==0)
        {
        	alert("请选择IP");
        	return ;
        }
        var love =""; //new Array();
        for(var i=0;i<country;i++){    
        if(box[i].checked==true){
	         
	        love+=box[i].value+",";
        }
		}
		
			{
				$.post("delGroup1CDNsaleOrderAction.do",{id:id,love:love},function(data){
				if(data==0)
				{
					alert("删除成功");
					location.reload();
				}
					
				});
			}
			}
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
					CDN分组管理                    
				</h3>
               
			</div>
			<table class="tb tb2 " id="tips">
				<tr style="border-bottom:dashed 1px #deeffb;">   <!--  class="dji"  -->
 					<th class="partition">
						<span><img src="images/idea_group.png" width="20" height="20" ></span>技巧提示
					</th>
					<th class="partition"style="text-align:right;">
						&nbsp;&nbsp;&nbsp;<a href="selectGroupCDNsaleOrderAction.do" style="color: red">返回CDN分组信息列表</a>
					</th>
				</tr>
				<tr>
					<td class="tipsblock" s="1">
						<ol id="tipslis">
							<li>
								组&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：<font color="red">组名不能修改</font>
							</li>
							<li>
								覆盖节点：原来的节点在上面，可以删除不需要的
							</li>
							<li>
								保存节点：保存节点根据加速线路、和地区选择里面要添加进组的节点<font color="red">（组里面存在的节点不能就行操作）</font>在点击保存按钮
							</li>
							<li>
								返回列表：修改完成点击右上边的"<font color="red">返回CDN分组信息列表</font>"
							</li>
						</ol>
					</td>
				</tr>
			</table>
			<div class="itemtitle">
			  	
			  <input type="submit" value="修改分组" class="sub_a" />
            	
			</div>
				<input type="hidden" name="struts.token.name" value="register0" />
<input type="hidden" name="register0" value="A7WCUM9ZT0RB0RN0BGAYZ6AJTBMP2ESE" />
				<input type="hidden" id="mark" name="mark" value="new" />
				<table align="center" border="0" width="100%" class="tb tb2">
					<tr align="left">
                         <th width="10%"> <b>组&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</b></th>
						<th width="25%">
							<b>覆盖节点</b>
						</th>
						
						<th width="15%">
							<b>加速线路、地区</b>
						</th>
						<th width="25%">
							<b>选额节点</b>
						</th>
                        <th width="15%"><b>操作</b></th>				
					</tr>    
						
					<tr id="czl_tr1" onmouseover="fs('czl_tr1');" onmouseout="lk('czl_tr1');" class="likai">
                      <td>
                      ${cdnGroup.groupName }
                      <input type="hidden" id="groupName" name="groupName" value="${cdnGroup.groupName }" />
					<input type="hidden" id="groupNameId" name="groupNameId" value="${cdnGroup.id}" /></td>
							<td style="font: 10pt;">
                            ${cdnGroup.panelPointId}<br />
                            <input type="button" onclick="delIP()" value="删除选中的节点"/>
                            </td>
							
							<td style="font: 10pt;">
								<SELECT id="province" value="this.value">
					<option value="0">请选择</option>
							<c:forEach items="${cdnArea}" var="ca">
								<option value="${ca.id }">${ca.province }</option>
							</c:forEach>
						</SELECT>
						<SELECT id="typeName" onchange="selectIP()" id="typeName">
						<option value="0">请选择</option>
							<c:forEach items="${cdnType}" var="ca1">
								<option value="${ca1.id }">${ca1.typeName }</option>
							</c:forEach>
						</SELECT>

							</td>
							<td style="font: 10pt;" id="addIPs">
								
							</td>
							<td  >
							<input type="button"  value="保存节点" onclick="addgroup()"/>
							</td>				
						</tr>
                        
                        						
						
						
				</table>
	
	
	</body>

</html>
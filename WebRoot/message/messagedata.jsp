<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  
    <base href="<%=basePath%>">
    <title>写信箱</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script language="javascript" src="<%=request.getContextPath()%>/js/message/0219.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/dtree.js"></script>
			
  </head>
 <script type="text/javascript">
 
 	function selbysuperid(str){
 		var surperid=$(str).val();
 		
 		var mes=$("#mesty");
 		mes.empty();
 		$.post('selbysuperidmessage.do',{surperid:surperid},
 		function (data){
 			if(data!=1)
 				mes.append(data);
 		});
 	}
 	
 	function val(){
 	var mes=$("#mesty").val();
 	if(mes=='-1'){
 		alert("请选择类型！");
		return false;
		}
	var receiver = $("#receiver").val();
	if(receiver == null || receiver == ''){
		alert("请选择接收人");
		return false;
	}
	var titleweb = $("#titleweb").val();
	if(titleweb == null || titleweb == ''){
		alert("请填写标题!");
		$("#titleweb").focus();
		return false;
	}
	var messagecontent = $("#messagecontent").val();
	var oEditor = FCKeditorAPI.GetInstance("messagecontent");
	if(oEditor.GetXHTML(true) == null || oEditor.GetXHTML(true) == ''){
		oEditor.EditorDocument.body.innerHTML="请输入消息内容...";
		oEditor.EditorDocument.attachEvent("onclick", clearFCK);
		return false;
	}
	var mesty=document.getElementById("mesty").value;
   // alert("aa"+emps);
	$('#users').attr("value",emps);
 	}
 	
 	function clearFCK(){
 	   var oEditor = FCKeditorAPI.GetInstance("messagecontent");
 	   oEditor.EditorDocument.body.innerHTML="";
 	}
 	
 	//根据是个人消息还是系统消息,再决定是否需要审核
   function judgeM()
   {
    
    var messJudge=document.getElementById("messJudge").value;
    var mId=document.getElementById("mId").value;
    var url="judgeMmessage.do";
    var mes=$("#mesty");
 		mes.empty();
    $.post(url,{messJudge:messJudge,mId:mId},function (data)
    {
            // alert(data);
            if(data!=1)
            
               
              mes.append(data);
            
            
    }
    );
   }
   
   
   //项目消息
   function prjMsg(){
     var prjmsg = $("#messJudge").val();
     if(prjmsg==2){
       $.post('showPrjmessage.do',{},function(data){
           var d = encodeURI(data,"utf-8");
           $("#mesty").empty().append(data);
       });
     }
   }
 
 </script>
  <body>
  <div style="margin-left: 60px">
<FORM name="customerform" action="<%=request.getContextPath()%>/addmessage.do"  method="post"  onsubmit="return val()">
	<div style="float:left; width:744px;">
			<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor=#c4d8ed border=0>
				<TBODY>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
						</TD>
						<TD width="100%" background="<%=request.getContextPath()%>/images/r_0.gif">
							<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
								<TBODY>
									<TR>
										<TD style="font-size: 12px;color: red;">
											&nbsp;写信箱中(带*号的为必填项)
										</TD>
										<TD align=right>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
						</TD>
					</TR>
					<TR>
						<TD ></TD>
						<TD>
							<TABLE class="toptable grid"  align="center" 
								style="border: 1px solid rgb(112, 128, 144); font-size: 14px; border-collapse: collapse;" width="744" height="432">
								<TBODY>										
									<TR>
										<TD width="10%" height=30 align=right>
											消息类型：
										</TD>
										<TD>
										
										 <input type="hidden" value="${messagetypes.messagetypeid }" name="messagetypeBySendertype.messagetypeid" id="mId"/>
										   <input type="hidden" disabled="disabled"
														value="${messagetypes.type }" size="10" id="mestype"
														name="mestype">
										  <!-- 根据是个人消息还是系统消息,再决定是否需要审核 -->
											<select id="messJudge" style="width:105px;" onchange="judgeM(),prjMsg()">
											      <option value="-1">请选择！！</option>
											      <option value="0">个人消息</option>
											      <option value="1">系统消息</option>
											      <option value="2">项目消息</option>
											</select>
										<!--   <select id="mesty" name="messagetypeByMessagetype.messagetypeid" style="width:105px;"> 
													   <option value="-1">请选择！！</option>  
														<c:forEach items="${messagetypes1}" var="data"> 
														    
															<option value="${data.messagetypeid}"> 
																 
																${data.type} 
															</option> 
														</c:forEach> 
													</select>
													-->
													
													
													 <select id="mesty" name="messagetypeByMessagetype.messagetypeid" style="width:105px;"> 
													   <option value="-1">请选择！！</option>  
														
													</select>
											&nbsp;
											<!--  
										消息优先级：
											<select style="width:60px">
												<option>普通</option>
												<option>一般</option>
												<option>紧急</option>
											</select>
											&nbsp;
											是否需求回执：
											<input type="checkbox" name="">
											-->
										</TD> 
									</TR>	
									<TR>
										<TD width="10%" height=30 align=right>
											接收人：
										</TD>
										<TD width="10%" class=category>
											<INPUT style="WIDTH: 95%" name="receiver" id="receiver" >
										</TD>
									</TR>
										
									<TR>
										<TD width="10%" height=30 align=right>
											标题：
										</TD>
										<TD width="10%" class=category>
											<INPUT style="WIDTH: 95%" name="titleweb" id="titleweb">
											
										</TD>
									</TR>	
									<!-- 
									<TR>
										<TD width="10%" height=30 align=right>
											 <input type="button" name="addaccessory" id="addaccessory" value="添加附件">
										</TD>
										<td></td>
									</TR>-->
									<TR>
									<TD width="10%" height=30 align=right>
											消息内容：
										</TD>
										<TD width="90%" class=category>
											<FCK:editor instanceName="messagecontent" inputName="messagecontent" height="600px" basePath="/fckeditor">
											<jsp:attribute name="value">
											</jsp:attribute>
											</FCK:editor>
										</TD>
									</TR>	
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<input type="hidden" id="users" name="users">
											<INPUT class=button type="submit" value="确认提交 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">

										</TD>
									</TR>
								</TBODY>
							</TABLE>
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
							<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
						</TD>
			</TABLE>
			</div>
		</FORM>
	<div id="sub-dept" style="float:left; width:230px;margin: 0px;padding: 0px;border: 0px;">
	</div>
</div>	
  <script type="text/javascript">
	$("#sub-dept").load("alldeptmessageDepartment.do");
	function setusers(){
	var mesty=document.getElementById("mesty").value;
   // alert("aa"+emps);
	$('#users').attr("value",emps);
   }
</script>
  </body>
</html>
<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>消息</title>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
	function showd(str)
	{
		var obj=new Object();
		obj.name=str;
		window.showModalDialog("<%=request.getContextPath() %>/message/logdetail.jsp",obj,"dialogWidth=500px;dialogHeight=200px");
	}
	//删除信息
	 function delMes()
   {
              
                 
                  var  els =document.getElementsByName("ids"); 
                  for(var i=0;i <els.length;i++){
               if(els[i].checked ==true)
               {  
                ids=els[i].value;
               
                var url="delsendmesmessage.do";
                $.post(url,{ids:ids},function (data)
                 {
                 
                    if(data==0)
                    {
                     alert("删除成功！！");
                     window.location.href='<%=request.getContextPath()%>/Listmessage.do';
                    }
                    else
                    {
                      alert("删除失败 ！！");
                    }
                });
                
                  } 
              
             
            }    
             
   
   }
	//删除所选信息
function del(url,href){
  
	var delflag=false;
	
	var all=document.getElementsByName('ids');
	
	var allId=new Array();
	var j=0;
	for(var i=0;i<all.length;i++)
	{
		if(all[i].checked==true)
		{
			allId[j]=all[i].value;
			j++;
		}
	}
	if(allId.length>0)
		delflag=true;
	if(!delflag)
	{
		alert("请选择要删除的记录！");
		return false;
	}
	delflag=confirm("是否确定要删除？");
	
	if(!delflag)
		return false;
	$.post(url,{ids:allId},
	function (data)
	{
		if(data==0){
			alert('删除成功！');
			window.location.href=href;
		}else if(data == 2)
		{
			alert("请将入库单的入库详细先删除");
		}
		else {
			alert('删除失败！');
		}
	});
}
</script>
</head>
<body>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
			border=0>
			<TBODY>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
					
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<!--startprint-->
						
						<FORM name=form1 action="" onsubmit="">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>


									<TR align="center">
									
										<TD width="10%" class=category>
											类型名称
										</TD>
										<TD width="55%" class=category>
											消息标题
										</TD>
										<TD width="10%" class=category>
											消息内容
										</TD>
										<TD width="10%" class=category>
											修改
										</TD>
										<TD width="10%" class=category>
											删除
										</TD>
									</TR>
									<!--循环-->
                                   
									<c:forEach items="${pages.pageList}" var="data" >
											<TR>
												<TD align=middle>
												 <input type="hidden" id="typeid" name="typeid" value="${data.messagetypeByMessagetype.messagetypeid}">
							               <a href="receiveInfomessage.do?typeid=${data.messagetypeByMessagetype.messagetypeid}&messageid=${data.messageid}">${data.messagetypeByMessagetype.type }</a>
												</TD>
												<input type="hidden" name="messageId" value="${data.messageid}"/>
												<TD align=middle>
													
												${data.titleweb }
												</TD>	
												<TD align="middle">
												  ${data.messagecontent }
												</TD>
												<TD align="middle">
												<A
														href="update1message.do?id=${data.messageid}"
														target=right><IMG style="CURSOR: hand" 
															hspace=2 src="<%=request.getContextPath() %>/images/res.gif" border=0>
													</a>
												</TD>
												<TD align=middle>
													<INPUT
														style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
														type=checkbox value="${data.messageid }" name=ids>
												</TD>
											</TR>
											</c:forEach>
					
											<TR>

											</tr>
									<!--循环结束-->
													<TD class=category colSpan=12 height=30 align="right">
													
								     					<INPUT id=chkall
															style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选(删除)
															
														<INPUT name="delbut" type=button class=button
															onclick="delMes()"
															value="删 除">
														
									</TD>
								</TBODY>
							</TABLE>
				</FORM>
						<!--endprint-->
					</TD>
					<TD><br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD>
					
					<p:pages url="getpagesmessage.do"/>
					
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>

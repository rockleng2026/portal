<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
	<head>


		<title>留言版</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<LINK href="<%=request.getContextPath()%>/Css/style.css" type=text/css
			rel=stylesheet>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/jquery.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/data.js"></script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<script type="text/javascript">

  //删除信息
	 function delMes()
   {
              
                 
                  var  els =document.getElementsByName("ids"); 
                  for(var i=0;i <els.length;i++){
               if(els[i].checked ==true)
               {  
                ids=els[i].value;
                 //alert(ids);
                var url="delsendmesmessage.do";
                $.post(url,{ids:ids},function (data)
                 {
                 
                    if(data==0)
                    {
                     alert("删除成功！！");
                     window.location.href='<%=request.getContextPath()%>/boardMessagemessage.do';
                    }
                    else
                    {
                      alert("删除失败 ！！");
                    }
                });
                
                  } 
              
             
            }    
             
   
   }
   
   	 function changeReadState()
   {
              
                 
                  var  els =document.getElementsByName("duqu"); 
                 for(var i=0;i <els.length;i++){
               if(els[i].checked ==true)
               {  
                ids=els[i].value;
                // alert(ids);
                var url="duqu1message.do";
                $.post(url,{ids:ids},function (data)
                 {
                 
                    if(data==0)
                    {
                     alert("读取状态改变成功！！");
                     window.location.href='<%=request.getContextPath()%>/boardMessagemessage.do';
                    }
                    else
                    {
                      alert("读取状态改变失败 ！！");
                    }
                });
                
                  } 
              
             
            } 
                
             
   
   }
 
   
</script>
	</head>

	<body>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
			border=0>
			<TBODY>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
                            	
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										留言版
									</TD>
									<TD align=right>
										&nbsp;
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_2.gif">
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<form action="">
							<table class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<tr>
									<td align="center" width="10%" class=category>
										消息类型
									</td>

									<td align="center" class=category>
										消息内容
									</td>

									<td align="center" class=category>
										消息标题
									</td>





									<td align="center" class=category>
										读取状态
									</td>
									<td align="center" class=category>
										读取
									</td>
									<td align="center" class=category>
										删除
									</td>
								</tr>
								<!-- 开始循环 -->
								<c:forEach items="${pages.pageList}" var="data">
									<tr>
										<td align="center" class=category>
											${data.messagetypeByMessagetype.type }
										</td>


										<td align="center" class=category>
											${data.messagecontent }
										</td>

										<td align="center" class=category>
											${data.titleweb }
										</td>



										<td align="center" class=category>
											<c:if test="${data.tmp1== '0'}">未读取</c:if>
											<c:if test="${data.tmp1== '1'}">${data.releasetime }</c:if>
										</td>
										<td align="center" class=category>
											<c:if test="${data.tmp1== '0'}">
												<INPUT
													style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
													type=checkbox value="${data.messageid}" name="duqu"
													onclick="changeReadState()">
											</c:if>
											<c:if test="${data.tmp1== '1'}">
												已读取
											</c:if>
										</td>
										<TD align="center" class=category>
											<INPUT
												style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
												type=checkbox value="${data.messageid }" name=ids>
										</TD>
									</tr>
								</c:forEach>
								<!-- 结束循环 -->
								<TD class=category colSpan=6 height=30 align="right">

									<INPUT id=chkall
										style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
										onclick=CheckAll(this.form) type=checkbox value=select
										name=chkall>
									全选(删除)

									<INPUT name="delbut" type=button class=button
										onclick="delMes()" value="删 除">

								</TD>
							</table>
						</form>
					</TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
					</TD>
					<TD>

						<p:pages url="getpagesmessage.do" />

					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</body>
</html>

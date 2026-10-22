<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>消息</title>
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
		
	function showInfo(id)
	{
		alert(id);
		//window.showModalDialog("<%=request.getContextPath() %>/workLogs/goDealWorkLog.do?id="+id,obj,"dialogWidth=900px;dialogHeight=600px");
		
		var nowDate = (new Date()).getTime();
		var url = "<%=request.getContextPath() %>/getmessage.do?id="+id+"&dd="+nowDate;
		window.location.href=url;
	}
	function showd(str)
	{
		var obj=new Object();
		window.showModalDialog("<%=request.getContextPath()%>/message/logdetail.jsp",obj,"dialogWidth=500px;dialogHeight=200px");
	}

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
                     window.location.href='<%=request.getContextPath()%>/messendmessage.do';
                    }
                    else
                    {
                      alert("删除失败 ！！");
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
						
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										已发送消息
									</TD>
									<TD align=right>
										&nbsp;
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<TD>
						
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
											消息类型
										</TD>
										<TD width="15%" class=category>
											消息标题
										</TD>
										
										<TD width="50%" class=category>
											消息内容
										</TD>
										<td width="15%">
											发布日期
										</td>
										
										<TD width="5%" class=category>
											修改
										</TD>
										<TD width="5%" class=category>
											删除
										</TD>
									</TR>
									<!--循环-->
									<div id="ct">
									
									</div>

									<c:forEach items="${pages.pageList}" var="data">


										<TR>
                                              <TD align=middle>
                                             
											  <input type="hidden" id="typeid" name="typeid" value="${data.messagetypeByMessagetype.messagetypeid}">
							               <a href="receiveInfomessage.do?typeid=${data.messagetypeByMessagetype.messagetypeid}&messageid=${data.messageid}">${data.messagetypeByMessagetype.type }</a>
											</TD>
											<TD align=middle>
												${data.titleweb }
											</TD>
											<TD align=middle>
													<a href="javascript:void(0);" onclick="showInfo('${data.messageid }')">查看内容</a>
											</TD>
											<td>
											${data.releasetime }
											</td>
											<td align="center">
												<A href="update1message.do?id=${data.messageid}"
													target=right><IMG style="CURSOR: hand" hspace=2
														src="<%=request.getContextPath()%>/images/res.gif"
														border=0> </a>
											</td>
											<TD align=middle>
												<input type="hidden" value="${data.messageid }" />
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
											onclick="delMes()" value="删 除">
									</TD>
								</TBODY>
							</TABLE>
						</FORM>
						<!--endprint-->
					</TD>
					<TD>
						<br>
					</TD>
				</TR>
				<TR>
					<TD>
						
					</TD>
					<TD>

						<p:pages url="messendmessage.do?funid=246" />

					</TD>
					<TD>
						
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>

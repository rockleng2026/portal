<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>入库单列表</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/data.js" ></script>
<script type="text/javascript">
function add(count){

	
 $("#jtip"+count+"").click(function(){//对象定位

 var h=0, l=0, w=0, obj = this;
 while(obj != null)
 {
 h += obj.offsetTop -10;
 l += obj.offsetLeft -15;
 obj = obj.offsetParent;
 }

 w = $(this).width();

 $("#alerts"+count+"").css({'top':h+'px','left':(l+w)+'px'});
 $("#alerts"+count+"").show();
})
}
</script>
<script type="text/javascript">
    //新增保存按钮,点击保存,把id写到订单和任务的中间表里去
    function allChecked(){
       form1.action="<%=request.getContextPath()%>/selMarkBytemp2TaskProject.do";
       form1.submit();
    }
    
    //保存按钮的显示和隐藏
		function showbc(){
		  var marker2 = $("#marker2").val();
		  var taskid = $("#taskid").val();
		  if(marker2.length>0 && marker2!="" && taskid!=""){
		     document.getElementById("bc").style.display='block';
		  }else{
		     document.getElementById("bc").style.display='none';
		  }
		}
</script>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>


<base target="_self"/> 
</head>
<body onload="showbc()">
		<FORM name=form2 action="warehousingInfoWarehousing.do" method="post">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
			
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath() %>/images/print.jpg">
						</TD>
					
						
						<TD align=right width="95%">
						请选择查询条件：
							<SELECT id="tiaojian" name="tiaojian" value="this.value">
								<option  value="2">单号查询</option>
								<option value="1">仓库查询</option>
								<option  value="3">客户查询</option>
								<option  value="4">经手人查询</option>
							</SELECT>&nbsp;&nbsp;
							<INPUT name="purNo" id="purNo" >
							<INPUT class=button type=submit   value=" 查询 ">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
		<form action="" id="form1">
		<TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed
			border=0>
			<TBODY>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_1.gif">
					</TD>
					<TD width="100%" background=images/r_0.gif>
						<TABLE cellSpacing=0 cellPadding=0 width="100%">
							<TBODY>
								<TR>
									<TD>
										&nbsp;入库单列表
									</TD>
									<TD align=right>
										&nbsp;
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_2.gif">
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<!--startprint-->
						
					
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>

								<TBODY>
									<TR align="center">
									
										<TD width="12%" height=30 class=category>
											入库单编号
										</TD>
										<TD width="8%" class=category>
											仓库
										</TD>
										<TD width="8%" class=category>
											入库类型
										</TD>
										
										<TD width="8%" class=category>
											入库时间
										</TD>
										<TD width="8%" class=category>
											经手人
										</TD>
										<TD width="8%" class=category>
											客户
										</TD>
										<TD width="8%" class=category>
											总价格
										</TD>
										

										<TD width="8%" class=category>

											审核状态
										</TD>

										<TD width="7%" class=category>
											流程跟踪
										</TD>
									  <td width="15%" class=category>
									       备注
									  </td>
									  <TD width="10%" class=category>
													修改	/删除/详细
												
									</TD>
									<input type="hidden" id="marker2" name="marker2" value="${marker }" />
							        <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
									</TR>
									<!--循环-->
                             
									<c:forEach items="${pages.pageList}" var="data" varStatus="status">
											<TR>
												<TD align=center>
												${data.storageNo }
												</TD>
													<TD align=center>
													${data.depot.name}
												</TD>
													<TD align=center>
													${data.allType.typeName}
												</TD>
												<TD align=center>
														${data.storageDate}
											
												</TD>
												<TD align=center>
													${data.employee.name}
												</TD>
												<TD align=center>
												<c:if test="${data.customer.realName==null}">公司入库</c:if>
													${data.customer.realName}
												</TD>
												<TD align=center>
													${data.productPriceSum}
												</TD>
												
												<TD align=center>
													<c:if test="${data.storageVerify==0 || data.storageVerify==null}">
														 <label id="sh">未通过审核</label>
													</c:if>
													<c:if test="${data.storageVerify==1 ||data.storageVerify==2}">
														 <label id="sh">已通过审核</label>
													</c:if>
													<c:if test="${data.storageVerify==8}">审核进行中</c:if>
													
												</TD>
												
												<TD align=center>
													<a href="followAuditing.do?orderNo=${data.storageNo }">流程跟踪</a>
												</TD>
												<TD align=center>
												     <c:if test="${empty data.storageRemark }">
												               
												     </c:if>
												    <c:if test="${! empty data.storageRemark }">
												              
											<!-- 	<a href="javascript:void(0)" id="jtip${data.storageId}" onclick="add(${data.storageId})" style="color: blue;">${data.storageRemark}</a> -->
											${data.storageRemark}
													
								<div id="alerts${data.storageId}" style="position: absolute; z-index: 2; width: 200px;height:500px; height:auto; background-color:#fff; border: 1px dashed #0166d4; display: none">
									
									
									<div align="right">
									<span onclick=document.getElementById("alerts${data.storageId}").style.display="none"
										style="color: #993333; font-weight: bold">关闭</span>
									</div>
									${data.storageRemark }
								</div>
								
												     </c:if>
												</TD>
							<TD align="center">	
											<A title="修改" href="updateShowWarehousing.do?cid=${data.storageId}"
											target=right><IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath() %>/images/res.gif" border=0>
											</a>
											<INPUT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
											type=checkbox value="${data.storageId }" name=ids>
											<A title="详细信息" href="detailWarehousing.do?cid=${data.storageId }&purNo=${data.storageNo}&info=info"
											target=right><IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath() %>/images/choose.gif" border=0>
											</a>
									</td>
									
								
											</TR>
											</c:forEach>
											<TR>

											</tr>
									<!--循环结束-->
									<tr>
									<TD class=category colSpan=13 height=30 align="right">
								     
								     	<INPUT id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
														<input type="button" id="bc" value="保存" onclick="allChecked(),closeWindeows(0)" />
														<INPUT name="delbut" type=button class=button
															onclick="del('delWarehousing.do','warehousingInfoWarehousing.do')"
															value="删 除">
									</TD>
								</TBODY>
							</TABLE>
					
						<!--endprint-->
					</TD>
					<TD><br></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD><p:pages url="warehousingInfoWarehousing.do"/></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		</form>
	</BODY>
</HTML>

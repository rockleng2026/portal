<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/pagetag.tld" prefix="p"%> 
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gbk">
		<title>Insert title here</title>
		<jsp:include page="/common/inc_css.jsp" flush="true" ></jsp:include>
<jsp:include page="/common/inc_js.jsp" flush="true" ></jsp:include>
<jsp:include page="/js/cha.jsp" flush="true" ></jsp:include>
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/showdiv.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<SCRIPT language=javascript>
		function del(id)
		{
		var t=new Date();
		var url="deleteReturnOrderRejection.do?t="+t;
		     if(confirm("你确定要删除该退货单吗？")==true)
		     {
		         $.post(url,{id:id},function(data){
		         	if(data=="0")
		         	{
		         		alert("该单据中商品未出库，不能删除该单据");
		         		return ;
		         	}
		            else if(data=="1")
		             {
		                 alert("删除操作成功");
		                 window.location.href="returnOrderListRejection.do?t="+t;
		             }else
		             {
		             	alert("删除失败")
		             	return ;
		             }
		        }
		                 );
		     }
		}
</SCRIPT>

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


		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY onload="showbc()">
		<FORM name=form2 action="getpageToOrder.do">
			<TABLE cellSpacing=2 cellPadding=0 width="100%" align=center border=0>
				<TBODY>
					<TR>
						<TD width="5%" height=21>
							&nbsp;
							<IMG style="CURSOR: hand" src="<%=request.getContextPath()%>/images/print.jpg" align=absMiddle>
						</TD>
						<TD align=right width="95%">
							退货单编号：<input type="text" name="returnorderNum" value=""  onclick="showDiv('filterDiv','')">
							<input type="submit" name="seach" value="筛选查询"  onclick="showDiv('filterDiv','')">
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
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
										&nbsp;采购退货单记录查询
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
					<TD></TD>
					<TD>
						<!--startprint-->
						<FORM name=form1 id="form1" action="employees.do?" onsubmit="return check()">
						<input type="hidden" name="method" value="delEmployees">
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1 width="100%">

								<TBODY>
									<TR align="center">
									     <TD width="5%" height=30 class=category>
											选择
										</TD>
										<TD width="10%" class=category>
											采购退货单号
										</TD>
										<TD width="10%" class=category>
											采购订单号
										</TD>
										<TD width="10%" class=category>
											到货单号
										</TD>
										<TD width="8%" class=category>
											退货日期
										</TD>
										<td width="7%" class=category>
											审核状态
										</td>
										<TD width="10%" class=category>
											采购类型
										</TD>
										<TD width="6%" class=category>
											联系人
										</TD>
										<TD width="8%" class=category>
											联系电话
										</TD>
										
										<TD width="6%" class=category>
											退货方式
										</TD>
										<TD width="5%" class=category>
											总金额
										</TD>
										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD width="3%" class=category>
													修改
												</TD>
											</c:if>
											<c:if test="${map.key==3}">
												<TD width="3%" class=category>
													删除
												</TD>
											</c:if>
											<c:if test="${map.key==4}">
												<TD width="6%" class=category>
													详情信息
												</TD>	
											</c:if>
										</c:forEach>
										<TD width="9%" class=category>
											流程跟踪
										</TD>
										<input type="hidden" id="marker2" name="marker2" value="${marker }" />
						                <input type="hidden" id="taskid" name="taskid" value="${taskid }" />
									</TR>
									<!--循环-->	
									<c:forEach items="${pages.pageList}" var="data">
									<tr align="center">
									    <TD align=center>
											<input type="checkbox" id="ids" name="ids" value="${data.id}"/>
										</TD>
										<TD>
											${data.purReturnNo}
										</TD>
										<TD>
											${data.toOrder.purOrder.purOrderNo}
										</TD>
										<TD>
											${data.toOrder.toOrderNum}
										</TD>
										<TD>
											${data.returnTime}
										</TD>
										<TD >
										<c:if test="${data.returnOrderVerify==0 || data.returnOrderVerify==null}">
										未审核</c:if>
										<c:if test="${data.returnOrderVerify==1 || data.returnOrderVerify==2}">
										已审核</c:if>
										<c:if test="${data.returnOrderVerify==8}">审核进行中</c:if>
										</TD>
										<TD>
											${data.buytype}
										</TD>
										<TD>
											${data.supplier.supplierName}
										</TD>
										<TD>
											${data.supplier.mobilePhone}
										</TD>
										<TD>
											${data.returnStyle}
										</TD>
										<TD>
											${data.orderGross}
										</TD>
										<c:forEach items="${option}" var="map">
											<c:if test="${map.key==2}">
												<TD>
												<c:if test="${data.returnOrderVerify!=8}">
													<a href="skippageRejection.do?returnorderid=${data.id}&&mark=edit" target=right>
													<IMG style="CURSOR: hand" onclick="" hspace=2 src="<%=request.getContextPath()%>/images/res.gif" align=absMiddle border=0>
													</a>    
													</c:if>
													<c:if test="${data.returnOrderVerify==8}">审核进行中</c:if>												</TD>	
											</c:if>
											<c:if test="${map.key==3}">
												<TD>
												<c:if test="${data.returnOrderVerify!=8}">
													<a href="javascript:void();" onclick="return del(${data.id});"><img src="<%=request.getContextPath()%>/img/del.gif" width="20px" height="20px" border=0 ></a>
												</c:if>
													<c:if test="${data.returnOrderVerify==8}">审核进行中</c:if>	
												</TD>
											</c:if>
											<c:if test="${map.key==4}">
												<TD>
												<c:if test="${data.returnOrderVerify!=8}">
													<a href="skippageRejection.do?returnorderid=${data.id}&&mark=find&info=info">详情信息</a> 
												</c:if>
													<c:if test="${data.returnOrderVerify==8}">审核进行中</c:if>	
												</TD>
											</c:if>
										</c:forEach>
										<TD align=center>
											<a href="followAuditing.do?orderNo=${data.purReturnNo}">流程跟踪</a>
										</TD>
										</tr>
									</c:forEach>
									<tr>
									  <td colspan="12" align="right">
									 <INPUT id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
															onclick=CheckAll(this.form) type=checkbox value=select
															name=chkall>
														全选
										<input type="button" id="bc" value="保存" onclick="allChecked(),closeWindeows(0)" /> 
									</td>
									</tr>
								</TBODY>
							</TABLE>
							<p:pages url="returnOrderListRejection.do"/>
						</FORM>
						<!--endprint-->
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_4.gif">
					</TD>
					<TD></TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath()%>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
<!--更多功能层 -->		
	</BODY>
</HTML>

<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.fuao.fajxc.vo.Customer"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/seftpages-1.0" prefix="pp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'changeCustomer.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/showdiv.js" ></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/juqery/lib/jquery1.6.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/data.js" charset="GBK"></script>
		<STYLE>
			BODY {
				BACKGROUND-COLOR: #ffffff
			}
		</STYLE>
	<script type="text/javascript">
	    function showfzr(){
		   $("#fzr").show(); 
	    }
	    // 转移负责人
	    function zyfzr(){
		    var oldfzr=$("#oldfzr").val();
		    var empid=$("#eid").val();
		    if(empid>0){
			    document.getElementById("form1").action="<%=request.getContextPath()%>/fzremp.do?empid="+empid+"&oldfzr="+oldfzr;
			    $("#form1").submit();
		    }else{
			    alert("请勾选选择新负责人！");
			}
		}
	</script>
  </head>
  
  <body>
  <FORM id="form1" name=form1 action="" method="post">
    <TABLE cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed	border=0>
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
										&nbsp;客户信息查询
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
					   <!-- beginprint -->
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4 align=center border=1>
								<TBODY>
									<TR align="center">									
										<TD width="6%" height=30 class=category>
											编号
										</TD>
										<TD width="8%" height=30 class=category>
											全选/反选
										</TD>
										<TD width="10%" class=category >
											客户姓名
										</TD>
										<TD width="9%" class=category >
											租用类型
										</TD>
										<!-- 客户类型2 -->
										<td width="9%" class=category >
										           客户类型
										</td>
										<TD width="10%" class=category>
											负责人
										</TD>
										<TD width="12%" class=category>
											客户电话
										</TD>
										<TD width="8%" class=category>
											客户QQ
										</TD>
										<TD width="8%" class=category>
											创建日期
										</TD>
										<TD width="12%" class=category>
											客户公司名称
										</TD>
										<TD width="12%" class=category>
										           移交记录
										</TD>
									</TR>			
									<%
									  List<Customer> cus=(List<Customer>)request.getAttribute("customerlist");
									  if(cus.size()>0){ %>					
										<c:forEach items="${customerlist}" var="customer" varStatus="count">
												<tr height="30">
											       <td align="center">${count.count }</td>
											       <td align="center">
											       <!-- 获取得到当前的负责人ID -->
											       <input type="hidden" id="oldfzr" value="${customer.employee.id }">
		                                                <INPUT onclick="showfzr()" style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
																type=checkbox value="${customer.customerId }" name=ids>	
		                                           </td>
											       <td align="center">${customer.realName }</td>
											       <td align="center">${customer.customerType }</td>
											       <td align="center">
											            <c:if test="${customer.customerType2==1}">意向客户</c:if>
											            <c:if test="${customer.customerType2==3}">正式客户</c:if>
											        </td>
											       <td align="center">${customer.employee.name }</td>
											       <td align="center">${customer.phone}</td>
											       <td align="center">${customer.qq }</td>
											       <td align="center">${customer.date }</td>
											       <td align="center">${customer.customerCompany }</td>
											       <td align="center">
											       <a href="<%=request.getContextPath()%>/customerJLemp.do?cid=${customer.customerId}">查看</a></td>
												</tr>
										 </c:forEach>
									<%}else{ %>
									      <tr>
									         <td colspan="11">暂无相关意向客户 </td>
									      </tr>
									<%} %>
									 <tr>
									    <td colspan="11">
									       <input type="button" id="ret" onclick="javascript:history.go(-1);" value="返回" style="background-color:#eef7fe; width:35px; height: 20px; border: 1px solid #a2b7c6; "/>&nbsp;
									       <INPUT id=chkall style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px"
											onclick="showfzr(),CheckAll(this.form)" type=checkbox value=select name=chkall>全选/反选 
											<span style="display: none;" id="fzr"> <b style="color: #062e62">请选择新负责人：</b>
											         <select id="eid">
											            <option value="-1">--请选择--</option>
									                    <c:forEach items="${emplist}" var="employee">
									                        <option value="${employee.id }">${employee.name }</option>
									                    </c:forEach>
									                  </select>
									        </span>
									       <input type="button" id="change" onclick="zyfzr()" value="转移客户" style="background-color:#eef7fe; width:60px; height: 20px; border: 1px solid #a2b7c6; "/>
									    </td>
									 </tr>
								</TBODY>
									</table>
						<!--endprint-->
					</TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
					</TD>
					<TD id="page">
					  <pp:pages1 url="customerByEidemp.do" param="empid=${emp }&customertype=${customerType}&openmethod=1"/>
					 </TD>
					<TD>
						<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
					</TD>
				</TR>
			</TBODY>
		</TABLE>
</FORM>
     
  </body>
</html>

<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	<%String path = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   		<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加CDN套餐</title>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery-1.4.2.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/juqery/lib/jquery.form.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/handlejson.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
		<SCRIPT type="text/javascript">
		function moenyselect(money,id)
		{
			var yuanjia=document.getElementById("price").value;
			if(document.getElementById("id"+id+"").checked==true)
			{	
				document.getElementById("price").value=parseInt(yuanjia)+parseInt(money);
				document.getElementById("price1").value=parseInt(yuanjia)+parseInt(money);
			}
			else
			{
				document.getElementById("price").value=parseInt(yuanjia)-parseInt(money);
				document.getElementById("price1").value=parseInt(yuanjia)-parseInt(money);
			}
			}
		function  youhuijia()
		{
			var yuanjia=document.getElementById("price").value;
			var payprice=document.getElementById("payprice").value;
			if(parseInt(payprice)-parseInt(yuanjia)>0)
			{
				alert("实际价格不能比原价大");
				return false;
				}
				}
		function selectTime()
		{
			var sj=document.getElementById("sj").value;
			if(sj!=0)
			{
				document.getElementById("usetime").value=sj;
			}
			else
			{
				document.getElementById("usetime").value=0;	
				}
			}
		</SCRIPT>
</HEAD>
<BODY >
		<FORM  id ="form1" name=form1 action="addCDNSetMealAction.do" method="post" onsubmit="return addValidators()">
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
											&nbsp;添加CDN套餐(带*号的为必填项)
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
							<TABLE class="toptable grid" cellSpacing=1 cellPadding=4
								align=center border=1>
								<TBODY>
									<TR>
										<TD width="15%" height=30 align=right>
											域名类型：
										</TD>
										<TD width="35%" class=category>
											<select id="realmtype" name="realmtype.id" >
												<c:forEach items="${realmTypeList }" var="realmType">
													<option value="${realmType.id }" <c:if test="${realmType.id == data.realmtype.id }"> selected="selected"</c:if>>${realmType.name }</option>
												</c:forEach>
											</select>										
										</TD>
										<TD width="15%" height=30 align=right>
											套餐名称：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('name','','nameMsg')" id="name" name="name">
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="nameMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											活动开始时间：
										</TD>
										<TD width="35%" class=category>
											<INPUT onblur="checkValueByRules('starttime','','starttimeMsg')" id="starttime" name="starttime" onclick="WdatePicker()">
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="starttimeMsg"></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											活动结束时间：
										</TD>
										<TD width="35%" class=category>
											<input onblur="checkValueByRules('endtime','','endtimeMsg')" type="text" id="endtime" name="endtime" onclick="WdatePicker()">
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="endtimeMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right width="15%" height=30>
											套餐使用时长：
										</TD>
										<TD width="35%" class=category>
											<input id="usetime" name="usetime" />天  
											<SELECT id="sj" name="sj" value="this.value" onchange="selectTime()">
											<option value="0">快捷选择</option>
											<option value="30">1个月（按1月30天算）</option>
											<option value="60">2个月（按1月30天算）</option>
											<option value="90">3个月（按1月30天算）</option>
											<option value="180">半年（按1月30天算）</option>
											<option value="360">1年（按1月30天算）</option>
											<option value="720">2年（按1月30天算）</option>
											<option value="1080">3年（按1月30天算）</option>
											</SELECT>
										</TD>
										<TD align=right width="15%" height=30>
											收费类型：
										</TD>
										<TD width="35%" class=category>
											<select id="chargeType" name="chargeType" >
												<option value="0" <c:if test="${data.chargeType =='0' }">selected="selected"</c:if>>免费</option>
												<option value="1" <c:if test="${data.chargeType =='1' }">selected="selected"</c:if>>赠送</option>
												<option value="2" <c:if test="${data.chargeType =='2' }">selected="selected"</c:if>>收费中预付</option>
												<option value="3" <c:if test="${data.chargeType =='3' }">selected="selected"</c:if>>后付</option>
											</select>
										</TD>
									</TR>
									<TR>
										<TD width="25%" align=right height=30>
											原价：
										</TD>
										<TD width="25%" class=category>
											<input onblur="checkValueByRules('price',['money'],'priceMsg')" id="price1" name="price1"  disabled="disabled" value="0"/><input onblur="checkValueByRules('price',['money'],'priceMsg')" id="price" name="price" type="hidden" value="0"/>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="priceMsg"></FONT>
										</TD>
										<TD align=right width="15%" height=30>
											实际价格：
										</TD>
										<TD width="35%" class=category>
											<input onblur="checkValueByRules('payprice',['money'],'paypriceMsg')" id="payprice" name="payprice" onchange="youhuijia()"/>
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="paypriceMsg"></FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30 width="15%">
											套餐描述
										</TD>
										<TD class=category colspan="3" width="85%">
											<textarea rows="10" cols="150" id="describe" name="describe"></textarea>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30 width="15%">
											选择套餐包含的商品
										</TD>
										<TD class=category colspan="3" width="85%">
											<c:forEach items="${propertyList }" var="property">
												 <input type="checkbox" name="property" id="id${property.id }" value="${property.id }"  onclick="moenyselect(${property.hitnum},${property.id })" />${property.name }
												 &nbsp;&nbsp;&nbsp;&nbsp;
											</c:forEach>
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category colspan="3">
											<INPUT class=button type=submit value="确认添加 ">
											<INPUT class=button type=reset value=" 重置 ">
											<input type="hidden" id="delflag" name="delflag" value="0" />
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>
						<TD><br></TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD><br></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
	</BODY>
</HTML>

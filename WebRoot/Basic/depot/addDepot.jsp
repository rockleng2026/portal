<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   		<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>添加仓库</title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/date2.js" charset="GBK"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/juqery/lib/jquery1.6.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/validators.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/showDialog.js" ></script>
		<script type="text/javascript"
			src="<%=request.getContextPath() %>/js/My97DatePicker/WdatePicker.js"></script>
<% String loginName=(String)request.getSession().getAttribute("loginName");%>
	
		<LINK href="<%=request.getContextPath() %>/Css/style.css" type=text/css rel=stylesheet>
		<STYLE>
BODY {
	BACKGROUND-COLOR: #ffffff
}
</STYLE>
<script type="text/javascript">
  function sub()
  {
    var toUrl = 'adddepot.do';
    var method = 'POST';
    var paramSerial = $('form').serialize();
     $.ajax({
          type: method,
          url: toUrl,
          data: encodeURI(paramSerial),
          success: function(date) {
               if(date==1)
               {
               alert("添加成功");
                window.location.href("selectdepot.do");
               }else
               alert("添加失败");
      }
       });

       
  }

</script>
		<META content="MSHTML 6.00.2900.3199" name=GENERATOR>
	</HEAD>
	<BODY>
		<FORM  id ="form1" name=form1 action="adddepot.do" method="post" onsubmit="return addValidators()">
		<s:token/>
		
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
											&nbsp;添加仓库资料(带*号的为必填项)
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
										<TD width="25%" height=30 align=right>仓库名称名称：</TD>
										<TD width="75%" class=category>
											<INPUT onblur="checkValueByRules('name','chenknamedepot.do','nameMsg')" style="WIDTH: 200px" id="name" name="name" />
											&nbsp;
											<FONT color=#ff0000 id="nameMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											仓库地址：
										</TD>
										<TD width="75%" class=category>
											<INPUT style="WIDTH: 200px" onblur="checkValueByRules('address','','addressMsg')" id="address" name="address" />
											&nbsp;
											<FONT color=#ff0000 id="addressMsg"></FONT><FONT color=#ff0000>*</FONT>
										</TD>
									</TR>
									<TR>
										<TD align=right height=30>
											仓库容量：
										</TD>
										<TD class=category>
											<INPUT style="WIDTH: 200px" name="capacity" id="capacity"  onblur="checkValueByRules(this,['num'],'capacityMsg')">
											&nbsp;
											<FONT color=#ff0000>*</FONT><font id="capacityMsg" color="red"></font>
										</TD>
									</TR>
									
									<TR>
										<TD align=right height=30>
											仓库管理员：
										</TD>
										<TD class=category>
											<input id="emp" value="${onedep.employee.name }" onblur="checkValueByRules('emp','','empMsg')" onclick="completemission('showDialogWarehousing.do?mark=employee','')">
											   	<input id="empid" name="admin" type="hidden" value="${onedep.employee.id }" />
											   	<FONT color=#ff0000>*</FONT><FONT id="empMsg" color=#ff0000></FONT>
										</TD>
										</TR>
										<TR>
										<TD align=right height=30>
											仓库建立日期：
										</TD>
										<TD class=category>
										 <INPUT id="time" onblur="checkValueByRules('time',['birth'],'timeMsg')"  style="WIDTH: 150px" name="time"
												onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d'})"/>
											&nbsp;
											<FONT color=#ff0000>*</FONT><FONT color=#ff0000 id="time"></FONT>点击输入框获取时间
										</TD>
									</TR>
									<TR>
										<TD height=30>
											&nbsp;
										</TD>
										<TD class=category>
											<INPUT  class=button type=button value=" 确认添加 " onclick="sub();">
											&nbsp;&nbsp;&nbsp;&nbsp;
											<INPUT class=button type=reset value=" 重置 ">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</TD>
									</TR>
								</TBODY>
									<jsp:include page="/showDialog/viewinfo.jsp"></jsp:include>
							</TABLE>
						</TD>
						<TD></TD>
					</TR>
					<TR>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_4.gif">
						</TD>
						<TD></TD>
						<TD>
							<IMG alt="" src="<%=request.getContextPath() %>/images/r_3.gif">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
	</BODY>
</HTML>

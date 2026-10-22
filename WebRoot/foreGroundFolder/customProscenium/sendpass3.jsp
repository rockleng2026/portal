<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!-- saved from url=(0044)http://www.ebadu.com/sendpass.asp -->
<HTML><HEAD><TITLE>邮件取回密码</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js" ></script>
<LINK rel=stylesheet type=text/css href="<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/doc.css">
<META name=GENERATOR content="MSHTML 8.00.6001.19154"></HEAD>
<BODY>
<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" align=center 
height="100%">
  <TBODY>
	<tr></tr>
  <TR>
  
    <TD vAlign=center align=middle>
     <table height="50" width=780 align=center>
    	<tr>
        	 <td style="background-image: url('<%=request.getContextPath()%>/foreGroundFolder/customProscenium/subnote_files/bg_t.gif');"><font size="4">&nbsp;&nbsp;&nbsp;&nbsp;找回密码</font></td>
        </tr>
    </table>
   
    <table height="50">
    	<tr>
        	<td vAlign="middle" align=middle>1. 填写密保资料>>2. 接收找回密码邮件>><font style="font-weight: bolder">3. 重置密码  </font>    	</td>
        </tr>
    </table>
      <TABLE border=0 width=760 align=center>
        <TBODY>
        <TR>
          <TD>
            <TABLE style="LINE-HEIGHT: 200%; FONT-SIZE: 9pt" border=0 
            cellSpacing=1 cellPadding=2 width="100%" bgColor=#cccccc 
            align=center>
              <TBODY>
              <TR>
                <TD bgColor=#ffffff align=middle><BR>
                  <TABLE cellSpacing=1 cellPadding=2 width=500 bgColor=#cccccc 
                  align=center>
                    <FORM method=post name=AddForm action="editpasswordCustomerServer.Action" onsubmit="return emailpassword()">
                    <TBODY>
                    <TR align="center">
                      <TD bgColor=#ffffff height=24 colSpan=3 
                        align=middle>邮件方式取回密码  </TD></TR>
                   
                    <TR align="center">
                      <TD bgColor=#ffffff>&nbsp;<FONT color=red>*</FONT> 
                      重置密码:</TD>
                      <TD bgColor=#ffffff>&nbsp;
                       <INPUT style="WIDTH: 180px" type="hidden" class=inputText id="customerId" name="customerId" value="${activeid }">
                      <INPUT style="WIDTH: 180px" type="password" class=inputText name="cardid" id="cardid"></TD>
                      <TD bgColor=#ffffff>请输入重置密码</TD></TR>
   					<TR align="center">
                      <TD bgColor=#ffffff>&nbsp;<FONT color=red>*</FONT> 
                      确认密码:</TD>
                      <TD bgColor=#ffffff>&nbsp;
                      <INPUT style="WIDTH: 180px" type="password" class=inputText name="customerPassword" id="customerPassword"></TD>
                      <TD bgColor=#ffffff>请输入确认密码</TD></TR>
                      <TR>
                      <TD bgColor=#ffffff colSpan=3 align="center">&nbsp;
                          &nbsp;<font color="red">${errorMsg == null ? "" : errorMsg }</font>
                        </TD></TR>
                    <TR>
                      <TD bgColor=#ffffff height=30 colSpan=3 align=middle><INPUT class=bt value=" 提 交 " type="submit"  name=Submit>&nbsp;&nbsp;&nbsp; 
<INPUT class=bt value=" 重 置 " type=reset name=B2></TD></TR><INPUT value=mail type=hidden name=SType /> </FORM>
                    <TR>
                      <TD bgColor=#ffffff colSpan=3 
                        align=middle>只有设置过密保资料的才可以通过页面取回! <A 
                        href="#"><FONT 
                        color=blue>短信取回密码</FONT></A></TD></TR></TBODY></TABLE><BR></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></BODY>
                 <script type="text/javascript">
                 	function emailpassword()
                 	{
                 		var customername = $("#customerName").val();
                 		var carid = $("#cardid").val();
                 		var customerPassword = $("#customerPassword").val();
                 		
                 		if(customername=='')
                 		{
                 			alert("请填写用户名称！");
                 			return false;
                 		}
                 		if(carid=='')
                 		{
                 			alert("请填写重置密码！");
                 			return false;
                 		}
                 		if(customerPassword=='')
                 		{
                 			alert("请填写确认密码！");
                 			return false;
                 		}
                 		if(carid!=customerPassword)
                 		{
                 			alert("两次输入密码不一致，请重新填写！");
                 			return false;
                 		}
                 		else
                 		{
                 			return true;
                 		}
                 	}
                 </script> 
                        
                        </HTML>
